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
        <%@include file="./components-old/header.jsp"%>
        <title>Applied Jobs</title>
    </head>
    <body>
        <div class="container">
            <%@include file="./components-old/nav-seeker.jsp"%>
            <%if(session.getAttribute("feedback-message") != null){%>
            <%@include file="./components-old/feedback-message.jsp"%>
            <%}%>
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
                                                    <td id="jobFeedBtn" data-id="<%=applications.getInt("JOB_ID")%>"><%=applications.getString("JOB_TITLE")%></td>
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
                <div class="card p-1 mt-1 rounded text-center d-none" id="job-loader">
                    <h1 id = "job-title"></h1>
                    <div class="d-flex justify-content-center">
                        <h3 id = "emp-name"></h3>
                        <h3 id = "job-location"></h3>
                        <h3 id = "job-industry"></h3>
                    </div>

                    <div class="d-flex justify-content-center">
                        <h5 id = "job-salary"></h5>
                        <h5 id = "job-type"></h5>
                        <h5 id = "job-level"></h5>
                    </div>

                    <hr>

                    <h5>Job Description</h5>
                    <p id = "job-desc"></p>
                    <hr>

                    <h5>Company Overview</h5>
                    <p id = "emp-overview"></p>
                    <hr>

                    <h5>Responsibilities</h5>
                    <ul>
                        <p id = "job-resp"></p>
                    </ul>
                    <hr>                        

                    <h5>Requirements</h5>
                    <ul>
                        <p id = "job-reqs"></p>
                    </ul>
                    <hr>

                    <h5>Benefits</h5>
                    <ul>
                        <p id = "job-benefits"></p>
                    </ul>

                    <form action = "CreateJobApp" class="form-control" method="post">
                        <input id="hidden-job-id" type="hidden" name="job-id" value=""/>
                        <input id="hidden-emp-id" type="hidden" name="emp-id" value=""/>
                        <%if(session.getAttribute("logged-id") == null){%>
                            <a class="btn btn-warning" href="login.jsp">Apply</a>
                        <%}else{%>
                            <button class="btn btn-warning" type="submit">Apply</button>
                        <%}%>
                    </form>
                </div>
            </div>
        </div>	
    <script>
        //Add listener to view buttons
        const viewButtons = document.querySelectorAll('#jobFeedBtn');
        const postLoader = document.querySelector("#job-loader");

        document.addEventListener("DOMContentLoaded", loadFirstJob());

        function loadFirstJob(){
          const jobID = document.getElementById("job-loader").getAttribute("data-id");
          loadJobInfo(jobID);
        }

        viewButtons.forEach(button => {
          button.addEventListener('click', () => {
            const jobID = button.getAttribute('data-id');
            console.log("asdf");
            // retrieve job info 
            loadJobInfo(jobID);
            postLoader.classList.remove("d-none");
          });
        });

        function loadJobInfo(jobID){
            fetch('./ViewJobInfo?id='+jobID)
                .then(response => response.json())
                .then(job => {
                    document.getElementById('job-title').innerHTML = job.jobtitle;
                    document.getElementById('emp-name').innerHTML = job.empname;
                    document.getElementById('job-location').innerHTML = job.joblocation;
                    document.getElementById('job-industry').innerHTML = job.jobindustry;

                    document.getElementById('job-salary').innerHTML = "₱"+job.jobsalary+" / Month";
                    document.getElementById('job-type').innerHTML = job.jobtype;
                    document.getElementById('job-level').innerHTML = job.joblevel;

                    document.getElementById('job-desc').innerHTML = job.jobdesc;
                    document.getElementById('emp-overview').innerHTML = job.empoverview;
                    document.getElementById('job-resp').innerHTML = job.jobresp;
                    document.getElementById('job-reqs').innerHTML = job.jobreqs;
                    document.getElementById('job-benefits').innerHTML = job.jobbenefits;

                    document.getElementById('hidden-job-id').value = job.jobid;
                    document.getElementById('hidden-emp-id').value = job.empid;
                })
            .catch(error => console.log(error));
        }
    </script>
    </body>
</html>
