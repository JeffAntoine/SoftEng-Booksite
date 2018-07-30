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
            String PASSWORD = "1122";

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
         
         
         <!-- JEFFS JSP BELOW-->
         <%!
        public class Comment {
                
                String URL = "jdbc:mysql://localhost:3306/geek_text";
                String USERNAME = "root";
                String PASSWORD = "1122";
                Connection connection = null;

                PreparedStatement insertComment = null;
                PreparedStatement selectComment = null;

                ResultSet resultSet = null;

                public Comment(){
                    try {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        
                        insertComment = connection.prepareStatement(
                        "INSERT INTO comments (bookid, userName, comment, score, anon, showName)"
                      + " VALUES (?,?,?,?,?,?);");
                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }
                    try {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        
                        selectComment = connection.prepareStatement(
                        "SELECT  bookid, showName,score, comment FROM comments;");
                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }
                }
                 public ResultSet getComment(){
                    try{
                        resultSet = selectComment.executeQuery();
                    } 
                    catch (SQLException e){
                    e.printStackTrace();
                    }
                    return resultSet;
                }
                public int setComment (String bookid, String userName, String comment, String scores, String anon, String showName){
                    int result = 0;
                    String non = "Anonymous";
                    try{
                        insertComment.setString(1, bookid);
                        insertComment.setString(2, userName);
                        insertComment.setString(3, comment);
                        insertComment.setString(4, scores);
                        insertComment.setString(5, anon);
                        if(anon.equals("anon")){
                            insertComment.setString(6, non);                            
                        }
                        if(anon.equals("public")){
                            insertComment.setString(6, userName);
                        }

                        result = insertComment.executeUpdate();
                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }
                    return result;
                }
            }
        %>
        
        <%
            int result = 0;
            
            if(request.getParameter("submit") != null){
                String book_id = new String();
                String user_name = new String();
                String commenting = new String();
                String scores = new String();
                String anon_input = new String();

                
                    book_id = bookId;
                
                
                    user_name = user;
                
                
                if (request.getParameter("comment") != null){
                    commenting = request.getParameter("comment");
                }
                if (request.getParameter("scores") != null){
                    scores = request.getParameter("scores");
                }
                if(request.getParameter("anon") != null){
                    anon_input = request.getParameter("anon");
                }
                
                Comment com = new Comment();
                result = com.setComment(book_id, user_name, commenting, scores, anon_input, user_name);
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
                    <a href="image.jsp?id=<%= books.getString("bookid")%>"><img class="product-item-img2 mx-auto d-flex rounded img-fluid mb-3 mb-lg-0  " src="<%= getCoverHTML(books.getBlob("cover")) %>" alt=""></a>     
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
            <div class='col-md-6 bg-faded1 p-5 d-flex ml-auto rounded '> <!--here is the description -->
                <div class="bg-faded rounded p-5">
                <!-- need to put clean background around it -->
                <div class="col-md-12">
                    <div class="row">                    
                        <div class="col-md-12">
                            <center><h3><td><%= books.getString("title")%></td></h3>
                        
                                <span class="badge badge-success">You Own This!</span>
                                <span class=" badge badge-secondary">Not Owned</span>
                            </center>
                            <span class="section-heading-Upper"><b>Author:</b> <td><a href="<%= books.getString("link")%>"><%= books.getString("author")%></a></td> </span><br>
                            <span class="section-heading-Upper"><b>Book Description:</b> <div align="justify"><td><%= books.getString("description")%></td></div></span>
                  	<span class="section-heading-Upper"><b>Genre:</b> <td><%= books.getString("genre")%></td></span><br>
                  	<span class="section-heading-lower"><b>Publisher:</b> <td><%= books.getString("publisherName")%></td></span><br>
                        <span class="section-heading-lower"><b>Release Date:</b> <td><%= books.getString("releaseDate")%></td></span><br>
                        <span class="section-heading-Lower"><b>Price:</b> $<td><%= books.getString("price")%></td></span><br>
                        
                                
                            <div>
                            <br><span >Global Rating:</span>
                                
                            <span class="fas fa-star" aria-hidden="true"></span>
                            <span class="fas fa-star" aria-hidden="true"></span>
                            <span class="fas fa-star" aria-hidden="true"></span>
                            <span class="far fa-star" aria-hidden="true"></span>
                            <span class="far fa-star" aria-hidden="true"></span>
							 
                                    <!--<text class="monospaced label label-success ">61</text>-->
                            </div>
                        </div>
                        
                        <div class="col-md-12 ">
                            <span class="monospaced">Write a Review below</span><br><br>
                            
                            <form onSubmit="setTimeout(function(){location.reload(true);},14)" action="basicbook.jsp?id=<%= bookId%>" method="POST">
    				<input type="hidden" name="id" value="${id}" />
    				<input type="submit" value="Add To Cart" name ="add" />
                                
			    </form>
                        </div>
                    </div><!-- end row -->                        
                </div><!-- end row-->
            </div>
        </div><!-- END ROW------PICTURE AND DESCRIPTION -->
    
    <p> &nbsp </p>
    <div class="bg-faded rounded p-5">
    <div class=' top-buffer '>
        <div class='col-md-12 bg-faded1 p-5 d-flex ml-auto rounded'> <!--here is the description -->
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12">
                        <h3>Reviews/Comments</h3>
                    </div>                        
                    <div>
                    <div class="col-md-12">
                        <!--NEW REVIEWS 
                        <div >
                            <form class="monospaced">write something nice :) </form>                                
                        </div>
                        -->


                        <!-- comment box here-->
                        <div class="page-container" >
                            <form name="myForm" action="basicbook.jsp?id=<%= books.getString("bookid")%>" method="POST" >                   
                                                <div class="form-group">
                                                    <textarea name="comment" class="form-control top-buffer" id="exampleFormControlTextarea1" rows="3" placeholder="Write something nice"></textarea>
                                                    <div class="row col-md-12 justify-content-between">
                                                                                                               
                                                         <td>rate</td>
                                                            <td>
                                                                <select name="scores">
                                                                    <option value="1">1</option>
                                                                    <option value="2">2</option>
                                                                    <option value="3">3</option>
                                                                    <option value="4">4</option>
                                                                    <option value="5">5</option>
                                                                </select>
                                                            </td>
                                                            <td>Anon</td>
                                                            <td>
                                                                <select name="anon">
                                                                    <option value="public">Public</option>
                                                                    <option value="anon">Anonymous</option>
                                                                </select>
                                                            </td>
                                                    </div>
                                                </div>
                                                <div class ="row left-buffer justify-content-between" >
                                                    <div class="form-check">
                                                        <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                                        <small id="emailHelp" class="form-text text-muted">This message does not promote hate of any kind</small>
                                                    </div>
                                                    <input type="submit" value="Submit" name="submit" />
                                                </div>
                                                
                                </form>
                        </div>           
                            <!-- old reviews -->
                             <%
                                    Comment com = new Comment();
                                    ResultSet comss = com.getComment();
                                %>
                                <div class="page-container">
                                        <% 
                                            while (comss.next()) {
                                        %>
                                            
                                        <!-- PAST TABLE CODE--> 
                                        <div class="comment bg-faded1 col-md-12">
                                                <div class="info">
                                                    <div class ="row left-buffer " >
                                                        <span class="section-heading-Upper"><b><%= comss.getString("showName")%></b></span><br>
                                                        <span class="left-buffer">Book ID:</span>
                                                        <a class="left-buffer"><%= comss.getString("bookid")%></a>
                                                    </div>
                                                    <div class ="row left-buffer " >
                                                        <span class="left-buffer">Rate Given:</span>
                                                        <a class="left-buffer"><%= comss.getString("score")%></a>
                                                    </div>
                                                    <p class="top-buffer-text"><%= comss.getString("comment")%></p>
                                                </div>
                                                
                                                

                                         </div>

                                   
                                     <% }%>
                                </div>
                        <div class="top-buffer" >
                            
                        </div>
                    </div><!-- end row -->                   
                    </div><!-- end row-->
                </div>
            </div>
            <div class = "col-md-12"><!-- Here is the bottome for the comment section-->
             <!-- 
                HERE NEEDS TO HAVE SEPERATION FROM TOP ELEMENTS
             
              row -- > small pic and rating
                    coloumn on other side 
                        -- > top has book title 
                        -- > stars to pick from
             
              row-- > full comment takes up space or reactive to text for size       
             -->
            </div>
        </div><!-- END CONTAINER -->
</section>

<!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>