# 🌾 Smart Farm IoT & AI Inventory System

ระบบฟาร์มอัจฉริยะแบบครบวงจร (Full-Stack IoT & AI) ตรวจจับอุณหภูมิ-ความชื้น นับจำนวนผลผลิตด้วย AI และแสดงผลผ่านแอปพลิเคชันมือถือแบบ Real-time

---

## 🛠️ Tech Stack & Architecture

- **Hardware:** ESP32 + DHT11 Sensor (GPIO 1)
- **Backend & Database:** PHP (REST API) + MySQL (XAMPP)
- **AI Engine:** Python + YOLOv8 (`ultralytics`)
- **Mobile Application:** Flutter (Cross-platform)

---

## 📁 Project Structure

```text
smart_farm/
├── hardware/              # โค้ด ESP32 (Arduino C++)
├── backend/               # PHP REST API & Database Connect
│   ├── api/               # API Endpoints (store_telemetry, store_inventory, get_latest)
│   └── db.php             # ไฟล์เชื่อมต่อ MySQL Database
├── ai_engine/             # Python YOLOv8 Script & Detection Logic
└── mobile_app/            # Flutter Mobile Application Source Code