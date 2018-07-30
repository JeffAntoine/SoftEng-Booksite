<%-- 
    Document   : index
    Created on : Jul 21, 2018, 1:20:20 AM
    Author     : jeff
--%>
<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inserting Data</title>
    </head>
    <body onLoad="displayResults()">
        <h1>Inserting Data</h1>
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
                        "INSERT INTO comments (bookid, userName, comment, anon)"
                      + " VALUES (?,?,?,?);");
                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }
                    try {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        
                        selectComment = connection.prepareStatement(
                        "SELECT  bookid, userName, comment FROM comments;");
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
                public int setComment (String bookid, String userName, String comment, String anon){
                    int result = 0;

                    try{
                        insertComment.setString(1, bookid);
                        insertComment.setString(2, userName);
                        insertComment.setString(3, comment);
                        insertComment.setString(4, anon);
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
                String nony = new String();

                if(request.getParameter("bookid") != null){
                    book_id = request.getParameter("bookid");
                }
                if (request.getParameter("userName") != null){
                    user_name = request.getParameter("userName");
                }
                
                if (request.getParameter("comment") != null){
                    commenting = request.getParameter("comment");
                }
                if (request.getParameter("anon") != null){
                    nony = request.getParameter("anon");
                }
                
                Comment com = new Comment();
                result = com.setComment(book_id, user_name, commenting, nony);
            }
        %>
        <form name="myForm" action="pbook.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>book id</td>
                        <td><input type="text" name="bookid" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>user name</td>
                        <td><input type="text" name="userName" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td> comment</td>
                        <td>
                            <textarea
                                name="comment" rows="20" value="comment" cols="20">                                
                            </textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>anon choice</td>
                        <td><select name="nony">
                                <option>ANON</option>
                                <option>PUB</option>
                            </select></td>
                    </tr>
                </tbody>
            </table>
                <input type="reset" value="Clear" name="clear" />
                <input type="submit" value="Submit" name="submit" />
        </form>
        <%
            Comment com = new Comment();
            ResultSet comss = com.getComment();
        %>
        <table border="1">
            <tbody>
                <tr>
                    <td>book id</td>
                    <td>user name </td>
                    <td>comment</td>
                </tr>
                <% while (comss.next()) { %>
                <tr>
                    <td><%= comss.getInt("bookid")%></td>
                    <td><%= comss.getString("userName")%></td>
                    <td><%= comss.getString("comment")%></td>
                </tr>
                <% }%>
            </tbody>
        </table>
            <SCRIPT LANGUAGE =" JavaScript">
                    <!--
                    function displayResults(){
                    
                        if(document.myForm.hidden.value == 1){
                            alert("Data Inserted");
                        }
                    }
                    // -->
                </SCRIPT>
    </body>
</html>
