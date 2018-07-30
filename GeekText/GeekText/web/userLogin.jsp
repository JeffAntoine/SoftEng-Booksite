%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GeekText</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/business-casual.min.css" rel="stylesheet">
    
<style>
#c{
border-radius:8px;
height:40px;
width:300px;
}
#l{
color:white;
font-size:20px;
text-align:left;
}
</style>
</head>

<body>
<%@ include file="homeMenu.jsp" %>

<body style="background-image:loginBackground.jpg">

<br>
<br>
<form name = "f1" action = "userLoginController" method ="POST">

  <table align="center"><tr><td id="l">

      <tr><th><h1><font color="white">Customer Login</font></h1></th></tr>
    <tr><td id="l"> <font color="white"> Username  : </font> </td></tr>
        <tr><td><input type ="text" id="c" name="username" ></td></tr>

    <tr><td id="l"> <font color="white">Password : </font> </td></tr>
        <tr><td><input type="password" id="c" name="password"></td></tr>

    <tr align="center"><td><input type="submit" name="submit" id="submit" value="Login" style="border-radius:10px;background:black;color:white;width:120px;height:40px;font-size:25px"></td></tr>
    <tr><td align="center"><a href='registration.jsp'><i>Sign Up</i></a></tr>

</table>

</form>

    <p> &nbsp </p>
    <p> &nbsp </p>

    <footer class="footer text-faded text-center py-5">
      <div class="container">
        <p class="m-0 small">Copyright &copy; Your Website 2018</p>
      </div>
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
