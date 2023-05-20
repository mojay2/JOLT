package controller.employerservlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteJobListing extends HttpServlet {

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
                    Integer loggedUser = (Integer)session.getAttribute("logged-id");

                    int jobID = Integer.parseInt(request.getParameter("job-id"));

                    String query = "DELETE FROM JOBS WHERE JOB_ID = ?" ;

                    PreparedStatement ps = conn.prepareStatement(query);            
                    ps.setInt(1, jobID);                    
                    ps.executeUpdate(); 

                    session.setAttribute("feedback-message", "Successfully Deleted Job Listing");
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