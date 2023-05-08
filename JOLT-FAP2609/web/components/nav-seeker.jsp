<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">JOLT</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav text-center">
            <a class="nav-item nav-link" href="LoadJobFeed">Job Feed</a>
            <a class="nav-item nav-link" href="#">Applied Jobs</a>
            <a class="nav-item nav-link" href="#">User Profile</a>
            <%if(session.getAttribute("logged-id") == null){%>
                <a class="btn btn-primary" href="login.jsp">Login</a> 
            <%}else{%>    
                <a class="btn btn-danger" href="LogoutServlet">Logout</a> 
            <%}%>           
        </div>
    </div>
</nav>