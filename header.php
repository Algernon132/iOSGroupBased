<?php
//Report errors. Remove from production
//FOR TESTING ONLY
ini_set('display_errors',1); error_reporting(E_ALL);

require "dbConfig.php";
require "returnJSON.php";

//Get each file from the functions directory
foreach (glob("functions/*.php") as $filename)
{
    require $filename;
}


//Create connection
$mysqli = new mysqli($dbhost,$dbuser,$dbpass,$dbname);  //from db.conf
    if($mysqli->connect_error){
        die('There was an error connecting to the database. Error number ' . $mysqli->connect_errno .' '. $mysqli->connect_error);
        }
console_log("Connected successfully");

//sanitize all user inputs to avoid mysql injection
foreach( $_POST as $key=>$stuff ) {
    if( is_array( $stuff ) ) {
        foreach( $stuff as $thing ) {
            $thing = $mysqli->real_escape_string($thing);
            if(is_numeric($thing)){
                $thing = (int)$thing;   //html forms only send strings, this will change strings containing numbers into ints so we can actually use them
            }
            $_POST[$key] = $thing;
        }
    } else {
        $stuff = $mysqli->real_escape_string($stuff);
        if(is_numeric($stuff)){
           $stuff = (int)$stuff;         
        }
        $_POST[$key] = $stuff;
        console_log($stuff);
    }
    
}
?>