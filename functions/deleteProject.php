<?php
function deleteProject($mysqli){
    //verify username and password
    //verify userID matches LeaderID of project
    //Delete entry in Project table
    
    
    //Set entries to cascade delete????
    //Seems like that would be easier
    //Tables were set to cascade.
    
    //What follows is the previous psuedocode
        //Delete all entries in MediaUploads table with an uploadID matching any upload with a projectID matching the project to be deleted
        //Delete all entries in Uploads table with a projectID matching the project to be deleted
        //Delete all entries in Shares table with a projectID matching the project to be deleted
}

?>