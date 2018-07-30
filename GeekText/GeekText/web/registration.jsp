<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style>
#c{
border-radius:8px;
height:40px;
width:300px;
}
#l{
color:white;
font-size:20px;
text-align:right;
}
</style>


</head>
<body>
<%@ include file="homeMenu.jsp" %>

<br>
<form name="f1" action="registration" method="POST">
<table align="center"><tr>

		  <tr><td id="l">Username :</td>
          <td><input type="text" name="username" id="c"></td></tr>   
           
          <tr><td id="l">Password :</td>
          <td><input type="password" name="password" id="c"></td></tr>
          
          <tr><td id="l">First Name :</td>
          <td><input type="text" name="fname" id="c"></td></tr>
          
          <tr><td id="l">Last Name :</td>
          <td><input type="text" name="lname" id="c"></td></tr>
          
          <tr><td id="l">Email :</td>
          <td><input type="text" name="email" id="c"></td></tr>
          
          <tr><td id="l">Address :</td>
          <td><input type="text" name="address" id="c"></td></tr>
          
          <tr><td id="l">Credit Card Num: :</td>
          <td><input type="number" name="ccnum" id="c"></td></tr>
          
          <tr><td id="l">Credit Card Expiration Date :</td>
          <td><input type="number" name="ccdate" id="c"></td></tr>
          
          <tr><td id="l">Extra Address :</td>
          <td><input type="text" name="exemail" id="c"></td></tr>
          
          <tr><td id="l">Extra Credit Card Num: :</td>
          <td><input type="number" name="exccnum" id="c"></td></tr>
          
          <tr><td id="l">Extra Credit Card Expiration Date :</td>
          <td><input type="number" name="exccdate" id="c"></td></tr>
         
                    <tr align="left"><td colspan="2" align="center">
                    <input type="submit" name="submit" id="submit" value="Register" style="border-radius:10px;background:Aqua;color:white;width:120px;height:40px;font-size:25px"></td></tr>
                    </table>
                    
                    <br>
                    <br>

</form>
 
</body>
</html>