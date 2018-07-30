package Controller;


import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import Model.User;

//import Utilities.DBConnection;



public class registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	public registration() {
	    super();
	    // TODO Auto-generated constructor stub
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
       
   
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter pw=response.getWriter();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		
		String ccnum = request.getParameter("ccnum");
		String ccdate = request.getParameter("ccdate");
		
		String exaddress = request.getParameter("exaddress");
		String exccnum = request.getParameter("exccnum");
		String exccdate = request.getParameter("exccdate");
		
		
		//pw.print("ok");
		Model.User obj=new Model.User();
		
	String result=obj.addUser(username, password, fname, lname, email, address, ccnum, ccdate, exaddress, exccnum, exccdate);
		
		if(result.equals("success"))
		{
			pw.print("<script language='javascript'>window.alert('Employee Detials Addded.');window.location='userLogin.jsp';</script>");
		}
		else
		{
			response.sendRedirect("error.jsp?msg=Employee Registration Failed");
		}
		
	
	}

	
}
