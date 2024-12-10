<?php
include 'conn.php';

// Eksekusi query untuk mengambil data dari tabel "buku"
$queryResult = $connect->query("SELECT * FROM anggota");

$result = array();

// Periksa apakah query berhasil
if ($queryResult) {
    while ($fetchData = $queryResult->fetch_assoc()) { // Perbaikan dari FECTH_ASSOC menjadi fetch_assoc
        $result[] = $fetchData;
    }
    // Mengembalikan hasil dalam format JSON
    echo json_encode($result);
} else {
    // Tampilkan pesan error jika query gagal
    echo json_encode(array("error" => $connect->error));
}
?>
