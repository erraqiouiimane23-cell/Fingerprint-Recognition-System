import os
import cv2
import pandas as pd

path = r"C:\Users\HP\Documents\PYTHON\dataset\Real"

IMG_SIZE = 50
data = []

for file in os.listdir(path):

    if not file.endswith(".BMP"):
        continue

    img_path = os.path.join(path, file)
    img = cv2.imread(img_path, 0)

    if img is None:
        continue

    img = cv2.resize(img, (IMG_SIZE, IMG_SIZE))
    features = img.flatten()

    person_id = file.split("__")[0]

    data.append([person_id] + list(features))

df = pd.DataFrame(data)
df.to_csv("dataset.csv", index=False)

print("✔ dataset.csv created successfully")