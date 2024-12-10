<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT");
header("Access-Control-Allow-Headers: Content-Type");

// Sertakan file koneksi
include "conn.php"; // Memastikan file conn.php ada di folder yang sama

// Cek apakah koneksi berhasil
if (!$conn) {
    die(json_encode(['error' => 'Gagal terhubung ke database']));
}

// Tangani permintaan OPTIONS (Preflight Request)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Pastikan metode adalah DELETE
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Ambil data JSON dari permintaan
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'] ?? null;

    if ($id) {
        // Sanitasi input ID untuk mencegah SQL Injection
        $id = intval($id);

        // Query untuk menghapus data berdasarkan ID menggunakan prepared statement
        $stmt = $conn->prepare("DELETE FROM anggota WHERE id = ?");
        if ($stmt) {
            $stmt->bind_param("i", $id); // "i" menunjukkan tipe data integer

            if ($stmt->execute()) {
                echo json_encode(['message' => 'Data berhasil dihapus']);
            } else {
                echo json_encode(['error' => 'Terjadi kesalahan: ' . $stmt->error]);
            }

            $stmt->close();
        } else {
            echo json_encode(['error' => 'Gagal menyiapkan statement']);
        }
    } else {
        echo json_encode(['error' => 'ID tidak ditemukan']);
    }
} else {
    echo json_encode(['error' => 'Metode tidak didukung']);
}

// Menutup koneksi
$conn->close();
?>
