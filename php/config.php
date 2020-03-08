<?php
header('Access-Control-Allow-Origin: *');
$host     = 'localhost';
$username = 'admin';
$password = 'adminpassword';
$database = 'dbleave';
$dbconfig = mysqli_connect($host, $username, $password, $database);
?>
