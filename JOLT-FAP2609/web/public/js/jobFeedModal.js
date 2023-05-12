var modal = document.getElementById("jobFeedModal");
var btns = document.querySelectorAll("#jobFeedBtn");
var spans = document.querySelectorAll("#jobFeedClose");
var nav = document.getElementById("navbar");
var cont = document.getElementById("container");

btns.forEach((btn) => {
  btn.onclick = function () {
    console.log(window.screen.width);
    if (window.screen.width < 1024) {
      modal.style.display = "flex";
      nav.classList.add("blur-sm");
      cont.classList.add("blur-sm");
      document.body.style.position = "fixed";
      document.body.style.top = `-${window.scrollY}px`;
    }
  };
});

spans.forEach((span) => {
  span.onclick = function () {
    closeModal();
  };
});

window.onclick = function (event) {
  if (event.target == modal) {
    closeModal();
  }
};

document.addEventListener("keydown", (event) => {
  if (event.key === "Escape") {
    closeModal();
  }
});

function closeModal() {
  modal.style.display = "none";
  nav.classList.remove("blur-sm");
  cont.classList.remove("blur-sm");
  const scrollY = document.body.style.top;
  document.body.style.position = "";
  document.body.style.top = "";
  window.scrollTo(0, parseInt(scrollY || "0") * -1);
}

        

