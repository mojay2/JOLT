<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <title>Create Job Ad</title>
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
                href="CreateJobAd.html"
                class="flex items-center justify-center px-4 py-2 text-sm font-medium text-black rounded-lg bg-yellow-400 hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 dark:bg-primary-600 dark:hover:bg-primary-700 focus:outline-none dark:focus:ring-primary-800"
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
    <!-- Form -->
    <form action="CreateJobServlet" method="post">
      <section
        class="flex flex-col-reverse md:flex-row space-y-4 md:space-y-0 md:space-x-4 px-4 mx-auto max-w-screen-max lg:px-12"
      >
        <div
          class="font-semibold p-3 w-full md:w-1/2 relative overflow-hidden bg-white shadow-md dark:bg-slate-300 sm:rounded-lg"
        >
            <!--job title-->
          What title best describes this job?
          <div class="space-x-4 flex flex-row">
            <input
                type="text"
              name="job-title"
              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2 dark:bg-slate-200 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black"
              required
            />
          </div>
          What type of job is it?
          <!-- Radio btns -->
          <ul class="font-normal p-1 flex flex-col w-full gap-1">
            <!-- Full-time -->
            <li>
              <input
                type="radio"
                id="Full-time"
                name="job-type"
                value="4"
                class="hidden peer"
                required
              />
              <label
                for="Full-time"
                class="inline-flex items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Full-time</div>
                </div>
              </label>
            </li>
            <!-- Part-time -->
            <li>
              <input
                type="radio"
                id="Part-time"
                name="job-type"
                value="3"
                class="hidden peer"
                required
              />
              <label
                for="Part-time"
                class="inline-flex items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Part-time</div>
                </div>
              </label>
            </li>
            <!-- Contract -->
            <li>
              <input
                type="radio"
                id="Contract"
                name="job-type"
                value="1"
                class="hidden peer"
                required
              />
              <label
                for="Contract"
                class="inline-flex items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Contract</div>
                </div>
              </label>
            </li>
            <!-- Internship -->
            <li>
              <input
                type="radio"
                id="Internship"
                name="job-type"
                value="2"
                class="hidden peer"
                required
              />
              <label
                for="Internship"
                class="inline-flex items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Internship</div>
                </div>
              </label>
            </li>
            <!-- Commission Only -->
            <li>
              <input
                type="radio"
                id="fresh-grad"
                name="job-type"
                value="0"
                class="hidden peer"
                required
              />
              <label
                for="fresh-grad"
                class="inline-flex items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Fresh-Grad</div>
                </div>
              </label>
            </li>
          </ul>

          What is the salary for this job?
          <div class="space-x-4 flex flex-row">
            <label
              for="sal1"
              class="block mb-2 text-2xl font-medium text-black dark:text-black"
              >₱</label
            >
            <input
              type="number"
              name="salary-min"
              id="sal1"
              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2 dark:bg-slate-200 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black"
              placeholder="0"
              required
            />
            <div class="font-normal text-2xl">to</div>

            <label
              for="sal1"
              class="block mb-2 text-2xl font-medium text-black dark:text-black"
              >₱</label
            >
            <input
              type="number"
              name ="salary-max"
              id="sal1"
              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2 dark:bg-slate-200 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black"
              placeholder="0"
              required
            />
            <select
              id="rate"
              class="bg-white text-black text-sm rounded-lg block w-full p-2.5 dark:bg-slate-300 dark:border-slate-200 dark:placeholder-slate-200 dark:text-black"
            >
              <option selected>per year</option>
              <option value="accept">per month</option>
              <option value="reject">per week</option>
            </select>
          </div>
          
          <!--select job industry-->
          What industry does this job fall in?
          <div class="space-x-4 flex flex-row">
            <select
                name ="job-industry"
              id="industry"
              class="bg-white text-black text-sm rounded-lg block w-full p-2.5 dark:bg-slate-200 dark:border-slate-200 dark:placeholder-slate-200 dark:text-black"
            >
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
          <!--  -->
          Level of Employment?
          <!-- Radio btns -->
          <ul class="font-normal p-1 flex flex-col w-full gap-1">
            <!-- Entry-level -->
            <li>
              <input
                type="radio"
                id="Entry-level"
                name="job-level"
                value="0"
                class="hidden peer"
                required
              />
              <label
                for="Entry-level"
                class="inline-flex items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Entry-level</div>
                </div>
              </label>
            </li>
            <!-- Intermediate -->
            <li>
              <input
                type="radio"
                id="Intermediate"
                name="job-level"
                value="1"
                class="hidden peer"
                required
              />
              <label
                for="Intermediate"
                class="inline-flex items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Intermediate</div>
                </div>
              </label>
            </li>
            <!-- Mid-level -->
            <li>
              <input
                type="radio"
                id="Mid-level"
                name="job-level"
                value="2"
                class="hidden peer"
                required
              />
              <label
                for="Mid-level"
                class="inline-flex items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Mid-level</div>
                </div>
              </label>
            </li>
            <!-- Senior -->
            <li>
              <input
                type="radio"
                id="Senior"
                name="job-level"
                value="3"
                class="hidden peer"
                required
              />
              <label
                for="Senior"
                class="block items-center justify-between w-full p-2 text-black bg-white border border-gray-200 rounded-lg cursor-pointer dark:peer-checked:text-slate-200 peer-checked:text-slate-200 dark:hover:text-gray-300 dark:peer-checked:bg-gray-700 peer-checked:bg-gray-700 dark:text-black dark:bg-slate-200 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full">Senior</div>
                </div>
              </label>
            </li>
          </ul>
          <div>
            <!-- submit -->
            <button
              type="submit"
              class="flex items-center justify-center w-full py-2 mt-5 text-sm font-medium text-black rounded-lg bg-yellow-400 hover:bg-primary-800 focus:ring-4 focus:ring-primary-300 dark:bg-primary-600 dark:hover:bg-primary-700 focus:outline-none dark:focus:ring-primary-800"
              >Create Job Ad<Button>
          </div>
        </div>

        <div
          class="font-semibold p-3 w-full md:w-1/2 relative overflow-hidden bg-white shadow-md dark:bg-slate-300 sm:rounded-lg"
        >
          What best describes this job location?
          <textarea
            id="roleLocation"
            name="job-location"
            rows="4"
            required
            class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 dark:bg-slate-200 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black"
            placeholder="Write here..."
          ></textarea>
          Job Description
          <textarea
            id="JobDesc"
            name="job-desc"
            rows="4"
            required
            class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 dark:bg-slate-200 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black"
            placeholder="Write here..."
          ></textarea>
          Responsibilities
          <textarea
            id="Responsibilities"
            name="job-resp"
            rows="4"
            required
            class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 dark:bg-slate-200 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black"
            placeholder="Write here..."
          ></textarea>
          Requirements
          <textarea
            id="Requirements"
            name="job-reqs"
            rows="4"
            required
            class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 dark:bg-slate-200 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black"
            placeholder="Write here..."
          ></textarea>
          Benefits
          <textarea
            id="Benefits"
            name="job-benefit"
            rows="4"
            required
            class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 dark:bg-slate-200 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black"
            placeholder="Write here..."
          ></textarea>
        </div>
      </section>
    </form>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
  </body>
</html>

