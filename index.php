<?php
//Connects to mysql, enables error reporting, imports function files
include"header.php";
$_POST['name'] = 'testFromWeb';
$_POST['password'] = 'testpass';
createUser($mysqli);
?>
