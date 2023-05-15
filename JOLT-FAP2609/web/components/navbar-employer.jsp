     <nav class="border-b-2 border-zinc-800 bg-slate-200">
      <div class="max-w-screen flex flex-row items-center justify-between p-3">
        <a href="#" class="ml-16 flex flex-col items-center">
          <img src="./public/assets/logo/JoltLogo.png" class="mb-1 h-14" alt="JOLT Logo" />
          <span class="text-sm text-neutral-600 pl-"> for Employers</span>
        </a>

        <!-- Dashboard -->
        <div class="">
          <div class="hidden w-full md:block pl-12" id="navbar-default">
            <ul
              class="font-medium flex flex-col p-4 md:p-0 mt-4 md:flex-row md:space-x-8 md:mt-0 md:border-0"
            >
              <li>
                <a
                  href="#"
                  class="bordre-b-2 border-sky-700 hover:border-sky-700 block hover:text-sky-700 py-2 pl-3 pr-4 font-bold text-black bg-blue-700 md:bg-transparent md:text-black md:p-2 dark:text-black md:dark:black"
                  aria-current="page"
                  >Dashboard</a
                >
              </li>
            </ul>
          </div>
        </div>

        <a
          href="LogoutServlet"
          class="mr-16 inline-block h-10 rounded-xl bg-yellow-400 px-6 py-1 text-2xl font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400"
          >Logout</a
        >
      </div>
    </nav>

    <section
      class="bg-slate-300 border-solid border-b border-black flex flex-wrap items-center justify-between mx-auto"
    >
      <div class="flex flex-row items-center md:pl-12 md:p-3">
        <ul
          class="relative font-bold pl-12 flex flex-row p-4 md:p-0 md:flex-row md:space-x-8 md:mt-0 md:border-0"
        >
          <li>
            <a
              href="employer-home"
              class="block hover:text-sky-700 py-1 pr-4 text-black md:bg-transparent md:text-black -md:pl-3 md:p-2 dark:text-black md:dark:black"
              aria-current="page"
              >Job</a
            >
          </li>
          <li>
            <a
              href="LoadJobCandidates"
              class="border-b-2 border-sky-700 hover:border-sky-700 block hover:text-sky-700 py-1 pr-4 text-black md:bg-transparent md:text-black md:p-2 dark:text-black md:dark:black"
              aria-current="page"
              >Candidates</a
            >
          </li>
        </ul>
      </div>
    </section>