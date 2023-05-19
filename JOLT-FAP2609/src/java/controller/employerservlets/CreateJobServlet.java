package controller.employerservlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CreateJobServlet extends HttpServlet {

    Connection conn;

    public void init() throws ServletException {
            ServletContext context = getServletContext();
            try {	
                    Class.forName(context.getInitParameter("jdbcClassName"));
                    //System.out.println("jdbcClassName: " + config.getInitParameter("jdbcClassName"));
                    String username = context.getInitParameter("dbUserName");
                    String password = context.getInitParameter("dbPassword");
                    StringBuffer url = new StringBuffer(context.getInitParameter("jdbcDriverURL"))
                            .append("://")
                            .append(context.getInitParameter("dbHostName"))
                            .append(":")
                            .append(context.getInitParameter("dbPort"))
                            .append("/")
                            .append(context.getInitParameter("databaseName"));
                    conn = 
                      DriverManager.getConnection(url.toString(),username,password);
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

                    //get employee id from user id
                    String query = "SELECT * FROM EMPLOYERS WHERE USER_ID = ?";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setInt(1, loggedUser);
                    ps.executeQuery();
                    ResultSet employee = ps.executeQuery();
                    int empID = 0;
                    if(employee.next()){
                        empID = employee.getInt("EMP_ID");
                    }

                    //Check for null select values
                    int jobLevel = Integer.parseInt(request.getParameter("job-level"));
                    int jobIndustry = Integer.parseInt(request.getParameter("job-industry"));
                    int jobType = Integer.parseInt(request.getParameter("job-type"));
                    if(jobLevel == -1 || jobIndustry == -1 || jobType == -1 ){
                        session.setAttribute("feedback-message", "Invalid User Input");
                        response.sendRedirect("create-job-listing.jsp");
                        return;
                    }

                    //empid, title, location, level, desc, resp, reqs, benefit, industry, salarymin, salarymax, jobtype
                    String query2 = "INSERT INTO JOBS (EMP_ID, JOB_TITLE, "
                    + "JOB_LOCATION, JOB_LEVEL, JOB_DESC, JOB_RESP, JOB_REQS, "
                    + "JOB_BENEFIT, INDUSTRY_ID, JOB_SALARY_MIN, JOB_SALARY_MAX,"
                    + " JOB_TYPE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                    PreparedStatement ps2 = conn.prepareStatement(query2);            

                    ps2.setInt(1, empID);  
                    ps2.setString(2, request.getParameter("job-title"));                    
                    ps2.setString(3, request.getParameter("job-location"));
                    ps2.setInt(4, Integer.parseInt(request.getParameter("job-level")));
                    ps2.setString(5, request.getParameter("job-desc"));
                    ps2.setString(6, request.getParameter("job-resp"));
                    ps2.setString(7, request.getParameter("job-reqs"));                    
                    ps2.setString(8, request.getParameter("job-benefit"));                    
                    ps2.setInt(9, Integer.parseInt(request.getParameter("job-industry")));
                    ps2.setString(10, request.getParameter("salary-min"));
                    ps2.setString(11, request.getParameter("salary-max"));
                    ps2.setInt(12,   Integer.parseInt(request.getParameter("job-type")));

                    ps2.executeUpdate(); 

                    session.setAttribute("feedback-message", "Successfully Created Job Listing");
                    response.sendRedirect("employer-home");
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