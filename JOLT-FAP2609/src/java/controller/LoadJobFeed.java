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

public class LoadJobFeed extends HttpServlet {

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
                    Integer userID = (Integer)session.getAttribute("logged-id");
                    String query;
                    PreparedStatement ps;

                    if(request.getParameter("query") == null && request.getParameter("industry") == null){
                        query = "SELECT * FROM JOBS "
                                   + "INNER JOIN EMPLOYERS ON JOBS.EMP_ID = EMPLOYERS.EMP_ID "
                                   + "INNER JOIN INDUSTRIES ON INDUSTRY_ID = IND_ID "
                                   + "INNER JOIN TYPES ON JOB_TYPE = TYPE_ID "
                                   + "INNER JOIN LEVELS ON JOB_LEVEL = LEVEL_ID "
                                   + "ORDER BY JOB_ID DESC"
                        ;
                        ps = conn.prepareStatement(query);
                    }else{
                        int industryID = Integer.parseInt(request.getParameter("industry"));
                            String extraParam ="AND IND_ID = ? ";                        
                            if(industryID == -1){
                                extraParam = "";
                            }
                        query = "SELECT * FROM JOBS "
                                + "INNER JOIN EMPLOYERS ON JOBS.EMP_ID = EMPLOYERS.EMP_ID "
                                + "INNER JOIN INDUSTRIES ON INDUSTRY_ID = IND_ID "
                                + "INNER JOIN TYPES ON JOB_TYPE = TYPE_ID "
                                + "INNER JOIN LEVELS ON JOB_LEVEL = LEVEL_ID "
                                + "WHERE LOWER(JOB_TITLE) LIKE LOWER(?) "
                                + "OR LOWER(JOB_DESC) LIKE LOWER(?) "
                                + "OR LOWER(JOB_REQS) LIKE LOWER(?) "
                                + "OR LOWER(JOB_BENEFIT) LIKE LOWER(?) "
                                + "OR LOWER(JOB_RESP) LIKE LOWER(?) "
                                + "OR LOWER(EMP_OVERVIEW) LIKE LOWER(?) "
                                + "OR LOWER(EMP_NAME) LIKE LOWER(?) "
                                + "OR LOWER(JOB_LOCATION) LIKE LOWER(?) "
                                + extraParam
                                + "ORDER BY JOB_ID DESC"
                        ;
                        ps = conn.prepareStatement(query); 
                        ps.setString(1, "%"+request.getParameter("query")+"%");
                        ps.setString(2, "%"+request.getParameter("query")+"%");
                        ps.setString(3, "%"+request.getParameter("query")+"%");
                        ps.setString(4, "%"+request.getParameter("query")+"%");
                        ps.setString(5, "%"+request.getParameter("query")+"%");
                        ps.setString(6, "%"+request.getParameter("query")+"%");
                        ps.setString(7, "%"+request.getParameter("query")+"%");
                        ps.setString(8, "%"+request.getParameter("query")+"%");
                        if(industryID != -1){
                            ps.setInt(9, Integer.parseInt(request.getParameter("industry")));
                        }
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