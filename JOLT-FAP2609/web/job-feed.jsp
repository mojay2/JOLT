<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer id = (Integer)session.getAttribute("logged-id");
    String search = "";
    if(request.getAttribute("query") != null) search = request.getAttribute("search").toString();
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
    <link rel="manifest" href="/public/assets/favicon/site.webmanifest" />
    <link rel="mask-icon" href="/public/assets/favicon/safari-pinned-tab.svg" color="#facc15" />
    <meta name="msapplication-TileColor" content="#e2e8f0" />
    <meta name="theme-color" content="#ffffff" />
    <title>JOLT - Job Feed</title>
  </head>
  <!-- Body -->
  <body class="bg-slate-200 font-display">
    
    <!-- Navbar -->
    <%@include file="./components/navbar-user.jsp"%>

    <!-- Content -->
    <div class="container mx-auto">
      <div class="bl mx-auto my-10 w-4/5 lg:w-3/5" id="container">
        <!-- Search -->
        <form action = "SearchJobFeed" method="get">
          <div class="mx-auto flex w-full flex-col items-center justify-around gap-y-4 divide-y-2 divide-zinc-800 rounded-2xl border-[3px] border-zinc-800 p-3 text-zinc-800 md:flex-row md:divide-x-2 md:divide-y-0">
            <div class="mx-auto flex w-full flex-1 items-center gap-2">
              <svg class="feather feather-search h-5 w-5 md:h-6 md:w-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="11" cy="11" r="8"></circle>
                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
              </svg>
              <label class="w-fit text-xs lg:text-base">What are you looking for?</label>
              <input class="w-28 flex-1 appearance-none border-0 border-b-2 border-neutral-600 bg-slate-200 px-0 text-xs text-zinc-800 placeholder:text-center placeholder:font-light focus:border-neutral-600 focus:ring-0 md:px-2 md:text-base min-[1284px]:w-44" id="search" name="search" type="text" placeholder="job title, keywords, or company" />
            </div>
            <div class="flex w-fit items-center gap-2 pt-4 min-[340px]:w-full md:w-fit md:px-4 md:pt-0">
              <svg class="feather feather-users h-4 w-4 md:h-6 md:w-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                <circle cx="9" cy="7" r="4"></circle>
                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
              </svg>
              <select class="w-full appearance-none border-0 bg-slate-200 text-center text-xs text-zinc-800 focus:outline-0 focus:ring-0 lg:text-base" id="specialization" name="industry">
                <option value="-1" selected>Have a specialization in mind?</option>
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

        <!-- Cards Container -->
        <div class="relative mt-8 flex flex-col gap-5 lg:flex-row">
          <div class="">
            <!-- Job Cards -->
            <div class="flex flex-none basis-auto flex-col gap-3">
              <!-- Start Card Template -->
              <%ResultSet jobs = (ResultSet)request.getAttribute("jobs");
                int counter = 0;
                int firstJobID = 0;
                while (jobs.next()) {
                    counter++;
                    if(counter == 1){
                        firstJobID = jobs.getInt("JOB_ID");
                    }%>
                    <button data-id="<%=jobs.getInt("JOB_ID")%>" id="jobFeedBtn" class="jobCard inline-block overflow-hidden rounded-2xl border-[3px] border-zinc-800 p-4 text-left text-zinc-800" name="post" value="1">
                        <div class="text-lg font-bold md:text-2xl"><%=jobs.getString("JOB_TITLE")%></div>
                        <div class="text-base md:text-xl"><%=jobs.getString("EMP_NAME")%></div>
                        <div class="text-base md:text-xl"><%=jobs.getString("JOB_LOCATION")%></div>
                        <div class="mt-2 flex gap-1 text-[10px] text-stone-100 md:text-xs">
                          <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-1 py-1 md:px-2">₱ <%=jobs.getString("JOB_SALARY_MAX")%> / month</div>
                          <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-1 py-1 md:px-2"><%=jobs.getString("TYPE_NAME")%></div>
                          <div class="rounded-full border-2 border-neutral-600 bg-blue-600 px-1 py-1 md:px-2"><%=jobs.getString("LEVEL_NAME")%></div>
                        </div>
                        <div class="mt-2 line-clamp-4 text-xs font-light md:text-sm"><%=jobs.getString("JOB_DESC")%></div>
                    </button>
                <%}%>
              <!-- End Card Template -->
            </div>
          </div>
          
          <!-- Job Single Post Card - Change "lg:inline" to "lg:hidden"  -->
          <!--post loader div-->
          <div id="job-loader" data-id="<%=firstJobID%>" class="sticky top-0 hidden h-screen flex-1 basis-auto overflow-auto rounded-2xl border-[3px] border-zinc-800 p-4 text-zinc-800 lg:hidden">
            <!-- Job Description -->
            <div class="flex items-center justify-between">
              <div id="job-title" class="text-4xl font-bold">Title</div>
              <button>
                <svg class="feather feather-printer h-8 w-8 text-zinc-800" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <polyline points="6 9 6 2 18 2 18 9"></polyline>
                  <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
                  <rect x="6" y="14" width="12" height="8"></rect>
                </svg>
              </button>
            </div>
            <div class="mt-2 text-sm font-light text-neutral-600">
              <span id="emp-name" class="font-semibold">24 Chicken</span>
              |
              <span id="job-location" class="font-semibold">Manila, Philippines</span>
              |
              <span id="job-industry" class="font-semibold">Sales</span>
              | Posted 2 days ago
            </div>
            <div class="mt-2 flex gap-1 border-b-2 border-neutral-600 pb-3 text-sm text-stone-100">
              <div id="job-salary" class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1"></div>
              <div id="job-type" class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1"></div>
              <div id="job-level" class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1"></div>
            </div>
            <div id="job-desc" class="mt-2 text-base">job desc</div>

            <!-- Company Overview -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-3xl font-bold">Company Overview</div>
            <div id="emp-overview" class="mt-2 text-base"></div>

            <!-- Responsibilities -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-3xl font-bold">Responsibilities</div>
            <div class="mt-2 text-base">
              <ul class="ml-4 list-outside list-disc">
                  <p id="job-resp"></p>
              </ul>
            </div>

            <!-- Requirements -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-3xl font-bold">Requirements</div>
            <div class="mt-2 text-base">
              <ul class="ml-4 list-outside list-disc">
                  <p id="job-reqs"></p>
              </ul>
            </div>

            <!-- Benefits -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-3xl font-bold">Job Benefits</div>
            <div class="mt-2 text-base">
              <ul class="ml-4 list-outside list-disc">
                  <p id="job-benefits"></p>
              </ul>
            </div>
            
            <!--apply for job--> 
            <form action = "CreateJobApp" class="form-control" method="post">
                <input id="hidden-job-id" type="hidden" name="job-id" value=""/>
                <input id="hidden-emp-id" type="hidden" name="emp-id" value=""/>
                <button id="apply-now" class="hidden mt-5 inline-block h-9 w-full rounded-3xl bg-yellow-400 text-center text-lg font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 disabled:bg-neutral-500 disabled:font-light disabled:text-slate-100 disabled:hover:bg-neutral-600" type="submit">Apply Now</button>
                <!-- Disabled (You have already applied) -->
                <button id="already-applied" class="hidden mt-5 inline-block h-9 w-full rounded-3xl bg-yellow-400 text-center text-lg font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 disabled:bg-neutral-500 disabled:text-slate-100 disabled:font-normal disabled:hover:bg-neutral-600" value="1" name="id" type="submit" disabled>You have already applied</button>    
            </form>
          </div>

          <!-- Job Single Post Card - Skeleton - Change "lg:hidden" to "lg:inline" -->
          <div role="status" id="skeleton" class="sticky top-0 hidden h-screen flex-1 basis-auto animate-pulse overflow-auto rounded-2xl border-[3px] border-zinc-800 p-4 text-zinc-800 lg:inline">
            <!-- Job Description -->
            <div class="mb-3 h-8 w-48 rounded-full bg-slate-300"></div>
            <div class="h-5 w-72 rounded-full bg-slate-300"></div>
            <div class="mt-2 flex gap-1 border-b-2 border-neutral-600 pb-3 text-sm text-stone-100">
              <div class="h-5 w-32 rounded-full bg-slate-300"></div>
              <div class="h-5 w-32 rounded-full bg-slate-300"></div>
              <div class="h-5 w-32 rounded-full bg-slate-300"></div>
            </div>

            <div class="mt-2 h-3 w-[calc(100%-10px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-34px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-13px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-12px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-20px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-30px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-12px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-40px)] rounded-full bg-slate-300"></div>
            <div class="invisible mt-2 text-base">We are seeking an experienced Marketing Manager to lead our marketing efforts and drive growth for our business. The ideal candidate will have a proven track record of developing and executing successful marketing campaigns, as well as the ability to analyze data and identify opportunities for optimization.</div>

            <div class="-mt-44 -mt-52 border-b-2 border-neutral-600 pb-3 min-[1280px]:-mt-28">
              <div class="h-8 w-72 rounded-full bg-slate-300"></div>
            </div>
            <div class="mt-2 h-3 w-[calc(100%-10px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-34px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-13px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-12px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-20px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-30px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-12px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-40px)] rounded-full bg-slate-300"></div>
            <div class="invisible mt-2 text-base">We are seeking an experienced Marketing Manager to lead our marketing efforts and drive growth for our business. The ideal candidate will have a proven track record of developing and executing successful marketing campaigns, as well as the ability to analyze data and identify opportunities for optimization.</div>

            <div class="-mt-44 border-b-2 border-neutral-600 pb-3 min-[1280px]:-mt-28">
              <div class="h-8 w-72 rounded-full bg-slate-300"></div>
            </div>
            <div class="mt-2 h-3 w-[calc(100%-10px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-34px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-13px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-12px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-20px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-30px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-12px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-40px)] rounded-full bg-slate-300"></div>

            <div class="mt-4 border-b-2 border-neutral-600 pb-3">
              <div class="h-8 w-72 rounded-full bg-slate-300"></div>
            </div>
            <div class="mt-2 h-3 w-[calc(100%-10px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-34px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-13px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-12px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-20px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-30px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-12px)] rounded-full bg-slate-300"></div>
            <div class="mt-2 h-3 w-[calc(100%-40px)] rounded-full bg-slate-300"></div>
          </div>
                    
        <!-- Invalid Search - Change "hidden" to "flex" -->
        <div id="empty-search" class="hidden h-full flex-col items-center justify-center p-4 text-zinc-800">
            <img src="./public/assets/images/error.png" alt="error image" class="h-auto w-[300px] border-b-4 border-zinc-800 px-4 pb-6 lg:w-[500px]" />
            <h1 class="md: mt-6 text-xl font-bold lg:text-4xl">No Results Found</h1>
            <p class="font-lg mt-6 w-5/6 text-center text-base lg:w-full lg:text-2xl">We're sorry, but we couldn't find any results for your search. Perhaps you could try using different keywords or filters to refine your search.</p>
        </div>
          
        </div>
      </div>
    </div>

    <!-- Job Modal -->
    <div id="jobFeedModal" tabindex="-1" aria-hidden="true" class="fixed top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full justify-center overflow-y-auto overflow-x-hidden p-4 md:inset-0">
      <div class="relative max-h-full w-full max-w-2xl">
        <!-- Modal content -->
        <div class="relative rounded-lg bg-slate-300 shadow">
          <!-- Modal body -->
          <div class="space-y-3 p-6">
            <div class="flex items-center justify-between">
              <div id="job-title-modal" class="text-2xl font-bold md:text-4xl"></div>
              <div class="flex flex-row">
                <button>
                  <svg class="feather feather-printer h-6 w-6 text-zinc-800 md:h-8 md:w-8" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="6 9 6 2 18 2 18 9"></polyline>
                    <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
                    <rect x="6" y="14" width="12" height="8"></rect>
                  </svg>
                </button>
                <button id="jobFeedClose" type="button" class="ml-3 inline-flex h-10 w-10 items-center rounded-lg bg-transparent p-1.5 text-sm text-zinc-800 hover:bg-slate-600 hover:text-stone-100">
                  <svg aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                  <span class="sr-only">Close modal</span>
                </button>
              </div>
            </div>
            <div class="mt-0 text-sm font-light text-neutral-600 md:mt-1">
              <span id="emp-name-modal" class="font-semibold"></span>
              |
              <span id="job-location-modal" class="font-semibold"></span>
              |
              <span id="job-industry-modal" class="font-semibold">Sales</span>
              | Posted 2 days ago
            </div>
            <div class="mt-2 flex gap-1 border-b-2 border-neutral-600 pb-3 text-[10px] text-stone-100 md:text-sm">
              <div id="job-salary-modal"  class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1"></div>
              <div id="job-type-modal" class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1"></div>
              <div id="job-level-modal" class="rounded-full border-2 border-neutral-600 bg-blue-600 px-2 py-1"></div>
            </div>
            <div id="job-desc-modal" class="mt-2 text-sm md:text-base"></div>

            <!-- Company Overview -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-xl font-bold md:text-3xl">Company Overview</div>
            <div id="emp-overview-modal" class="mt-2 text-sm md:text-base"></div>

            <!-- Responsibilities -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-xl font-bold md:text-3xl">Responsibilities</div>
            <div class="mt-2 text-sm md:text-base">
              <ul class="ml-4 list-outside list-disc">
                  <p id="job-resp-modal"></p>
              </ul>
            </div>

            <!-- Requirements -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-xl font-bold md:text-3xl">Requirements</div>
            <div class="mt-2 text-sm md:text-base">
              <ul class="ml-4 list-outside list-disc">
                <p id="job-reqs-modal"></p>
              </ul>
            </div>

            <!-- Benefits -->
            <div class="mt-4 border-b-2 border-neutral-600 pb-3 text-xl font-bold md:text-3xl">Requirements</div>
            <div class="mt-2 text-sm md:text-base">
              <ul class="ml-4 list-outside list-disc">
                <p id="job-benefits-modal"></p>
              </ul>
            </div>

            <form action = "CreateJobApp" class="form-control" method="post">
                <input id="hidden-job-id-modal" type="hidden" name="job-id" value=""/>
                <input id="hidden-emp-id-modal" type="hidden" name="emp-id" value=""/>
                <button id="apply-now-modal" class="hidden mt-5 inline-block h-9 w-full rounded-3xl bg-yellow-400 text-center text-lg font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 disabled:bg-neutral-500 disabled:font-light disabled:text-slate-100 disabled:hover:bg-neutral-600" type="submit">Apply Now</button>
                <!-- Disabled (You have already applied) -->
                <button id="already-applied-modal" class="hidden mt-5 inline-block h-9 w-full rounded-3xl bg-yellow-400 text-center text-lg font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 disabled:bg-neutral-500 disabled:text-slate-100 disabled:font-normal disabled:hover:bg-neutral-600" value="1" name="id" type="submit" disabled>You have already applied</button>    
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Scripts -->
    <script src="./public/js/jobFeedLoader.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
    <script src="./public/js/navbar.js" defer></script>
    <script src="./public/js/jobFeedModal.js" defer></script>

  </body>
</html>
