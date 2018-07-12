package model;
import java.Util.DBConnection; //this was just utilities.
import java.sql.*;
public class Login {
	public String authenticate(String eid,String username,String password)
	{
		String result="fail";
		try
		{
			Connection con=DBConnection.createConnection();
		Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select * from users where user_id='"+eid+"' and user_name='"+username+"' and password='"+password+"'");
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
