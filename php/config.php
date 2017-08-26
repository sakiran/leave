<?php
header('Access-Control-Allow-Origin: *');
$host     = 'localhost';
$username = 'root';
$password = '';
$database = 'leave';
$dbconfig = mysqli_connect($host, $username, $password, $database);
?>