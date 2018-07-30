package Model;
import Utilities.DBConnection;
import java.sql.*;
public class userAuthenticate {
	public String authenticate(String username,String password)
	{
		String result="fail";
		try
		{
			Connection con=DBConnection.createConnection();
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select * from users where username='"+username+"' and password='"+password+"'");
			if(rs.next())
				result="success";
			else
				result="fail";
			
		}
		catch(Exception e)
		{
		}
		
		return result;
	}

}
