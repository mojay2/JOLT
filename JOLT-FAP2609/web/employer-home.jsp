<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession();
%>

<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.css" rel="stylesheet" />
  <title>Job Ads</title>
</head>

<body class="bg-slate-200">
  <!-- Navbar -->
    <%@include file="./components/navbar-employer.jsp"%>
    
  <!-- heading -->
  <section class="py-3 sm:py-5">
      <div class="justify-around px-4 my-5 mx-auto max-w-screen-max lg:px-12">
        <div
          class="relative overflow-hidden bg-white shadow-md dark:bg-slate-300 sm:rounded-lg"
        >
          <div
            class="ustify-around flex items-center p-6 space-x-2 rounded-b dark:border-gray-600"
          >
            <div class="flex items-center flex-1 space-x-4">
              <h5>
                <span class="text-black font-bold">Job Ads</span>
              </h5>
            </div>
            <div
              class="flex flex-col flex-shrink-0 space-y-3 md:flex-row md:items-center lg:justify-end md:space-y-0 md:space-x-3"
            >
              <a
                href="create-job-listing.jsp"
                class="flex items-center justify-center  px-4 py-2 text-sm font-medium text-black rounded-lg bg-yellow-400 hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 dark:bg-primary-600 dark:hover:bg-primary-700 focus:outline-none dark:focus:ring-primary-800"
              >
                <svg
                  class="h-3.5 w-3.5 mr-2"
                  fill="currentColor"
                  viewbox="0 0 20 20"
                  xmlns="http://www.w3.org/2000/svg"
                  aria-hidden="true"
                >
                  <path
                    clip-rule="evenodd"
                    fill-rule="evenodd"
                    d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z"
                  />
                </svg>
                Create Job Ad
              </a>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Job Ads -->
    <div class="justify-around px-4 my-5 mx-auto max-w-screen-max lg:px-12">
        <%ArrayList<HashMap> jobs = (ArrayList)request.getAttribute("jobs");%>
            <%for(int i = 0; i < jobs.size(); i++){
                HashMap<String,String> job = jobs.get(i);%>
      <div class="relative overflow-hidden bg-white shadow-md my-3 dark:bg-slate-300 sm:rounded-lg">
        
            <div
              class="justify-around flex items-center p-6 space-x-2 rounded-b dark:border-gray-600">
              <h2 class="flex flex-col font-bold w-1/2 text-2xl leading-relaxed text-black dark:text-black">
                <%=job.get("job-title")%>
                <span class="font-normal mb-1 text-sm">Posted on 18 Mar 2023 </span>
                <span class="text-sm text-sky-700 flex flex-row space-x-5">
                <form id="delete<%=job.get("job-id")%>" method = "post" action="DeleteJobListing">
                    <input type="hidden" name="job-id" value ="<%=job.get("job-id")%>"/>
                    <a href="LoadJobCandidates?job-id=<%=job.get("job-id")%>" class="hover:text-gray-50">View</a>
                    <button type="submit" class="hover:text-gray-50">Delete</button>
                </form>
                </span>
              </h2>
              <p class="flex justify-around w-1/2 text-center text-4xl text-black dark:text-black">
                <span class="flex flex-col"><%=job.get("accepted-count")%>
                  <span class="text-sm">Accepted</span>
                </span>
                <span class="flex flex-col"><%=job.get("rejected-count")%>
                  <span class="text-sm">Rejected</span>
                </span>
                <span class="flex flex-col"><%=job.get("pending-count")%>
                    <span class="text-sm">Pending</span>
                </span>
              </p>
            </div>
        
      </div>
        <%}%>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
</body>

</html>

