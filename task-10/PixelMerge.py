import os
import cv2
import numpy as np
from PIL import Image, ImageDraw

image_folder = 'assets' 

image_files = sorted([f for f in os.listdir(image_folder) if f.endswith('.png')])

dot_positions = []

for image_file in image_files:
    image_path = os.path.join(image_folder, image_file)
    image = cv2.imread(image_path)

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    _, thresh = cv2.threshold(gray, 250, 255, cv2.THRESH_BINARY_INV)

    contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    if contours:
        contour = contours[0]
        M = cv2.moments(contour)
        if M["m00"] != 0:
            cX = int(M["m10"] / M["m00"])
            cY = int(M["m01"] / M["m00"])
            color = image[cY, cX].tolist()  
            dot_positions.append((cX, cY, color))
    else:
        dot_positions.append(None)

canvas_size = (512, 512)
final_image = Image.new('RGB', canvas_size, (255, 255, 255))
draw = ImageDraw.Draw(final_image)

previous_dot = None
for dot in dot_positions:
    if dot:
        cX, cY, color = dot
        if previous_dot:
            pX, pY, pColor = previous_dot
            draw.line((pX, pY, cX, cY), fill=tuple(pColor), width=2)
        previous_dot = (cX, cY, color)
    else:
        previous_dot = None

final_image.save('final_image.png')
