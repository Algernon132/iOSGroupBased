<?php
require "returnJSON.php";
if(!isset($_POST["action"])){
    $returnObject = new returnJSON();
    $returnObject->successCode = 8;
    die(json_encode($returnObject));
}

include"header.php";        //Connects to mysql, enables error reporting, imports function files

console_log(json_encode($_POST));

//verify the userID matches the password
if($_POST["action"]!="createUser"){
    verifyCredentials($mysqli);
}

include"callFuncFromQuery.php";
?>
