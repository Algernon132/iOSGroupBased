<?php
function createUser($mysqli){
    //Get variables from POST. POST can be sent from web, desktop program, or app.
    $username = $_POST["username"];
    $hashedPassword = $_POST["hashedPassword"];
    $userStatus = 0;    //DEFAULT VALUE. CHANGE WHEN APPROPRIATE
    $fullName = $_POST["fullName"];
    $returnObject = new returnJSON();
    if(isset($_POST["organizationID"])){
        $organizationID = $_POST["organizationID"];
    }else{
        $organizationID = NULL;
    }
    
    $argArray = array($username,$hashedPassword,$userStatus,$organizationID,$fullName);
    //Create user tuple
    $query = 'INSERT INTO Users(Username,HashedPassword,UserStatus,OrganizationID,FullName)' . createArgs($argArray); //Automatically generates string for SQL args. Huge pain otherwise
    console_log($query);
    
    performInsert($mysqli,$query,$returnObject);
}

?>