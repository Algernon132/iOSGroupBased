<?php
function getJSONFromSQL($mysqlResult){
   if(gettype($mysqlResult)!="array"){
        //will crash if not passed an array
        return null;
   }
    //Initialize array variable
  $dbdata = array();

//Fetch into associative array
  while ( $row = $mysqlResult->fetch_assoc())  {
	   $dbdata[]=$row;
  }

//Return array in JSON format
 return json_encode($dbdata);
}

?>