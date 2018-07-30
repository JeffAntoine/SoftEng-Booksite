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
            //PreparedStatement insertBook = null;
            ResultSet resultSet = null;
            ResultSet resultSet2 = null;
            PreparedStatement selectAuthor = null;

            public Book(String author)
            {
                try
                {
                    System.out.print("Hello\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Hello\n");
                    selectBook = connection.prepareStatement(
                        "select * from book where author = ?");
                    selectBook.setString(1, author);
                    
                    selectAuthor = connection.prepareStatement(
                        "select * from author where name = ?");
                    selectAuthor.setString(1, author);

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
            public ResultSet getAuthor()
            {
                try
                {
                    resultSet2 = selectAuthor.executeQuery();
                } catch (SQLException e)
                {
                    e.printStackTrace();
                }
                return resultSet2;
            }
            
        }

        %>
        <%
            String authorName = request.getParameter("author");
            Book book = new Book(authorName);
            ResultSet books = book.getBook();
            ResultSet author = book.getAuthor();
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
            <li>
            	<font color="white" ><i> Welcome, ${username} </i></font><br/>
            	<font color= "white" > <a class="nav-link text-uppercase text-expanded" href="userProfileHTML.jsp" > Profile </a></font>
            </li>
           </ul>
        </div>
      </div>
    </nav>
                

<section class="page-section">
      <div class="container">
        <div class="product-item">
          <div class="product-item-title d-flex">
            <div class="bg-faded p-5 d-flex ml-auto rounded">
              <h2 class="section-heading mb-0">
                <span class="section-heading-upper">Author:</span>
                <span class="section-heading-lower"><%= authorName%></span>
              </h2>
            </div>
          </div>
            <p>&nbsp</p>
            <p>&nbsp</p>
            <p>&nbsp</p>
          <div class="product-item-description d-flex mr-auto">
            <div class="bg-faded p-5 rounded">
              <p class="mb-0">        
                <style>td{padding: 3px;}</style>   
                            
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
                    return "<img src=\"" + dataURL + "\" style=\"max-width: 200px; height:auto\"/>";
                }%>
                
                <% author.next();%>
                <b>Meet the Author:</b> <div align="justified"><%=author.getString("bio")%></div>
                <p></p>
                
                
                <table id = "bookList" width="1000">
                            <thead>
                                <tr>
                                <th></th>
                                <th width="300"> <div align="center">Book ID: </div></th>
                                <th width="600"> <div align="center">Title: </div></th>
                                <th width="800"> <div align="center">Genre: </div></th>
                                <th width="600"> <div align="center">Release Date: </div></th>
                                <th width="300"> <div align="center">Price: </div></th>
                                <th width="80"> <div align="center">Stock: </div></th>
                                </tr>
                                <td></td>
                            </thead>
                            <tbody>
                                <% while(books.next()) {%>
                                    <tr>
                                        <td><div align="center"><%= getCoverHTML(books.getBlob("cover")) %></div></td>
                                        <td><div align="center"><%= books.getString("bookid")%></div></td>
                                        <td><div align="center"><a href="basicbook.jsp?id=<%= books.getString("bookid")%>"><%= books.getString("title")%></a></div></td>
                                        <td><div align="center"><%= books.getString("genre")%></div></td>
                                        <td><div align="center"><%= books.getString("releaseDate")%></div></td>
                                        <td><div align="center">$<%= books.getString("price")%></div></td>
                                        <td><div align="center"><%= books.getString("stock")%></div></td>
                                        <td></td>
                                    </tr>
                                <%}%>
                            </body>
                        </table>
                            
                                               
                </div><!-- end row-->
            </div>
        </div><!-- END ROW------PICTURE AND DESCRIPTION -->
    
    
            </div>
        </div><!-- END CONTAINER -->
</section>

<!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>