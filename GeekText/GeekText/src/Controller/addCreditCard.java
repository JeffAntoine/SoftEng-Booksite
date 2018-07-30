package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class addCreditCard extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public addCreditCard() {
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
		
		String ccnum = request.getParameter("ccnum");
		String ccdate = request.getParameter("ccdate");
		String username = request.getParameter("username");
		
		
		//pw.print("ok");
		Model.User obj=new Model.User();
		
	String result=obj.addCreditCard(ccnum, ccdate, username);
		
		if(result.equals("success"))
		{
			pw.print("<script language='javascript'>window.alert('Employee Details Updated.');window.location='index.jsp';</script>");
		}
		else
		{
			response.sendRedirect("error.jsp?msg=Employee Update Failed");
		}
		
	
	}


}
