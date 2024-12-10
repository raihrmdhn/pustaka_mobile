<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$host = "localhost";
$dbname = "pustaka_2301083018";
$username = "root"; // ganti dengan username MySQL Anda
$password = ""; // ganti dengan password MySQL Anda

$conn = new mysqli($host, $username, $password, $dbname);

// Periksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT id, judul, pengarang, penerbit, tahun_terbit, gambar FROM buku";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $buku_array = [];
    while($row = $result->fetch_assoc()) {
        $buku_array[] = $row;
    }
    echo json_encode($buku_array);
} else {
    echo json_encode(['message' => 'Tidak ada data']);
}

$conn->close();
?>
