<?php
$host = "localhost"; 
$user = "root";  
$pass = ""; 
$dbname = "smart_farm_db"; 
$conn = new mysqli($host, $user, $pass, $dbname); 
if ($conn->connect_error) { 
    die(json_encode(["status" => "error", "message" => "Database Connection Failed"])); 
} 
?>