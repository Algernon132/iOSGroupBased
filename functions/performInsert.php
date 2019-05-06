<?php

function performInsert($mysqli,$query,$returnObject){
    $queryResult = $mysqli->query($query);
    if($queryResult == true){
        $returnObject->successCode = 0;
    }else{
        $returnObject->successCode = 1;
    }
    die(json_encode($returnObject));
}
?>