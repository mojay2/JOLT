<%-- 
    Document   : error
    Created on : 05 6, 23, 10:34:54 PM
    Author     : lance
--%>

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
    <link rel="apple-touch-icon" sizes="180x180" href="/public/assets/favicon/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="/public/assets/favicon/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="/public/assets/favicon/favicon-16x16.png" />
    <link rel="manifest" href="/public/assets/favicon/site.webmanifest" />
    <link rel="mask-icon" href="/public/assets/favicon/safari-pinned-tab.svg" color="#facc15" />
    <meta name="msapplication-TileColor" content="#e2e8f0" />
    <meta name="theme-color" content="#ffffff" />

    <title>401 Invalid Login</title>
  </head>

  <!-- Body -->
  <body class="bg-slate-200 font-display">
    <!-- Navbar -->
    <%@include file="./components/navbar-user.jsp"%>

    <!-- Error -->
    <div class="container mx-auto h-[calc(100vh-110px)] overflow-auto">
      <div class="flex flex-col justify-center items-center h-full p-4  text-zinc-800">
        <img src="./public/assets/images/error.png" alt="error image" class="h-auto w-[300px] border-b-4 border-zinc-800 px-4 pb-6 lg:w-[500px]" />
        <h1 class="md: mt-6 text-3xl font-bold lg:text-5xl">401 Invalid Login</h1>
        <p class="mt-6 w-5/6 text-center text-lg font-normal lg:w-1/2 lg:text-3xl">Uh oh, it looks like the credentials you entered are not valid. Please double-check your email and password and try again</p>
      </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.5/flowbite.min.js"></script>
  </body>
</html>
