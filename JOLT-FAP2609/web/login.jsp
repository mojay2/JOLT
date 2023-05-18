<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
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

    <title>JOLT - Login</title>
  </head>
  <!-- Body -->
  <body class="bg-slate-200 font-display">
    <!-- Navbar -->
    <%@include file="./components/navbar-user.jsp"%>

    <!-- Content -->
    <div class="container mx-auto">
      <div class="mt-6 justify-evenly gap-16 lg:flex">
        <div class="ml-6 mr-6 mt-2">
          <form id="login" action="LoginServlet" method="post">
            <!-- Header -->
            <div class="w-full">
              <div class="text-center text-3xl font-bold sm:text-left md:text-5xl">Login to your account</div>
              <div class="my-5 text-center text-lg font-light sm:text-left lg:text-xl">Welcome back! Please enter your login details to access your account and all of its features.</div>
            </div>

            <!-- Role -->
            <div class="mb-5 text-center text-2xl font-bold sm:text-left sm:text-3xl">Your Role</div>
            <div class="flex justify-evenly">
              <label class="flex w-2/5 cursor-pointer items-center rounded-2xl border-2 border-zinc-800 p-4 text-center sm:items-start sm:text-left">
                <input class="peer invisible absolute" type="radio" name="user-type" value="1" required />
                <div class="flex-1 peer-checked:text-blue-600">
                  <svg class="feather feather-user mx-auto h-11 w-11 text-blue-600 sm:mx-0" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                  <circle cx="12" cy="7" r="4"></circle>
                  </svg>
                  <div class="mt-3 font-bold sm:text-2xl">Careers</div>
                  <div class="text-xs sm:text-sm">Looking for employment</div>
                </div>
                <div class="hidden h-4 w-4 flex-initial rounded-full border-2 border-zinc-800 peer-checked:border-4 peer-checked:border-blue-600 sm:block sm:h-6 sm:w-6"></div>
              </label>
              <label class="flex w-2/5 cursor-pointer items-center rounded-2xl border-2 border-zinc-800 p-4 text-center sm:items-start sm:text-left">
                <input class="peer invisible absolute" type="radio" name="user-type" value="2" required />
                <div class="flex-1 peer-checked:text-blue-600">
                  <svg class="feather feather-phone-call mx-auto h-9 w-9 text-blue-600 sm:mx-0" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M15.05 5A5 5 0 0 1 19 8.95M15.05 1A9 9 0 0 1 23 8.94m-1 7.98v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                  </svg>
                  <div class="mt-5 font-bold sm:text-2xl">Employer</div>
                  <div class="text-[10px] sm:text-sm">Looking for job applicants</div>
                </div>
                <div class="hidden h-6 w-6 flex-initial rounded-full border-2 border-zinc-800 peer-checked:border-4 peer-checked:border-blue-600 sm:block"></div>
              </label>
            </div>

            <!-- Line -->
            <div class="my-5 w-full border-2 border-dashed border-zinc-800"></div>

            <!-- Credentials -->
            <div class="mb-5 text-center text-2xl font-bold sm:text-left sm:text-3xl">Your Credentials</div>
            <div class="mb-4 flex w-full items-center rounded-3xl border-2 border-zinc-800 p-2">
              <label class="w-32 text-center" for="email">Email</label>
              <input class="w-full appearance-none border-0 border-transparent bg-slate-200 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="email" name="email" type="text" placeholder="Enter your email" required />
            </div>
            <div class="mb-4 flex w-full items-center rounded-3xl border-2 border-zinc-800 p-2">
              <label class="w-32 text-center" for="password">Password</label>
              <input class="w-full appearance-none border-0 border-transparent bg-slate-200 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="password" name="password" type="password" placeholder="Enter your password" required />
            </div>

            <!-- Submit -->
            <button class="mb-5 mt-5 h-12 w-full rounded-3xl bg-yellow-400 text-lg font-bold hover:bg-yellow-500 focus:ring-4 focus:ring-blue-400 sm:text-xl" type="button" data-modal-target="captchaModal" data-modal-toggle="captchaModal">Submit Credentials</button>
          </form>
        </div>

        <!-- Carousel -->
        <div id="default-carousel" class="relative hidden w-3/6 xl:block" data-carousel="slide">
          <!-- Carousel wrapper -->
          <div class="relative h-full overflow-hidden rounded-2xl drop-shadow-2xl">
            <!-- Item 1 -->
            <div class="hidden duration-700 ease-in-out" data-carousel-item>
              <img src="public/assets/images/Carousel1.jpg" class="absolute h-full w-full rounded-2xl object-cover" alt="..." />
            </div>
            <!-- Item 2 -->
            <div class="hidden duration-700 ease-in-out" data-carousel-item>
              <img src="public/assets/images/Carousel2.jpg" class="absolute h-full w-full object-cover object-top" alt="..." />
            </div>
            <!-- Item 3 -->
            <div class="hidden duration-700 ease-in-out" data-carousel-item>
              <img src="public/assets/images/Carousel3.jpg" class="absolute h-full w-full object-cover object-right" alt="..." />
            </div>
            <div class="hidden duration-700 ease-in-out" data-carousel-item>
              <img src="public/assets/images/Carousel4.jpg" class="absolute h-full w-full object-cover object-right" alt="..." />
            </div>

            <div class="hidden duration-700 ease-in-out" data-carousel-item>
              <img src="public/assets/images/Carousel5.jpg" class="absolute h-full w-full object-cover object-bottom" alt="..." />
            </div>
          </div>
          <!-- Slider indicators -->
          <div class="absolute bottom-5 left-1/2 z-30 flex -translate-x-1/2 space-x-3">
            <button type="button" class="h-3 w-20 rounded-full" aria-current="true" aria-label="Slide 1" data-carousel-slide-to="0"></button>
            <button type="button" class="h-3 w-20 rounded-full" aria-current="false" aria-label="Slide 2" data-carousel-slide-to="1"></button>
            <button type="button" class="h-3 w-20 rounded-full" aria-current="false" aria-label="Slide 3" data-carousel-slide-to="2"></button>
            <button type="button" class="h-3 w-20 rounded-full" aria-current="false" aria-label="Slide 4" data-carousel-slide-to="3"></button>
            <button type="button" class="h-3 w-20 rounded-full" aria-current="false" aria-label="Slide 5" data-carousel-slide-to="4"></button>
          </div>
          <!-- Slider controls -->
          <button type="button" class="group absolute left-0 top-0 z-30 flex h-full cursor-pointer items-center justify-center px-10 focus:outline-none" data-carousel-prev></button>
          <button type="button" class="group absolute right-0 top-0 z-30 flex h-full cursor-pointer items-center justify-center px-10 focus:outline-none" data-carousel-next></button>
        </div>
      </div>
    </div>

    <!-- Captcha Modal -->
    <div id="captchaModal" tabindex="-1" aria-hidden="true" class="fixed left-0 right-0 top-0 z-50 hidden h-[calc(100%-1rem)] max-h-full w-full overflow-y-auto overflow-x-hidden p-4 md:inset-0">
      <div class="relative max-h-full w-full max-w-md">
        <!-- Modal content -->
        <div class="relative rounded-lg bg-slate-300 shadow">
          <!-- Modal header -->
          <div class="flex items-start justify-between rounded-t border-b border-neutral-600 p-4">
            <h3 class="text-xl font-semibold text-zinc-800 md:text-3xl">Captcha Verification</h3>
            <button type="button" class="ml-auto inline-flex items-center rounded-lg bg-transparent p-1.5 text-sm text-zinc-800 hover:bg-slate-600 hover:text-stone-100" data-modal-hide="captchaModal">
              <svg aria-hidden="true" class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
              <span class="sr-only">Close modal</span>
            </button>
          </div>
          <!-- Modal body -->
          <div class="space-y-5 p-4">
            <img class="mx-auto w-full" src="./simpleImg" /> 
            <div class="mb-4 flex w-full items-center rounded-3xl border-2 border-zinc-800 p-2">
              <label class="w-32 text-center" for="answer">Captcha</label>
              <input class="w-full appearance-none border-0 border-transparent bg-slate-300 font-semibold text-zinc-800 placeholder:font-light focus:border-transparent focus:ring-0" id="captcha" form="login" name="answer" type="text" placeholder="Enter the captcha" required />
            </div>
          </div>
          <!-- Modal footer -->
          <div class="flex items-center space-x-2 rounded-b border-t border-gray-200 p-4 dark:border-gray-600">
            <button data-modal-hide="captchaModal" type="submit" form="login" class="rounded-2xl bg-yellow-400 px-5 py-2.5 text-center text-sm font-semibold text-zinc-800 hover:bg-yellow-500 focus:outline-none focus:ring-4 focus:ring-blue-400 md:text-base">Confirm Submit</button>
            <button data-modal-hide="captchaModal" type="button" class="rounded-2xl border border-neutral-600 bg-neutral-600 px-5 py-2.5 text-sm text-stone-100 hover:bg-neutral-700 focus:z-10 focus:outline-none focus:ring-4 focus:ring-blue-400 md:text-base">Back</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
    <script src="./public/js/navbar.js" defer></script>
  </body>
</html>