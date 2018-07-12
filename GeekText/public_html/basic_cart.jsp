<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

</html>

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

            Connection connection = null;
            PreparedStatement selectBook = null;
            PreparedStatement updateCart = null;
            ResultSet resultSet = null;

            public Book()
            {
                try
                {
                    System.out.print("Hello\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Hello\n");
                    selectBook = connection.prepareStatement(
                        "select * from test_cart");
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
        

        

                    // set actors will set placeholders to passed variables
           public int updateCart (String bookid, int count)
            {
                int result = 0;
                try
                {
                    System.out.print("Update test\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Update test\n");
                    updateCart = connection.prepareStatement(
                    "update test_cart "
                    + "set count = ? "
                    + "where bookid = ?");

                    updateCart.setString(2, bookid);
                    updateCart.setInt(1, count);
                    result = updateCart.executeUpdate();
                } catch (SQLException e)
                  { e.printStackTrace(); }
                return result;
            }
        }
     
        %>
        <%
            Book book = new Book();
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
            <li class="nav-item active px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="books_db.jsp">Books</a>
            </li>
            <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="basic_cart.jsp">Shopping Cart</a>
            </li>
             <li class="nav-item px-lg-4">
              <a class="nav-link text-uppercase text-expanded" href="userLoginInterface.jsp">Log In</a>
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
                <span class="section-heading-upper">Your Cart</span>
                <span class="section-heading-lower">All Your Choices</span>
              </h2>
            </div>
          </div>
            <h1>
          <%
                int result = 0;
                
                //check to see if any info is submited by checking the state of the update button
                if (request.getParameter("update") != null)
                {
                    // initialise strings
                    int count = 0;
                    String bookid = new String();
                    
                    //check if all info is entered and set params
                    if (request.getParameter("count") != null)
                    {
                        count = Integer.parseInt(request.getParameter("count"));
                    }
                    if (request.getParameter("bookid") != null)
                    {
                        bookid = request.getParameter("bookid");
                    }
                    
                    //Book bookCart = new Book();
                    result = book.updateCart(bookid, count);
                    System.out.print("Testing!!!!!" + result +"\n"+ count + "\n" + bookid + "\n");
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
                            <td>Book ID</td>
                            <td>Title</td>
                            <td>Count</td>
                            <td>Price</td>
                        </tr>
                        
                        <%  //print all items in cart
                            int loop = 1;
                            while(books.next()) {%>
                        <tr>
                            <form onSubmit="setTimeout(function(){window.location.reload();},10)" name="update_count" action="basic_cart.jsp" method="POST">
                                <td><%= books.getString("bookid")%>    
                                   <input type="hidden" name="bookid" value="<%= books.getString("bookid")%>" size="2" />
                                </td>
                                <td>  <%= books.getString("title")%> </td>
                                <td>
                                    <input type="text" name="count" value="<%= books.getString("count")%>" size="2" />
                                    <input type="submit" value="update" name="update" /> 
                                </td>
                            </form>
                            <%  
                                double total = 0.0;
                                double totalItem = 0.0;
                                int countItem = (Integer.parseInt(books.getString("count")));
                                totalItem = countItem * (Float.parseFloat(books.getString("price")));
                                total = total + totalItem;
                            %>
                            <td>$<%= String.format("%.2f", totalItem)%></td>
                        </tr>
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
                        <%}%>
                    </tbody>
                </table>
                    
                    <div>
                        <a href="checkout.jsp" style="border-radius:15px;background:black;color:white;width:120px;height:60px;font-size:20px">Checkout</a>
                    </div>
            </p>
          </div>
        </div>
      </div>
      </section>
    </script>
  </body>
</html>