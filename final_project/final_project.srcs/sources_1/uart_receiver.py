import serial
import pygame
import numpy as np
import cv2

WIDTH = 320
HEIGHT = 240
BITS_PER_PIXEL = 4
BITS_PER_BYTE = 8
BAUD_RATE = 115200
TIMEOUT = 1

COLORS = [
    [0, 53, 0],
    [0, 41, 255],
    [0, 255, 0],
    [0, 255, 255],
    [255, 0, 0],
    [255, 0, 255],
    [255, 255, 0],
    [255, 255, 255],
    [38, 154, 0],
    [0, 150, 255],
    [207, 26, 128],
    [216, 219, 127],
    [255, 150, 0],
    [197, 163, 255],
    [0, 46, 133],
    [0, 151, 134],
    [0, 255, 121],
    [99, 0, 62],
    [129, 0, 255],
    [168, 74, 0],
    [108, 96, 208],
    [134, 228, 15],
    [102, 211, 188]
]

ser = serial.Serial('COM11', BAUD_RATE)  

def process_grad_thresh_img(img):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    blur = cv2.medianBlur(gray, 7)

    _, thresh = cv2.threshold(blur, 0, 255, cv2.THRESH_OTSU)
    labels = cv2.connectedComponents(thresh, 4, cv2.CV_32S)

    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            if labels[1][i][j] != 0:
                img[i][j] = COLORS[labels[1][i][j] % len(COLORS)] 
            else:
                img[i][j] = [0, 0, 0]
    return img

def adaptive_threshold(img):
    thresh = cv2.adaptiveThreshold(img, 255,
	    cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY_INV, 21, 10)
    return cv2.cvtColor(thresh, cv2.COLOR_GRAY2BGR)

def gradient(img):
    return cv2.cvtColor(cv2.Sobel(img, cv2.CV_8U,1,0,ksize=3), cv2.COLOR_GRAY2BGR)

def init():
    pygame.init()
    display_window = pygame.display.set_mode((WIDTH*2, HEIGHT*2))
    window_exited = False
    print('Began listening')

    while not window_exited:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                window_exited = True

        img_buf = ser.read(int(HEIGHT*WIDTH*BITS_PER_PIXEL/BITS_PER_BYTE))
        img_int = []

        for i in range(int(WIDTH*HEIGHT*BITS_PER_PIXEL/BITS_PER_BYTE)):
            c_val = img_buf[i]
            first_pixel = (c_val & 15) << 4
            second_pixel = ((c_val >> 4) & 15) << 4
            img_int.append(first_pixel)
            img_int.append(second_pixel)

        np_img = np.uint8(np.asarray(img_int).reshape(HEIGHT, WIDTH))
        np_img_rgb = cv2.cvtColor(np_img, cv2.COLOR_BGR2RGB)
        img_proc = process_grad_thresh_img(cv2.cvtColor(np_img, cv2.COLOR_GRAY2BGR))
        img_athresh = process_grad_thresh_img(adaptive_threshold(np_img))
        img_grad = process_grad_thresh_img(gradient(np_img))
        display_window.fill((0, 0, 0))
        display_window.blit(pygame.pixelcopy.make_surface(np.swapaxes(np_img_rgb, 0, 1)), (0, 0))
        display_window.blit(pygame.pixelcopy.make_surface(np.swapaxes(img_proc, 0, 1)), (WIDTH, 0))
        display_window.blit(pygame.pixelcopy.make_surface(np.swapaxes(img_athresh, 0, 1)), (0, HEIGHT))
        display_window.blit(pygame.pixelcopy.make_surface(np.swapaxes(img_grad, 0, 1)), (WIDTH, HEIGHT))
        pygame.display.update()

        
        print('Image drawn, listening again')

    pygame.quit()
    ser.close()

if __name__ == "__main__":
    init()