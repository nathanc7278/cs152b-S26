import torch
import torch.nn as nn

# Output dimensions = (W - K + 2P) / S + 1

def fpga_preprocess_tensor(x):
    return (torch.clamp(torch.round(x * 255.0), 0.0, 254.0) - 128.0) / 127.0


class FPGAInputTransform:
    def __call__(self, x):
        return fpga_preprocess_tensor(x)

class CNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.conv1 = nn.Conv2d(in_channels=1, out_channels=4, kernel_size=3, padding=1)
        # 1x28x28 -> 4x28x28
        self.relu1 = nn.ReLU()
        self.pool1 = nn.MaxPool2d(kernel_size=2)
        # 4x28x28 -> 4x14x14

        self.conv2 = nn.Conv2d(in_channels=4, out_channels=8, kernel_size=3, padding=1)
        # 4x14x14 -> 8x14x14
        self.relu2 = nn.ReLU()
        self.pool2 = nn.MaxPool2d(kernel_size=2)
        # 8x14x14 -> 8x7x7

        self.fc1 = nn.Linear(in_features=8*7*7, out_features=16)
        self.relu3 = nn.ReLU()
        self.fc2 = nn.Linear(16, 10)
        

    def forward(self, x):
        x = self.conv1(x)
        x = self.relu1(x)
        x = self.pool1(x)

        x = self.conv2(x)
        x = self.relu2(x)
        x = self.pool2(x)
        x = x.view(x.size(0), -1)
        x = self.fc1(x)
        x = self.relu3(x)
        return self.fc2(x)
    

# transform = transforms.Compose([
#     transforms.ToTensor()
# ])
# data = datasets.MNIST('.', train=True, download=True, transform=transform)
# # data = (image_tensor, label)
# images = torch.stack(list(data[0] for data in data), dim=0)
# # 60000 images of 1x28x28 -> 60000x1x28x28
# print(images.shape)
# print(images.mean())
# print(images.std())
# Results in:
# torch.Size([60000, 1, 28, 28])
# tensor(0.1307)
# tensor(0.3081)
