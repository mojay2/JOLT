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

public class LoadJobCandidates extends HttpServlet {

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
                    Integer userID = (Integer)session.getAttribute("logged-id");
                    String forwardURL;
                    //get emp id
                    String query = "SELECT * FROM EMPLOYERS WHERE USER_ID = ?";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setInt(1, userID);
                    ps.executeQuery();
                    ResultSet employee = ps.executeQuery();

                    int empID = 0;

                    if(employee.next()){
                        session.setAttribute("logged-employer",employee.getString("EMP_NAME"));
                        empID = employee.getInt("EMP_ID");
                    }
                    //Check if request is from view job applicants button, or candidates page
                    if(request.getParameter("job-id") == null){
                        forwardURL = "job-candidates.jsp";
                        //Check if there is a request for specific app status
                        if(request.getParameter("status")==null){
                            query = "SELECT * FROM APPLICATIONS "
                                    + "INNER JOIN JOBSEEKERS ON JOBSEEKERS.SEEKER_ID = APPLICATIONS.SEEKER_ID "
                                    + "INNER JOIN EMPLOYERS ON EMP_ID = EMPLOYER_ID "
                                    + "INNER JOIN JOBS ON JOBS.JOB_ID = APPLICATIONS.JOB_ID "
                                    + "INNER JOIN STATUSES ON APP_STATUS = STATUS_ID "
                                    + "WHERE EMPLOYER_ID = ?"
                            ;
                            int applicantCount = getApplicantCount(empID);
                            request.setAttribute("applicant-count", applicantCount);
                            ps = conn.prepareStatement(query);
                            ps.setInt(1, empID);
                        }else{
                            query = "SELECT * FROM APPLICATIONS "
                                    + "INNER JOIN JOBSEEKERS ON JOBSEEKERS.SEEKER_ID = APPLICATIONS.SEEKER_ID "
                                    + "INNER JOIN EMPLOYERS ON EMP_ID = EMPLOYER_ID "
                                    + "INNER JOIN JOBS ON JOBS.JOB_ID = APPLICATIONS.JOB_ID "
                                    + "INNER JOIN STATUSES ON APP_STATUS = STATUS_ID "
                                    + "WHERE EMPLOYER_ID = ? AND APP_STATUS = ?"
                            ;   
                            int applicantCount = getApplicantCount(empID);
                            request.setAttribute("applicant-count", applicantCount);
                            ps = conn.prepareStatement(query);
                            ps.setInt(1, empID);
                            ps.setInt(2, Integer.parseInt(request.getParameter("status"))); 
                        }
                    }else{
                        forwardURL = "view-job-candidates.jsp";
                                    query = "SELECT * FROM APPLICATIONS "
                                    + "INNER JOIN JOBSEEKERS ON JOBSEEKERS.SEEKER_ID = APPLICATIONS.SEEKER_ID "
                                    + "INNER JOIN EMPLOYERS ON EMP_ID = EMPLOYER_ID "
                                    + "INNER JOIN JOBS ON JOBS.JOB_ID = APPLICATIONS.JOB_ID "
                                    + "INNER JOIN STATUSES ON APP_STATUS = STATUS_ID "
                                    + "WHERE EMPLOYER_ID = ? AND APPLICATIONS.JOB_ID = ?"
                            ;
                            ps = conn.prepareStatement(query);
                            ps.setInt(1, empID);
                            ps.setInt(2, Integer.parseInt(request.getParameter("job-id"))); 
                    }
                   
                    ResultSet applications = ps.executeQuery();

                    request.setAttribute("applications", applications);
                    request.getRequestDispatcher(forwardURL).forward(request,response);
                } else {
                    request.setAttribute("error-message", "Connection Error");
                    request.getRequestDispatcher("error.jsp").forward(request,response);
                }
        } catch (SQLException sqle){
                request.setAttribute("error-message", sqle.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request,response);
        } 

    }

public int getApplicantCount(int empID) throws SQLException{
    int appcount = 0;
    String query = "SELECT * FROM APPLICATIONS "
            + "WHERE EMPLOYER_ID = ?"
    ;
    PreparedStatement ps = conn.prepareStatement(query);
    ps.setInt(1, empID);
    ResultSet count = ps.executeQuery();
    while (count.next()){
        appcount++;
    }
    return appcount;
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