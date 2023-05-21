<?php

  $db = "tmp_final_db"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["message"] = "";
  $return["success"] = false;

  $connect = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  if(isset($_POST["username"]) && isset($_POST["username"])) {
    $username = $_POST["username"];
    $password = md5($_POST["password"]);

    $username = mysqli_real_escape_string($connect, $username);

    $sql = "SELECT * FROM user_list WHERE username = '$username'";

    $res = mysqli_query($connect, $sql);
    $numrows = mysqli_num_rows($res);

    if(numrows > 0) {
        $obj = mysqli_fetch_object($res);
        if($password == $obj->password) {
            $return["success"] = true;
            $return["full_name"] = obj->full_name;
            $return["student_num"] = obj->student_num;
            $return["message"] = "wrong password.";
        }
        else {
            $return["error"] = true;
            $return["message"] = "no username found.";
        }
    }
    else {
        $return["error"] = true;
    }
  }
  else {
    $return["error"] = true
  }

  mysqli_close($connect);

  header('Content-Type: application/json');
  echo json_encode($return);

?>