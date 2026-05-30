import cv2
import numpy as np
import pickle

model = pickle.load(open("model.pkl", "rb"))
scaler = pickle.load(open("scaler.pkl", "rb"))

IMG_SIZE = 50

img1 = cv2.imread("img1.bmp", 0)
img2 = cv2.imread("img2.bmp", 0)

img1 = cv2.resize(img1, (IMG_SIZE, IMG_SIZE))
img2 = cv2.resize(img2, (IMG_SIZE, IMG_SIZE))

diff = np.abs(img1.flatten() - img2.flatten()).reshape(1, -1)

diff = scaler.transform(diff)

pred = model.predict(diff)
proba = model.predict_proba(diff)

print(pred, np.max(proba))