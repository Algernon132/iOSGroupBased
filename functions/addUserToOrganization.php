<?php
function addUserToOrganization($mysqli){
    //verify username and password
    verifyCredentials($mysqli);
    $returnObject = new returnJSON();
    $organizationName = $_POST['organizationName'];
    $organizationPassword = $_POST['organizationPassword']; //hashed
    //verify the organization password matches the organization ID
    
    $query = "SELECT * FROM Organization WHERE OrganizationName =" ;
    //SELECT * FROM Organization WHERE OrganizationName = "$organizationName" AND OrganizationPassword = "$organizationPassword"
    
    //set user's organizationID to the correct org
}

?>