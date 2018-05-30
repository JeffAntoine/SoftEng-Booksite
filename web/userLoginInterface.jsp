<!DOCTYPE html>
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

  </head>

  <body>

    <h1 class="site-heading text-center text-white d-none d-lg-block">
      <span class="site-heading-upper text-primary mb-3">Thinkgeek meets Barnes and Noble</span>
      <span class="site-heading-lower">ThinkGeek</span>
    </h1>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
      <div class="container">
        <a class="navbar-brand text-uppercase text-expanded font-weight-bold d-lg-none" href="#">Start Bootstrap</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav mx-auto">
            <li class="nav-item active px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="index.jsp">Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="about.html">About</a>
            </li>
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="books_db.jsp">Books</a>
            </li>
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="shoppingCart.html">Shopping Cart</a>
            </li>
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="userLoginInterface.jsp">Log In</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

  <center>
    <style>
#c{
border-radius:8px;
height:40px;
width:300px;
}
#l{
color:blue;
font-size:20px;
}
</style>

</head>
<body style="background-image:loginBackground.jpg">


<br>
<form name="f1" action="Login" method="post">
  <table><tr><td id="l">
    
      <tr><th><h1><font color="white">Customer Login</font></h1></th></tr>
    <tr><td id="l"> <font color="white"> Username/Email  : </font> </td></tr>
        <tr><td><input type="text" name="eid" placeholder="Employee ID"  id="c"></td></tr>

    <tr><td id="l"> <font color="white">Password : </font> </td></tr>
        <tr><td><input type="password" name="pwd" placeholder="Password"  id="c"></td></tr>

    <tr align="center"><td><input type="submit" name="submit" id="submit" value="Login" style="border-radius:10px;background:black;color:white;width:120px;height:40px;font-size:25px"></td></tr>
    <tr><td align="center"><a href='forgotpassword.jsp'><h3><i>Forgot Password?</i></h3></a></tr>

</table>


</form>
</center>
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
