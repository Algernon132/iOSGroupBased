<?php
function getIDFromUsername($mysqli){
    $query = "SELECT ID FROM Users WHERE USERNAME = \"" .$_POST["Username"] . "\"";
    $queryResult= $mysqli->query($query);
    $ID = getJSONFromSQL($queryResult);
    return($ID);
    
}

?>