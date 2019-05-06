<?php
function createUser($mysqli){
    //Get variables from POST. POST can be sent from web, desktop program, or app.
    $name = $_POST["name"];
    $hashedPassword = $_POST["hashedPassword"];
    $userStatus = 0;    //DEFAULT VALUE. CHANGE WHEN APPROPRIATE
            
    if(isset($_POST["organizationID"])){
        $organizationID = $_POST["organizationID"];
    }else{
        $organizationID = NULL;
    }
    
    $argArray = array($name,$password,$userStatus,$organizationID);
    //Create user tuple
    $query = 'INSERT INTO Users(Name,Password,UserStatus)' . createArgs($argArray); //Automatically generates string for SQL args. Huge pain otherwise
    console_log($query);
    $queryResult = $mysqli->query($query);
    if($queryResult == true){
        echo "Successfully created user.";
    }else{
        echo "Could not create user.";
    }
}

?>