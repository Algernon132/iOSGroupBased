<?php
function loadContent($mysqli){
    $returnObject = new returnJSON();
    
    $query = "SELECT * FROM Uploads";
    
    $queryResult = $mysqli->query($query);
    if($queryResult != false){
        $returnObject->successCode = 0;
        $returnObject->isReturnedJSON = true;
        $returnObject->returnJSON = "test";
        $returnObject->returnJSON = getJSONFromSQL($queryResult);
    }else{
        $returnObject->successCode = 4;
    }
    console_log("Loaded content");
    die(json_encode($returnObject));
}

?>