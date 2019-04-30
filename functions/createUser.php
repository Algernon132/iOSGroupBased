<?php
function createUser($mysqli){
    $name = $_POST["name"];
    $password = $_POST["password"];
    $userStatus = 0;
    
    $query = 'INSERT INTO Users(Name,Password,UserStatus) VALUES ("' .$name . '","' . $password . '",' . $userStatus . ")";
    console_log($query);
    $queryResult = $mysqli->query($query);
    if($queryResult == true){
        echo "Successfully created user.";
    }else{
        echo "Could not create user.";
    }
}

?>