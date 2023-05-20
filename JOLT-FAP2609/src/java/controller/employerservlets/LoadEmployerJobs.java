package controller.employerservlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoadEmployerJobs extends HttpServlet {

Connection conn;
    public void init() throws ServletException {
            ServletContext context = getServletContext();
            conn = (Connection)context.getAttribute("connection");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {	
                if (conn != null) {
                    HttpSession session = request.getSession();
                    Integer userID = (Integer)session.getAttribute("logged-id");
                    
                    //get emp id;
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

                    //get all jobs with the emp id
                    query = "SELECT * FROM JOBS "
                            + "WHERE JOBS.EMP_ID = ? AND JOB_ISACTIVE = 0"
                    ;

                    ps = conn.prepareStatement(query);
                    ps.setInt(1, empID);
                    ResultSet jobs = ps.executeQuery();

                    List<HashMap> jobList = new ArrayList<>();

                    while(jobs.next()){     
                        HashMap<String, String> map = new HashMap<>();
                        map.put("job-id", ""+jobs.getInt("JOB_ID"));
                        map.put("job-title", jobs.getString("JOB_TITLE"));
                        map.put("pending-count", ""+getCount(empID, 0, jobs.getInt("JOB_ID")));
                        map.put("accepted-count", ""+getCount(empID, 1, jobs.getInt("JOB_ID")));
                        map.put("rejected-count", ""+getCount(empID, 2, jobs.getInt("JOB_ID")));
                        jobList.add(map);
                    }

                    request.setAttribute("jobs", jobList);
                    request.getRequestDispatcher("employer-home.jsp").forward(request,response);
                } else {
                    request.setAttribute("error-message", "Connection Error");
                    request.getRequestDispatcher("error.jsp").forward(request,response);
                }
        } catch (SQLException sqle){
                request.setAttribute("error-message", sqle.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request,response);
        } 

    }

    int getCount (int empID, int status, int jobID) throws SQLException{
        int count = 0;
        String query = "SELECT * FROM JOBS "
        + "INNER JOIN EMPLOYERS ON JOBS.EMP_ID = EMPLOYERS.EMP_ID "
        + "INNER JOIN APPLICATIONS ON JOBS.JOB_ID = APPLICATIONS.JOB_ID "
        + "WHERE JOBS.EMP_ID = ? AND JOB_ISACTIVE = 0 AND APP_STATUS = ? "
        + "AND APPLICATIONS.JOB_ID = ?";

        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, empID);
        ps.setInt(2, status);
        ps.setInt(3, jobID);

        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            count++;
        }
        return count;
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