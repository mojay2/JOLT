var modal = document.getElementById("jobFeedModal");
var btns = document.querySelectorAll("#jobFeedBtn");
var spans = document.querySelectorAll("#jobFeedClose");
var nav = document.getElementById("navbar");
var cont = document.getElementById("container");

btns.forEach((btn) => {
  btn.onclick = function () {
    if (window.screen.width < 1024) {
        modal.style.display = "flex";
        nav.classList.add("blur-sm");
        cont.classList.add("blur-sm");
        document.body.style.position = "fixed";
        document.body.style.top = `-${window.scrollY}px`;
        const jobID = btn.getAttribute('data-id');
        loadJobInfoModal(jobID);
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

const applyBtnModal = document.getElementById("apply-now-modal");
const applyBtnDisabledModal = document.getElementById("already-applied-modal");
function loadJobInfoModal(jobID){
    fetch('./ViewJobInfo?id='+jobID)
        .then(response => response.json())
        .then(job => {
                if(!applyBtnDisabledModal.classList.contains('hidden')){
                    applyBtnDisabledModal.classList.add('hidden');
                }
                if(!applyBtnModal.classList.contains('hidden')){
                    applyBtnModal.classList.add('hidden');
                }
                document.getElementById('print-link-modal').href = "PrintJobInfo?job="+job.jobid;

                document.getElementById('job-title-modal').innerHTML = job.jobtitle;
                document.getElementById('emp-name-modal').innerHTML = job.empname;
                document.getElementById('job-location-modal').innerHTML = job.joblocation;
                document.getElementById('job-industry-modal').innerHTML = job.jobindustry;

                document.getElementById('job-salary-modal').innerHTML = "₱"+job.jobsalary+" / Month";
                document.getElementById('job-type-modal').innerHTML = job.jobtype;
                document.getElementById('job-level-modal').innerHTML = job.joblevel;

                document.getElementById('job-desc-modal').innerHTML = job.jobdesc;
                document.getElementById('emp-overview-modal').innerHTML = job.empoverview;
                document.getElementById('job-resp-modal').innerHTML = job.jobresp;
                document.getElementById('job-reqs-modal').innerHTML = job.jobreqs;
                document.getElementById('job-benefits-modal').innerHTML = job.jobbenefits;

                document.getElementById('hidden-job-id-modal').value = job.jobid;
                document.getElementById('hidden-emp-id-modal').value = job.empid;
                
                if(job.appliedjobs.includes(jobID)){
                    applyBtnDisabledModal.classList.remove("hidden");
                }else{
                    applyBtnModal.classList.remove("hidden");
                }
        })
    .catch(error => console.log(error));
}

        

