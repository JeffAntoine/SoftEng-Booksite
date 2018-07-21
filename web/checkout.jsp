<%-- 
    Document   : checkout
    Created on : Jun 20, 2018, 6:23:02 PM
    Author     : RexAevum
--%>
<!DOCTYPE html>
<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <%
        //HttpSession session=request.getSession(true);   
        String user =(String )session.getAttribute("username");
        System.out.println("User checkout= " + user);
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

  </head>

  <body>
      
    <%!
        public class Book 
        {
            String URL = "jdbc:mysql://localhost:3306/geek_text";
            String USERNAME = "root";
            String PASSWORD = "root";
            String user = new String();

            Connection connection = null;
            PreparedStatement selectBook = null; // selects books from cart
            PreparedStatement updateInventory = null; // update item count for the cart
            PreparedStatement delCart = null; // remove an item form cart 
            PreparedStatement checkBookCount = null; // checking if the count is available in the db
            PreparedStatement updateBook = null;// for updating the cart when cahnging items in cart
            ResultSet resultSet = null;


            public Book(String tempUser)
            {
                this.user = tempUser;
                try
                {
                    System.out.print("Book Select Checkout\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    selectBook = connection.prepareStatement(
                        "select * from test_cart where userName = ?");
                    selectBook.setString(1, user);
                    
                    System.out.print("Book Select Checkout Done\n");
                }catch (SQLException e)
                {
                    e.printStackTrace();
                }


            }

            
            
            public ResultSet getBook()// get all books from cart
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

            public int checkBookCount (String bookid)
            {
                int stock = -1;
                try
                {
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    checkBookCount = connection.prepareStatement(
                    "select stock from book "
                    + "where bookid = ?");
                    // setting the bookid for which to check stock
                    //int temp = Integer.parseInt(bookid);
                    checkBookCount.setString(1, bookid);
                    //System.out.println("temp = " + temp);

                    // need to get the stock count for compaison
                    ResultSet stockDb = checkBookCount.executeQuery(); 
                     System.out.println("Stock after checkout = ");
                    stockDb.first();//need to move the cursor to the first row
                    stock = stockDb.getInt("stock");//retreve the number in stock
                    connection.close();
                }
                catch (SQLException e)
                {
                    e.printStackTrace();
                }

                return stock;
            }              
        

                    // update inventory after checkout
            public int updateInventory (String bookid, int count)
            {
                int result = 0;
                int stock = checkBookCount(bookid);
                stock = stock - count;
                System.out.print("Book new stock =" + stock + "\n");
                try
                {
                    System.out.print("Update test\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Update test\n");

                    // check if the amount wanted is in stock 
                    
                    updateInventory = connection.prepareStatement(
                    "update book "
                    + "set stock = ? "
                    + "where bookid = ?");
                    updateInventory.setInt(1, stock);
                    updateInventory.setString(2, bookid);
                    result = updateInventory.executeUpdate();
                    connection.close();

                } catch (SQLException e)
                { 
                    e.printStackTrace(); 
                }

                return result;
            }


        

            public int delCart (String userName)// delet all items form the cart once checkout is done
            {
                int result = 0;
                try
                {
                    System.out.print("Delete test\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Delete test\n");
                    delCart = connection.prepareStatement(
                    "delete from test_cart "
                    + "where userName = ?");

                    delCart.setString(1, userName);
                    result = delCart.executeUpdate();
                    connection.close();
                } catch (SQLException e)
                { 
                    e.printStackTrace(); 
                }

                return result;
            } 
        }
     
        %>
        <%
            //generate the books from cart
            System.out.println("User for book = " + user);
            Book book = new Book(user);
            ResultSet books = book.getBook();
        %>

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
            <li class="nav-item px-lg-4">
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
            <li class="nav-item active px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="basic_cart.jsp">Shopping Cart</a>
            </li>
             <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="userLoginInterface.jsp">Log In</a>
            </li>
            <li class="nav-item px-lg-4">
                <a class="nav-link text-uppercase text-expanded"></a>
                <input type="text" placeholder="Search..">
            </li>
          </ul>
        </div>
      </div>
    </nav>

      <section class="page-section">
      <div class="container">
        <div class="product-item">
          <div class="product-item-title d-flex">
           <div class="product-item-description d-flex ml-auto">
            <div class="bg-faded p-5 d-flex ml-auto rounded" align="middle">
              <h2 class="section-heading mb-0">
                <span class="section-heading-upper">YOUR CART, <%=user%></span>
                <span class="section-heading-lower">Checkout Done!</span>
                <div>
                    <p><br><a href="basic_cart.jsp" style="border-radius:15px;color:green;width:120px;height:60px;font-size:30px" align="middle">Click here to go back to cart</a></p>
                </div>
              </h2>

            </div>
          </div>

                        
                        <%  //print all items in cart
                            String bookID = "";
                            int countUpdate = 0;
                            while(books.next()) 
                            {
                                
                                    bookID = books.getString("bookid");
                                    countUpdate = books.getInt("count");
                                    out.print("Checkout update = " + bookID + "\t" + countUpdate);
                                    int r1 = book.updateInventory(bookID, countUpdate);
                            }
                           int r2 = book.delCart(user);
                        
                        %>

                    
          </div>
      </div>

      </section>
</body>
</html>