<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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
        <title>Employer Home</title>
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
                                                <th>Pending</th>
                                                <th>Accepted</th>
                                                <th>Rejected</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%ArrayList<HashMap> jobs = (ArrayList)request.getAttribute("jobs");%>
                                        <%for(int i = 0; i < jobs.size(); i++){
                                            HashMap<String,String> job = jobs.get(i);%>
                                            <tr>
                                                <td><%=job.get("job-id")%></td>
                                                <td><%=job.get("job-title")%></td>
                                                <td><%=job.get("pending-count")%></td>
                                                <td><%=job.get("accepted-count")%></td>
                                                <td><%=job.get("rejected-count")%></td>
                                                <td>
                                                    <form id="delete<%=job.get("job-id")%>" method = "post" action="DeleteJobListing">
                                                        <input type="hidden" name="job-id" value ="<%=job.get("job-id")%>"/>
                                                        <a class="btn btn-info" href="LoadJobCandidates?job-id=<%=job.get("job-id")%>">View</a>
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
