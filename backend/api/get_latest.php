<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

require_once __DIR__ . '/../db.php';

$response = [
    "temperature" => "--",
    "humidity" => "--",
    "apple_count" => 0,
    "mango_count" => 0,
    "orange_count" => 0
];

if (isset($conn) && !$conn->connect_error) {
    // 1. ดึงข้อมูลอุณหภูมิ/ความชื้น
    try {
        $sql_tel = "SELECT temperature, humidity FROM telemetry ORDER BY id DESC LIMIT 1";
        $result_tel = $conn->query($sql_tel);
        if ($result_tel && $result_tel->num_rows > 0) {
            $row = $result_tel->fetch_assoc();
            $response['temperature'] = $row['temperature'];
            $response['humidity'] = $row['humidity'];
        }
    } catch (Exception $e) {
        // หากไม่มีตาราง telemetry จะใช้ค่าเริ่มต้น "--" โดยไม่ล่ม
    }

    // 2. ดึงข้อมูลสต็อกผลไม้
    try {
        $sql_inv = "SELECT apple_count, mango_count, orange_count FROM warehouse_inventory ORDER BY id DESC LIMIT 1";
        $result_inv = $conn->query($sql_inv);
        if ($result_inv && $result_inv->num_rows > 0) {
            $row = $result_inv->fetch_assoc();
            $response['apple_count'] = (int)$row['apple_count'];
            $response['mango_count'] = (int)$row['mango_count'];
            $response['orange_count'] = (int)$row['orange_count'];
        }
    } catch (Exception $e) {
        // หากไม่มีตาราง warehouse_inventory จะใช้ค่าเริ่มต้น 0 โดยไม่ล่ม
    }
}

echo json_encode($response);
if (isset($conn)) {
    $conn->close();
}
?>