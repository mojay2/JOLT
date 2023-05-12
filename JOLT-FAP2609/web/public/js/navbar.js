window.addEventListener("load", function () {
  var pathName = window.location.pathname;
  var jobFeedNav = document.getElementById("navbar1");
  var appliedJobsNav = document.getElementById("navbar2");
  var userProfileNav = document.getElementById("navbar3");
  var jobFeedMobileNav = document.getElementById("navbarMobile1");
  var appliedJobsMobileNav = document.getElementById("navbarMobile2");
  var userProfileMobileNav = document.getElementById("navbarMobile3");

  switch (pathName) {
    case '/jobfeed.html':
      jobFeedNav.classList.add("border-b-4");
      jobFeedMobileNav.classList.add("bg-blue-400");
      break;

    case "/applied.html":
      appliedJobsNav.classList.add("border-b-4");
      appliedJobsMobileNav.classList.add("bg-blue-400");
      break;

    case "/profile.html":
      userProfileNav.classList.add("border-b-4");
      userProfileMobileNav.classList.add("bg-blue-400");
      break;

    default:
      break;
  }
});
