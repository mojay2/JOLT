window.addEventListener("load", function () {
  var wholePathName = window.location.pathname;
  var pathName = wholePathName.substring(wholePathName.lastIndexOf('/') + 1);
  var jobFeedNav = document.getElementById("navbar1");
  var appliedJobsNav = document.getElementById("navbar2");
  var userProfileNav = document.getElementById("navbar3");
  var jobFeedMobileNav = document.getElementById("navbarMobile1");
  var appliedJobsMobileNav = document.getElementById("navbarMobile2");
  var userProfileMobileNav = document.getElementById("navbarMobile3");

  switch (pathName) {
    case 'LoadJobFeed':
      jobFeedNav.classList.add("border-b-4");
      jobFeedMobileNav.classList.add("bg-blue-400");
      break;

    case "LoadAppliedJobs":
      appliedJobsNav.classList.add("border-b-4");
      appliedJobsMobileNav.classList.add("bg-blue-400");
      break;

    case "ViewProfile":
      userProfileNav.classList.add("border-b-4");
      userProfileMobileNav.classList.add("bg-blue-400");
      break;
      
    case "LoginServlet":
      jobFeedNav.classList.add("border-b-4");
      jobFeedMobileNav.classList.add("bg-blue-400");
      break;
      
    default:
      break;
  }
});
