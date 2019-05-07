<?php
include"header.php";        //Connects to mysql, enables error reporting, imports function files

//just for testing
$_POST["username"] = "testFromWeb";
$_POST["hashedPassword"] = "changedPass";
$_POST["newPassword"] = "changedPass2";
$_POST["action"] = "changePassword";



//echo json_encode($_POST);
//include("callFuncFromQuery.php");

$tableName = "testTable";
$returnValueArray = array("*");
$whereArray = array("Name"=>"Chaz","ID"=>1);
die(createSelectStatement($tableName,$returnValueArray,$whereArray));
?>
