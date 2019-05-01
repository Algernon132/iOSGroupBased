<?php
include"header.php";        //Connects to mysql, enables error reporting, imports function files
$_POST["name"] = "newTestName";
$_POST["password"] = "newTestPass";
createUser($mysqli);
?>
