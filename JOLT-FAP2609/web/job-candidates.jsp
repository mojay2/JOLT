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
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav text-center">
                            <a class="nav-item nav-link" href="LoadJobCandidates">Active</a>
                            <a class="nav-item nav-link" href="LoadJobCandidates?status=0">Pending Review</a>
                            <a class="nav-item nav-link" href="LoadJobCandidates?status=1">Accepted</a>
                            <a class="nav-item nav-link" href="LoadJobCandidates?status=2">Rejected</a>
                        </div>
                    </div>
                </nav>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-header">Job Applicants</div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Name</th>
                                                <th>Status</th>
                                                <th>Job Title</th>
                                                <th>Recent Experience</th>
                                                <th>Interested?</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%ResultSet applications = (ResultSet)request.getAttribute("applications");
                                            while (applications.next()) {
                                                int appID = applications.getInt("APP_ID");%>
                                                <tr>
                                                    <td><%=applications.getInt("APP_ID")%></td>
                                                    <td><%=applications.getString("SEEKER_FNAME")+" "+applications.getString("SEEKER_LNAME")%></td>
                                                    <td><%=applications.getString("STATUS_NAME")%></td>
                                                    <td><%=applications.getString("JOB_TITLE")%></td>
                                                    <td><%=applications.getString("SEEKER_EXP_TITLE")%></td>
                                                    <td>
                                                        <form id="changeStatus<%=appID%>" method="post" action="UpdateAppStatus">
                                                            <input type="hidden" name="app-id" value="<%=appID%>">
                                                            <select class="form-select" name="app-status" onchange="document.getElementById('changeStatus<%=appID%>').submit()">
                                                                <option value="-1"> Are you Interested?</option>
                                                                <option value="0">Pending</option>
                                                                <option value="1">Accept</option>
                                                                <option value="2">Reject</option>
                                                            </select>
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
    <script>
        function submitForm() {
            document.getElementById("changeStatus").submit();
        }
    </script>
    </body>
</html>
