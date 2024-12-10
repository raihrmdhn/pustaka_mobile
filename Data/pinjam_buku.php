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

    $buku = $_POST['buku'];
    $anggota = $_POST['anggota'];
    $tanggalPinjam = $_POST['tanggal_pinjam'];
    $tanggalKembali = $_POST['tanggal_kembali'];

    $stmt = $pdo->prepare("INSERT INTO peminjaman (buku, anggota, tanggal_pinjam, tanggal_kembali) VALUES (?, ?, ?, ?)");
    $stmt->execute([$buku, $anggota, $tanggalPinjam, $tanggalKembali]);

    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
