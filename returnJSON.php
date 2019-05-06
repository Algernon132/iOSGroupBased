<?php

class returnJSON{
    var $successCode;        //Status of success/failure
    var $isReturnedJSON;    //boolean. True if any JSON was returned, like when accessing submissions
    var $returnJSON;        //Actual JSON content to be returned. Stored as a JSON encoded String
    function __construct() {
        $this->successCode = 3;
        $this->isReturnedJSON = false;
        $this->returnJSON = null;
    }
}

/*
    STATUS CODES
    0: SUCCESS
    1: GENERAL FAILURE
    2: FAILED TO VERIFY USER CREDENTIALS
    3: SUCCESS CODE WAS NEVER SET. I CODED SOMETHING WRONG, LET ME KNOW
    4: MYSQL QUERY RETURNED NO VALUES
*/

?>