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
import model.Security;

public class EditCredentials extends HttpServlet {

  Connection conn;

    public void init() throws ServletException {
            ServletContext context = getServletContext();
            conn = (Connection)context.getAttribute("connection");
    }

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    try {
      if (conn != null) {
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("logged-id");
        String current = request.getParameter("cur-password");
        String password = request.getParameter("new-password");
        String confirm = request.getParameter("confirm");

        String keyString = getServletConfig().getInitParameter("key");
        String cipherType = getServletConfig().getInitParameter("cipher");

        String query = "SELECT * FROM USERS WHERE USER_ID = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        String dbPass = "";
        if (rs.next()) {
          dbPass = rs.getString("USER_PASSWORD");
        }
        rs.close();

        if (current.equals(Security.decrypt(dbPass, cipherType, keyString)) && password.equals(confirm)) {
          //update password
          query = "UPDATE USERS "
                  + "SET USER_PASSWORD = ? "
                  + "WHERE USER_ID = ?";
          ps = conn.prepareStatement(query);
          ps.setString(1, Security.encrypt(password, cipherType, keyString));
          ps.setInt(2, userID);
          ps.executeUpdate();
          ps.executeUpdate();
        }

        request.getRequestDispatcher("ViewProfile").forward(request, response);
      } else {
        request.setAttribute("error-message", "Connection Error");
        request.getRequestDispatcher("error.jsp").forward(request, response);
      }
    } catch (SQLException sqle) {
      request.setAttribute("error-message", sqle.getMessage());
      request.getRequestDispatcher("error.jsp").forward(request, response);
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
