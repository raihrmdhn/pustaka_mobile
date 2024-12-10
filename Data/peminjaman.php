<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$host = 'localhost';
$dbname = 'pustaka_2301083018';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $query = $pdo->query("SELECT * FROM peminjaman");
    $peminjaman = $query->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($peminjaman);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>
