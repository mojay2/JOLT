window.addEventListener("load", function () {
  const queryString = window.location.search;
  const urlParams = new URLSearchParams(queryString);
  const status = urlParams.get("status");

  var appliedBtn = document.getElementById("applied");
  var pendingBtn = document.getElementById("pending");
  var acceptedBtn = document.getElementById("accepted");
  var rejectedBtn = document.getElementById("rejected");

console.log(status);

  switch (status) {
    case '0':
      pendingBtn.classList.add("border-yellow-400");
      break;

    case '1':
      acceptedBtn.classList.add("border-yellow-400");
      break;

    case '2':
      rejectedBtn.classList.add("border-yellow-400");
      break;

    default:
      appliedBtn.classList.add("border-yellow-400");
      break;
  }
});
