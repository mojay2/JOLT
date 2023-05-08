<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="./components/header.jsp"%>
        <title>Job Feed</title>
    </head>
    <body>
        <%
            session = request.getSession();
            Integer id = (Integer)session.getAttribute("logged-id");
            String user;
            String viewURL;
            String applyURL;
            if(id == null){
                user = "guest";
                viewURL = "login.jsp";
                applyURL = "login.jsp";
            }else{
                user = "jobseeker";
                viewURL = "LoadJobFeed";
                applyURL = "LoadJobFeed";
            }
        %>
        
        <div class="container">
            <%@include file="./components/nav-seeker.jsp"%>
            <div class="active-jobs content p-1 mt-1 d-block rounded text-center">
            </div>
            <div class="content p-1 mt-2 d-block rounded text-center">
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-header"></div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Job Title</th>
                                                <th>Employer</th>
                                                <th>Location</th>
                                                <th>Salary</th>
                                                <th>Industry</th>                                                
                                                <th>Job Type</th>
                                                <th>Job Level</th>  
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%ResultSet jobs = (ResultSet)request.getAttribute("jobs");
                                            while (jobs.next()) {%>
                                                <tr>
                                                    <td><%=jobs.getString("JOB_TITLE")%></td>
                                                    <td><%=jobs.getString("EMP_NAME")%></td>
                                                    <td><%=jobs.getString("JOB_LOCATION")%></td>
                                                    <td>₱<%=jobs.getString("JOB_SALARY_MAX")%>/Month</td>
                                                    <td><%=jobs.getString("IND_NAME")%></td>
                                                    <td><%=jobs.getString("TYPE_NAME")%></td>
                                                    <td><%=jobs.getString("LEVEL_NAME")%></td>            
                                                    <td>
                                                        <a href="<%=viewURL%>"><button class="btn btn-info btn-sm"><i class="fa fa-eye" aria-hidden="true"></i> View</button></a>
                                                        <a href="<%=applyURL%>"><button class="btn btn-warning btn-sm"><i class="fa fa-eye" aria-hidden="true"></i>Apply</button></a>
                                                    </td>
                                                </tr>
                                                <%}%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>	
    </body>
</html>
