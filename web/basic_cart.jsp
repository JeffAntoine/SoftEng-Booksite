<!DOCTYPE html>
<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <%
        //If no valid username is found will porceed as guest and return nothing for the cart
        String user = (String)session.getAttribute("username");
        if (user.length() < 1 || user == null)
            user = "Guest";
        //System.out.println("User = " + user);
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
            PreparedStatement saveCart = null; // select books to wish list
            PreparedStatement wishList = null; // select books form wishlist
            PreparedStatement updateCart = null; // update item count for the cart
            PreparedStatement updateInventory = null; // update item inventory
            PreparedStatement delCart = null; // remove an item form cart 
            PreparedStatement checkBookCount = null; // checking if the count is available in the db
            PreparedStatement updateBook = null;// for updating the cart when cahnging items in cart
            ResultSet resultSet = null;
            ResultSet wishlistSet = null;

            public Book(String tempUser)
            {
                this.user = tempUser;
                try
                {
                    System.out.print("Book Select start\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    selectBook = connection.prepareStatement(
                        "select * from test_cart where userName = ?");
                    selectBook.setString(1, user);
                    wishList = connection.prepareStatement(
                        "select * from wishlist where userName = ?");
                    wishList.setString(1, user);
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

            public ResultSet getWish() //print all items in wishlist
            {
                 try
                {
                    wishlistSet = wishList.executeQuery();
                    
                } catch (SQLException e)
                {
                    e.printStackTrace();
                }
                System.out.print("wishlist done\n");
                return wishlistSet;
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
                     System.out.println("Stock after DB1 = ");
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
        

                    // set actors will set placeholders to passed variables
           public int updateCart (String bookid, int count, String userName)
            {
                int result = 0;
                int stock = checkBookCount(bookid);
                try
                {
                    System.out.print("Update test\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Update test\n");

                    // check if the amount wanted is in stock 
                    
                    updateCart = connection.prepareStatement(
                    "update test_cart "
                    + "set count = ? "
                    + "where bookid = ? and userName = ?");
                    
                    if (count < 0) //check for a negative number
                    {
                        //send a notification to the user that items are not available 
                        updateCart.setString(2, bookid);
                        updateCart.setInt(1, 0);
                        updateCart.setString(3, userName);
                        result = updateCart.executeUpdate(); 
     
                    }
                    else if (count <= stock) // if stock is available
                    {
                        updateCart.setString(2, bookid);
                        updateCart.setInt(1, count);
                        updateCart.setString(3, userName);
                        result = updateCart.executeUpdate();
                    }
                    else// if count is more than the available stock   
                    {
                        updateCart.setString(2, bookid);
                        updateCart.setInt(1, stock);
                        updateCart.setString(3, userName);
                        result = updateCart.executeUpdate(); 
                    }
                    connection.close();
                } catch (SQLException e)
                { 
                    e.printStackTrace(); 
                }

                return result;
            }

            //update available stock
            public int updateInventory (String bookid, int count, boolean addInv)
            {
                int result = 0;
                int stock = checkBookCount(bookid);
                if (addInv)
                    stock = stock + count; // will return books to inventory
                else
                    stock = stock - count;//will remove books from inventroy
                System.out.println("Stock during update = " + stock + bookid);
                try
                {
                    System.out.print("Update test\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Update test\n");

                    // check if the amount wanted is in stock 
                    
                    updateInventory = connection.prepareStatement(
                    "update book "
                    + "set count = ? "
                    + "where bookid = ?");
                    updateInventory.setInt (1, stock);
                    updateInventory.setString(2, bookid);
                    connection.close();
                } catch (SQLException e)
                { 
                    e.printStackTrace(); 
                }

                return result;
            }

            public int delCart (String bookid, String userName)
            {
                int result = 0;
                try
                {
                    System.out.print("Delete test\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Delete test\n");
                    delCart = connection.prepareStatement(
                    "delete from test_cart "
                    + "where bookid = ? and userName = ?");

                    delCart.setString(1, bookid);
                    delCart.setString(2, userName);
                    result = delCart.executeUpdate();
                    connection.close();
                } catch (SQLException e)
                { 
                    e.printStackTrace(); 
                }

                return result;
            }

            // save for later
            public int saveCart (String bookid, String userName)
            {
                int result = 0;
                int result1 = 0;
                try
                {
                    System.out.print("Delete test\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Delete test\n");
                    saveCart = connection.prepareStatement(
                    "insert into wishlist "
                    + "select * from test_cart "
                    + "where userName = ? and bookid = ?");

                    saveCart.setString(1, userName);
                    saveCart.setString(2, bookid);
                    result = saveCart.executeUpdate();
                    // remove the book form the cart after save info to wishlist
                    delCart = connection.prepareStatement(
                    "delete from test_cart "
                    + "where userName = ? and bookid = ?");
                    delCart.setString(1, userName);
                    delCart.setString(2, bookid);
                    result1 = delCart.executeUpdate();
                    connection.close();
                } catch (SQLException e)
                { 
                    e.printStackTrace(); 
                }

                return result;
            }
            //return to shopping cart
            public int returnToCart (String bookid, String userName)
            {
                int result = 0;
                int result1 = 0;
                try
                {
                    System.out.print("Delete test\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Delete test\n");
                    saveCart = connection.prepareStatement(
                    "insert into test_cart "
                    + "select * from wishlist "
                    + "where userName = ? and bookid = ?");

                    saveCart.setString(1, userName);
                    saveCart.setString(2, bookid);
                    result = saveCart.executeUpdate();
                    // delete teh book form the wishlist table after move it back to cart
                    delCart = connection.prepareStatement(
                    "delete from wishlist "
                    + "where userName = ? and bookid = ?");
                    delCart.setString(1, userName);
                    delCart.setString(2, bookid);
                    result1 = delCart.executeUpdate();

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
            //generate teh books from wishlist
            Book wishBook = new Book(user);
            ResultSet wishBooks = book.getWish();
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
            <div class="bg-faded p-5 d-flex ml-auto rounded">
              <h2 class="section-heading mb-0">
                <span class="section-heading-upper">YOUR CART, <%=user%></span>
                <span class="section-heading-lower">All Your Selections</span>
              </h2>
            </div>
          </div>
            <h1>
          <%
                int result = 0;
                int resultInv = 0;
                // initialise strings
                int count = 0;
                int dif = 0;
                if (request.getParameter("count") != null)
                    dif = Integer.parseInt(request.getParameter("count")) ;
                    System.out.println ("Dif = " + dif);
                String bookid = new String();
                String userName = new String();
                
                //check to see if any info is submited by checking the state of the update button - work on cart table
                if (request.getParameter("update") != null)
                {
                    
                    //check if all info is entered and set params
                    if (request.getParameter("count") != null)
                    {
                        count = Integer.parseInt(request.getParameter("count"));
                    }
                    if (request.getParameter("bookid") != null)
                    {
                        bookid = request.getParameter("bookid");
                    }
                    if (request.getParameter("userName") != null)
                    {
                        userName = request.getParameter("userName");
                    }
                    
                    //Book bookCart = new Book();
                    resultInv = book.updateInventory(bookid, count, false);
                    result = book.updateCart(bookid, count, userName);
                   // System.out.print("Update the cart: \nResult = " + result +"\ncount = "+ count + "\nbookid = " + bookid + "\nusername = " + userName + "\nresInv = " + resultInv);
                }
                // delete form shopping cart
                else if (request.getParameter("delete") != null)
                {
                    bookid = request.getParameter("bookid");
                    userName = request.getParameter("userName");
                    //count = Integer.parseInt(request.getParameter("count"));
                    //resultInv = book.updateInventory(bookid, count, true);
                    result = book.delCart(bookid, userName);
                }
                else if (request.getParameter("save") != null)
                {
                    bookid = request.getParameter("bookid");
                    userName = request.getParameter("userName");
                    result = book.saveCart(bookid, userName);
                }
                
                //
                // Wishlist
                //
                if (request.getParameter("buy") != null)
                {
                    bookid = request.getParameter("bookid");
                    userName = request.getParameter("userName");
                    result = book.returnToCart(bookid, userName);
                }
            %>

            
            </h1>
          <div class="product-item-description d-flex mr-auto">
            <div class="bg-faded p-5 rounded">
              <p class="mb-0">        
                <style>td{padding: 3px;}</style>
                <table border="1">
                    <tbody>
                        <tr>
                            <td style="visibility: hidden;">Book ID</td>
                            <td width="400">Title</td>
                            <td>Count</td>
                            <td>Price</td>
                        </tr>
                        
                        <%  //print all items in cart
                            double total = 0.0;
                            double totalItem = 0.0;
                            while(books.next()) {%>
                        <tr>
                            <form onSubmit="setTimeout(function(){location.reload(true);},14)" name="update_count" action="basic_cart.jsp" method="POST">
                                <td style="visibility: hidden;" > <%= books.getString("bookid")%>    
                                   <input type="hidden" name="bookid" value="<%= books.getString("bookid")%>" size="2" />
                                   <input type="hidden" name="userName" value="<%= books.getString("userName")%>" size="2" />
                                </td>
                                <td width="400">
                                    <a href="basicbook.jsp?id=<%=books.getString("bookid")%>"> <%= books.getString("title")%>         </a>
                                           <p><input type="submit" value="Save for Later" name="save" /></p>
                                </td>  <!-- print the link to the item page -->
                                <td>
                                    <p><input type="text" name="count" value="<%= books.getString("count")%>" size="2" /> <a style="font-size:15px"> Max amount: <%= book.checkBookCount(books.getString("bookid"))%></a></p>
                                    <input type="submit" value="Update" name="update" /> 
                                    <input type="submit" value="Delete" name="delete" />
                                    <input type="hidden" name="hidden" value="<%= result %>" />
                                </td>
                            </form>
                            <%  // does math for the price and totals
                                int countItem = (Integer.parseInt(books.getString("count")));
                                totalItem = countItem * (Float.parseFloat(books.getString("price")));
                                total = total + totalItem;
                            %>
                            <td>$<%= String.format("%.2f", totalItem)%></td>
                        </tr>
                        <%}%>
                        <tr>
                            <td style="visibility: hidden;"> </td>
                            <td style="visibility: hidden;"> </td>
                            <td>Subtotal</td>
                            <td>$<%= String.format("%.2f", total)%></td>
                        </tr>
                        <tr>
                            <td style="visibility: hidden;"> </td>
                            <td style="visibility: hidden;"> </td>
                            <td>Total(no tax calculation)</td>
                            <td>$<%= String.format("%.2f", total)%></td>
                        </tr>
                        
                    </tbody>
                </table>
                    
                    <div> 
                        <a href="checkout.jsp" style="border-radius:30px;background:black;color:white;width:130px;height:60px;font-size:20px"> Checkout </a>
                    </div>
            </p>
          </div>
        </div>
      </div>
            <div>
                <h1 style="color:white">Wishlist</h1>
                <div class="product-item-description2 d-flex mr-auto">
                <div class="bg-faded p-5 rounded">
                  <p class="mb-0">        
                    <style>td{padding: 3px;}</style>
                    <table border="1">
                        <tbody>
                            <tr>
                                <td style="visibility: hidden;">Book ID</td>
                                <td width="400">Title</td>
                                <td>Count</td>
                                <td>Price</td>
                            </tr>

                            <%  //print all items in cart
                                double totalS = 0.0;
                                double totalItemS = 0.0;
                                while(wishBooks.next()) {%>
                            <tr>
                                <form onSubmit="setTimeout(function(){location.reload(true);},14)" name="update_wish" action="basic_cart.jsp" method="POST">
                                    <td style="visibility: hidden;" > <%= wishBooks.getString("bookid")%>    
                                       <input type="hidden" name="bookid" value="<%= wishBooks.getString("bookid")%>" size="2" />
                                       <input type="hidden" name="userName" value="<%= wishBooks.getString("userName")%>" size="2" />
                                    </td>
                                    <td width="400"><a href="<%= wishBooks.getString("link")%>"> <%= wishBooks.getString("title")%> </a>
                                    </td>  <!-- print the link to the item page -->
                                    <td><%= wishBooks.getString("count")%></td>
                                <%  // does math for the price and totals
                                    int countItemS = (Integer.parseInt(wishBooks.getString("count")));
                                    totalItemS = countItemS * (Float.parseFloat(wishBooks.getString("price")));
                                    totalS = totalS + totalItemS;
                                %>
                                <td>$<%= String.format("%.2f", totalItemS)%></td>
                                <td><input type="submit" value="Add To Cart" name="buy" /></td>
                                </form>
                            </tr>
                            <%}%>


                        </tbody>
                    </table>
            </div>
      </section>
    </script>
</body>
</html>