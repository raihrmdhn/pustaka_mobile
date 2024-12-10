<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT");
header("Access-Control-Allow-Headers: Content-Type");

$host = 'localhost'; // Alamat server database
$username = 'root'; // Username MySQL
$password = ''; // Password MySQL
$dbname = 'pustaka_2301083018'; // Nama database

// Koneksi ke database
$conn = new mysqli($host, $username, $password, $dbname);

// Cek koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

header('Content-Type: application/json');

// Mendapatkan data JSON yang dikirim dari Flutter
$data = json_decode(file_get_contents('php://input'), true);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Insert data baru
    $nim = $data['nim'];
    $nama = $data['nama'];
    $alamat = $data['alamat'];
    $jenis_kelamin = $data['jenisKelamin'];
    $password = $data['password'];

    $sql = "INSERT INTO anggota (nim, nama, alamat, jenis_kelamin, password) 
            VALUES ('$nim', '$nama', '$alamat', '$jenis_kelamin', '$password')";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(['message' => 'Data berhasil ditambahkan']);
    } else {
        echo json_encode(['error' => 'Terjadi kesalahan: ' . $conn->error]);
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    // Update data berdasarkan id
    $id = $data['id'];
    $nim = $data['nim'];
    $nama = $data['nama'];
    $alamat = $data['alamat'];
    $jenis_kelamin = $data['jenisKelamin'];
    $password = $data['password'];

    $sql = "UPDATE anggota SET nim='$nim', nama='$nama', alamat='$alamat', 
            jenis_kelamin='$jenis_kelamin', password='$password' WHERE id=$id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(['message' => 'Data berhasil diperbarui']);
    } else {
        echo json_encode(['error' => 'Terjadi kesalahan: ' . $conn->error]);
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
    // Hapus data berdasarkan id
    $id = $data['id'];
    $sql = "DELETE FROM anggota WHERE id=$id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(['message' => 'Data berhasil dihapus']);
    } else {
        echo json_encode(['error' => 'Terjadi kesalahan: ' . $conn->error]);
    }
}

$conn->close();
?>
