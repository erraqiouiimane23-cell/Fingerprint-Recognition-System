import os

path = r"C:\Users\HP\Documents\PYTHON\dataset\Real"

for file in os.listdir(path):

    if not file.endswith(".BMP"):
        continue

    parts = file.replace(".BMP", "").split("__")

    if len(parts) != 2:
        continue

    person_id = parts[0]
    gender, hand, finger = parts[1].split("_")

    print(file, "=>", person_id, gender, hand, finger)