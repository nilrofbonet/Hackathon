<?php
$servername = "localhost";
$username = "QResp";  // Replace with your username
$password = "suquet";      // Replace with your password
$dbname = "patient_db";  // Replace with your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
