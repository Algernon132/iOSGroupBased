<?php
function getJSONFromSQL($mysqlResult){
$dbData = array();
while($r = mysqli_fetch_assoc($mysqlResult)) {
    $dbData[] = $r;
}
return($dbData);
}

?>