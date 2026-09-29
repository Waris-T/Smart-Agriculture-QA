<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require_once '../db.php';

// ดึงข้อมูล Telemetry
$telemetry_res = $conn->query("SELECT * FROM telemetry_data ORDER BY id DESC LIMIT 1");
$telemetry_data = ($telemetry_res && $telemetry_res->num_rows > 0) ? $telemetry_res->fetch_assoc() : null;

// ดึงข้อมูล Inventory
$inventory_res = $conn->query("SELECT * FROM warehouse_inventory ORDER BY id DESC LIMIT 1");
$inventory_data = ($inventory_res && $inventory_res->num_rows > 0) ? $inventory_res->fetch_assoc() : null;

echo json_encode([
    "status" => "success",
    "telemetry" => $telemetry_data,
    "inventory" => $inventory_data
]);
?>