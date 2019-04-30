<?php
function createUser($mysqli){
    //Get variables from POST. POST can be sent from web, desktop program, or app.
    $name = $_POST["name"];
    $password = $_POST["password"];
    $userStatus = 0;    //DEFAULT VALUE. CHANGE WHEN APPROPRIATE
    
    //Create user tuple
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