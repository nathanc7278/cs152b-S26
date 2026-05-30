import re

import numpy as np
import torch
from torchvision import datasets, transforms

from model import CNN, fpga_preprocess_tensor


HEADER_PATH = "weights.h"


def parse_scalar(text, name):
    match = re.search(rf"static const float {name} = ([^;]+)f;", text)
    if not match:
        raise ValueError(f"Missing scalar {name}")
    return float(match.group(1))


def parse_array(text, c_type, name, dtype):
    pattern = rf"static const {c_type} {name}\[[^\]]+\] = \{{(.*?)\}};"
    match = re.search(pattern, text, re.S)
    if not match:
        raise ValueError(f"Missing array {name}")
    vals = [v.strip().rstrip("f") for v in match.group(1).split(",") if v.strip()]
    return np.array(vals, dtype=dtype)


def round_away_from_zero(x):
    return int(x + (0.5 if x >= 0.0 else -0.5))


def clamp_int8(x):
    return np.int8(max(-128, min(127, x)))


def conv2d_int8(x, h, w, in_ch, out_ch, weights, bias, w_scales,
                input_scale, output_scale):
    weights = weights.reshape(out_ch, in_ch, 3, 3)
    out = np.zeros((out_ch, h, w), dtype=np.int8)
    for oc in range(out_ch):
        requant = input_scale * w_scales[oc] / output_scale
        for y in range(h):
            for col in range(w):
                acc = 0
                for ic in range(in_ch):
                    for ky in range(3):
                        for kx in range(3):
                            iy = y + ky - 1
                            ix = col + kx - 1
                            if 0 <= iy < h and 0 <= ix < w:
                                acc += int(x[ic, iy, ix]) * int(weights[oc, ic, ky, kx])
                acc += int(bias[oc])
                out[oc, y, col] = clamp_int8(round_away_from_zero(acc * requant))
    return out


def maxpool2d_int8(x):
    ch, h, w = x.shape
    return x.reshape(ch, h // 2, 2, w // 2, 2).max(axis=(2, 4)).astype(np.int8)


def fc_int8(x, out_size, weights, bias, w_scales, input_scale, output_scale):
    x = x.reshape(-1)
    weights = weights.reshape(out_size, x.size)
    out = np.zeros(out_size, dtype=np.int8)
    for o in range(out_size):
        acc = int(np.dot(x.astype(np.int32), weights[o].astype(np.int32)))
        acc += int(bias[o])
        requant = input_scale * w_scales[o] / output_scale
        out[o] = clamp_int8(round_away_from_zero(acc * requant))
    return out


def infer_exported(img, weights):
    raw = np.clip(np.rint(img.numpy() * 255.0), 0, 254).astype(np.int16)
    x = (raw - 128).astype(np.int8)

    x = conv2d_int8(x, 28, 28, 1, 4, weights["conv1_weight"],
                    weights["conv1_bias"], weights["conv1_weight_scale"],
                    weights["input_scale"], weights["conv1_out_scale"])
    x = np.maximum(x, 0).astype(np.int8)
    x = maxpool2d_int8(x)

    x = conv2d_int8(x, 14, 14, 4, 8, weights["conv2_weight"],
                    weights["conv2_bias"], weights["conv2_weight_scale"],
                    weights["conv1_out_scale"], weights["conv2_out_scale"])
    x = np.maximum(x, 0).astype(np.int8)
    x = maxpool2d_int8(x)

    x = fc_int8(x, 16, weights["fc1_weight"], weights["fc1_bias"],
                weights["fc1_weight_scale"], weights["conv2_out_scale"],
                weights["fc1_out_scale"])
    x = np.maximum(x, 0).astype(np.int8)

    x = fc_int8(x, 10, weights["fc2_weight"], weights["fc2_bias"],
                weights["fc2_weight_scale"], weights["fc1_out_scale"],
                weights["fc2_out_scale"])
    return int(np.argmax(x))


def load_exported_weights():
    text = open(HEADER_PATH, encoding="utf-8").read()
    weights = {
        name: parse_scalar(text, name)
        for name in [
            "input_scale",
            "conv1_out_scale",
            "conv2_out_scale",
            "fc1_out_scale",
            "fc2_out_scale",
        ]
    }

    for name in ["conv1_weight", "conv2_weight", "fc1_weight", "fc2_weight"]:
        weights[name] = parse_array(text, "int8_t", name, np.int8)
        weights[f"{name}_scale"] = parse_array(text, "float", f"{name}_scale", np.float32)

    for name in ["conv1_bias", "conv2_bias", "fc1_bias", "fc2_bias"]:
        weights[name] = parse_array(text, "int32_t", name, np.int32)

    return weights


model = CNN()
model.load_state_dict(torch.load("mnist_cnn.pth", map_location="cpu"))
model.eval()
weights = load_exported_weights()

data = datasets.MNIST("./data", train=False, download=True,
                      transform=transforms.ToTensor())

correct_raw_float = 0
correct_deployed_float = 0
correct_exported = 0
total = 1000

with torch.no_grad():
    for i in range(total):
        img, label = data[i]

        raw_out = model(img.unsqueeze(0))
        if raw_out.argmax().item() == label:
            correct_raw_float += 1

        deployed_img = fpga_preprocess_tensor(img).unsqueeze(0)
        deployed_out = model(deployed_img)
        if deployed_out.argmax().item() == label:
            correct_deployed_float += 1

        if infer_exported(img, weights) == label:
            correct_exported += 1

print(f"Raw float accuracy:       {correct_raw_float / total * 100:.1f}%")
print(f"Deployed-input float:     {correct_deployed_float / total * 100:.1f}%")
print(f"Exported int8 accuracy:   {correct_exported / total * 100:.1f}%")
print(f"Exported quant gap:       {(correct_deployed_float - correct_exported) / total * 100:.1f}%")
