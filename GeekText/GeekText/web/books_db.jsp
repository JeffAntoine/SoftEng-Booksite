<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 
<%@ page import="java.util.Base64" %> 
<%@ page import="java.util.HashMap" %> 
<%@ page import="java.lang.Math" %> 
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
            String PASSWORD = "root";
            int selectCount;
            
            Connection connection = null;
            PreparedStatement selectBook = null;
            ResultSet resultSet = null;

            public Book(String sortBy, String orderBy, String genreFilter, 
                        String ratingFilter, String topSellers)
            {
                try
                {
                    System.out.print("Hello\n");
                    connection = DriverManager.getConnection (URL, USERNAME, PASSWORD);
                    System.out.print("Hello\n");
                    String bookQuery = "from book_rating";
                    
                    if (genreFilter != null ) {
                        bookQuery += " WHERE genre = '" + genreFilter + "'";
                    } else if (ratingFilter != null){
                        bookQuery += " WHERE rating > (" + ratingFilter + "-1) AND rating <= " + ratingFilter;
                    } else if (topSellers != null && topSellers.equalsIgnoreCase("true")){
                        bookQuery += " WHERE sold > 100";
                    }

                    if(pageNumber == null){
                        pageNumber = "1";
                        params.put("page", pageNumber);
                    }

                    ResultSet countResult = connection.prepareStatement(
                        "select COUNT(*) as count " + bookQuery)
                        .executeQuery();
                    countResult.next();
                    selectCount = countResult.getInt("count");
                    
                    if(sortBy != null && orderBy != null){
                        bookQuery += " order by " + sortBy + " " + orderBy;
                    }

                    bookQuery += " LIMIT " + (Integer.parseInt(pageNumber) - 1) * pageMax + "," + pageMax;

                    System.out.println("SQL: select * " + bookQuery);
                    selectBook = connection.prepareStatement(
                        "select * " + bookQuery);
                    
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
            public int getCount(){
                return selectCount;
            }
        }

    %>
       <%! 
        Book book;
        ResultSet books;
        String sortParam;
        String orderParam;
        String genreFilter;
        String ratingFilter;
        String topSellers;
        String pageNumber;
        int pageMax = 10;
        HashMap<String, String> params = new HashMap<String, String>();
    %>
        <%
            sortParam = request.getParameter("sort");
            orderParam = request.getParameter("order");
            genreFilter = request.getParameter("genre");
            ratingFilter = request.getParameter("rating");
            topSellers = request.getParameter("topseller");
            pageNumber = request.getParameter("page");
            params.put("sort", sortParam);
            params.put("order", orderParam);
            params.put("genre", genreFilter);
            params.put("rating", ratingFilter);
            params.put("topseller", topSellers);
            params.put("page", pageNumber);
            book = new Book(sortParam, orderParam, genreFilter, ratingFilter, topSellers);
            ResultSet books = book.getBook();
            
        %>
        <%! public String getParamURL(HashMap<String,String> parameters){
                String url = "?";
                for(String param : parameters.keySet()){
                    if(parameters.get(param) != null)
                        url += param + "=" + parameters.get(param) + "&";
                }
                return url;
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
                
                <select name="menu1" id="menu1">
                    
                <option disabled selected> Browse By Genre </option>
                <option value="Dystopian Fiction">Dystopian Fiction</option>
                <option value="Erotic Romance Novel">Erotic Romance Novel</option>
                <option value="Fantasy Fiction">Fantasy Fiction</option>
                <option value="Thriller">Thriller</option>
                <option value="Educational">Educational</option>
                <option value="Young Adult Fiction">Young Adult Fiction</option>
                <option value="Educational">Crime Fiction</option>
                <option value="Historical Fiction">Historical Fiction</option>
                <option value="Non-Fiction">Non-Fiction</option>
                <option value="Fiction">Fiction</option>
                <option value="Childrens Literature">Children's Literature</option>
              
                </select>
                
                <script type="text/javascript">
                 var urlmenu = document.getElementById( 'menu1' );
                 urlmenu.onchange = function() {
                      window.location.replace( "?genre=" + this.options[ this.selectedIndex ].value );
                 };
                </script>
                
                
                <select name="menu2" id="menu2">
                <option disabled selected>Browse By Ratings </option>
                <option value="1">Ratings 0 to 1</option>
                <option value="2">Ratings 1 to 2</option>
                <option value="3">Ratings 2 to 3</option>
                <option value="4">Ratings 3 to 4</option>
                <option value="5">Ratings 4 to 5</option>
                </select>
                
                <script type="text/javascript">
                 var urlmenu = document.getElementById( 'menu2' );
                 urlmenu.onchange = function() {
                      window.location.replace( "?rating=" + this.options[ this.selectedIndex ].value );
                 };
                </script>
                
                
                <select name="menu3" id="menu3">
                <option value="Top Sellers">Browse By Top Sellers </option>
                </select>
                
                <script type="text/javascript">
                 var urlmenu = document.getElementById( 'menu3' );
                 urlmenu.onclick = function() {
                      window.location.replace( "?topseller=true" );
                 };
                </script>
                
                <p></p>
               
                <%! public String sortTitleLink (String title, String sortType) {
                        String newTitle = title;
                        HashMap <String, String> newParams = (HashMap) params.clone();
                        newParams.put("sort", sortType);
                        newParams.put("order", "desc");
                        if (sortParam != null && orderParam != null && sortType.equalsIgnoreCase(sortParam)){
                            if (orderParam.equalsIgnoreCase("desc")){
                                newTitle += " ⬇︎";
                                newParams.put("order", "asc");
                            } else {
                                newTitle += " ⬆︎";
                            }
                        }
                        return "<a href=\"books_db.jsp" + getParamURL(newParams) + "\">" + newTitle + "</a>";
                    }
                        
                %>
                
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

                
                <center><table id = "bookList" width="1000">
                            <thead>
                                <tr>
                                <th></th>
                                <th width="300"> <div align="center"> Book ID </div></th>
                                <th width="600"> <div align="center"><%= sortTitleLink("Title", "title") %> </div></th>
                                <th width="700"> <div align="center"><%= sortTitleLink("Author", "author") %> </div></th>
                                <th width="800"> <div align="center">Genre </div></th>
                                <th width="600"> <div align="center"><%= sortTitleLink("Release Date", "releaseDate") %></div></th>
                                <th width="300"> <div align="center"><%= sortTitleLink("Price", "price") %> </div></th>
                                <th width="80"> <div align="center">Stock </div></th>
                                <th width="300"> <div align="center"><%= sortTitleLink("Rating", "rating") %> </div></th>
                                </tr>
                                <td></td>
                            </thead>
                            <tbody>
                                
                                <% while(books.next()) {%>
                                    <tr>
                                        <td><div align="center"><%= getCoverHTML(books.getBlob("cover")) %></div></td>
                                        <td><div align="center"><%= books.getString("bookid")%></div></td>
                                        <td><div align="center"><a href="basicbook.jsp?id=<%= books.getString("bookid")%>"><%= books.getString("title")%></a></div></td>
                                        <td><div align="center"><%= books.getString("author")%></div></td>
                                        <td><div align="center"><%= books.getString("genre")%></div></td>
                                        <td><div align="center"><%= books.getString("releaseDate")%></div></td>
                                        <td><div align="center">$<%= books.getString("price")%></div></td>
                                        <td><div align="center"><%= books.getString("stock")%></div></td>
                                        <td><div align="center"><%= books.getFloat("rating")%></div></td>
                                        <td></td>
                                    </tr>
                                <%}%>
                            </body>
                        </table>
                            <%! 
                            public String getPageURL(String pageNum){
                                HashMap<String, String> newParams = (HashMap) params.clone();
                                newParams.put("page", pageNum);
                                return getParamURL(newParams);
                            }
                            %>
                            
                            <% for(int i = 1; i <= ((int) Math.ceil((double)book.getCount() / pageMax)); i++ ) { %>
                            <a href="<%= getPageURL(i + "") %>" 
                               style="<%= (params.get("page").equals(i+"") ? "text-decoration:underline" : "") %>">Page <%= i %></a>
                            <% } %>
                </center>
                   
                   
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
