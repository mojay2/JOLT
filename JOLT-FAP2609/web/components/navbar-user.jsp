    <%
        String jobFeedURL;
        String appliedJobsURL;
        String viewProfileURL;
        String loginLogoutURL;
        String loginLogoutButton;

        if(session.getAttribute("logged-id") == null){
            jobFeedURL = "LoadJobFeed";
            appliedJobsURL = "login.jsp";
            viewProfileURL = "login.jsp";
            loginLogoutURL = "login.jsp";
            loginLogoutButton = "Login";
        }else{
            jobFeedURL = "LoadJobFeed";
            appliedJobsURL = "LoadAppliedJobs";
            viewProfileURL = "ViewProfile";
            loginLogoutURL = "LogoutServlet";
            loginLogoutButton = "Logout";
        }
    %>

    <!-- Navbar -->
    <nav class="border-b-2 border-zinc-800 bg-slate-200" id="navbar">
      <div class="flex max-w-full flex-wrap items-center justify-between p-3"> 
       <a href="jobfeed.jsp" class="ml-3 flex flex-col items-center sm:ml-10 lg:ml-16">
          <img src="./public/assets/logo/JoltLogo.png" class="mb-1 h-14" alt="JOLT Logo" />
          <span class="text-sm text-neutral-600">(Job Opportunities Listing Tool)</span>
        </a>
        <button type="button" class="ml-3 mr-3 inline-flex items-center rounded-lg p-2 text-sm text-zinc-800 hover:text-blue-300 focus:outline-none focus:ring-2 focus:ring-blue-400 sm:mr-6 lg:hidden" data-drawer-target="drawer-navbar" data-drawer-show="drawer-navbar" data-drawer-placement="right" aria-controls="drawer-navbar">
          <span class="sr-only">Open main menu</span>
          <svg class="h-10 w-10" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg>
        </button>
        <div class="mx-auto hidden w-full lg:block lg:w-auto">
                <ul class="flex justify-between gap-16 text-xl text-zinc-800">        
                    <li>
                      <a href="<%=jobFeedURL%>" id="navbar1" class="border-blue-600 pb-1 hover:border-b-4">Job Feed</a>
                    </li>
                    <li>
                      <a href="<%=appliedJobsURL%>" id="navbar2" class="border-blue-600 pb-1 hover:border-b-4">Applied Jobs</a>
                    </li>
                    <li>
                      <a href="<%=viewProfileURL%>" id="navbar3" class="border-blue-600 pb-1 hover:border-b-4">User Profile</a>
                    </li>
                </ul>
        </div>
        <a href="<%=loginLogoutURL%>" class="mr-16 hidden h-10 rounded-xl bg-yellow-400 px-6 py-1 text-2xl font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 lg:inline-block"><%=loginLogoutButton%></a>
      </div>
    </nav>
    
    <!-- Navbar Drawer -->
    <div id="drawer-navbar" class="fixed right-0 top-0 z-40 h-screen w-80 translate-x-full divide-y-2 divide-zinc-800 overflow-y-auto bg-slate-200 text-zinc-800 transition-transform" tabindex="-1" aria-labelledby="drawer-navbar">
      <button type="button" class="h-[104px] w-full" data-drawer-hide="drawer-navbar" aria-controls="drawer-navbar">
        <div class="flex h-full cursor-pointer items-center justify-end pr-10 hover:bg-blue-400">
          <svg class="feather feather-x h-12 w-12" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </div>
      </button>
      <div class="h-[60px]">
        <a href="<%=jobFeedURL%>" class="text-lg">
          <div id="navbarMobile1" class="flex h-full cursor-pointer items-center justify-between pl-10 pr-10 font-semibold hover:bg-blue-400">
            <div class="">Job Feed</div>
            <svg class="feather feather-chevron-right h-12 w-12" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
          </div>
        </a>
      </div>
      <div class="h-[60px]">
        <a href="<%=appliedJobsURL%>" class="text-lg">
          <div id="navbarMobile2" class="flex h-full cursor-pointer items-center justify-between pl-10 pr-10 font-semibold hover:bg-blue-400">
            <div class="">Applied Jobs</div>
            <svg class="feather feather-chevron-right h-12 w-12" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
          </div>
        </a>
      </div>
      <div class="h-[60px]">
        <a href="<%=viewProfileURL%>" class="text-lg">
          <div id="navbarMobile3" class="flex h-full cursor-pointer items-center justify-between pl-10 pr-10 font-semibold hover:bg-blue-400">
            <div class="">User Profile</div>
            <svg class="feather feather-chevron-right h-12 w-12" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
          </div>
        </a>
      </div>
      <div class="h-[60px]">
        <a href="<%=loginLogoutURL%>" class="text-lg">
          <div class="flex h-full cursor-pointer items-center justify-between border-b-2 border-zinc-800 pl-10 pr-10 font-semibold hover:bg-yellow-400">
            <div class=""><%=loginLogoutButton%></div>
            <svg class="feather feather-chevron-right h-12 w-12" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
          </div>
        </a>
      </div>
    </div>