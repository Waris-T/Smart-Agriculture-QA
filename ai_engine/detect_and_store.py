import requests
from ultralytics import YOLO

# โหลดโมเดล YOLOv8
model = YOLO('yolov8n.pt')

API_URL = "http://10.194.51.189:8080/smart_farm/backend/api/store_inventory.php"

def detect_and_store(image_path):
    results = model(image_path, conf=0.25)
    results[0].save("result_output.jpg")

    apple_cnt = 0
    mango_cnt = 0
    orange_cnt = 0

    for box in results[0].boxes:
        class_id = int(box.cls[0])
        class_name = model.names[class_id].lower()

        if class_name == "apple":
            apple_cnt += 1
        elif class_name == "orange":
            orange_cnt += 1
        elif class_name == "mango":
            mango_cnt += 1

    print(f"\n[ยอดรวม] Apple: {apple_cnt}, Mango: {mango_cnt}, Orange: {orange_cnt}")

    # ส่ง Key ให้ตรงกับที่ PHP รอรับ (apple, mango, orange)
    payload = {
        "apple": apple_cnt,
        "mango": mango_cnt,
        "orange": orange_cnt
    }

    try:
        response = requests.post(API_URL, json=payload)
        print("[API Response]:", response.text)
    except Exception as e:
        print("[Error]:", e)

if __name__ == "__main__":
    detect_and_store("test.jpg")