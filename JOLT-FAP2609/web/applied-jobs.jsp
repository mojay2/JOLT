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
        <title>Applied Jobs</title>
    </head>
    <body>
        <div class="container">
            <%@include file="./components/nav-seeker.jsp"%>
            <div class="content p-1 mt-2 d-block rounded text-center">
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav text-center">
                            <a class="nav-item nav-link" href="LoadAppliedJobs">Applied</a>
                            <a class="nav-item nav-link" href="LoadAppliedJobs?status=0">Pending</a>
                            <a class="nav-item nav-link" href="LoadAppliedJobs?status=1">Accepted</a>
                            <a class="nav-item nav-link" href="LoadAppliedJobs?status=2">Rejected</a>
                        </div>
                    </div>
                </nav>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-header">Your Applications</div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Job Title</th>
                                                <th>Employer</th>
                                                <th>Location</th>
                                                <th>Salary</th>
                                                <th>Job Type</th>
                                                <th>Job Level</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%ResultSet applications = (ResultSet)request.getAttribute("applications");
                                            while (applications.next()) {
                                                int appID = applications.getInt("APP_ID");%>
                                                <tr>
                                                    <td><%=applications.getString("JOB_TITLE")%></td>
                                                    <td><%=applications.getString("EMP_NAME")%></td>
                                                    <td><%=applications.getString("JOB_LOCATION")%></td>
                                                    <td><%=applications.getString("JOB_SALARY_MAX")%>/Month</td>
                                                    <td><%=applications.getString("TYPE_NAME")%></td>
                                                    <td><%=applications.getString("LEVEL_NAME")%></td>
                                                    <td><%=applications.getString("STATUS_NAME")%></td>
                                                    <td>
                                                        <form id="deleteForm<%=appID%>" method="post" action="DeleteJobApplication">
                                                            <input type="hidden" name="app-id" value="<%=appID%>">
                                                            <button type="submit" class="btn btn-danger">Withdraw App</button>
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
