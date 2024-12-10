<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$conn = new mysqli("localhost", "root", "", "pustaka_2301083018");

if ($conn->connect_error) {
    die(json_encode(['error' => 'Failed to connect to database']));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $judul = $_POST['judul'] ?? '';
    $pengarang = $_POST['pengarang'] ?? '';
    $penerbit = $_POST['penerbit'] ?? '';
    $tahun_terbit = $_POST['tahun_terbit'] ?? '';
    $gambar = $_POST['gambar'] ?? '';

    $stmt = $conn->prepare("INSERT INTO buku (judul, pengarang, penerbit, tahun_terbit, gambar) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $judul, $pengarang, $penerbit, $tahun_terbit, $gambar);

    if ($stmt->execute()) {
        echo json_encode(['success' => 'Data inserted successfully']);
    } else {
        echo json_encode(['error' => 'Failed to insert data']);
    }

    $stmt->close();
}
$conn->close();
?>
