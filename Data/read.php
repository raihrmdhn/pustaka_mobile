<?php
require "conn.php";
$query=mysqli_query($connect,"SELECT * FROM anggota");

$data=mysqli_fetch_all($query,MYSQLI_ASSOC);

echo json_encode($data);


?>