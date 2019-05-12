<?php
function addUserToOrganization($mysqli){
    $returnObject = new returnJSON();
    
    $organizationName = $_POST['organizationName'];
    $organizationPassword = $_POST['organizationPassword']; //hashed
    //verify the organization password matches the organization ID
    
    $tableName = "Organization";
    $returnValueArray = array("*"); //select all
    $whereArray= array("OrganizationPassword"=>$organizationPassword,"OrganizationName"=>$organizationName);
    
    
    $query = createSelectStatement($tableName,$returnValueArray,$whereArray);
    //SELECT * FROM Organization WHERE OrganizationName = "$organizationName" AND OrganizationPassword = "$organizationPassword"
    
    //$queryResult = $mysqli->query($query);
    //replaced by performInsert
    
    performInsert($mysqli,$query,$returnObject);
    
    //set user's organizationID to the correct org
}

?>