<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="./components-old/header.jsp"%>
        <title>JOLT</title>
    </head>
    
    <body>
        <div class="container">
            <%@include file="./components-old/nav-seeker.jsp"%>
            <div>
                <h1 class="title text-center">JABOOOOOOOOOOOOARD LANDING PAGE</h1>  
            </div>
            
            <form action = "SearchJobFeed" method="get">
                <div class="input-group mb-3 w-50 mx-auto">
                <input type="text" class="form-control" placeholder="Search" name="search">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary">Search</button>
                    </div>
                    <div class="input-group-append">
                        <select class="form-select" id="industry" name="industry">
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
        </div>
        <%@include file="./components-old/footer.jsp"%>
    </body>
</html>


