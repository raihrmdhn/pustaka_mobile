<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT");
header("Access-Control-Allow-Headers: Content-Type");

$host = 'localhost'; // Ganti dengan host server Anda
$username = 'root'; // Ganti dengan username database Anda
$password = ''; // Ganti dengan password database Anda
$dbname = 'pustaka_2301083018'; // Ganti dengan nama database Anda

// Membuat koneksi ke database
$conn = new mysqli($host, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Mendapatkan data yang dikirim oleh aplikasi Flutter
$data = json_decode(file_get_contents("php://input"), true);

// Debugging: Log data yang diterima
error_log(print_r($data, true)); // Menulis data ke log error

$nim = $data['nim'] ?? null;
$nama = $data['nama'] ?? null;
$alamat = $data['alamat'] ?? null;
$jenisKelamin = $data['jenisKelamin'] ?? null;
$password = $data['password'] ?? null;

// Memastikan semua data terisi
if (isset($nim) && isset($nama) && isset($alamat) && isset($jenisKelamin) && isset($password)) {
    // Menyusun query INSERT
    $sql = "INSERT INTO anggota (nim, nama, alamat, jenis_kelamin, password) 
            VALUES ('$nim', '$nama', '$alamat', '$jenisKelamin', '$password')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(['message' => 'Data berhasil ditambahkan']);
    } else {
        echo json_encode(['error' => 'Terjadi kesalahan: ' . $conn->error]);
    }
} else {
    echo json_encode(['error' => 'Data tidak lengkap']);
}

// Menutup koneksi
$conn->close();
?>
