<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            session = request.getSession();
            Integer id = (Integer)session.getAttribute("logged-id");
            String errMessage = (String)session.getAttribute("error-message");
        %>
        <%@include file="./components/header.jsp"%>
        <title>Home Page</title>
    </head>
    <body>
        <div class="container">
            <%@include file="./components/nav-seeker.jsp"%>            
            <div class="card p-1 mt-1 rounded text-center">
                <%ResultSet user = (ResultSet)request.getAttribute("user");
                if(user.next()){%>
                <h1><%=user.getString("SEEKER_FNAME")+" "+user.getString("SEEKER_LNAME")%></h1>
                <h2><%=user.getString("SEEKER_TITLE")%></h2>
                <hr/>
                <h3>Contact Details</h3>
                <p><%=user.getString("SEEKER_NUMBER")%></p>
                <p><%=user.getString("USER_EMAIL")%></p>
                <p><%=user.getString("SEEKER_ADDRESS")%></p>
                <p><%=user.getString("SEEKER_ZOOMID")%></p>
                <hr/>
                
                <h1>About Me</h1>
                <p><%=user.getString("SEEKER_ABOUT")%></p>
                <hr/>

                <h1>Education</h1>
                <h3><%=user.getString("SEEKER_EDUC_COURSE")%></h3>
                <p><%=user.getString("SEEKER_EDUC_SCHOOL")%></p>
                <p><%=user.getString("SEEKER_EDUC_BATCH")%></p>
                <hr/>
                
                <h1>Experience</h1>
                <h3><%=user.getString("SEEKER_EXP_TITLE")%></h3>
                <p><%=user.getString("SEEKER_EXP_COMPANY")%></p>
                <p><%=user.getString("SEEKER_EXP_BATCH")%></p>
                <hr/>
                
                <h1>Skills</h1>
                <%String[] skills = user.getString("SEEKER_SKILLS").split("\\*");%>
                <ul>
                    <% for (String bullet: skills){%>
                    <%if(bullet.trim().isEmpty()){
                        continue;
                    }%>
                    <li><%=bullet%></li>
                    <%}%>
                </ul>
                <hr>      
                <%}%>

            </div>
        </div>	
    </body>
</html>
