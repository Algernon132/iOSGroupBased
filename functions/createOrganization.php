<?php
function createOrganization($mysqli){     
    $returnObject = new returnJSON();
    
    $orgName = $_POST["organizationName"];
    $orgPass = $_POST["organizationPassword"];
    $orgDescription = $_POST["organizationDescription"];
    $argumentArray = array($orgName, hashPassword($orgPass), $orgDescription);
    //Create new organization tuple
    $query = "INSERT INTO Organizations (OrganizationName, OrganizationPassword, OrganizationDescription)" . createArgs($argumentArray);//Set organization name, description, and password
    
    console_log("organization query: " . $query);
    $queryResult = $mysqli->query($query);  //send SQL query
    if($queryResult == true){
        console_log("Organization tuple created successfully");
    }else{
        $returnObject->successCode = 1;     //general failure
        die(json_encode($returnObject));
    }
    
    //Create new editor tuple
    $userID = $_POST["userID"];
    $OrganizationID = $mysqli->insert_id;   //retrieve autoIncrement ID from the last query
    $editorArgArray = array($userID, $OrganizationID);
    $editorQuery = "INSERT INTO Editors (UserID, OrganizationID)" . createArgs($editorArgArray);
    //Set organizationID to ID just generated and set Editor to the userID who created it.
    console_log($editorQuery);
    $queryResult = $mysqli->query($editorQuery);  //send SQL query
    if($queryResult == true){
        $returnObject->successCode = 0;     //success
    }else{
        $returnObject->successCode = 5;     //general failure
        die(json_encode($returnObject));
    }
}

?>