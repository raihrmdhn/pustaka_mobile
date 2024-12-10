<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
 
$conn = new mysqli("localhost", "root", "", "pustaka_2301083018");

if ($conn->connect_error) {
    die(json_encode(['error' => 'Failed to connect to database']));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'] ?? '';

    $stmt = $conn->prepare("DELETE FROM buku WHERE id = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo json_encode(['success' => 'Data deleted successfully']);
    } else {
        echo json_encode(['error' => 'Failed to delete data']);
    }

    $stmt->close();
}
$conn->close();
?>
