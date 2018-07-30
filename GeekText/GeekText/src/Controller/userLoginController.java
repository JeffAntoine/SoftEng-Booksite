package Controller;

import java.io.IOException;
//import java.io.PrintWriter;
//import Model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@SuppressWarnings("serial")
public class userLoginController extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	//PrintWriter pw=response.getWriter();
	//pw.print("ok");
	

	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	Model.userAuthenticate obj=new Model.userAuthenticate();
	
String result=obj.authenticate(username, password);
	
	if(result.equals("success"))
	{
		response.sendRedirect("index.jsp");
		HttpSession session = request.getSession();
        session.setAttribute("username", username);
	}
	else
	{
		response.sendRedirect("error.jsp?msg=Admin account not found");
	}
	



}

}