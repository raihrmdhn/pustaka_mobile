<?php
// Set header untuk mengizinkan akses dari sumber yang berbeda (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Menghubungkan ke database (pastikan Anda mengatur informasi koneksi dengan benar)
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "pustaka_2301083018"; // Ganti dengan nama database Anda

// Membuat koneksi ke database
$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Mengambil data JSON yang dikirim dari client
$data = json_decode(file_get_contents("php://input"), true);

// Memastikan bahwa data yang diperlukan ada
if (isset($data['id']) && isset($data['judul']) && isset($data['pengarang']) && isset($data['penerbit']) && isset($data['tahun_terbit'])) {
    $id = $data['id'];
    $judul = $data['judul'];
    $pengarang = $data['pengarang'];
    $penerbit = $data['penerbit'];
    $tahun_terbit = $data['tahun_terbit'];
    $gambar = isset($data['gambar']) ? $data['gambar'] : ''; // Menangani gambar jika ada

    // Menyiapkan query untuk memperbarui data buku
    $sql = "UPDATE buku SET judul=?, pengarang=?, penerbit=?, tahun_terbit=?, gambar=? WHERE id=?";
    $stmt = $conn->prepare($sql);

    // Mengikat parameter dan mengeksekusi query
    $stmt->bind_param("sssssi", $judul, $pengarang, $penerbit, $tahun_terbit, $gambar, $id);

    if ($stmt->execute()) {
        // Mengirim respons sukses
        echo json_encode(["status" => "success", "message" => "Data berhasil diperbarui"]);
    } else {
        // Mengirim respons gagal
        echo json_encode(["status" => "error", "message" => "Gagal memperbarui data"]);
    }

    // Menutup statement dan koneksi
    $stmt->close();
} else {
    // Jika data tidak lengkap
    echo json_encode(["status" => "error", "message" => "Data tidak lengkap"]);
}

// Menutup koneksi
$conn->close();
?>
