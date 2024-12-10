
<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT");
header("Access-Control-Allow-Headers: Content-Type");
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'pustaka_2301083018';

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT id, judul, pengarang FROM buku";
$result = $conn->query($sql);

$books = [];
if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $books[] = $row;
  }
}

echo json_encode($books);
$conn->close();
?>
