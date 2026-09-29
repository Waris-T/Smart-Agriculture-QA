# 🌾 Smart Farm IoT & AI Inventory System

ระบบจัดการฟาร์มอัจฉริยะแบบ Full-Stack ตรวจจับอุณหภูมิ-ความชื้น นำเข้าข้อมูลด้วย AI (YOLOv8) และแสดงผลผ่าน Flutter Mobile Dashboard แบบ Real-time

## 🏗️ System Architecture
- **Hardware:** ESP32 + DHT11 Sensor
- **Backend:** PHP (REST API) + MySQL (XAMPP)
- **AI Engine:** Python + YOLOv8 (`ultralytics`)
- **Mobile App:** Flutter (Cross-platform)

## 📁 Project Structure
```text
smart_farm/
├── hardware/              # Arduino code for ESP32
├── backend/               # PHP REST APIs & Database connection
│   ├── api/               # store_telemetry, store_inventory, get_latest
│   └── db.php
├── ai_engine/             # Python YOLOv8 detection scripts
└── mobile_app/            # Flutter Dashboard Application