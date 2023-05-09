window.addEventListener("load", function () {
  var pathName = window.location.pathname;
  var jobFeedNav = document.getElementById("navbar1");
  var appliedJobsNav = document.getElementById("navbar2");
  var userProfileNav = document.getElementById("navbar3");
  switch (pathName) {
    case '/jobfeed.html':
      jobFeedNav.classList.add("border-b-4");
      break;

    case "/applied.html":
      appliedJobsNav.classList.add("border-b-4");
      break;

    case "/profile.html":
      userProfileNav.classList.add("border-b-4");
      break;

    default:
      break;
  }
});
