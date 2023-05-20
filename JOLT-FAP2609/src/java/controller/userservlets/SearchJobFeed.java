package controller.userservlets;

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

public class SearchJobFeed extends HttpServlet {

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

                    String searchParam = request.getParameter("search");
                    int industry = Integer.parseInt(request.getParameter("industry"));
                    String query = "SELECT * FROM JOBS "
                        + "INNER JOIN EMPLOYERS ON JOBS.EMP_ID = EMPLOYERS.EMP_ID "
                        + "INNER JOIN INDUSTRIES ON INDUSTRY_ID = IND_ID "
                        + "INNER JOIN TYPES ON JOB_TYPE = TYPE_ID "
                        + "INNER JOIN LEVELS ON JOB_LEVEL = LEVEL_ID "                    
                    ;   
                    if (!searchParam.isEmpty() || industry != -1) {
                        query += " WHERE ";
                        if (!searchParam.isEmpty()) {
                                query += "(LOWER(JOB_TITLE) LIKE LOWER(?) OR LOWER(EMP_NAME) LIKE LOWER(?) "
                                        + "OR LOWER(LEVEL_NAME) LIKE LOWER(?) OR LOWER(JOB_LOCATION) LIKE LOWER(?) "
                                        + "OR LOWER(EMP_OVERVIEW) LIKE LOWER(?))";
                        }
                        if (!searchParam.isEmpty() && industry != -1) {
                            query += " AND ";
                        }
                        if (industry != -1) {
                            query += "IND_ID = ? ";
                        }           
                    }
                    query += "ORDER BY JOB_ID DESC";

                    PreparedStatement ps = conn.prepareStatement(query);
                    int parameterIndex = 1;
                    if (!searchParam.isEmpty()) {
                        String searchBoxParam = "%" + searchParam + "%";
                        ps.setString(parameterIndex++, searchBoxParam);
                        ps.setString(parameterIndex++, searchBoxParam);
                        ps.setString(parameterIndex++, searchBoxParam);
                        ps.setString(parameterIndex++, searchBoxParam);
                        ps.setString(parameterIndex++, searchBoxParam);                   
                    }
                    if (industry != -1) {
                        ps.setInt(parameterIndex++, industry);
                    }

                    ResultSet jobs = ps.executeQuery();

                    request.setAttribute("jobs", jobs);
                    request.setAttribute("query", request.getParameter("query")); 
                    request.getRequestDispatcher("job-feed.jsp").forward(request,response);
                } else {
                    request.setAttribute("error-message", "Connection Error");
                    request.getRequestDispatcher("error.jsp").forward(request,response);
                }
        } catch (SQLException sqle){
                request.setAttribute("error-message", sqle.getMessage());
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