<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>atozknowledge.com demo Regjsp</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%

String username =request.getParameter("username"); 
session.putValue("username",username); 
String password=request.getParameter("password"); 
String fname=request.getParameter("fname"); 
String lname=request.getParameter("lname"); 
String email=request.getParameter("email"); 
String address=request.getParameter("address"); 
String ccnum=request.getParameter("ccnum"); 
String ccdate=request.getParameter("ccdate"); 

Class.forName("com.mysql.jdbc.Driver"); 
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geek_text",
"root","root"); 
Statement st= con.createStatement(); 
ResultSet rs; 

int i=st.executeUpdate("insert into users values ('"+username+"','"+password+"','"+fname+"','"+lname+"','"+email+"','"+address+"','"+ccnum+"','"+ccdate+"')"); 

response.sendRedirect("Login.jsp");

%>

</body>
</html>