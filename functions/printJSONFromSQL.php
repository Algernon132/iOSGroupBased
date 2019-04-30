<?php
function printJSONFromSQL($mysqlResult){
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