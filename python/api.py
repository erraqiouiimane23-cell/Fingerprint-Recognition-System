from flask import Flask, request, jsonify
import cv2
import numpy as np
import pickle

app = Flask(__name__)

# load model
model = pickle.load(open("model.pkl", "rb"))

IMG_SIZE = 64

def extract(img):
    img = cv2.resize(img, (IMG_SIZE, IMG_SIZE))
    img = img / 255.0
    return img.flatten()

@app.route("/identify", methods=["POST"])
def identify():

    file = request.files.get("image")
    if not file:
        return jsonify({"status": "fail", "message": "no image"}), 400

    img_bytes = np.frombuffer(file.read(), np.uint8)
    img = cv2.imdecode(img_bytes, cv2.IMREAD_GRAYSCALE)

    if img is None:
        return jsonify({"status": "fail", "message": "invalid image"}), 400

    try:
        feat = extract(img).reshape(1, -1)

        pred = model.predict(feat)[0]
        proba = model.predict_proba(feat).max()

        result = "SAME" if pred == 1 else "DIFFERENT"

        return jsonify({
            "prediction": result,
            "score": float(proba),
            "status": "success"
        })

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        }), 500


if __name__ == "__main__":
    app.run(debug=True)