<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%
    session = request.getSession();
    Integer id = (Integer)session.getAttribute("logged-id");
    String errMessage = (String)session.getAttribute("error-message");
%>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Links -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.css" rel="stylesheet" />

    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="./public/assets/favicon/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="./public/assets/favicon/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="./public/assets/favicon/favicon-16x16.png" />
    <link rel="manifest" href="./public/assets/favicon/site.webmanifest" />
    <link rel="mask-icon" href="./public/assets/favicon/safari-pinned-tab.svg" color="#facc15" />
    <meta name="msapplication-TileColor" content="#e2e8f0" />
    <meta name="theme-color" content="#ffffff" />

    <title>JOLT - My Applications</title>
  </head>
  <!-- Body -->
  <body class="bg-slate-200 font-display">
    <!-- Navbar -->
    <%@include file="./components/navbar-user.jsp"%>

    <!-- Content -->
    <div class="container mx-auto">
      <div class="mx-auto mt-5 w-4/5 text-zinc-800 md:w-3/5">
        <!-- Header -->
        <div class="text-center text-3xl font-bold md:text-left md:text-5xl">Your Applications</div>
        <div class="mt-3 text-center text-xl font-light md:text-left md:text-3xl">Be ahead and keep track of your progress here</div>

        <!-- Categories -->
        <form action="LoadAppliedJobs">
          <div class="mt-6 flex flex-wrap justify-around gap-x-5 gap-y-5 overscroll-x-auto text-xl md:mt-10 md:justify-around md:text-2xl">
            <a id="applied" class="border-b-4 border-neutral-600 pb-1 hover:border-yellow-400" href="LoadAppliedJobs">Applied</a>
            <button id="pending" class="border-b-4 border-neutral-600 pb-1 hover:border-yellow-400" name="status" value="0">Pending</button>
            <button id="accepted" class="border-b-4 border-neutral-600 pb-1 hover:border-yellow-400" name="status" value="1">Accepted</button>
            <button id="rejected" class="border-b-4 border-neutral-600 pb-1 hover:border-yellow-400" name="status" value="2">Rejected</button>
          </div>
        </form>

        <!-- Applications Cards -->
        <div class="relative mt-8 text-zinc-800">
          <!-- Card (Pending) -->
          <%ResultSet applications = (ResultSet)request.getAttribute("applications");
            while (applications.next()) {
            int appID = applications.getInt("APP_ID");%>
            <form id="deleteForm<%=appID%>" method="get" action="DeleteJobApplication">
            <input type="hidden" name="app-id" value="<%=appID%>"/>
            <div class="overflow-x-auto border-t-2 border-zinc-800 py-2 md:py-4">
              <div class="item-center flex justify-between gap-8">
                <div class="flex items-center">
                  <button type="button" data-modal-target="jobModal" data-modal-toggle="jobModal">
                    <div class="overflow-x-auto text-left text-lg font-bold md:text-2xl"><%=applications.getString("JOB_TITLE")%></div>
                  </button>
                    <%if(applications.getInt("APP_STATUS") == 0){%>
                        <div class="ml-5 rounded-3xl bg-orange-400 px-2 py-1 text-center text-sm font-semibold md:ml-10 md:px-3 md:text-lg"><%=applications.getString("STATUS_NAME")%></div>
                    <%}else if(applications.getInt("APP_STATUS") == 1){%> 
                        <div class="ml-5 rounded-3xl bg-lime-400 px-2 py-1 text-center text-sm font-semibold md:ml-10 md:px-3 md:text-lg"><%=applications.getString("STATUS_NAME")%></div>
                    <%}else{%>
                        <div class="ml-5 rounded-3xl bg-rose-400 px-2 py-1 text-center text-sm font-semibold md:ml-10 md:px-3 md:text-lg"><%=applications.getString("STATUS_NAME")%></div>
                    <%}%>
                </div>
                <button class="mr-1 rounded-2xl bg-yellow-400 px-2 py-1 text-sm font-semibold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 md:text-lg lg:px-5" data-modal-target="withdrawModal<%=appID%>" data-modal-toggle="withdrawModal<%=appID%>" type="button">Withdraw Application</button>
              </div>
              <div class="text-extralight mt-1 text-base md:text-xl"><%=applications.getString("EMP_NAME")%></div>
              <div class="text-extralight mt-1 text-base md:text-xl"><%=applications.getString("JOB_LOCATION")%></div>
              <div class="mt-2 flex gap-1 text-center text-[9px] text-stone-100 md:text-sm">
                <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-1 py-1 md:px-2">₱ <%=applications.getString("JOB_SALARY_MAX")%> / month</div>
                <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-1 py-1 md:px-2"><%=applications.getString("TYPE_NAME")%></div>
                <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-1 py-1 md:px-2"><%=applications.getString("LEVEL_NAME")%></div>
              </div>
              <div class="text-thin mt-3 text-xs md:text-base">Applied two weeks ago</div>
            </div>
        </form>
              
        <!-- Withdraw Modal -->
        <div id="withdrawModal<%=appID%>" tabindex="-1" aria-hidden="true" class="fixed left-0 right-0 top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full overflow-y-auto overflow-x-hidden p-4 md:inset-0">
          <div class="relative max-h-full w-full max-w-lg">
            <!-- Modal content -->
            <div class="relative rounded-2xl bg-slate-300 shadow">
              <!-- Modal header -->
              <div class="flex items-start justify-between rounded-t border-b border-neutral-600 p-4">
                <h3 class="flex-1 text-lg font-semibold text-zinc-800 md:text-2xl">Confirm Job Application Withdrawal</h3>
                <button type="button" class="ml-auto inline-flex items-center rounded-lg bg-transparent p-1.5 text-sm text-zinc-800 hover:bg-slate-600 hover:text-stone-100" data-modal-hide="withdrawModal<%=appID%>">
                  <svg aria-hidden="true" class="h-7 w-7" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                  <span class="sr-only">Close modal</span>
                </button>
              </div>
              <!-- Modal body -->
              <div class="space-y-2 p-4">
                <p class="text-sm leading-relaxed text-slate-800 md:text-base">Are you sure you want to withdraw your job application? This action cannot be undone.</p>
              </div>
              <!-- Modal footer -->
              <div class="flex items-center space-x-2 rounded-b border-t border-gray-200 p-4 dark:border-gray-600">
                <button data-modal-hide="withdrawModal<%=appID%>" name="app-id" form="deleteForm<%=appID%>" value="<%=appID%>" type="submit" class="rounded-2xl bg-yellow-400 px-5 py-2 text-center text-sm font-semibold text-zinc-800 hover:bg-yellow-500 focus:outline-none focus:ring-4 focus:ring-blue-400 md:text-base">Confirm Submit</button>
                <button data-modal-hide="withdrawModal<%=appID%>" type="button" class="rounded-2xl border border-neutral-600 bg-neutral-600 px-5 py-2 text-sm text-stone-100 hover:bg-neutral-700 focus:z-10 focus:outline-none focus:ring-4 focus:ring-blue-400 md:text-base">Back</button>
              </div>
            </div>
          </div>
        </div>   
              
        <%}%>
         
        </div>
      </div>
    </div>

    <!-- Job Modal -->
    <div id="jobModal" tabindex="-1" aria-hidden="true" class="fixed left-0 right-0 top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full overflow-y-auto overflow-x-hidden p-4 md:inset-0">
      <div class="relative max-h-full w-full max-w-2xl">
        <!-- Modal content -->
        <div class="relative rounded-lg bg-slate-300 shadow">
          <!-- Modal body -->
          <div class="space-y-3 p-6">
            <div class="flex items-center justify-between">
              <div class="text-2xl font-bold md:text-4xl">Marketing Manager</div>
              <div class="flex flex-row">
                <button>
                  <svg class="feather feather-printer h-6 w-6 text-zinc-800 md:h-8 md:w-8" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="6 9 6 2 18 2 18 9"></polyline>
                    <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
                    <rect x="6" y="14" width="12" height="8"></rect>
                  </svg>
                </button>
                <button type="button" class="ml-3 inline-flex h-10 w-10 items-center rounded-lg bg-transparent p-1.5 text-sm text-zinc-800 hover:bg-slate-600 hover:text-stone-100" data-modal-hide="jobModal">
                  <svg aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                  <span class="sr-only">Close modal</span>
                </button>
              </div>
            </div>
            <div class="mt-0 text-sm font-light text-neutral-600 md:mt-1">
              <span class="font-semibold">24 Chicken</span>
              |
              <span class="font-semibold">Manila, Philippines</span>
              |
              <span class="font-">Sales</span>
              | Posted 2 days ago
            </div>
            <div class="mt-2 flex gap-1 border-b-2 border-neutral-600 pb-3 text-[10px] text-stone-100 md:text-sm">
              <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1">₱ 500,000 / month</div>
              <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1">Full Time</div>
              <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1">Senior</div>
            </div>
            <div class="mt-2 text-sm md:text-base">We are seeking an experienced Marketing Manager to lead our marketing efforts and drive growth for our business. The ideal candidate will have a proven track record of developing and executing successful marketing campaigns, as well as the ability to analyze data and identify opportunities for optimization.</div>

            <!-- Company Overview -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-xl font-bold md:text-3xl">Company Overview</div>
            <div class="mt-2 text-sm md:text-base">[Company Name] is a leading provider of [product/service] solutions for [target audience]. Our mission is to [company mission statement]. We pride ourselves on our commitment to innovation, excellence, and customer satisfaction.</div>

            <!-- Responsibilities -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-xl font-bold md:text-3xl">Responsibilities</div>
            <div class="mt-2 text-sm md:text-base">
              <ul class="ml-4 list-outside list-disc">
                <li>Develop and execute comprehensive marketing strategies to increase brand awareness and drive sales.</li>
                <li>Collaborate with internal teams to create compelling content and collateral for various channels.</li>
                <li>Manage and optimize digital marketing campaigns across multiple platforms, including social media, email, and search.</li>
                <li>Analyze marketing data and provide regular reports on campaign performance and ROI.</li>
                <li>Monitor industry trends and competitor activity to inform marketing strategy and identify new opportunities.</li>
              </ul>
            </div>

            <!-- Requirements -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-xl font-bold md:text-3xl">Requirements</div>
            <div class="mt-2 text-sm md:text-base">
              <ul class="ml-4 list-outside list-disc">
                <li>Bachelor's degree in Marketing or related field.</li>
                <li>5+ years of experience in marketing, with a focus on digital marketing.</li>
                <li>Demonstrated success in developing and executing marketing campaigns.</li>
                <li>Strong analytical skills and the ability to use data to inform decision-making.</li>
                <li>Excellent communication and collaboration skills.</li>
              </ul>
            </div>

            <!-- Benefits -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-xl font-bold md:text-3xl">Requirements</div>
            <div class="mt-2 text-sm md:text-base">
              <ul class="ml-4 list-outside list-disc">
                <li>Competitive salary and bonus opportunities.</li>
                <li>Comprehensive health, dental, and vision insurance.</li>
                <li>401(k) with employer match.</li>
                <li>Generous paid time off policy.</li>
                <li>Flexible work arrangements.</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
    <script src="./public/js/navbar.js" defer></script>
    <script src="./public/js/appliedCategories.js" defer></script>
    <script src="./public/js/appliedJobModal.js" defer></script>
  </body>
</html>
