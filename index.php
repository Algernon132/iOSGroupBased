<?php
include"header.php";        //Connects to mysql, enables error reporting, imports function files

//just for testing
$_POST["username"] = "testFromWeb";
$_POST["hashedPassword"] = "changedPass";
$_POST["newPassword"] = "changedPass2";
$_POST["action"] = "changePassword";

//sanitize user inputs to avoid mysql injection
foreach( $_POST as $stuff ) {
    if( is_array( $stuff ) ) {
        foreach( $stuff as $thing ) {
            $thing = $mysqli->real_escape_string($thing);
        }
    } else {
        $stuff = $mysqli->real_escape_string($stuff);
    }
}

//echo json_encode($_POST);
include("callFuncFromQuery.php");
?>
