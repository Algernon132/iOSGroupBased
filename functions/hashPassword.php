<?php
function hashPassword($password){
    $hashedPass = hash('sha256', $password);
    return $hashedPass;
}
    
?>