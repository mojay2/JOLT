//Add listener to view buttons
const viewButtons = document.querySelectorAll('#jobFeedBtn');
const jobLoader = document.getElementById("job-loader");
const skeleton = document.getElementById("skeleton");
const emptySearch = document.getElementById("empty-search");
const applyBtn = document.getElementById("apply-now");
const applyBtnDisabled = document.getElementById("already-applied");

document.addEventListener("DOMContentLoaded", loadFirstJob());

function loadFirstJob(){
    const jobID = document.getElementById("job-loader").getAttribute("data-id");
    console.log(jobID);
    if(jobID === '0'){
        //Search is empty
        skeleton.classList.remove("lg:inline");
        skeleton.classList.add("lg:hidden"); 
        emptySearch.classList.remove("hidden");        
        emptySearch.classList.add("flex");
    }else{
        loadJobInfo(jobID);
    }
}

viewButtons.forEach(button => {
  button.addEventListener('click', () => {
    const jobID = button.getAttribute('data-id');
    loadJobInfo(jobID);
  });
});

function loadJobInfo(jobID){
    fetch('./ViewJobInfo?id='+jobID)
        .then(response => response.json())
        .then(job => {
                if(!applyBtnDisabled.classList.contains('hidden')){
                    applyBtnDisabled.classList.add('hidden');
                }
                if(!applyBtn.classList.contains('hidden')){
                    applyBtn.classList.add('hidden');
                }
                document.getElementById('print-link').href = "PrintJobInfo?job="+job.jobid;
                
                document.getElementById('job-title').innerHTML = job.jobtitle;
                document.getElementById('emp-name').innerHTML = job.empname;
                document.getElementById('job-location').innerHTML = job.joblocation;
                document.getElementById('job-industry').innerHTML = job.jobindustry;

                document.getElementById('job-salary').innerHTML = "₱"+job.jobsalary+" / Month";
                document.getElementById('job-type').innerHTML = job.jobtype;
                document.getElementById('job-level').innerHTML = job.joblevel;

                document.getElementById('job-desc').innerHTML = job.jobdesc;
                document.getElementById('emp-overview').innerHTML = job.empoverview;
                document.getElementById('job-resp').innerHTML = job.jobresp;
                document.getElementById('job-reqs').innerHTML = job.jobreqs;
                document.getElementById('job-benefits').innerHTML = job.jobbenefits;

                document.getElementById('hidden-job-id').value = job.jobid;
                document.getElementById('hidden-emp-id').value = job.empid;
                
                
                if(job.appliedjobs.includes(jobID)){
                    applyBtnDisabled.classList.remove("hidden");
                }else{
                    applyBtn.classList.remove("hidden");
                }
    
                skeleton.classList.remove("lg:inline");
                skeleton.classList.add("lg:hidden");    
                jobLoader.classList.remove("lg:hidden");
                jobLoader.classList.add("lg:inline");
        })
    .catch(error => console.log(error));
}

const urlParams = new URLSearchParams(window.location.search);
const industry = urlParams.get('industry');
const select = document.querySelector('select[name="industry"]');
const searchParam = urlParams.get('search');
const searchBox = document.querySelector('input[name="search"]');
if (industry) {
  select.value = industry;
}
if(searchParam){
    searchBox.value = searchParam;
}