<?php
function createSelectStatement($tableName,$returnValueArray,$whereArray){
    //tableName is the name of the table to be selected from
    
    //returnValueArray is an array of values to be returned
    //e.g. '*' or ('name','ID','dateCreated')
    
    //whereArray is an associative array of values to be put into the statement's WHERE clause
    //eg 'id'=1 AND 'name'='joe'
    //null if no WHERE clause
    
    $statement = "SELECT ";
    if(count($returnValueArray)>1){                     //if there is more than one return value
        foreach($returnValueArray as $returnValue){
            $statement .= $returnValue;
            $statement .= ",";
        }
        $statement = rtrim($statement,',');             //remove trailing comma
    }else{
        $statement .= $returnValueArray[0];
    }
    $statement .= " FROM ";
    $statement .= $tableName;
    if($whereArray != null){                            //skip all of this if there are no WHEREs
        $statement .= " WHERE ";
        foreach($whereArray as $key=>$value){
            $statement .= $key;
            $statement .= " = ";
            if(gettype($value) == "string"){            //have to enclose strings in quotes
                $statement .= "\"";
                $statement .= $value;
                $statement .= "\"";
            }else if($value == null){                   //special case. Don't enclose null values in quotes
                $statement .= "null";
            }else{
                $statement .= $value;                   //presumably an int
            }
            $statement .= " AND "; 
        }//end foreach
        $statement = rtrim($statement,' AND ');         //remove trailing 'AND'
    }
    
    $statement .= ";";                                  //final semicolon

    return($statement);

}//end function
?>

