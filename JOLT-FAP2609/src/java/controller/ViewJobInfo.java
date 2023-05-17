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
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ViewJobInfo extends HttpServlet {

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

            response.setContentType("application/json");
        try(PrintWriter out = response.getWriter()) {	
                if (conn != null) {
                    HttpSession session = request.getSession();
                    Integer userID = (Integer)session.getAttribute("logged-id");
                    String appliedJobsString = "[]";

                    int jobID = Integer.parseInt(request.getParameter("id"));
                    //get job info using job id
                    String query = "SELECT * FROM JOBS "
                                + "INNER JOIN EMPLOYERS ON JOBS.EMP_ID = EMPLOYERS.EMP_ID "
                                + "INNER JOIN INDUSTRIES ON INDUSTRY_ID = IND_ID "
                                + "INNER JOIN TYPES ON JOB_TYPE = TYPE_ID "
                                + "INNER JOIN LEVELS ON JOB_LEVEL = LEVEL_ID "
                                + "WHERE JOB_ID = ?"
                    ;

                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setInt(1, jobID);
                    ResultSet job = ps.executeQuery();

                    //Get all applied jobs by user (if any)
                    List<String> appliedJobs = new ArrayList<>();
                    if(userID != null){
                        query = "SELECT * FROM APPLICATIONS "
                                + "INNER JOIN JOBSEEKERS ON JOBSEEKERS.SEEKER_ID = APPLICATIONS.SEEKER_ID "
                                + "INNER JOIN JOBS ON JOBS.JOB_ID = APPLICATIONS.JOB_ID "
                                + "WHERE APPLICATIONS.SEEKER_ID = ?"
                        ;   
                        ps = conn.prepareStatement(query);
                        ps.setInt(1, userID);
                        ResultSet applied = ps.executeQuery();
                        while(applied.next()){
                            appliedJobs.add("\""+applied.getInt("JOB_ID")+"\"");
                        }
                        appliedJobsString = appliedJobs.toString();
                    }



                    //Convert resultset into JSON
                    String json = "{}";
                    if(job.next()){
                        json = "{\"jobtitle\":\"" + job.getString("JOB_TITLE")
                        + "\",\"empname\":\"" + job.getString("EMP_NAME")
                        + "\",\"joblocation\":\"" + job.getString("JOB_LOCATION")
                        + "\",\"jobindustry\":\"" + job.getString("IND_NAME")
                        + "\",\"jobsalary\":\"" + job.getString("JOB_SALARY_MAX")
                        + "\",\"jobtype\":\"" + job.getString("TYPE_NAME")
                        + "\",\"joblevel\":\"" + job.getString("LEVEL_NAME")
                        + "\",\"jobdesc\":\"" + job.getString("JOB_DESC")
                        + "\",\"empoverview\":\"" + job.getString("EMP_OVERVIEW")
                        + "\",\"jobresp\":\"" + splitAndFormat(job.getString("JOB_RESP"))
                        + "\",\"jobreqs\":\"" + splitAndFormat(job.getString("JOB_REQS"))
                        + "\",\"jobbenefits\":\"" + splitAndFormat(job.getString("JOB_BENEFIT"))
                        + "\",\"jobid\":\"" + job.getString("JOB_ID")
                        + "\",\"empid\":\"" + job.getString("EMP_ID")
                        + "\",\"appliedjobs\":" + appliedJobsString
                        + "}";
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