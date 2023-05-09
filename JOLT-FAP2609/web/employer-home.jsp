<%@page import="java.sql.ResultSet"%>
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
            
            <%@include file="./components/nav-employer.jsp"%>
            
            <div class="content p-1 mt-2 d-block rounded text-center">
                <h3 class="">Welcome Back, <%=(String)session.getAttribute("logged-employer")%></h3>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-header">Active Jobs</div>
                            <div class="card-body">
                                <a href="create-job-listing.jsp" class="btn btn-success btn-sm">Create Job Listing</a>
                                <br/>
                                <br/>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Job Title</th>
                                                <th>Job Type</th>
                                                <th>Job Level</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%ResultSet jobs = (ResultSet)request.getAttribute("jobs");
                                            while (jobs.next()) { %>
                                                <tr>
                                                    <td><%=jobs.getString("JOB_ID")%></td>
                                                    <td><%=jobs.getString("JOB_TITLE")%></td>
                                                    <td><%=jobs.getString("TYPE_NAME")%></td>
                                                    <td><%=jobs.getString("LEVEL_NAME")%></td>            
                                                    <td>
                                                        <form id="delete<%=jobs.getString("JOB_ID")%>" method = "post" action="DeleteJobListing">
                                                            <input type="hidden" name="job-id" value ="<%=jobs.getString("JOB_ID")%>"/>
                                                            <a class="btn btn-info" href="LoadJobCandidates?job-id=<%=jobs.getString("JOB_ID")%>">View</a>
                                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                                        </form>
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
