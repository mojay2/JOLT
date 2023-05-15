    const viewButtons = document.querySelectorAll('#viewApplicantBtn');

    viewButtons.forEach(button => {
      button.addEventListener('click', () => {
        const applicantID = button.getAttribute('data-id');
        loadApplicantInfo(applicantID);
      });
    });

    function loadApplicantInfo(jobID){
        fetch('./ViewApplicant?id='+jobID)
            .then(response => response.json())
            .then(applicant => {
                document.getElementById('name').innerHTML = applicant.fname +" "+applicant.lname;
                document.getElementById('title').innerHTML = applicant.title;
                document.getElementById('about').innerHTML = applicant.about;
                document.getElementById('course').innerHTML = applicant.course;
                document.getElementById('school').innerHTML = applicant.school;
                document.getElementById('educ_date').innerHTML = applicant.educ_date;
                document.getElementById('job_title').innerHTML = applicant.educ_date;
                document.getElementById('company').innerHTML = applicant.company;
                document.getElementById('job_date').innerHTML = applicant.job_date;
                document.getElementById('skills').innerHTML = applicant.skills;
                document.getElementById('contact-details').innerHTML = applicant.number + "<br/>" + applicant.email + "<br/>" + applicant.address + "<br/>" + applicant.zoomid + "<br/>";

            })
        .catch(error => console.log(error));
    }