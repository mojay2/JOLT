
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="./components-old/header.jsp"%>
        <title>Login Page</title>
    </head>
    
    <body>
        <div class="container">
            <%@include file="./components-old/nav-seeker.jsp"%>
            <%if(session.getAttribute("feedback-message") != null){%>
            <%@include file="./components-old/feedback-message.jsp"%>
            <%}%>
            <div>
                <h1 class="title text-center">JABOOOOOOOOOOOOARD</h1>  
            </div>
            <div class="d-flex justify-content-center align-content-center text-center">
                <form class="mt-2 p-2 rounded w-50" action="LoginServlet" method="post">
                    <div class="form-outline my-3">
                        <label class="form-label" for="email">Email address</label>
                        <input type="email" id="email" name = "email" class="form-control" required/>                 
                    </div>

                    <div class="form-outline my-3">
                        <label class="form-label" for="password">Password</label>
                        <input type="password" id="password" name = "password" class="form-control" required/>                 
                    </div>
                    
                    <div class="form-check my-3">
                        <h3>Your Role:</h3>
                        <div>
                            <label class="form-check-label" for="jobseeker">Looking for employment</label>
                            <input type="radio" id="jobseeker" name = "user-type" class="form-check-input" value="1" required/>  
                        </div> 
                        <div>
                            <label class="form-check-label" for="employer">Looking for job applicants</label>
                            <input type="radio" id="employer" name = "user-type" class="form-check-input" value="2" required/>  
                        </div>               
                    </div>
                    <div class="form-check my-3">
                        <img class="mb-4" src="./simpleImg" /> 
                        <input name="answer" />
                    </div>
                    <div class="for">
                        <button type="submit" class="btn btn-info btn-block mb-4">Sign in</button>
                    </div>
                </form>      
            </div>
        </div>
        <%@include file="./components-old/footer.jsp"%>
    </body>
</html>


