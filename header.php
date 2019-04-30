<?php
//Report errors. Remove from production
//FOR TESTING ONLY
ini_set('display_errors',1); error_reporting(E_ALL);

function console_log( $data ){ //prints data to console. Very useful for debugging v
  echo '<script>';
  echo 'console.log('. json_encode( $data ) .')';
  echo '</script>';
}

require "dbConfig.php";
//Get each file from the functions directory
foreach (glob("functions/*.php") as $filename)
{
    require $filename;
}

// Create connection
$mysqli = new mysqli($dbhost,$dbuser,$dbpass,$dbname);  //from db.conf
    if($mysqli->connect_error){
        die('There was an error connecting to the database. Error number ' . $mysqli->connect_errno .' '. $mysqli->connect_error);
        }
console_log("Connected successfully");
?>