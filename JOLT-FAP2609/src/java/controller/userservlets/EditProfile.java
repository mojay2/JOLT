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

public class EditProfile extends HttpServlet {

Connection conn;
    public void init() throws ServletException {
            ServletContext context = getServletContext();
            conn = (Connection)context.getAttribute("connection");
    }

    //This servlet returns an entry from the USER table corresponding to the logged in USERID
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {	
                if (conn != null) {
                    HttpSession session = request.getSession();
                    Integer userID = (Integer)session.getAttribute("logged-id");

                    String query = "SELECT * FROM USERS "
                                + "INNER JOIN JOBSEEKERS ON JOBSEEKERS.USER_ID = USERS.USER_ID "
                                + "WHERE JOBSEEKERS.USER_ID = ?"
                    ;

                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setInt(1, userID);
                    ResultSet user = ps.executeQuery();

                    Integer seekerID = 0;
                    if(user.next()){
                        seekerID = user.getInt("SEEKER_ID");
                    }

                    //update useremail
                   query = "UPDATE USERS "
                        + "SET USER_EMAIL = ? "
                        + "WHERE USER_ID = ?";
                    ps = conn.prepareStatement(query);
                    ps.setString(1, request.getParameter("email"));
                    ps.setInt(2, userID);
                    ps.executeUpdate();

                    //Split first and last name
                    String[] nameArr = ((String)request.getParameter("name")).split(" ");
                    String fname = "", lname = "";
                    for(int i = 0; i < nameArr.length; i++){
                        if(i == nameArr.length-1)
                            lname = nameArr[i];
                        else
                            fname += nameArr[i]+" ";
                    }

                    //update jobseekertable
                    query = "UPDATE JOBSEEKERS "
                        + "SET SEEKER_FNAME = ?, "
                        + "SEEKER_LNAME = ? , "
                        + " SEEKER_TITLE = ? , "
                        + " SEEKER_NUMBER = ? , "
                        + " SEEKER_ADDRESS = ? , "
                        + " SEEKER_ZOOMID = ? , "
                        + " SEEKER_ABOUT = ? , "
                        + " SEEKER_EDUC_COURSE = ? , "
                        + " SEEKER_EDUC_SCHOOL = ? , "
                        + " SEEKER_EDUC_BATCH = ? , "
                        + " SEEKER_EXP_TITLE = ? , "
                        + " SEEKER_EXP_COMPANY = ? , "
                        + " SEEKER_EXP_BATCH = ? , "
                        + " SEEKER_SKILLS = ?"
                        + "WHERE SEEKER_ID = ?";

                    ps = conn.prepareStatement(query);
                    ps.setString(1, fname);
                    ps.setString(2, lname);
                    ps.setString(3, request.getParameter("title"));
                    ps.setString(4, request.getParameter("number"));
                    ps.setString(5, request.getParameter("location"));
                    ps.setString(6, request.getParameter("zoom"));
                    ps.setString(7, request.getParameter("about"));
                    ps.setString(8, request.getParameter("course"));
                    ps.setString(9, request.getParameter("college"));
                    ps.setString(10, request.getParameter("educ_date"));
                    ps.setString(11, request.getParameter("job"));
                    ps.setString(12, request.getParameter("company"));
                    ps.setString(13, request.getParameter("job_date"));
                    ps.setString(14, request.getParameter("skills"));
                    ps.setInt(15, seekerID);

                    ps.executeUpdate();


                    request.getRequestDispatcher("ViewProfile").forward(request,response);
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