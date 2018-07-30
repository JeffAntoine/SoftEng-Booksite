<%@page import="java.sql.*"%>
<%@ page import="java.io.*" %> 
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        <%!
        public class Book
        {
            String URL = "jdbc:mysql://localhost:3306/geek_text";
            String USERNAME = "root";
            String PASSWORD = "1122";

            Connection connection = null;
            PreparedStatement selectBook = null;
            ResultSet resultSet = null;

            public Book()
            {
                try
                {
                    System.out.print("Hello\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Hello\n");
                    selectBook = connection.prepareStatement(
                        "select * from book order by price");
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
        }

        %>
        <%
            Book book = new Book();
            ResultSet books = book.getBook();
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
      <div class="container">
        <div class="product-item">
          <div class="product-item-title d-flex">
            <div class="bg-faded p-5 d-flex ml-auto rounded">
              <h2 class="section-heading mb-0">
                <span class="section-heading-upper">Book Selection</span>
                <span class="section-heading-lower">All Books</span>
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
                
                <form name="sortPrice" method="POST" action="bookQuery.jsp"> 
                    <p><button>Sort by Price</button></p>
                </form>
                
                
                
                <center><table id = "bookList" width="1000">
                            <thead>
                                <tr>
                                <th></th>
                                <th width="300"> <div align="center">Book ID </div></th>
                                <th width="600"> <div align="center">Title </div></th>
                                <th width="700"> <div align="center">Author </div></th>
                                <th width="800"> <div align="center">Genre </div></th>
                                <th width="600"> <div align="center">Release Date </div></th>
                                <th width="300"> <div align="center">Price </div></th>
                                <th width="80"> <div align="center">Stock </div></th>
                                </tr>
                                <td></td>
                            </thead>
                            <tbody>
                                
                                <% while(books.next()) {%>
                                    <tr>
                                        <td><div align="center">test</div></td>
                                        <td><div align="center"><%= books.getString("bookid")%></div></td>
                                        <td><div align="center"><%= books.getString("title")%></a></div></td>
                                        <td><div align="center"><%= books.getString("author")%></div></td>
                                        <td><div align="center"><%= books.getString("genre")%></div></td>
                                        <td><div align="center"><%= books.getString("releaseDate")%></div></td>
                                        <td><div align="center">$<%= books.getString("price")%></div></td>
                                        <td><div align="center"><%= books.getString("stock")%></div></td>
                                        <td></td>
                                    </tr>
                                <%}%>
                            </body>
                        </table>
                </center>
                   
                   <div class="pagination-container">
                       <nav>
                           <ul class="pagination"></ul>
                       </nav>
                   </div>
          </div>
        </div>
      </div>
    </div>
    </section>

    <footer class="footer text-faded text-center py-5">
      <div class="container">
        <p class="m-0 small">Copyright &copy; Your Website 2018</p>
      </div>
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
