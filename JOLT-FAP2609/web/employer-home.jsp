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
                <h1 class="">You are an Employer with ID: <%=id%></h1>
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
                                                    <td><%=jobs.getInt("JOB_TYPE")%></td>
                                                    <td><%=jobs.getInt("JOB_LEVEL")%></td>            
                                                    <td>
                                                        <a href="#"><button class="btn btn-info btn-sm"><i class="fa fa-eye" aria-hidden="true"></i> View</button></a>
                                                        <a href="#"><button class="btn btn-primary btn-sm"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Edit</button></a>
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
