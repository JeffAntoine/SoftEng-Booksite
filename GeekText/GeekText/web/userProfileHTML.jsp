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
      <span class="site-heading-upper text-primary mb-3">ThinkGeek meets Barnes and Noble</span>
      <span class="site-heading-lower">GeekText</span>
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
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="index.jsp">Home</a>
            </li>
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="books_db.jsp">Books</a>
            </li>
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="basic_cart.jsp">Shopping Cart</a>
            </li>
             <li class="nav-item active px-lg-4">
             <a class="nav-link text-uppercase text-expanded" href="LoginHTML.jsp">Log In</a>
            </li>
            <li>
            	<font color="white" ><i> Welcome, ${username} </i></font><br/>
            	<font color= "white" > <a class="nav-link active text-uppercase text-expanded" href="userProfileHTML.jsp" > Profile </a></font>
           
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

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
String username = request.getParameter("username");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "geek_text";
String userId = "root";
String password ="root";
boolean flag = false;

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
ResultSet resultSet2 = null;
%>
<h2 align="center"><font color= "white"><strong>Customer Info</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr>
<tr>

</tr>
<tr bgcolor="#A52A2A">
<td><b>Username</b></td>
<td><b>Password</b></td>
<td><b>First Name</b></td>
<td><b>Last Name</b></td>
<td><b>Email</b></td>
<td><b>Address</b></td>
<td><b>Credit Card Number</b></td>
<td><b>Credit Card Date</b></td> 

</tr>
<%
 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement = connection.createStatement();
String sql2 = "SELECT * FROM users";
resultSet2 = statement.executeQuery(sql2);
String user = resultSet2.getString(1);
String sql ="SELECT * FROM users WHERE username='",+ user +, "'";


resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr bgcolor="#DEB887">

<td><%=resultSet.getString("username") %></td>
<td><%=resultSet.getString("password") %></td>
<td><%=resultSet.getString("fname") %></td>
<td><%=resultSet.getString("lname") %></td>
<td><%=resultSet.getString("email") %></td>
<td><%=resultSet.getString("address") %></td>
<td><%=resultSet.getString("ccnum") %></td>
<td><%=resultSet.getString("ccdate") %></td>

</tr>

<% 
}


%>
</table>




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