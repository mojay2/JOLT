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
            <div class="content p-1 mt-1 d-block rounded text-center">
                <h2 class="">Create a Job Listing</h2>
                <form class="mt-2 p-2 rounded" action="CreateJobServlet" method="post">
     
                    <label class="form-label" for="job-title">Job Title</label>                     
                    <input type="text" id="job-title" name = "job-title" class="form-control" required/>     

                    <label class="form-label" for="job-location">Job Location</label>
                    <input type="text" id="job-location" name = "job-location" class="form-control" required/>
                    
                    <label class="form-label" for="job-industry">Industry</label>
                    <select class="form-select" id="job-industry" name="job-industry">
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
                    
                    <label class="form-label" for="job-type">Job Type</label>
                    <select class="form-select" id="job-type" name="job-type">
                        <option value="-1">Select One</option>
                        <option value="0">Fresh Grad</option>
                        <option value="1">Contractual</option>
                        <option value="2">Internship</option>
                        <option value="3">Part-Time</option>
                        <option value="4">Full-Time</option>
                    </select>

                    <label class="form-label" for="job-level">Employment Level</label>
                    <select class="form-select" id="job-level" name="job-level">
                        <option value="-1">Select One</option>
                        <option value="0">Entry Level</option>
                        <option value="1">Intermediate</option>
                        <option value="2">Mid Level</option>
                        <option value="3">Senior/Executive Level</option>
                    </select>
                    
                    <label class="form-label" for="job-desc">Job Description</label>
                    <!--<input type="text" id="job-desc" name = "job-desc" class="form-control" required/>-->
                    <textarea class="form-control" id="text-area" name="job-desc" rows="3"></textarea>
                    
                    <label class="form-label" for="job-resp">Job Responsibilities</label>
                    <!--<input type="text" id="job-resp" name = "job-resp" class="form-control" required/>-->
                    <textarea class="form-control" id="text-area" name="job-resp" rows="3"></textarea>
                    
                    
                    <label class="form-label" for="job-reqs">Job Requirements</label>
                    <!--<input type="text" id="job-reqs" name = "job-reqs" class="form-control" required/>-->
                    <textarea class="form-control" id="text-area" name="job-reqs" rows="3"></textarea>
                    
                    <label class="form-label" for="job-benefit">Job Benefits</label>
                    <!--<input type="text" id="job-benefit" name = "job-benefit" class="form-control" required/>-->
                    <textarea class="form-control" id="text-area" name="job-benefit" rows="3"></textarea>
                    
                    <label class="form-label" for="salary-min">Salary Range</label>
                    <input type="number" id="salary-min" name = "salary-min" class="form-control" required/>
                    <label class="form-label" for="salary-max">To (PHP PER YEAR)</label>
                    <input type="number" id="salary-max" name = "salary-max" class="form-control" required/>
                            
                    <button type="submit" class="btn btn-info btn-block my-4">Create</button>
                </form> 
            </div>
        </div>
        <script>
          const textareas = document.querySelectorAll('textarea');
          
          textareas.forEach((textarea, index) => {
            if(index !== 0 ){
                textarea.addEventListener('keydown', (e) => {
              if (e.key === 'Enter') {
                textarea.value += "*";
              }
            });
            }
          });
        </script>
    </body>
</html>
