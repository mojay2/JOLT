<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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

    <title>JOLT - User Profile</title>
  </head>
  <!-- Body -->
  <body class="bg-slate-200 font-display">
    <!-- Navbar -->
    <%@include file="./components/navbar-user.jsp"%>

    <!-- Content -->
    <form id="edit-credentials" method="post" action="EditCredentials">
    </form>
    <form id="edit-profile" method="post" action="EditProfile">
      <div class="container mx-auto">
        <div class="md:8/12 mx-auto my-10 w-9/12 text-zinc-800 lg:w-3/5">
          <!-- Header -->
          <div class="text-center text-3xl font-bold md:text-5xl">Your Profile</div>
          <div class="mt-3 text-center text-xl font-light md:text-3xl">Stay a while and showcase your whole journey</div>

          <!-- Container -->
          <%ResultSet user = (ResultSet) request.getAttribute("user");%>
          <%if (user.next()) {%>

          <div class="mt-10 flex flex-wrap justify-center gap-3 text-zinc-800 lg:justify-between">
            <!-- Profile Contact -->
            <div id="contact" class="flex-0 basis-[330px] self-start rounded-2xl border-2 border-zinc-800 px-4 py-6">
              <!-- Tool -->
              <div class="cursor-pointer hover:text-yellow-400" onclick="showEditModal()">
                <svg class="feather feather-edit ml-auto h-6 w-6 md:h-7 md:w-7" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit">
                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                </svg>
              </div>

              <!-- Image -->
              <svg class="mx-auto mt-[-20px]" xmlns="http://www.w3.org/2000/svg" width="106" height="106" viewBox="0 0 532 532" xmlns:xlink="http://www.w3.org/1999/xlink">
              <g>
              <g>
              <circle cx="270.759" cy="260.92941" r="86.34897" fill="#a0616a" />
              <polygon points="199.2879 366.61365 217.2879 320.61365 310.2879 306.61365 320.28003 408.44043 226.28003 410.44043 199.2879 366.61365" fill="#a0616a" />
              </g>
              <path
                d="M357.94449,276.8613c-1.12067,4.48965-3.38602,15.17972-6.9238,15.23233-2.89023,.04208-5.65668-46.33466-2.76953-54.00568,3.31638-8.81271-5.39886-19.96062-11.96411-25.6832-11.80423-10.2894-38.00696,11.80466-64.65118,1.79587-.70633-.26482-.56558-.23502-8.97934-3.59174-25.88966-10.32974-27.2506-10.62788-28.73386-10.77521-12.55046-1.24167-27.86705,9.02844-34.12146,21.55038-6.50168,13.01653-1.06937,24.18106-7.18346,55.67184-.71246,3.67065-1.83138,8.90216-3.59174,8.97934-3.21819,.14029-6.3605-17.04846-7.18346-21.55038-3.44792-18.86186-6.7722-37.04675,0-57.46771,.73878-2.22729,5.29158-10.49458,14.36693-26.93799,13.0744-23.68825,19.65018-35.57709,21.55038-37.7132,13.62859-15.32624,38.43575-29.30734,59.26357-23.34626,10.52704,3.01299,8.63953,7.85691,21.55038,12.57105,23.00821,8.40057,43.00476-1.87303,46.69254,5.3876,1.9537,3.84602-3.51236,7.01686-3.59174,14.36693-.13593,12.6114,15.81424,16.25575,25.14212,28.73386,5.01447,6.70819,13.59753,6.78012-8.87228,96.78212l.00003,.00003Z"
                fill="#2f2e41"
                />
              </g>
              <path
                d="M464.92017,442.61035c-3.48022,3.91016-7.09009,7.74023-10.83008,11.48047-50.23999,50.23926-117.04004,77.90918-188.09009,77.90918-61.40991,0-119.63989-20.66992-166.75-58.71973-.03003-.01953-.05005-.04004-.07983-.07031-6.25-5.03906-12.30005-10.39941-18.14014-16.05957,.10986-.87988,.22998-1.75,.35986-2.61035,.82007-5.7998,1.73022-11.33008,2.75-16.41992,8.3501-41.71973,118.22021-85.51953,121.08008-86.66016,.04004-.00977,.06006-.01953,.06006-.01953,0,0,14.14014,52.12012,74.72998,51.4502,41.27002-.4502,33.27002-51.4502,33.27002-51.4502,0,0,.5,.09961,1.43994,.2998,11.91992,2.53027,94.68018,20.70996,127.33008,45.52051,9.94995,7.55957,17.08984,23.66016,22.21997,42.85938,.21997,.82031,.42993,1.66016,.65015,2.49023Z"
                fill="#2563eb"
                />
              <path
                d="M454.09009,77.91016C403.8501,27.6709,337.05005,0,266,0S128.15015,27.6709,77.90991,77.91016C27.67017,128.15039,0,194.9502,0,266c0,64.85059,23.05005,126.16016,65.29004,174.57031,4.03003,4.62988,8.23999,9.13965,12.61987,13.52051,1.03003,1.0293,2.07007,2.05957,3.12012,3.05957,5.84009,5.66016,11.89014,11.02051,18.14014,16.05957,.02979,.03027,.0498,.05078,.07983,.07031,47.11012,38.0498,105.3401,58.71973,166.75001,58.71973,71.05005,0,137.8501-27.66992,188.09009-77.90918,3.73999-3.74023,7.34985-7.57031,10.83008-11.48047,43.36987-48.71973,67.07983-110.83984,67.07983-176.61035,0-71.0498-27.66992-137.84961-77.90991-188.08984Zm10.17993,362.20996c-7.86987,8.9502-16.33008,17.37012-25.33008,25.18066-17.06982,14.84961-36.06982,27.5293-56.55981,37.62988-7.19019,3.5498-14.56006,6.7793-22.1001,9.66992-29.29004,11.24023-61.08008,17.39941-94.28003,17.39941-32.04004,0-62.76001-5.73926-91.18994-16.23926-11.67017-4.30078-22.94995-9.41016-33.78003-15.26074-1.59009-.85938-3.16992-1.72949-4.73999-2.61914-8.26001-4.68066-16.25-9.79004-23.91992-15.31055-10.98999-7.87988-21.3501-16.58984-30.98022-26.03027-5.3999-5.29004-10.55981-10.7998-15.48975-16.5293C26.09009,391.77051,2,331.65039,2,266,2,120.43066,120.42993,2,266,2s264,118.43066,264,264c0,66.66016-24.82983,127.62012-65.72998,174.12012Z"
                fill="#3f3d56"
                />
              </svg>

              <!-- Name & Title -->
              <div class="mt-3 text-center text-xl font-bold md:text-3xl"><%=user.getString("SEEKER_FNAME") + " " + user.getString("SEEKER_LNAME")%></div>
              <div class="mt-1 text-center text-lg font-light md:text-2xl"><%=user.getString("SEEKER_TITLE")%></div>

              <!-- Links -->
              <div class="mt-4 flex items-center justify-around rounded-2xl border-2 border-zinc-800 px-4 py-2">
                <svg class="feather feather-linkedin h-4 w-4 cursor-pointer md:h-6 md:w-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path>
                <rect x="2" y="9" width="4" height="12"></rect>
                <circle cx="4" cy="4" r="2"></circle>
                </svg>
                <svg class="feather feather-github h-4 w-4 cursor-pointer md:h-6 md:w-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path>
                </svg>
                <svg class="feather feather-link h-4 w-4 cursor-pointer md:h-6 md:w-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path>
                <path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path>
                </svg>
                <svg class="feather feather-twitter h-4 w-4 cursor-pointer md:h-6 md:w-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></svg>
                <svg class="feather feather-facebook h-4 w-4 cursor-pointer md:h-6 md:w-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></svg>
              </div>

              <!-- Contact Details -->
              <div class="mx-4 mt-8 border-t-2 border-zinc-800">
                <div class="mt-5 text-center text-base font-semibold md:text-xl">Contact Details</div>
                <!-- Details Column -->
                <div class="mt-5 flex flex-col gap-5">
                  <div class="flex justify-between">
                    <div class="text-xs font-bold sm:text-sm md:text-base">Number</div>
                    <div class="text-xs text-blue-600 sm:text-sm md:text-base"><%=user.getString("SEEKER_NUMBER")%></div>
                  </div>
                  <div class="flex justify-between">
                    <div class="text-xs font-bold sm:text-sm md:text-base">Email</div>
                    <div class="text-xs text-blue-600 sm:text-sm md:text-base"><%=user.getString("USER_EMAIL")%></div>
                  </div>

                  <div class="flex justify-between">
                    <div class="text-xs font-bold sm:text-sm md:text-base">Location</div>
                    <div class="text-xs text-blue-600 sm:text-sm md:text-base"><%=user.getString("SEEKER_ADDRESS")%></div>
                  </div>

                  <div class="flex justify-between">
                    <div class="text-xs font-bold sm:text-sm md:text-base">Zoom</div>
                    <div class="text-xs text-blue-600 sm:text-sm md:text-base"><%=user.getString("SEEKER_ZOOMID")%></div>
                  </div>
                </div>
              </div>
            </div>

            <!-- ! Edit Profile Contact -->
            <div id="edit-contact" class="flex-0 hidden basis-[330px] self-start rounded-2xl border-2 border-zinc-800 bg-slate-300 px-4 py-6">
              <!-- Tool -->
              <div class="cursor-pointer hover:text-blue-400" onclick="showEditModal()">
                <svg class="feather feather-x ml-auto h-7 w-7 md:h-8 md:w-8" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
              </div>

              <!-- Image -->
              <svg class="mx-auto mt-[-20px]" xmlns="http://www.w3.org/2000/svg" width="106" height="106" viewBox="0 0 532 532" xmlns:xlink="http://www.w3.org/1999/xlink">
              <g>
              <g>
              <circle cx="270.759" cy="260.92941" r="86.34897" fill="#a0616a" />
              <polygon points="199.2879 366.61365 217.2879 320.61365 310.2879 306.61365 320.28003 408.44043 226.28003 410.44043 199.2879 366.61365" fill="#a0616a" />
              </g>
              <path
                d="M357.94449,276.8613c-1.12067,4.48965-3.38602,15.17972-6.9238,15.23233-2.89023,.04208-5.65668-46.33466-2.76953-54.00568,3.31638-8.81271-5.39886-19.96062-11.96411-25.6832-11.80423-10.2894-38.00696,11.80466-64.65118,1.79587-.70633-.26482-.56558-.23502-8.97934-3.59174-25.88966-10.32974-27.2506-10.62788-28.73386-10.77521-12.55046-1.24167-27.86705,9.02844-34.12146,21.55038-6.50168,13.01653-1.06937,24.18106-7.18346,55.67184-.71246,3.67065-1.83138,8.90216-3.59174,8.97934-3.21819,.14029-6.3605-17.04846-7.18346-21.55038-3.44792-18.86186-6.7722-37.04675,0-57.46771,.73878-2.22729,5.29158-10.49458,14.36693-26.93799,13.0744-23.68825,19.65018-35.57709,21.55038-37.7132,13.62859-15.32624,38.43575-29.30734,59.26357-23.34626,10.52704,3.01299,8.63953,7.85691,21.55038,12.57105,23.00821,8.40057,43.00476-1.87303,46.69254,5.3876,1.9537,3.84602-3.51236,7.01686-3.59174,14.36693-.13593,12.6114,15.81424,16.25575,25.14212,28.73386,5.01447,6.70819,13.59753,6.78012-8.87228,96.78212l.00003,.00003Z"
                fill="#2f2e41"
                />
              </g>
              <path
                d="M464.92017,442.61035c-3.48022,3.91016-7.09009,7.74023-10.83008,11.48047-50.23999,50.23926-117.04004,77.90918-188.09009,77.90918-61.40991,0-119.63989-20.66992-166.75-58.71973-.03003-.01953-.05005-.04004-.07983-.07031-6.25-5.03906-12.30005-10.39941-18.14014-16.05957,.10986-.87988,.22998-1.75,.35986-2.61035,.82007-5.7998,1.73022-11.33008,2.75-16.41992,8.3501-41.71973,118.22021-85.51953,121.08008-86.66016,.04004-.00977,.06006-.01953,.06006-.01953,0,0,14.14014,52.12012,74.72998,51.4502,41.27002-.4502,33.27002-51.4502,33.27002-51.4502,0,0,.5,.09961,1.43994,.2998,11.91992,2.53027,94.68018,20.70996,127.33008,45.52051,9.94995,7.55957,17.08984,23.66016,22.21997,42.85938,.21997,.82031,.42993,1.66016,.65015,2.49023Z"
                fill="#2563eb"
                />
              <path
                d="M454.09009,77.91016C403.8501,27.6709,337.05005,0,266,0S128.15015,27.6709,77.90991,77.91016C27.67017,128.15039,0,194.9502,0,266c0,64.85059,23.05005,126.16016,65.29004,174.57031,4.03003,4.62988,8.23999,9.13965,12.61987,13.52051,1.03003,1.0293,2.07007,2.05957,3.12012,3.05957,5.84009,5.66016,11.89014,11.02051,18.14014,16.05957,.02979,.03027,.0498,.05078,.07983,.07031,47.11012,38.0498,105.3401,58.71973,166.75001,58.71973,71.05005,0,137.8501-27.66992,188.09009-77.90918,3.73999-3.74023,7.34985-7.57031,10.83008-11.48047,43.36987-48.71973,67.07983-110.83984,67.07983-176.61035,0-71.0498-27.66992-137.84961-77.90991-188.08984Zm10.17993,362.20996c-7.86987,8.9502-16.33008,17.37012-25.33008,25.18066-17.06982,14.84961-36.06982,27.5293-56.55981,37.62988-7.19019,3.5498-14.56006,6.7793-22.1001,9.66992-29.29004,11.24023-61.08008,17.39941-94.28003,17.39941-32.04004,0-62.76001-5.73926-91.18994-16.23926-11.67017-4.30078-22.94995-9.41016-33.78003-15.26074-1.59009-.85938-3.16992-1.72949-4.73999-2.61914-8.26001-4.68066-16.25-9.79004-23.91992-15.31055-10.98999-7.87988-21.3501-16.58984-30.98022-26.03027-5.3999-5.29004-10.55981-10.7998-15.48975-16.5293C26.09009,391.77051,2,331.65039,2,266,2,120.43066,120.42993,2,266,2s264,118.43066,264,264c0,66.66016-24.82983,127.62012-65.72998,174.12012Z"
                fill="#3f3d56"
                />
              </svg>

              <!-- Name & Title -->
              <div class="mt-3 flex w-full items-center rounded-2xl border-2 border-zinc-800 bg-slate-200 p-1">
                <label class="w-32 text-center text-sm md:text-base" for="name">Name</label>
                <input class="w-full appearance-none rounded-2xl border-0 border-transparent bg-slate-200 text-sm font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:text-base" id="name" name="name" type="text" value="<%=user.getString("SEEKER_FNAME") + " " + user.getString("SEEKER_LNAME")%>"/>
              </div>
              <div class="mt-3 flex w-full items-center rounded-2xl border-2 border-zinc-800 bg-slate-200 p-1">
                <label class="w-32 text-center text-sm md:text-base" for="title">Title</label>
                <input class="w-full appearance-none rounded-2xl border-0 border-transparent bg-slate-200 text-sm font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:text-base" id="title" name="title" type="text" value="<%=user.getString("SEEKER_TITLE")%>"/>
              </div>

              <!-- Contact Details -->
              <div class="mx-4 mt-8 border-t-2 border-zinc-800">
                <div class="mt-5 text-center text-xl font-semibold">Contact Details</div>
                <!-- Details Column -->
                <div class="mt-5 flex flex-col gap-5">
                  <div class="flex items-center justify-between">
                    <div class="text-xs font-bold md:text-base">Number</div>
                    <input class="w-28 appearance-none rounded-2xl border-2 border-zinc-800 bg-slate-200 text-right text-xs font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:w-40 md:text-base" id="number" name="number" type="text" value="<%=user.getString("SEEKER_NUMBER")%>" />
                  </div>
                  <div class="flex items-center justify-between">
                    <div class="text-xs font-bold md:text-base">Email</div>
                    <input class="w-28 appearance-none rounded-2xl border-2 border-zinc-800 bg-slate-200 text-right text-xs font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:w-40 md:text-base" id="email" name="email" type="text" value="<%=user.getString("USER_EMAIL")%>" />
                  </div>

                  <div class="flex items-center justify-between">
                    <div class="text-xs font-bold md:text-base">Location</div>
                    <input class="w-28 appearance-none rounded-2xl border-2 border-zinc-800 bg-slate-200 text-right text-xs font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:w-40 md:text-base" id="location" name="location" type="text" value="<%=user.getString("SEEKER_ADDRESS")%>" />
                  </div>

                  <div class="flex items-center justify-between">
                    <div class="text-xs font-bold md:text-base">Zoom</div>
                    <input class="w-28 appearance-none rounded-2xl border-2 border-zinc-800 bg-slate-200 text-right text-xs font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:w-40 md:text-base" id="zoom" name="zoom" type="text" value="<%=user.getString("SEEKER_ZOOMID")%>" />
                  </div>
                </div>
                <div class="flex items-center justify-between flex-col gap-3 mt-6 md:mt-8">
                  <button class="w-full h-9 rounded-2xl bg-yellow-400 text-base font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 md:text-lg" type="button" data-modal-target="profileModal" data-modal-toggle="profileModal">Confirm Profile Changes</button>
                  <button id="credential-btn" class="w-full h-7 rounded-2xl bg-neutral-600 text-xs text-stone-100 font-bold hover:bg-neutral-700 md:text-sm" type="button" onclick="showCredentials()">Show Credentials</button>
                </div>
              </div>

              <!-- Change Password -->
              <div id="change-credential" class="mx-4 mt-8 border-t-2 border-zinc-800 hidden">
                <div class="mt-5 text-center text-xl font-semibold">Credentials</div>
                <!-- Details Column -->
                <div class="mt-5 flex flex-col gap-5">
                  <div class="flex items-center justify-between">
                    <div class="text-xs font-bold md:text-base">Current Password</div>
                    <input class="w-28 appearance-none rounded-2xl border-2 border-zinc-800 bg-slate-200 text-right text-xs font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:w-40 md:text-base" form="edit-credentials" id="password" name="cur-password" type="password" value="" placeholder="*******" />
                  </div>
                  <div class="flex items-center justify-between">
                    <div class="text-xs font-bold md:text-base">Password</div>
                    <input class="w-28 appearance-none rounded-2xl border-2 border-zinc-800 bg-slate-200 text-right text-xs font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:w-40 md:text-base" form="edit-credentials" id="password" name="new-password" type="password" value="" placeholder="*******" />
                  </div>
                  <div class="flex items-center justify-between">
                    <div class="text-xs font-bold md:text-base">Confirm Password</div>
                    <input class="w-28 appearance-none rounded-2xl border-2 border-zinc-800 bg-slate-200 text-right text-xs font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0 md:w-40 md:text-base" form="edit-credentials" id="confirm" name="confirm" type="password" value="" placeholder="*******"  />
                  </div>
                </div>
                <button class="h-9 w-full rounded-2xl bg-yellow-400 mt-6 md:mt-8 text-base font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 md:text-lg" type="button" data-modal-target="credentialModal" data-modal-toggle="credentialModal">Change Credentials</button>
              </div>
            </div>

            <!-- Profile Description -->
            <div id="description" class="basis-[330px] self-start rounded-2xl border-2 border-zinc-800 px-8 py-6 lg:flex-1 min-[1280px]:basis-96">
              <!-- About Me -->
              <div class="border-b-2 border-zinc-800 pb-2 text-xl font-bold md:text-3xl">About me</div>
              <div class="mt-2 text-sm md:text-base"><%=user.getString("SEEKER_ABOUT")%></div>

              <!-- Education -->
              <div class="mt-5 border-b-2 border-zinc-800 pb-2 text-xl font-bold md:text-3xl">Education</div>
              <div class="mt-2 text-lg font-semibold md:text-2xl"><%=user.getString("SEEKER_EDUC_COURSE")%></div>
              <div class="text-sm font-light md:text-base"><%=user.getString("SEEKER_EDUC_SCHOOL")%></div>
              <div class="text-sm font-light md:text-base"><%=user.getString("SEEKER_EDUC_BATCH")%></div>

              <!-- Education -->
              <div class="mt-5 border-b-2 border-zinc-800 pb-2 text-xl font-bold md:text-3xl">Experience</div>
              <div class="mt-2 text-lg font-semibold md:text-2xl"><%=user.getString("SEEKER_EXP_TITLE")%></div>
              <div class="text-sm font-light md:text-base"><%=user.getString("SEEKER_EXP_COMPANY")%></div>
              <div class="text-sm font-light md:text-base"><%=user.getString("SEEKER_EXP_BATCH")%></div>

              <!-- About Me -->
              <div class="mt-5 border-b-2 border-zinc-800 pb-2 text-xl font-bold md:text-3xl">Skills</div>
              <div class="mt-2">
                <ul class="ml-4 list-outside list-disc text-sm md:text-base">
                  <%String[] skills = user.getString("SEEKER_SKILLS").split("\\*");%>
                  <% for (String bullet : skills) {%>
                  <%if (bullet.trim().isEmpty()) {
                      continue;
                    }%>
                  <li><%=bullet%></li>
                    <%}%>
                </ul>
              </div>
            </div>

            <!-- ! Edit Profile Description -->
            <div id="edit-description" class="hidden basis-[330px] self-start rounded-2xl border-2 border-zinc-800 bg-slate-300 px-10 py-6 lg:flex-1 min-[1280px]:basis-96">
              <!-- About Me -->
              <div class="border-b-2 border-zinc-800 pb-2 text-xl font-bold md:text-3xl">About me</div>
              <textarea name="about" class="mt-2 block w-full rounded-2xl border border-zinc-800 bg-slate-200 p-2.5 text-sm text-zinc-800 focus:border-blue-400 focus:ring-blue-400" rows="4"><%=user.getString("SEEKER_ABOUT")%></textarea>

              <!-- Education -->
              <div class="mt-5 border-b-2 border-zinc-800 pb-2 text-xl font-bold md:text-3xl">Education</div>
              <div class="mt-3 flex w-full max-w-[300px] items-center rounded-2xl border-2 border-zinc-800 bg-slate-200 p-1">
                <label class="w-32 text-center text-sm md:text-base" for="course">Course</label>
                <input class="w-full appearance-none rounded-2xl border-0 border-transparent bg-slate-200 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="course" name="course" type="text" value="<%=user.getString("SEEKER_EDUC_COURSE")%>" />
              </div>
              <div class="mt-3 flex w-full max-w-[300px] items-center rounded-2xl border-2 border-zinc-800 bg-slate-200 p-1">
                <label class="w-32 text-center text-sm md:text-base" for="college">College</label>
                <input class="w-full appearance-none rounded-2xl border-0 border-transparent bg-slate-200 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="college" name="college" type="text" value="<%=user.getString("SEEKER_EDUC_SCHOOL")%>" />
              </div>
              <div class="mt-3 flex w-full max-w-[300px] items-center rounded-2xl border-2 border-zinc-800 bg-slate-200 p-1">
                <label class="w-32 text-center text-sm md:text-base" for="educ_date">Date</label>
                <input class="w-full appearance-none rounded-2xl border-0 border-transparent bg-slate-200 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="educ_date" name="educ_date" type="text" value="<%=user.getString("SEEKER_EDUC_BATCH")%>" />
              </div>

              <!-- Education -->
              <div class="mt-5 border-b-2 border-zinc-800 pb-2 text-xl font-bold md:text-3xl">Experience</div>
              <div class="mt-3 flex w-full max-w-[300px] items-center rounded-2xl border-2 border-zinc-800 bg-slate-200 p-1">
                <label class="w-32 text-center text-sm md:text-base" for="job">Job</label>
                <input class="w-full appearance-none rounded-2xl border-0 border-transparent bg-slate-200 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="job" name="job" type="text" value="<%=user.getString("SEEKER_EXP_TITLE")%>" />
              </div>
              <div class="mt-3 flex w-full max-w-[300px] items-center rounded-2xl border-2 border-zinc-800 bg-slate-200 p-1">
                <label class="w-32 text-center text-sm md:text-base" for="company text-sm md:text-base">Company</label>
                <input class="w-full appearance-none rounded-2xl border-0 border-transparent bg-slate-200 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="company" name="company" type="text" value="<%=user.getString("SEEKER_EXP_COMPANY")%>" />
              </div>
              <div class="mt-3 flex w-full max-w-[300px] items-center rounded-2xl border-2 border-zinc-800 bg-slate-200 p-1">
                <label class="w-32 text-center text-sm md:text-base" for="job_date">Date</label>
                <input class="w-full appearance-none rounded-2xl border-0 border-transparent bg-slate-200 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="job_date" name="job_date" type="text" value="<%=user.getString("SEEKER_EXP_BATCH")%>" />
              </div>

              <!-- About Me -->
              <div class="mt-5 border-b-2 border-zinc-800 pb-2 text-xl font-bold md:text-3xl">Skills</div>
              <textarea name="skills" class="mt-2 block w-full rounded-2xl border border-zinc-800 bg-slate-200 p-2.5 text-sm text-zinc-800 focus:border-blue-400 focus:ring-blue-400" rows="4"><%=user.getString("SEEKER_SKILLS")%></textarea>
            </div>
          </div>
        </div>
      </div>

      <!-- Confirm Profile Changes Modal -->
      <div id="profileModal" tabindex="-1" aria-hidden="true" class="fixed left-0 right-0 top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full overflow-y-auto overflow-x-hidden p-4 md:inset-0">
        <div class="relative max-h-full w-full max-w-lg">
          <!-- Modal content -->
          <div class="relative rounded-lg bg-slate-300 shadow">
            <!-- Modal header -->
            <div class="flex items-start justify-between rounded-t border-b border-neutral-600 p-4">
              <h3 class="flex-1 text-2xl font-semibold text-zinc-800">Confirm Profile Changes</h3>
              <button type="button" class="ml-auto inline-flex items-center rounded-lg bg-transparent p-1.5 text-sm text-zinc-800 hover:bg-slate-600 hover:text-stone-100" data-modal-hide="profileModal">
                <svg aria-hidden="true" class="h-7 w-7" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                <span class="sr-only">Close modal</span>
              </button>
            </div>
            <!-- Modal body -->
            <div class="space-y-6 p-6">
              <p class="text-base leading-relaxed text-slate-800">Are you sure you want to change your profile details? This will change your visible information to employers.</p>
            </div>
            <!-- Modal footer -->
            <div class="flex items-center space-x-2 rounded-b border-t border-gray-200 p-6 dark:border-gray-600">
              <button data-modal-hide="profileModal" type="submit" class="rounded-2xl bg-yellow-400 px-5 py-2.5 text-center text-base font-semibold text-zinc-800 hover:bg-yellow-500 focus:outline-none focus:ring-4 focus:ring-blue-400">Confirm</button>
              <button data-modal-hide="profileModal" type="button" class="rounded-2xl border border-neutral-600 bg-neutral-600 px-5 py-2.5 text-base text-stone-100 hover:bg-neutral-700 focus:z-10 focus:outline-none focus:ring-4 focus:ring-blue-400">Back</button>
            </div>
          </div>
        </div>
      </div>
    </form>
    <%}%>

    <!-- Confirm Credential Changes Modal -->
    <div id="credentialModal" tabindex="-1" aria-hidden="true" class="fixed left-0 right-0 top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full overflow-y-auto overflow-x-hidden p-4 md:inset-0">
      <div class="relative max-h-full w-full max-w-lg">
        <!-- Modal content -->
        <div class="relative rounded-lg bg-slate-300 shadow">
          <!-- Modal header -->
          <div class="flex items-start justify-between rounded-t border-b border-neutral-600 p-4">
            <h3 class="flex-1 text-2xl font-semibold text-zinc-800">Confirm Credentials Change</h3>
            <button type="button" class="ml-auto inline-flex items-center rounded-lg bg-transparent p-1.5 text-sm text-zinc-800 hover:bg-slate-600 hover:text-stone-100" data-modal-hide="credentialModal">
              <svg aria-hidden="true" class="h-7 w-7" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
              <span class="sr-only">Close modal</span>
            </button>
          </div>
          <!-- Modal body -->
          <div class="space-y-6 p-6">
            <p class="text-base leading-relaxed text-slate-800">Are you sure you want to change your credentials? This will update your login information and may affect your access to certain features or services.</p>
          </div>
          <!-- Modal footer -->
          <div class="flex items-center space-x-2 rounded-b border-t border-gray-200 p-6 dark:border-gray-600">
            <button data-modal-hide="credentialModal" type="submit" form="edit-credentials" class="rounded-2xl bg-yellow-400 px-5 py-2.5 text-center text-base font-semibold text-zinc-800 hover:bg-yellow-500 focus:outline-none focus:ring-4 focus:ring-blue-400">Confirm</button>
            <button data-modal-hide="credentialModal" type="button" class="rounded-2xl border border-neutral-600 bg-neutral-600 px-5 py-2.5 text-base text-stone-100 hover:bg-neutral-700 focus:z-10 focus:outline-none focus:ring-4 focus:ring-blue-400">Back</button>
          </div>
        </div>
      </div>
    </div>
    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
    <script src="./public/js/navbar.js" defer></script>
    <script src="./public/js/editProfile.js" defer></script>
  </body>
</html>
