<?php
//Connects to mysql, enables error reporting, imports function files
include"header.php";
$argArray = Array("StringArg1",11,"StringArg2",22);
echo(createArgs($argArray));
?>
