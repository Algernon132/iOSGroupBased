<?php
function verifyCredentials($mysqli){
    $hashedPassword = $_POST["hashedPassword"];
    $username = $_POST["username"];
    $argArray = array($hashedPassword,$username);
    
    $query = "SELECT ID FROM Users WHERE Username = " . "'" . $username . "'" . " AND HashedPassword = " . "'" . $hashedPassword . "';";
    console_log($query);
    $queryResult = $mysqli->query($query);
    
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