<?php

$username = $_POST['username'];
$password = $_POST['password'];

$username = stripcslashes($username);
$password = stripcslashes($password);
#$username = mysqli_real_escape_string($username);
#$password = mysqli_real_escape_string($password);

$testdb = mysqli_connect("localhost", "root", "");
mysqli_select_db($testdb, "login");

$result = mysqli_query($testdb, "select * from users where username = '$username' and password = '$password'")
or die("Fail to query database" .mysqli_error() );

$row = mysqli_fetch_array($result);

if($row['username'] == $username && $row['password'] == $password)
{
  Echo "<a href=userLoginInterfaceSucess.jsp>Click For Success!!</a>";
}
else {
  Echo "<a href=userLoginInterfaceFail.jsp>Click Oops Something Happend. Click Here!!</a>";
}

?>
