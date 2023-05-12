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

public class CreateJobApp extends HttpServlet {

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
                    Integer loggedUser = (Integer)session.getAttribute("logged-id");

                    if(loggedUser == null){
                        response.sendRedirect("login.jsp");
                        return;
                    }

                    //get jobseeker id from user id
                    String query = "SELECT * FROM JOBSEEKERS WHERE USER_ID = ?";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setInt(1, loggedUser);
                    ps.executeQuery();
                    ResultSet jobSeeker = ps.executeQuery();
                    int seekerID = 0;
                    if(jobSeeker.next()){
                        seekerID = jobSeeker.getInt("SEEKER_ID");
                    }

                    int jobID = Integer.parseInt(request.getParameter("job-id"));
                    int empID = Integer.parseInt(request.getParameter("emp-id"));

                    //Check if an application already exists
                    query = "SELECT * FROM APPLICATIONS WHERE JOB_ID = ? AND SEEKER_ID = ?";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, jobID);
                    ps.setInt(2, seekerID);
                    ps.executeQuery();
                    ResultSet appCheck = ps.executeQuery();
                    if(appCheck.next()){
                        session.setAttribute("feedback-message", "You have already Applied for this job.");
                        response.sendRedirect("LoadJobFeed"); 
                    }else{
                        //Create a new application 
                        String query2 = "INSERT INTO APPLICATIONS (SEEKER_ID,"
                                        + "EMPLOYER_ID, JOB_ID) VALUES (?,?,?)";

                        PreparedStatement ps2 = conn.prepareStatement(query2);            

                        ps2.setInt(1, seekerID);  
                        ps2.setInt(2, empID);                    
                        ps2.setInt(3, jobID);

                        ps2.executeUpdate(); 
                        session.setAttribute("feedback-message", "Successfully Applied");
                        response.sendRedirect("LoadAppliedJobs"); 
                    }
                } else {
                    request.setAttribute("error-message", "Connection Error");
                    request.getRequestDispatcher("error.jsp").forward(request,response);
                }
        } catch (SQLException sqle){
                request.setAttribute("error-message", sqle.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request,response);
        } catch (Exception e){
                request.setAttribute("error-message", e.toString());
                request.getRequestDispatcher("error.jsp").forward(request,response);
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