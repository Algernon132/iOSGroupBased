<?php

    //Every function will be passed the active mysqli connection. Queries will then be sent from the respective function.
    if($_POST != null){
    $queryType = $_POST["action"];
      switch($queryType){
          case 'login':
              login($mysqli);
              break;
          case 'logout':
              logout($mysqli);
              break;
          case 'loadContent':
              loadContent($mysqli);
              break;
          case 'shareProject':
              shareProject($mysqli);
              break;
          case 'createUser':
              createUser($mysqli);
              break;
          case 'createOrganization':
              createOrganization($mysqli);
              break;
          case 'deleteUser':
              deleteUser($mysqli);
              break;
          case 'deleteOrganization':
              deleteOrganization($mysqli);
              break;
          case 'createProject':
              createProject($mysqli);
              break;
          case 'deleteProject':
              deleteProject($mysqli);
              break;
          case 'addUserToOrganization':
              addUserToOrganization($mysqli);
              break;
          case 'removeUserFromOrganization':
              removeUserFromOrganization($mysqli);
              break;
          case 'addContributorToProject':
              addContributorToProject($mysqli);
              break;
          case 'removeContributorFromProject':
              removeContributorFromProject($mysqli);
              break;
          case 'uploadTextEntry':
              uploadTextEntry($mysqli);
              break;
          case 'deleteTextEntry':
              deleteTextEntry($mysqli);
              break;
          case 'uploadMedia':
              uploadMedia($mysqli);
              break;
          case 'deleteMedia':
              deleteMedia($mysqli);
              break;
          case 'changePassword':
              changePassword($mysqli);
              break;
          case 'updateProject':
              updateProject($mysqli);
              break;
          case 'updateOrganization':
              updateOrganization($mysqli);
              break;
          case 'addEditorNote':
              addEditorNote($mysqli);
              break;
          default:
              die(json_encode(false));
      }
    }else{
        //die(json_encode($_POST));
        echo('');
    }
?>

