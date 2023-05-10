package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nl.captcha.Captcha;


public class LoginServlet extends HttpServlet {

Connection conn;
    int counter;
    public void init() throws ServletException
    {
    	try {	
			Class.forName("org.apache.derby.jdbc.ClientDriver");
			String username = "app";
			String password = "app";
			String url = 
			  "jdbc:derby://localhost:1527/JoltDB"; 
			conn = 
			  DriverManager.getConnection(url,username,password);
		} catch (SQLException sqle){
			System.out.println("SQLException error occured - " 
				+ sqle.getMessage());
		} catch (ClassNotFoundException nfe){
			System.out.println("ClassNotFoundException error occured - " 
		        + nfe.getMessage());
		}
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {	
                if (conn != null) {
                    HttpSession session = request.getSession(); 

                    //Verify captcha
                    Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
                    String answer = request.getParameter("answer");
                    if (!captcha.isCorrect(answer)) {
                        session.setAttribute("feedback-message", "Incorrect Captcha");
                        response.sendRedirect("login.jsp");
                        return;
                    }

                    //Verify login credentials
                    String keyString = getServletConfig().getInitParameter("key");
                    String cipherType = getServletConfig().getInitParameter("cipher");
                    String ecryptedUserPass = model.Security.encrypt(request.getParameter("password"), cipherType, keyString);
                    
                    String query = "SELECT * FROM USERS WHERE USER_EMAIL = ? "
 + "                                AND USER_PASSWORD = ? "
 + "                                AND USER_TYPE = ?";
                    PreparedStatement ps = conn.prepareStatement(query);            
                    
                    ps.setString(1, request.getParameter("email"));            
                    ps.setString(2, ecryptedUserPass);
                    ps.setString(3, request.getParameter("user-type"));
                    
                    ResultSet loggedUser = ps.executeQuery();
                    
                    if(loggedUser.next()){   
                        //Successful login
                        int userID = loggedUser.getInt("USER_ID"); 
                        int userType = loggedUser.getInt("USER_TYPE");

                        session.setAttribute("logged-id", userID);

                        if(userType == 1){
                            session.setAttribute("logged-usertype", "jobseeker");
                            request.getRequestDispatcher("/LoadJobFeed").forward(request,response);
                        }
                        else{
                            session.setAttribute("logged-usertype", "employer");
                            request.getRequestDispatcher("/employer-home").forward(request,response);
                        }
                    }
                    else{
                    //Failed login
                        counter++;
                        session.setAttribute("feedback-message", "Wrong Login Credentials");
                        request.getRequestDispatcher("login.jsp").forward(request,response);
                    }
                } else {
                    response.sendRedirect("error.jsp");
                }
        } catch (SQLException sqle){
                response.sendRedirect("error.jsp");
        } 

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
