
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


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

<h1><center><font color="white">Edit Info</font></center></h1>
<center><font color="white">*If certain field(s) will not change, then enter then as they currently are!*</font></center>

<br>
<form name="f1" action="updateUser" method="POST">
<table align="center"><tr>
			
		  <tr><td id="l">Enter Current Username :</td>
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
         
                    <tr align="left"><td colspan="2" align="center">
                    <input type="submit" name="submit" id="submit" value="Update" style="border-radius:10px;background:Aqua;color:white;width:120px;height:40px;font-size:25px"></td></tr>
                    </table>
                    
                    <br>
                    <br>

</form>

</body>
</html>