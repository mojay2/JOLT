<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="./components/header.jsp"%>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>Job Feed</title>
    </head>
    <body>
        <%
            Integer id = (Integer)session.getAttribute("logged-id");
            String query = "";
            if(request.getAttribute("query") != null) query = request.getAttribute("query").toString();
        %>
        
        <div class="container">
            <%@include file="./components/nav-seeker.jsp"%>
            <%if(session.getAttribute("feedback-message") != null){%>
            <%@include file="./components/feedback-message.jsp"%>
            <%}%>
            <div class="active-jobs content p-1 mt-1 d-block rounded text-center">
            </div>
            <form method="get" action="LoadJobFeed" id="searchbar">
                <div class="input-group mb-3 w-50 mx-auto">
                <input type="text" class="form-control" placeholder="Search" name="query" value="<%=query%>">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary">Search</button>
                    </div>
                    <div class="input-group-append">
                        <select class="form-select" id="industry" name="industry" onchange="document.getElementById('searchbar').submit()">
                            <option value="-1">Select One</option>
                            <option value="1">Information Technology</option>
                            <option value="2">Healthcare</option>
                            <option value="3">Sales</option>
                            <option value="4">Education</option>
                            <option value="5">Finance</option>
                            <option value="6">Marketing</option>
                            <option value="7">Engineering</option>
                            <option value="8">Hospitality</option>
                        </select>
                    </div>
                </div>
            </form>
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
                                            int counter = 0;
                                            int firstJobID = 0;
                                            while (jobs.next()) {
                                                counter++;
                                                if(counter == 1){
                                                    firstJobID = jobs.getInt("JOB_ID");
                                                }%>
                                                <tr>
                                                    <td><%=jobs.getString("JOB_TITLE")%></td>
                                                    <td><%=jobs.getString("EMP_NAME")%></td>
                                                    <td><%=jobs.getString("JOB_LOCATION")%></td>
                                                    <td>₱<%=jobs.getString("JOB_SALARY_MAX")%>/Month</td>
                                                    <td><%=jobs.getString("IND_NAME")%></td>
                                                    <td><%=jobs.getString("TYPE_NAME")%></td>
                                                    <td><%=jobs.getString("LEVEL_NAME")%></td>            
                                                    <td>
                                                    <button class="btn btn-primary view-job" data-id="<%=jobs.getInt("JOB_ID")%>">View</button>
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
                                        
            <!--POST INFO-->
            <div class="card p-1 mt-1 rounded text-center" id="job-loader" data-id="<%=firstJobID%>">
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
                                        
        <script>
          
        const viewButtons = document.querySelectorAll('.view-job');
        
        document.addEventListener("DOMContentLoaded", loadFirstJob());
        function loadFirstJob(){
          const jobID = document.getElementById("job-loader").getAttribute("data-id");
          loadJobInfo(jobID);
        }
        
        viewButtons.forEach(button => {
          button.addEventListener('click', () => {
            const jobID = button.getAttribute('data-id');
            // retrieve job info from the server
            loadJobInfo(jobID);
          });
        });
          
          
          
        function loadJobInfo(jobID){
            fetch('./ViewJobInfo?id='+jobID)
                .then(response => response.json())
                .then(job => {
                    document.getElementById('job-title').innerHTML = job.jobtitle;
                    document.getElementById('emp-name').innerHTML = job.empname + "||";
                    document.getElementById('job-location').innerHTML = job.joblocation + "||";
                    document.getElementById('job-industry').innerHTML = job.jobindustry;

                    document.getElementById('job-salary').innerHTML = job.jobsalary +"/month||";
                    document.getElementById('job-type').innerHTML = job.jobtype+"||";
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
