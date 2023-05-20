package controller;

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
import nl.captcha.Captcha;

public class LoginServlet extends HttpServlet {

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

                //Verify captcha
                Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
                String answer = request.getParameter("answer");
                if (!captcha.isCorrect(answer)) {
                    session.setAttribute("feedback-message", "Incorrect Captcha");
                    response.sendRedirect("login.jsp");
                    return;
                }

                // Verify login credentials
                String keyString = getServletConfig().getInitParameter("key");
                String cipherType = getServletConfig().getInitParameter("cipher");
                String encryptedUserPass = model.Security.encrypt(request.getParameter("password"), cipherType, keyString);

                String query = "SELECT * FROM USERS WHERE USER_EMAIL = ? "
                        + "AND USER_PASSWORD = ?";
                PreparedStatement ps = conn.prepareStatement(query);

                ps.setString(1, request.getParameter("email"));
                ps.setString(2, encryptedUserPass);

                ResultSet loggedUser = ps.executeQuery();

                if (loggedUser.next()) {
                    // Successful login
                    int userID = loggedUser.getInt("USER_ID");
                    int userType = loggedUser.getInt("USER_TYPE");

                    if (userType != Integer.parseInt(request.getParameter("user-type"))) {
                        response.sendRedirect("unauthorized-access.jsp");
                    } else {
                        session.setAttribute("logged-id", userID);

                        if (userType == 1) {
                            session.setAttribute("logged-usertype", "jobseeker");
                            request.getRequestDispatcher("/LoadJobFeed").forward(request, response);
                        } else {
                            session.setAttribute("logged-usertype", "employer");
                            request.getRequestDispatcher("/employer-home").forward(request, response);
                        }
                    }
                } else {
                    response.sendRedirect("invalid-login.jsp");
                    //session.setAttribute("feedback-message", "Wrong Login Credentials");
                    //request.getRequestDispatcher("login.jsp").forward(request,response);
                }
            } else {
                response.sendRedirect("error500.jsp");
            }
        } catch (SQLException sqle) {
            response.sendRedirect("error500.jsp");
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
