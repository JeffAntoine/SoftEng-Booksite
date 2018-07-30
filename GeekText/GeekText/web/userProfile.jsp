<%@page import="Model.User"%>
<%@page import="Utilities.DBConnection"%>
<%@page import="java.sql.ResultSet" %>

<html lang="en">
  <head>
<style>
#c{
border-radius:8px;
height:40px;
width:300px;
}
#l{
color:blue;
font-size:20px;
}
</style>

</head>
<body style="background-image:loginBackground.jpg">
<%@ include file="homeMenu.jsp" %>

<table width="100%" border="1" >
 <tr style="background-color:cyan">
 <th id="l">USERNAME</th> 
 <th id="l">FRIST NAME</th>
 <th id="l">LAST NAME</th>
 <th id="l">EMAIL</th>
 <th id="l">ADDRESS</th>
 <th id="l">CREDIT CARD #</th>
 <th id="l">CREDIT CARD DATE</th></tr>


<%

User obj=new User();
ResultSet rs=obj.getAllUsers();
while(rs.next())
{
%>
 <tr>
  
 
 <td><font color="white"> <%=rs.getString("username") %></font></td>
 <td><font color="white"> <%=rs.getString("fname") %></font></td>
 <td><font color="white"> <%=rs.getString("lname") %></font></td>
 <td><font color="white"> <%=rs.getString("email") %></font></td>
 <td><font color="white"> <%=rs.getString("address") %></font></td>
 <td><font color="white"> <%=rs.getString("ccnum") %></font></td>
 <td><font color="white"> <%=rs.getInt("ccdate") %></font></td>
 
 </tr>
 
<%
}
%>

</table>




<td><center><a href='editInfo.jsp' style="color: #4DCC19;"><i>Edit</i></a></center></td>
<br>
<td><center><a href='addAddress.jsp' style="color: #4DCC19;"><i>Add Another Address</i></a></center></td>
<br>
<td><center><a href='addtCC.jsp' style="color: #4DCC19;"><i>Add Another Credit Card</i></a></center></td>
<br>

    <p> &nbsp </p>
    <p> &nbsp </p>

    <footer class="footer text-faded text-center py-5">
      <div class="container">
        <p class="m-0 small">Copyright &copy; Your Website 2018</p>
      </div>
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>