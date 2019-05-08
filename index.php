<?php
include"header.php";        //Connects to mysql, enables error reporting, imports function files



//just for testing
//$_POST["username"] = "testFromWeb7";
//$_POST["hashedPassword"] = hashPassword("changedPass6");
//$_POST["newPassword"] = "changedPass2";
//$_POST["action"] = "changePassword";
//$_POST["userID"] = 3;
//$_POST["fullName"] = "Testy McTesterson3";
//$_POST["userStatus"] = 0;
//$_POST["projectName"] = "testProject";
//$_POST["projectDescription"] = "Just a test project";
//$_POST["organizationName"] = "testOrg3";
//$_POST["organizationPassword"] = "testPassword";
//$_POST["organizationDescription"] = "Just a test organization";

console_log(json_encode($_POST));
//verify the userID matches the password
if($_POST["action"]!="createUser"){
    verifyCredentials($mysqli);
}

include"callFuncFromQuery.php";
?>
