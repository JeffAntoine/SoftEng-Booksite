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
            <li>
            	<font color="white" ><i> Welcome, ${username} </i></font><br/>
            	<font color= "white" > <a class="nav-link text-uppercase text-expanded" href="userProfileHTML.jsp" > Profile </a></font>
           
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
                            <span class="section-heading-Upper"><b>Author:</b> <td><a href="AuthorBooks.jsp?author=<%= books.getString("author")%>"><%= books.getString("author")%></a></td></span><br>
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
                            <form>                   
                                <div class="form-group">
                                    <div class="row col-md-12 justify-content-between">
                                        <input type="email" class="form-control col-md-9" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Headline">
                                            <div class="row">
                                                <div class=" top-buffer col-md-12 ">
                                                    <i class="far fa-star" aria-hidden="true"></i>
                                                    <i class="far fa-star" aria-hidden="true"></i>
                                                    <i class="far fa-star" aria-hidden="true"></i>
                                                    <i class="far fa-star" aria-hidden="true"></i>
                                                    <i class="far fa-star" aria-hidden="true"></i>
                                                </div>
                                            </div>
                                    </div>
                                    <textarea class="form-control top-buffer" id="exampleFormControlTextarea1" rows="3" placeholder="Write something nice"></textarea>
                                </div>
                                                
                                <div class ="row left-buffer justify-content-between" >
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                        <small id="emailHelp" class="form-text text-muted">This message does not promote hate of any kind</small>
                                    </div>
                                    <!-- Rectangular switch will make switch determine ANON status
                                    <label class="switch left-buffer ">
                                    <input type="checkbox">
                                    <span class="slider"></span>
                                    </label>-->
                                    <button type="submit" class="btn btn-primary right-buffer">Submit</button>
                                </div>
                            </form>
                        </div>           
                            <!-- old reviews -->
                        <div class="top-buffer" >
                            <div class="dropdown">
                                <button class="btn btn-outline-dark dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Sort By
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    
                                <a class="dropdown-item" href="#">Newest First</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Most Popular</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Oldest First</a>
                                </div>
                            </div>
                        </div>
                        <div class="justify-content-between row col-md-12">
                            <div  class ="top-buffer" >
                                <div class="row">
                                    <div class="col-md-12 ">
                                        <i class="fas fa-star-half-alt" aria-hidden="true"></i>
                                        <i class="far fa-star" aria-hidden="true"></i>
                                        <i class="far fa-star" aria-hidden="true"></i>
                                        <i class="far fa-star" aria-hidden="true"></i>
                                        <i class="far fa-star" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div>
                                    <span class="badge badge-success">Verified Purchase</span>
                                    <i class ="fas fa-user-secret left-buffer" ></i>
                                    <span class =" monospaced" > (Anon) | 6/18/18</span>
                                    <!-- <span class=" badge badge-secondary">Not Purchased</span>
                                    <span class="monospaced">Janest Dosed</span>-->
                                </div><!-- end row -->                        
                                <div class="row">
                                    <div class="col-md-12 row left-buffer">
                                        <strong class="top-buffer-text" >No Good,</strong>
                                        <p class="description left-buffer">
                                        This book sucked honestly, YouTube is butter
                                    </div>
                                </div><!-- end row -->           
                            </div>
                            <div class="top-buffer right-buffer">
                                <div class="dropdown">
                                    <button class="btn btn-outline-dark dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="#">Report</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div  class ="top-buffer" >
                            <div class="row">
                                <div class="col-md-12 ">
                                    <i class="fas fa-star" aria-hidden="true"></i>
                                    <i class="fas fa-star" aria-hidden="true"></i>
                                    <i class="fas fa-star" aria-hidden="true"></i>
                                    <i class="fas fa-star" aria-hidden="true"></i>
                                    <i class="far fa-star" aria-hidden="true"></i>
                                </div>
                            </div>
                            <div>
                                <span class="badge badge-success">Verified Purchase</span>
                                <!-- <span class=" badge badge-secondary">Not Purchased</span>-->
                                <span class="monospaced">Jane Doe  | 4/22/18</span>
                            </div><!-- end row -->                        
                            <div class="row">
                                <div class="col-md-12 row left-buffer">
                                    <strong class="top-buffer-text" > Has Potential,</strong>
                                    <p class="description left-buffer">
                                        This book was pretty helpful, If it was free 10/10
                                        but its not so 8/10. The introduction was too long for my taste
                                        couldn't really get into it so I went with my 20 page rule.
                                        On page 15 it actually got interesting, nonetheless worth the money
                                        for beginners:)
                                </div>
                            </div><!-- end row -->                         
                        </div>
                                
                        <div  class ="top-buffer" >
                            <div class="row">
                                <div class="col-md-12 ">
                                    <i class="fas fa-star" aria-hidden="true"></i>
                                    <i class="fas fa-star" aria-hidden="true"></i>
                                    <i class="fas fa-star" aria-hidden="true"></i>
                                    <i class="far fa-star" aria-hidden="true"></i>
                                    <i class="far fa-star" aria-hidden="true"></i>
                                </div>
                            </div>
                            <div>
                                <span class="badge badge-success">Verified Purchase</span>
                                <!-- <span class=" badge badge-secondary">Not Purchased</span>-->
                                <span class="monospaced">Doug Dimadome | 11/1/17</span>
                            </div><!-- end row -->                        
                            <div class="row">
                                <div class="col-md-12 row left-buffer">
                                    <strong class="top-buffer-text" > reasonable price,</strong>
                                    <p class="description left-buffer">
                                        it was okay not crazy, check out my shop in Dimsdale
                                </div>
                            </div><!-- end row -->
                            <!-- need to add scroll function so only 2 seen at once-->                       
                        </div><!-- end old reviews-->
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