<?php
function createArgs($arguments){
    //Will take an array of arguments, loop through them, insert them into a string that can be used in an insert command, and returns
    // .= is the PHP string concatenation operator
    

    //Strings need quotes around them and commas separating each argument. Ints need only commas
    //parentheses at start and end
    //no comma at end
    
    $queryString = " VALUES (";                                     //open parentheses
    foreach($arguments as $value)
    {
        //echo "Key=" . $key . ", Value=" . $value;
        if(gettype($value)=="string"){
            $queryString .= '"';                             //start quote if string
            $queryString .= $value;                          //insert string
            $queryString .= '"';                             //close quote if string
        }else if(getType($value)=="integer"){
            $queryString .= $value;                          //special case. Add 'null' w/o quotes     
        }else if($value == null){
            $queryString .= "null";                         //insert value if not string (probably int)
        }
        
        $queryString .= ",";
    }//end foreach
    
    $queryString = rtrim($queryString,',');                  //remove trailing comma
    $queryString .= ")";                                     //close parentheses
     
    return $queryString;
    
}//end function

?>