<?php
function getIDFromUsername($mysqli){
    $query = "SELECT ID FROM Users WHERE USERNAME = \"" .$_POST["username"] . "\"";
    $queryResult= $mysqli->query($query);
    $ID = getJSONFromSQL($queryResult);
    console_log("getID");
    console_log($ID);
    return($ID[0]);
    
}

?>