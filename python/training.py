import os
import cv2
import numpy as np
import pandas as pd
import random
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import pickle

path = r"C:\Users\HP\Documents\PYTHON\dataset\Real"
files = os.listdir(path)

IMG_SIZE = 64

def extract(img):
    img = cv2.resize(img, (IMG_SIZE, IMG_SIZE))
    img = img / 255.0
    return img.flatten()

data = []

# ===================== SAME =====================
for _ in range(2000):

    f1 = random.choice(files)
    id1 = f1.split("__")[0]

    same = [f for f in files if f.startswith(id1) and f != f1]
    if len(same) == 0:
        continue

    f2 = random.choice(same)

    img1 = cv2.imread(os.path.join(path, f1), 0)
    img2 = cv2.imread(os.path.join(path, f2), 0)

    if img1 is None or img2 is None:
        continue

    f = np.abs(extract(img1) - extract(img2))
    data.append(list(f) + [1])

# ===================== DIFFERENT =====================
for _ in range(2000):

    while True:
        f1, f2 = random.sample(files, 2)
        if f1.split("__")[0] != f2.split("__")[0]:
            break

    img1 = cv2.imread(os.path.join(path, f1), 0)
    img2 = cv2.imread(os.path.join(path, f2), 0)

    if img1 is None or img2 is None:
        continue

    f = np.abs(extract(img1) - extract(img2))
    data.append(list(f) + [0])

df = pd.DataFrame(data)

X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

model = RandomForestClassifier(n_estimators=200, random_state=42)
model.fit(X_train, y_train)

print("Accuracy:", model.score(X_test, y_test))

pickle.dump(model, open("model.pkl", "wb"))

print("✔ MODEL SAVED")