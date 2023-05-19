<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession();
    Integer id = (Integer)session.getAttribute("logged-id");
    String errMessage = (String)session.getAttribute("error-message");
    Integer appCount = (Integer)request.getAttribute("applicant-count");
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
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.css"
      rel="stylesheet"
    />
    <title>Candidates</title>
  </head>

  <body class="bg-slate-200">
      
    <!-- Navbar  and  job/candidates section -->
    <%@include file="./components/navbar-employer.jsp"%>

    <!-- Applicant no. -->
    <section class="flex flex-col mx-auto p-4 -pb-12 items-center">
      <button
        type="button"
        class="focus:outline-none text-black bg-yellow-400 hover:bg-yellow-400 font-bold rounded-lg text-sm px-5 py-2.5 mr-2 dark:focus:ring-yellow-900"
      >
        Applicants (<%=appCount%>)
      </button>
    </section>

    <!-- Status section -->
    <section
      class="bg-slate-200 border-soid border-b border-black flex flex-wrap items-center justify-between mx-auto"
    >
      <div class="flex flex-row items-center md:pl-12 md:p-3">
        <ul
          class="relative font-medium pl-12 flex flex-row p-4 md:p-0 md:flex-row md:space-x-8 md:mt-0 md:border-0"
        >
          <li>
            <a
              href="LoadJobCandidates"
              class="hover:border-b-2 hover:border-sky-700 hover:border-sky-700 block hover:text-sky-700 py-1 pr-4 text-black md:bg-transparent md:text-black -md:pl-3 md:p-2 dark:text-black md:dark:black"
              aria-current="page"
              >Active</a
            >
          </li>
          <li>
            <a
              href="LoadJobCandidates?status=0"
              class="hover:border-b-2 hover:border-sky-700 block hover:text-sky-700 py-1 pr-4 text-black md:bg-transparent md:text-black md:p-2 dark:text-black md:dark:black"
              aria-current="page"
              >Pending Review</a
            >
          </li>
          <li>
            <a
              href="LoadJobCandidates?status=1"
              class="hover:border-b-2 hover:border-sky-700 block hover:text-sky-700 py-1 pr-4 text-black md:bg-transparent md:text-black -md:pl-3 md:p-2 dark:text-black md:dark:black"
              aria-current="page"
              >Accepted</a
            >
          </li>
          <li>
            <a
              href="LoadJobCandidates?status=2"
              class="hover:border-b-2 hover:border-sky-700 block hover:text-sky-700 py-1 pr-4 text-black md:bg-transparent md:text-black md:p-2 dark:text-black md:dark:black"
              aria-current="page"
              >Rejected</a
            >
          </li>
        </ul>
      </div>
    </section>

    <!-- Candidates list -->
    <section class="p-12">
      <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
        <table class="w-full text-sm text-left text-gray-500 dark:text-black">
          <thead
            class="text-xs text-black uppercase bg-gray-50 dark:bg-slate-300 dark:text-black"
          >
            <tr>
              <th scope="col" class="w-1/12 px-6 py-3">ID</th>
              <th scope="col" class="w-3/12 px-8 py-3">Name</th>
              <th scope="col" class="w-2/12 px-6 py-3">Status</th>
              <th scope="col" class="w-2/12 px-8 py-3">Job Title</th>
              <th scope="col" class="w-2/12 px-6 py-3">Recent Experience</th>
              <th scope="col" class="w-2/12 px-6 py-3 text-right">
                Interested?
              </th>
            </tr>
          </thead>
          <tbody>
            <%ResultSet applications = (ResultSet)request.getAttribute("applications");
            while (applications.next()) {
                int appID = applications.getInt("APP_ID");%>
            <tr
              class="bg-white dark:bg-slate-200 hover:bg-gray-50 dark:hover:bg-slate-300"
            >
              <td class="w-1/12 px-6 py-4"><%=applications.getInt("APP_ID")%></td>
              <th scope="row" class="w-3/12 px-3 py-4">
                <!-- Modal toggle -->
                <button
                    data-id="<%=appID%>" id="viewApplicantBtn"
                    data-modal-target="defaultModal"
                    data-modal-toggle="defaultModal"
                    class="block text-black hover:text-sky-700 focus:outline-none font-medium rounded-lg text-sm px-5 py-2.5 text-center"
                    type="button"
                >
                  <%=applications.getString("SEEKER_FNAME")+" "+applications.getString("SEEKER_LNAME")%>
                </button>

                <!-- Main modal -->
                
              </th>
              <td class="w-2/12 px-6 py-4"><%=applications.getString("STATUS_NAME")%></td>
              <td class="w-2/12 px-8 py-4"><%=applications.getString("JOB_TITLE")%></td>
              <td class="w-2/12 px-6 py-4"><%=applications.getString("SEEKER_EXP_TITLE")%></td>

              <!-- Dropdown menu -->
              <td class="w-2/12 py-3">
                <form id="changeStatus<%=appID%>" method="post" action="UpdateAppStatus" class="mr-2">
                    <input type="hidden" name="app-id" value="<%=appID%>">
                    <select
                      id="status"
                      class="bg-white text-black text-sm rounded-lg block w-full p-2.5 dark:bg-slate-300 dark:border-slate-200 dark:placeholder-slate-200 dark:text-black" 
                      name="app-status" onchange="document.getElementById('changeStatus<%=appID%>').submit()"
                    >   
                        <option value="-1" selected> Status</option>
                        <option value="0">Pending</option>
                        <option value="1">Accept</option>
                        <option value="2">Reject</option>
                    </select>
                </form>
              </td>
            </tr>
            <%}%>
          </tbody>
        </table>
          
                <!--main modal-->
                <div
                  id="defaultModal"
                  tabindex="-1"
                  aria-hidden="true"
                  class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full"
                >
                  <div class="relative w-full max-w-2xl max-h-full">
                    <!-- Modal content -->
                    <div
                      class="relative bg-slate-300 rounded-lg shadow dark:bg-slate-300"
                    >
                      <!-- Modal header -->
                      <div
                        class="flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600"
                      >
                        <div class="w-1/5">
                          <div class="">
                            <img
                              src="./public/assets/images/Jay 1.png"
                              class="scale-95 rounded-full"
                              alt=""
                            />
                          </div>
                        </div>
                        <div class="space-y-0 pl-10">
                          <h3
                            id ="name"
                            class="text-xl font-bold text-black dark:text-black"
                          >
                          </h3>
                          <h4
                            id="title"
                            class="text-xl font-semibold text-black dark:text-black"
                          >
                          </h4>

                          <!-- group icons -->
                          <div
                            class="relative top-4 rounded-md shadow-sm"
                            role="group"
                          >
                            <button
                              type="button"
                               class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-slate-200 border border-gray-200 rounded-l-lg hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-slate-200 dark:border-gray-600 dark:text-white dark:hover:text-white dark:hover:bg-slate-300 dark:focus:ring-blue-500 dark:focus:text-white"
                            >
                              <img src="./public/assets/images/linkedin.svg" alt="" />
                            </button>
                            <button
                              type="button"
                              class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-slate-200 border-t border-b border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-slate-200 dark:border-gray-600 dark:text-white dark:hover:text-white dark:hover:bg-slate-300 dark:focus:ring-blue-500 dark:focus:text-white"
                            >
                              <img src="./public/assets/images/github.svg" alt="" />
                            </button>
                            <button
                              type="button"
                              class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-white border-t border-b border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-gray-700 dark:border-gray-600 dark:text-white dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-blue-500 dark:focus:text-white"

                            >
                              <img src="./public/assets/images/link.svg" alt="" />
                            </button>
                            <button
                              type="button"
                              class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-slate-200 border-t border-b border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-slate-200 dark:border-gray-600 dark:text-white dark:hover:text-white dark:hover:bg-slate-300 dark:focus:ring-blue-500 dark:focus:text-white"
                            >
                              <img src="./public/assets/images/twitter.svg" alt="" />
                            </button>

                            <button
                              type="button"
                              class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-slate-200 border border-gray-200 rounded-r-md hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-2 focus:ring-blue-700 focus:text-blue-700 dark:bg-slate-200 dark:border-gray-600 dark:text-white dark:hover:text-white dark:hover:bg-slate-300 dark:focus:ring-blue-500 dark:focus:text-white"
                            >
                              <img src="./public/assets/images/facebook.svg" alt="" />
                            </button>
                          </div>
                        </div>

                        <button
                          type="button"
                          class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                          data-modal-hide="defaultModal"
                        >
                          <svg
                            aria-hidden="true"
                            class="w-5 h-5"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path
                              fill-rule="evenodd"
                              d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                              clip-rule="evenodd"
                            ></path>
                          </svg>
                          <span class="sr-only">Close modal</span>
                        </button>
                      </div>

                      <!-- Modal body -->
                      <!-- About me -->
                      <div class="p-6 space-y-3">
                        <h2
                            class="border-b-4 border-black text-2xl leading-relaxed text-black dark:text-black"
                        >
                          About Me
                        </h2>
                        <p id="about" class="text-sm text-black dark:text-black">
                          Lorem ipsum dolor sit amet consectetur adipisicing
                          elit. Quas debitis ad rerum laboriosam qui provident a
                          placeat minus, eos nobis facilis ut unde voluptatum
                          ratione earum impedit, ipsa, incidunt nam.
                        </p>
                        <!-- Education -->
                        <h2
                          class="border-b-4 border-black text-2xl leading-relaxed text-black dark:text-black"
                        >
                          Education
                        </h2>
                        <h3 id="course" class="text-base text-black dark:text-black">
                          BS Computer Science
                        </h3>
                        <p id="school" class="text-sm text-black dark:text-black">
                            University of Santo Tomas </p>
                        <p id="educ_date" class="text-sm text-black dark:text-black">
                          2021 - 2025
                        </p>
                        <!-- Experience -->
                        <h2
                          class="border-b-4 border-black text-2xl leading-relaxed text-black dark:text-black"
                        >
                          Experience
                        </h2>
                        <p id="job_title" class="text-sm text-black dark:text-black">
                            job title </p>
                        <p id="company" class="text-sm text-black dark:text-black">
                            24 Chicken Enterprises </p>
                        <p id="job_date" class="text-sm text-black dark:text-black">
                          2022 - Present
                        </p>

                        <!-- Skills -->
                        <h2
                          class="border-b-4 border-black text-2xl leading-relaxed text-black dark:text-black"
                        >
                          Skills
                        </h2>
                        <ul id="skills"
                          class="list-disc list-inside text-sm text-black dark:text-black"
                        >
                          <li>Strong problem-solving and analytical skills</li>
                          <li>
                            Excellent communication and collaboration skills
                          </li>
                          <li>Experience working in Agile environments</li>
                        </ul>
                      </div>

                      <!-- Modal footer -->
                      <div
                         class="justify-around flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b dark:border-gray-600"
                      >
                        <h2
                          class="border-b-4 border-black text-2xl leading-relaxed text-black dark:text-black"
                        >
                          Contact Details
                        </h2>
                        <p class="text-sm text-black dark:text-black">
                          Number
                          <br />
                          Email
                          <br />
                          Location
                          <br />
                          Zoom
                        </p>
                        <p
                            id ="contact-details"
                          class="text-right text-sm text-blue-600 dark:text-blue-600"
                        >
                          09123456789
                          <br />
                          email@email.com
                          <br />
                          Manila, Philippines
                          <br />
                          zoom_id
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
      </div>
    </section>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
    <script src="./public/js/candidateModal.js"></script>
  </body>
</html>
