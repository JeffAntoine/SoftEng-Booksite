package Utilities;

import java.sql.Connection;
import java.sql.DriverManager;


public class DBConnection {

public static Connection createConnection()
{
Connection con = null;
String url = "jdbc:mysql://localhost:3306/geek_text";

try
{
try
{
Class.forName("com.mysql.jdbc.Driver");
}
catch (ClassNotFoundException e)
{
e.printStackTrace();
}
String password = "root";
con = DriverManager.getConnection(url, "root", password);

}
catch (Exception e)
{
e.printStackTrace();
}

return con;
}
}