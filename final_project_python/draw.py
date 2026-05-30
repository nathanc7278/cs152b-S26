import serial
import numpy as np
from PIL import Image, ImageDraw, ImageTk
import tkinter as tk
from tkinter import Canvas
import time

ser = serial.Serial('COM9', 115200, timeout=2)
time.sleep(0.5)
ser.reset_input_buffer()


def mnist_style_image(image):
    bbox = image.getbbox()
    if bbox is None:
        return None

    digit = image.crop(bbox)
    w, h = digit.size
    if w > h:
        new_w = 20
        new_h = max(1, int(round(h * 20 / w)))
    else:
        new_h = 20
        new_w = max(1, int(round(w * 20 / h)))

    digit = digit.resize((new_w, new_h), Image.Resampling.LANCZOS)
    arr = np.array(digit, dtype=np.float32)
    mass = arr.sum()

    small = Image.new("L", (28, 28), color=0)
    if mass <= 0:
        small.paste(digit, ((28 - new_w) // 2, (28 - new_h) // 2))
        return small

    ys, xs = np.indices(arr.shape)
    cx = float((xs * arr).sum() / mass)
    cy = float((ys * arr).sum() / mass)
    paste_x = int(round((28 - 1) / 2.0 - cx))
    paste_y = int(round((28 - 1) / 2.0 - cy))
    paste_x = max(0, min(28 - new_w, paste_x))
    paste_y = max(0, min(28 - new_h, paste_y))
    small.paste(digit, (paste_x, paste_y))
    return small

class App:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Draw a digit (Left) - FPGA Input (Right)")
        
        self.frame = tk.Frame(self.root)
        self.frame.pack(padx=10, pady=10)

        self.canvas = Canvas(self.frame, width=280, height=280, bg='black', highlightthickness=1, highlightbackground="gray")
        self.canvas.pack(side=tk.LEFT, padx=10)
        
        self.preview_canvas = Canvas(self.frame, width=280, height=280, bg='black', highlightthickness=1, highlightbackground="gray")
        self.preview_canvas.pack(side=tk.RIGHT, padx=10)
        
        self.image = Image.new("L", (280, 280), color=0)
        self.draw = ImageDraw.Draw(self.image)
        self.photo = None
        
        self.canvas.bind('<B1-Motion>', self.paint)
        self.canvas.bind('<ButtonRelease-1>', self.send)
        
        btn = tk.Button(self.root, text='Clear', command=self.clear)
        btn.pack(pady=10)
        
        self.label = tk.Label(self.root, text="Draw a digit")
        self.label.pack(pady=10)
        
        self.root.mainloop()

    def paint(self, event):
        r = 10
        x, y = event.x, event.y
        self.canvas.create_oval(x-r, y-r, x+r, y+r, fill='white', outline='white')
        self.draw.ellipse([x-r, y-r, x+r, y+r], fill=255)

    def clear(self):
        self.canvas.delete('all')
        self.preview_canvas.delete('all')
        self.image = Image.new("L", (280, 280), color=0)
        self.draw = ImageDraw.Draw(self.image)
        self.label.config(text="Draw a digit")
        self.root.title("Draw a digit (Left) - FPGA Input (Right)")

    def send(self, event):
        small = mnist_style_image(self.image)
        if small is None:
            return

        self.preview_canvas.delete('all')
        preview_img = small.resize((280, 280), Image.Resampling.NEAREST)
        self.photo = ImageTk.PhotoImage(preview_img)
        self.preview_canvas.create_image(0, 0, image=self.photo, anchor=tk.NW)
        
        arr = np.array(small, dtype=np.uint8)
        arr = np.clip(arr, 0, 254).astype(np.uint8)
        flat = arr.flatten()
        
        ser.reset_input_buffer()
        ser.write(b'\xFF\xFF\xFF\xFF')
        ser.write(bytes(flat))
        ser.flush()
        
        result = ser.read(1)
        if result:
            digit = result[0]
            print(f'Predicted: {digit}')
            self.label.config(text=f'Predicted: {digit}')
        else:
            print('Timeout')
            self.label.config(text='Timeout, try again')


App()
