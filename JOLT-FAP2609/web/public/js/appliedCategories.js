window.addEventListener("load", function () {
  const queryString = window.location.search;
  const urlParams = new URLSearchParams(queryString);
  const category = urlParams.get("category");

  var appliedBtn = document.getElementById("applied");
  var pendingBtn = document.getElementById("pending");
  var acceptedBtn = document.getElementById("accepted");
  var rejectedBtn = document.getElementById("rejected");

  switch (category) {
    case "applied":
      appliedBtn.classList.add("border-yellow-400");
      break;

    case "pending":
      pendingBtn.classList.add("border-yellow-400");
      break;

    case "accepted":
      acceptedBtn.classList.add("border-yellow-400");
      break;

    case "rejected":
      rejectedBtn.classList.add("border-yellow-400");
      break;

    default:
      appliedBtn.classList.add("border-yellow-400");
      break;
  }
});
