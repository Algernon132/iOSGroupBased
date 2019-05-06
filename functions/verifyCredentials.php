<?php
function verifyCredentials($mysqli){
    $hashedPassword = $_POST["hashedPassword"];
    $username = $_POST["username"];
    $argArray = array($hashedPassword,$username);
    
    //CHANGE "name" TO "username" on production
    $query = "SELECT ID FROM Users WHERE name = " . "'" . $username . "'" . " AND password = " . "'" . $hashedPassword . "';";
    console_log($query);
    $queryResult = $mysqli->query($query);
    console_log(json_encode($queryResult));
    
    //Close connection and print JSON if no results are found for the given username and password
    if($queryResult->num_rows != null && $queryResult->num_rows != 0){
        return true;
    }else{
        $failureObject = new returnJSON();
        $failureObject->successCode = 2;    //failed to verify credentials
        die(json_encode($failureObject));
    }
    
}

?> 