<?php
function uploadSubmission($mysqli){
    verifyCredentials($mysqli);

    //User will have already selected the ProjectID to submit this under
    //INSERT INTO Uploads(Title,ProjectID,UploaderID,UploadContent) VALUES (...)
    $title = $_POST["submissionTitle"];
    $projectID = $_POST["submissionProjectID"];
    $uploaderID = $_POST["userID"];
    $uploadContent = $_POST["uploadContent"];
    $argArray = array($title,$projectID,$uploaderID,$uploadContent);
    
    $returnObject = new returnJSON();
    
    $query = "INSERT INTO Uploads(Title,ProjectID,UploaderID,UploadContent)" . createArgs($argArray);
    console_log($query);
    performInsert($mysqli,$query,$returnObject);
}

?>