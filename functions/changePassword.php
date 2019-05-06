<?php
function changePassword($mysqli){
    //verify username and password match
    verifyCredentials($mysqli);
    $newPassword = $_POST["newPassword"];
    $username = $_POST["username"];
    $returnObject = new returnJSON;        //Create an empty object without warnings
    
    
    $query = "UPDATE Users SET password = " . "'" . $newPassword . "'" . " WHERE username = " . "'" . $username . "';";
    console_log($query);
    $queryResult = $mysqli->query($query);
    if($queryResult === true){
        $returnObject->successCode = 1;     //general failure
        
    }else{
        $returnObject->successCode = 0;     //success
    }
    $returnObject->isReturnedJSON = false;
    $returnObject->returnJSON = null;
    echo json_encode($returnObject);
    //update password
    //would like to use at least hashed passwords. This would be a good place to hash it
}

?>