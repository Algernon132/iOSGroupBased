<?php
    function console_log( $data ){ //prints data to console. Very useful for debugging
        echo '<script>';
        echo 'console.log('. json_encode( $data ) .')';
        echo '</script>';
    }
?>