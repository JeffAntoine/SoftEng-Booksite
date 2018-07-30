<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%
String username=request.getParameter("username"); 
session.putValue("username",username); 

String password=request.getParameter("password"); 
Class.forName("com.mysql.jdbc.Driver");

java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geek_text","root","root"); 
Statement st= con.createStatement(); 
ResultSet rs=st.executeQuery("select * from users where username='"+username+"'");

if(rs.next() && rs.getString(2).equals(password)) 
	{ 
		response.sendRedirect("index.jsp");
	}
else
	{
		response.sendRedirect("LoginHTML.jsp");
	}



%>