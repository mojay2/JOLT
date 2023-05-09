<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="./components/header.jsp"%>
        <title>JOLT</title>
    </head>
    
    <body>
        <div class="container">
            <%@include file="./components/nav-seeker.jsp"%>
            <div>
                <h1 class="title text-center">JABOOOOOOOOOOOOARD LANDING PAGE</h1>  
            </div>
            
            <form id="searchbar" method="get" action="LoadJobFeed">
                <div class="input-group mb-3 w-50 mx-auto">
                <input type="text" class="form-control" placeholder="Search" name="query">
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
        </div>
        <%@include file="./components/footer.jsp"%>
    </body>
</html>


