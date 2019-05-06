<?php
function createUser($mysqli){
    //Get variables from POST. POST can be sent from web, desktop program, or app.
    $name = $_POST["name"];
    $hashedPassword = $_POST["hashedPassword"];
    $userStatus = 0;    //DEFAULT VALUE. CHANGE WHEN APPROPRIATE
            
    $returnObject = new returnJSON();
    if(isset($_POST["organizationID"])){
        $organizationID = $_POST["organizationID"];
    }else{
        $organizationID = NULL;
    }
    
    $argArray = array($name,$password,$userStatus,$organizationID);
    //Create user tuple
    $query = 'INSERT INTO Users(Name,Password,UserStatus)' . createArgs($argArray); //Automatically generates string for SQL args. Huge pain otherwise
    console_log($query);
    
    performInsert($mysqli,$query,$returnObject);
}

?>