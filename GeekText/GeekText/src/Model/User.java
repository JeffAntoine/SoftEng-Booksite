package Model;

import Utilities.DBConnection;
import java.sql.*;


public class User {

	public String addUser(String username,String password,String fname,String lname,String email, String address,String ccnum,String ccdate, String exaddress, String exccnum, String exccdate)
	{
		String result="fail";
		try
		{
			Connection con=DBConnection.createConnection();
			Statement st=con.createStatement();
			String qry="insert into users values('"+username+"','"+password+"','"+fname+"','"+lname+"','"+email+"','"+address+"',"+ccnum+",'"+ccdate+"', '"+exaddress+"', '"+exccnum+"','"+exccdate+"' )";
			int n=st.executeUpdate(qry);
			
			if(n==1)
				result="success";
			else
				result="fail";
			
			if (fname == "failure")
			{
				result = "fail";
			}
			
		}
		catch(Exception e)
		{
		}
		
		return result;
	}
	
	public ResultSet getUser(String username)
	{
		ResultSet rs=null;
		
		try
		{
			Connection con=DBConnection.createConnection();
			Statement st=con.createStatement();
			String qry="select * from users where username='"+username+"'";
			rs=st.executeQuery(qry);
		}
		catch(Exception  e)
		{
		   rs=null;
		}
		return rs;
		
	}
	
	public ResultSet getAllUsers()
	{
		ResultSet rs=null;
		
		try
		{
			Connection con=DBConnection.createConnection();
			Statement st=con.createStatement();
			String qry="select * from users";
			rs=st.executeQuery(qry);
		}
		catch(Exception  e)
		{
		   rs=null;
		}
		return rs;
		
	}
	
	public String updateUser(String username, String password, String fname, String lname, String email, String address, String ccnum, String ccdate)
	{
		
		String result="fail";
		try
		{
			Connection con=DBConnection.createConnection();
			Statement st=con.createStatement();
			String qry="update users set password ='"+password+"', fname = '"+fname+"', lname = '"+lname+"', email = '"+email+"', address = '"+address+"', ccnum = '"+ccnum+"', ccdate = '"+ccdate+"' where username = '"+username+"'";
			int n=st.executeUpdate(qry);
			
			if(n==1)
				result="success";
			else
				result="fail";
			
			if (fname == "failure")
			{
				result = "fail";
			}
			
		}
		catch(Exception e)
		{
		}
		
		return result;
	
	}
	
	public String addAddress(String address, String username)
	{
		String result="fail";
		try
		{
			Connection con=DBConnection.createConnection();
			Statement st=con.createStatement();
			String qry="insert into users(exaddress) values('"+address+"') where username = '"+username+"";
			int n=st.executeUpdate(qry);
			
			if(n==1)
				result="success";
			else
				result="fail";
			
		}
		catch(Exception e)
		{
		}
		
		return result;
	}
	
	public String addCreditCard(String ccnum, String ccdate, String username)
	{
		String result="fail";
		try
		{
			Connection con=DBConnection.createConnection();
			Statement st=con.createStatement();
			String qry="insert into users(ccnum, ccdate) values('"+ccnum+"','"+ccdate+"') where username = '"+username+"" ;
			int n=st.executeUpdate(qry);
			
			if(n==1)
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


