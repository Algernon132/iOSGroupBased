<?php
function createProject($mysqli){
    $username = $_POST["username"];
    $hashedPassword = $_POST["hashedPassword"];
    $projectName = $_POST["projectName"];
    $projectDescription = $_POST["projectDescription"];
    
    if(isset($_POST["organizationID"])){
        $organizationID = $_POST["organizationID"];
    }else{
        $organizationID = NULL;
    }
    
    //verify the userID matches the password
    
    //Set LeaderID to userID that created the project
    //Set project name and description
    //If an organization ID is provided, set it. Otherwise set it to NULL
}

?>