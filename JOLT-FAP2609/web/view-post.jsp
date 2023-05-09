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
                <%ResultSet job = (ResultSet)request.getAttribute("job");
                    if(job.next()){%>
                        <h1><%=job.getString("JOB_TITLE")%></h1>
                        <h3><%=job.getString("EMP_NAME")%> || 
                            <%=job.getString("JOB_LOCATION")%> ||
                            <%=job.getString("IND_NAME")%>                               
                        </h3>
                        <h5>₱<%=job.getString("JOB_SALARY_MAX")%>/Month || 
                            <%=job.getString("TYPE_NAME")%> || 
                            <%=job.getString("LEVEL_NAME")%>
                        </h5>
                        <hr>
                        
                        <h5>Job Description</h5>
                        <p><%=job.getString("JOB_DESC")%></p>
                        <hr>
                        
                        <h5>Responsibilities</h5>
                        <%String[] jobResp = job.getString("JOB_RESP").split("\\*");%>
                        <ul>
                            <% for (String bullet: jobResp){%>
                            <%if(bullet.trim().isEmpty()){
                                continue;
                            }%>
                            <li><%=bullet%></li>
                            <%}%>
                        </ul>
                        <hr>                        

                        
                        <h5>Requirements</h5>
                        <%String[] jobReqs = job.getString("JOB_REQS").split("\\*");%>
                        <ul>
                            <% for (String bullet: jobReqs){%>
                            <%if(bullet.trim().isEmpty()){
                                continue;
                            }%>
                            <li><%=bullet%></li>
                            <%}%>
                        </ul>
                        <hr>
                        
                        <h5>Benefits</h5>
                        <%String[] jobBnfts = job.getString("JOB_BENEFIT").split("\\*");%>
                        <ul>
                            <% for (String bullet: jobBnfts){%>
                            <%if(bullet.trim().isEmpty()){
                                continue;
                            }%>
                            <li><%=bullet%></li>
                            <%}%>
                        </ul>
                        
                        <form action = "CreateJobApp" class="form-control" method="post">
                            <input type="hidden" name="job-id" value="<%=job.getString("JOB_ID")%>"/>
                            <input type="hidden" name="emp-id" value="<%=job.getString("EMP_ID")%>"/>
                        <span>
                            <a class="btn btn-info" href="LoadJobFeed">Back</a>
                            <%if(session.getAttribute("logged-id") == null){%>
                                <a class="btn btn-warning" href="login.jsp">Apply</a>
                            <%}else{%>
                                <button class="btn btn-warning" type="submit">Apply</button>
                            <%}%>
                        </span>
                        </form>
                    <%}
                %>

            </div>
        </div>	
    </body>
</html>
