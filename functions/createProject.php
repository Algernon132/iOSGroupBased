<?php
function createProject($mysqli){
    $returnObject = new returnJSON();
    
    $username = $_POST["username"];
    $hashedPassword = $_POST["hashedPassword"];
    $userID = $_POST["userID"];
    $projectName = $_POST["projectName"];
    $projectDescription = $_POST["projectDescription"];
    
    if(isset($_POST["organizationID"])){    //orgID is optional
        $organizationID = $_POST["organizationID"];
    }else{
        $organizationID = NULL;
    }
    //verify the userID matches the password
    verifyCredentials($mysqli);
    
    $argArray = array($projectName, $projectDescription, $organizationID, $userID);
    
    //Set LeaderID to userID that created the project
    //Set project name and description
    //If an organization ID is provided, set it. Otherwise set it to NULL
    $query = "INSERT INTO Project (ProjectName, ProjectDescription, OrganizationID, LeaderID)" . createArgs($argArray);
    
    performInsert($mysqli,$query,$returnObject);
    
    
}

?>