package model;

import javax.servlet.*;  
import java.sql.*;  

public class DbConn implements ServletContextListener{  

    public void contextInitialized(ServletContextEvent event) {  
        try{  
        Class.forName("org.apache.derby.jdbc.ClientDriver");  
        String url = "jdbc:derby://localhost:1527/JoltDB";
        String username = "app";
        String password ="app";

        Connection con = DriverManager.getConnection(url, username, password);
            //storing connection object as an attribute in ServletContext  
            ServletContext ctx= event.getServletContext();  
            ctx.setAttribute("connection", con);  

            }catch(Exception e){e.printStackTrace();}  
        }  
  
    public void contextDestroyed(ServletContextEvent arg0) {}  
}  

