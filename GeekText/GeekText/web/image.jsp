<%@page import="java.sql.*"%>
<%@ page import= "java.io.*" %>
<%@ page import="java.util.Base64" %> 
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <%
        String user = (String)session.getAttribute("username");
        if (user.length() < 1 || user.equals(null))
            user = "Guest";
    %>
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
    <!-- My added CDNs-->
    <link rel="stylesheet" 
          href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" 
          crossorigin="anonymous">
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
  </head>
<body>
    
    <%!
        public class Book
        {
            String URL = "jdbc:mysql://localhost:3306/geek_text";
            String USERNAME = "root";
            String PASSWORD = "root";

            Connection connection = null;
            PreparedStatement selectBook = null;
            PreparedStatement insertBook = null;
            ResultSet resultSet = null;

            public Book(String bookid)
            {
                try
                {
                    System.out.print("Hello\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Hello\n");
                    selectBook = connection.prepareStatement(
                        "select * from book where bookid = ?");
                    selectBook.setString(1, bookid);
                }catch (SQLException e)
                {
                    e.printStackTrace();
                }
            }
            public ResultSet getBook()
            {
                try
                {
                    resultSet = selectBook.executeQuery();
                } catch (SQLException e)
                {
                    e.printStackTrace();
                }
                return resultSet;
            }
            
            public int insert(String user, String bookid, String title, String link, double price)
            {
                System.out.println("user = " + user +"\nbookid = " + bookid + "\ntitle = " + title + "\nprice = " + price);
            	int result = 0;
            	try
                {
                    System.out.print("Hello insert\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Hello insert\n");
                    insertBook = connection.prepareStatement(
                    		 "insert into test_cart (userName, bookid, title, link, price, count)" + " values (?, ?, ?, ?, ?, ?)");
                    insertBook.setString(1, user);
                    insertBook.setString(2, bookid);
                    insertBook.setString(3, title);
                    insertBook.setString(4, link);
                    insertBook.setDouble(5, price);
                    insertBook.setInt(6, 1);
                    result = insertBook.executeUpdate();
                    connection.close();
                    
                }catch (SQLException e)
                {
                    e.printStackTrace();
                }
            	return result;
            }  
        }

        %>
        <%
            String bookId = request.getParameter("id");
            Book book = new Book(bookId);
            ResultSet books = book.getBook();

            
            if (books.next())
            {
                  double price=  Double.parseDouble(books.getString("price"));
                  String title = books.getString("title"); 
                  if (request.getParameter("add") != null)
                  {
                      System.out.println (book.insert(user, bookId, title, null, price));
                  }

            }
            
         %>
  
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
            <li class="nav-item active px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="books_db.jsp">Books</a>
            </li>
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="basic_cart.jsp">Shopping Cart</a>
            </li>
             <li class="nav-item px-lg-4">
                <a class="nav-link text-uppercase text-expanded" href="LoginHTML.jsp">Log In</a>
            </li>
           </ul>
        </div>
      </div>
    </nav>

<section class="page-section">
    <div class="container ">
        <div class=' row bg-div'>
            <div class="product-item col-md-6 top-buffer">
                    <img class="product-item-img2 mx-auto d-flex rounded img-fluid mb-3 mb-lg-0  " src="<%= getCoverHTML(books.getBlob("cover")) %>" alt="" width="1000" height="1000">    
                     <%! public String getCoverHTML (Blob imgBlob){
                    String base64Image = "";
                    String dataURL = "";
                    if (imgBlob != null){
                        try{
                            byte[] blobBytes = imgBlob.getBytes(1,(int) imgBlob.length());
                            base64Image = Base64.getEncoder().encodeToString(blobBytes); 
                            dataURL = "data:image/jpeg;base64," + base64Image;
                        } catch (SQLException e){
                            e.getMessage();
                        }
                    }
                    return dataURL;
                }%>
                
                    <!-- need to put overall rating under the image here -->
            </div>

        </div>
    </div>
            
</section>
<!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>