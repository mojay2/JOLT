const viewButtons = document.querySelectorAll('#jobFeedBtn');

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
        })
    .catch(error => console.log(error));
}