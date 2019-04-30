<?php
function printJSONFromSQL($mysqlResult){
   if(gettype($mysqlResult)!=array){
        //will crash if not passed an array
        echo("PrintJSON did not receive array. The query likely completed, but the result can't be returned.");
        return;
   }
    //Initialize array variable
  $dbdata = array();

//Fetch into associative array
  while ( $row = $mysqlResult->fetch_assoc())  {
	   $dbdata[]=$row;
  }

//Print array in JSON format
 echo json_encode($dbdata);
}

?>