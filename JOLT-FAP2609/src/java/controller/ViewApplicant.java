package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ViewApplicant extends HttpServlet {

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

            response.setContentType("application/json");
        try(PrintWriter out = response.getWriter()) {	
                if (conn != null) {
                    HttpSession session = request.getSession();
                    Integer userID = (Integer)session.getAttribute("logged-id");

                    int appID = Integer.parseInt(request.getParameter("id"));
                    //get job info using job id
                    String query = "SELECT * FROM APPLICATIONS "
                                + "INNER JOIN JOBSEEKERS ON JOBSEEKERS.SEEKER_ID = APPLICATIONS.SEEKER_ID "
                                + "INNER JOIN USERS ON USERS.USER_ID = JOBSEEKERS.USER_ID "
                                + "WHERE APPLICATIONS.APP_ID = ?"
                    ;

                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setInt(1, appID);
                    ResultSet applicant = ps.executeQuery();

                    //Convert resultset into JSON
                    String json = "{}";
                    if(applicant.next()){
                        json = "{\"fname\":\"" + applicant.getString("SEEKER_FNAME")
                        + "\",\"email\":\"" + applicant.getString("USER_EMAIL")
                        + "\",\"lname\":\"" + applicant.getString("SEEKER_LNAME")
                        + "\",\"title\":\"" + applicant.getString("SEEKER_TITLE")
                        + "\",\"about\":\"" + applicant.getString("SEEKER_ABOUT")
                        + "\",\"course\":\"" + applicant.getString("SEEKER_EDUC_COURSE")
                        + "\",\"school\":\"" + applicant.getString("SEEKER_EDUC_SCHOOL")
                        + "\",\"educ_date\":\"" + applicant.getString("SEEKER_EDUC_BATCH")
                        + "\",\"experience\":\"" + applicant.getString("SEEKER_EXP_TITLE")
                        + "\",\"company\":\"" + applicant.getString("SEEKER_EXP_COMPANY")
                        + "\",\"job_date\":\"" + applicant.getString("SEEKER_EXP_BATCH")
                        + "\",\"skills\":\"" + splitAndFormat(applicant.getString("SEEKER_SKILLS"))
                        + "\",\"address\":\"" + applicant.getString("SEEKER_ADDRESS")
                        + "\",\"number\":\"" + applicant.getString("SEEKER_NUMBER")
                        + "\",\"zoomid\":\"" + applicant.getString("SEEKER_ZOOMID")
                        + "\"}";
                    }
                    out.print(json);
                    out.flush();
                } else {
                    request.setAttribute("error-message", "Connection Error");
                    request.getRequestDispatcher("error.jsp").forward(request,response);
                }
        } catch (SQLException sqle){
                request.setAttribute("error-message", sqle.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request,response);
        } 

    }

    String splitAndFormat(String input){
        String output = "";
        String[] arr = input.split("\\*");
        for(String bullet: arr){
            if(bullet.trim().isEmpty()){
                continue;
            }
            output += "<li>"+bullet+"</li>";
        }
        return output;
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