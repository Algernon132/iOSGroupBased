<?php
function createOrganization($mysqli){ 
    //Verify userID and password
    verifyCredentials($mysqli);
    
    $returnObject = new returnJSON();
    
    $orgName = $_POST("organizationName");
    $orgPass = $_POST("organizationPassword");
    $orgDescription = $_POST("organizationDescription");
    $orgArgArray = array($orgName, hashPassword($orgPass), $orgDescription);
    //Create new organization tuple
    $orgQuery = "INSERT INTO Organization (OrganizationName, OrganizationPassword, OrganizationDescription)" . createArgs($argArray);//Set organization name, description, and password
    
    console_log("organization query: " . $orgQuery);
    $queryResult = $mysqli->query($query);  //send SQL query
    if($queryResult == true){
        console_log("Organization tuple created successfully");
    }else{
        $returnObject->successCode = 1;     //general failure
        die(json_encode(returnObject));
    }
    
    //Create new editor tuple
    $userID = $_POST("userID");
    $OrganizationID = $mysqli->insert_id;   //retrieve autoIncrement ID from the last query
    $editorArgArray = array($userID, $OrganizationID);
    $editorQuery = "INSERT INTO Editors (UserID, OrganizationID)" . createArgs($editorArgArray);
    //Set organizationID to ID just generated and set Editor to the userID who created it.
    $queryResult = $mysqli->query($editorQuery);  //send SQL query
    if($queryResult == true){
        $returnObject->successCode = 0;     //success
    }else{
        $returnObject->successCode = 1;     //general failure
        die(json_encode($returnObject));
    }
}

?>