<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="./components/header.jsp"%>
        <title>Home Page</title>
    </head>
    <body>
        <%
            session = request.getSession();
            Integer id = (Integer)session.getAttribute("logged-id");
        %>
        <div class="container">
            <%@include file="./components/nav-seeker.jsp"%>
            <div class="content p-1 mt-2 d-block rounded text-center">
                <h1 class="">You are a Job seeker with ID: <%=(Integer)session.getAttribute("logged-id")%></h1>
            </div>
                
            <div class="active-jobs content p-4 mt-5 d-block rounded text-center">
                <h2 class="">Available Job Listings</h2>
            </div>
        </div>	
    </body>
</html>
