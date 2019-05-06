<?php
include"header.php";        //Connects to mysql, enables error reporting, imports function files
$_POST["username"] = "testFromWeb";
$_POST["hashedPassword"] = "changedPass";
$_POST["newPassword"] = "changedPass2";
$_POST["action"] = "changePassword";
//echo json_encode($_POST);
include("callFuncFromQuery.php");
?>
