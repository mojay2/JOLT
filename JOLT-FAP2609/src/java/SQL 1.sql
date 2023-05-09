DROP TABLE APPLICATIONS;
DROP TABLE JOBS;
DROP TABLE JOBSEEKERS;
DROP TABLE EMPLOYERS;
DROP TABLE INDUSTRIES;
DROP TABLE USERS;
DROP TABLE STATUSES;
DROP TABLE TYPES;
DROP TABLE LEVELS;

CREATE TABLE USERS(
    USER_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    USER_EMAIL VARCHAR(50) UNIQUE,
    USER_PASSWORD VARCHAR(50),
    USER_TYPE INT
);

CREATE TABLE INDUSTRIES(
    IND_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    IND_NAME VARCHAR(100)
);

CREATE TABLE STATUSES(
    STATUS_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 0, Increment by 1),
    STATUS_NAME VARCHAR(100)
);

CREATE TABLE TYPES(
    TYPE_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 0, Increment by 1),
    TYPE_NAME VARCHAR(100)
);

CREATE TABLE LEVELS(
    LEVEL_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 0, Increment by 1),
    LEVEL_NAME VARCHAR(100)
);

CREATE TABLE EMPLOYERS(
    EMP_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    USER_ID INTEGER references USERS(USER_ID) ON DELETE CASCADE,
    EMP_NAME VARCHAR(50),
    EMP_OVERVIEW VARCHAR(2000),
    EMP_ADDRESS VARCHAR(100),
    EMP_NUMBER VARCHAR(50)
);

CREATE TABLE JOBSEEKERS(
    SEEKER_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    USER_ID INTEGER references USERS(USER_ID) ON DELETE CASCADE,
    SEEKER_FNAME VARCHAR(50),
    SEEKER_LNAME VARCHAR(50),
    SEEKER_TITLE VARCHAR(50),
    SEEKER_ABOUT VARCHAR(2000),
    SEEKER_EDUC_COURSE VARCHAR(100),
    SEEKER_EDUC_SCHOOL VARCHAR(50),
    SEEKER_EDUC_BATCH VARCHAR(50),
    SEEKER_EXP_TITLE VARCHAR(50),
    SEEKER_EXP_COMPANY VARCHAR(100),
    SEEKER_EXP_BATCH VARCHAR(50),
    SEEKER_SKILLS VARCHAR(2000),
    SEEKER_ADDRESS VARCHAR(50),
    SEEKER_NUMBER VARCHAR(50),
    SEEKER_ZOOMID VARCHAR(50)
);

CREATE TABLE JOBS(
    JOB_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    EMP_ID INTEGER references EMPLOYERS(EMP_ID) ON DELETE CASCADE,
    JOB_TITLE VARCHAR(50),
    JOB_LOCATION VARCHAR(100),
    JOB_LEVEL INTEGER references LEVELS(LEVEL_ID),
    JOB_DESC VARCHAR(2000),
    JOB_RESP VARCHAR(2000),
    JOB_REQS VARCHAR(2000),
    JOB_BENEFIT VARCHAR(2000),
    INDUSTRY_ID INTEGER references INDUSTRIES(IND_ID),
    JOB_SALARY_MIN VARCHAR(50),    
    JOB_SALARY_MAX VARCHAR(50),
    JOB_TYPE INTEGER references TYPES(TYPE_ID),
    JOB_ISACTIVE INT DEFAULT 0
);

CREATE TABLE APPLICATIONS(
    APP_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    SEEKER_ID INTEGER REFERENCES JOBSEEKERS(SEEKER_ID) ON DELETE CASCADE,
    EMPLOYER_ID INTEGER REFERENCES EMPLOYERS(EMP_ID) ON DELETE CASCADE,
    JOB_ID INTEGER REFERENCES JOBS(JOB_ID) ON DELETE CASCADE,
    APP_STATUS INT DEFAULT 0
);


INSERT INTO USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES ('user1@gmail.com', 'user1', 1);
INSERT INTO USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES ('user2@gmail.com', 'user2', 1);
INSERT INTO USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES ('user3@gmail.com', 'user3', 1);

INSERT INTO USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES ('employer1@gmail.com', 'employer1', 2);
INSERT INTO USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES ('employer2@gmail.com', 'employer2', 2);
INSERT INTO USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES ('employer3@gmail.com', 'employer3', 2);

INSERT INTO INDUSTRIES (IND_NAME) VALUES ('Information Technology');
INSERT INTO INDUSTRIES (IND_NAME) VALUES ('Healthcare');
INSERT INTO INDUSTRIES (IND_NAME) VALUES ('Sales');
INSERT INTO INDUSTRIES (IND_NAME) VALUES ('Education');
INSERT INTO INDUSTRIES (IND_NAME) VALUES ('Finance');
INSERT INTO INDUSTRIES (IND_NAME) VALUES ('Marketing');
INSERT INTO INDUSTRIES (IND_NAME) VALUES ('Engineering');
INSERT INTO INDUSTRIES (IND_NAME) VALUES ('Hospitality');

INSERT INTO STATUSES (STATUS_NAME) VALUES ('Pending');
INSERT INTO STATUSES (STATUS_NAME) VALUES ('Accepted');
INSERT INTO STATUSES (STATUS_NAME) VALUES ('Rejected');

INSERT INTO TYPES (TYPE_NAME) VALUES ('Fresh Grad');
INSERT INTO TYPES (TYPE_NAME) VALUES ('Contractual');
INSERT INTO TYPES (TYPE_NAME) VALUES ('Internship');
INSERT INTO TYPES (TYPE_NAME) VALUES ('Part-Time');
INSERT INTO TYPES (TYPE_NAME) VALUES ('Full-Time');

INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Entry-Level');
INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Intermediate');
INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Mid-Level');
INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Senior-Level');
INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Executive-Level');

INSERT INTO EMPLOYERS (USER_ID, EMP_NAME, EMP_OVERVIEW, EMP_ADDRESS, EMP_NUMBER)
    VALUES (4, 'Google','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum', 
            'Pasay City', '12345678912');
INSERT INTO EMPLOYERS (USER_ID, EMP_NAME, EMP_OVERVIEW, EMP_ADDRESS, EMP_NUMBER)
    VALUES (5, 'CityLand','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
            'Quezon City', '12345678912');
INSERT INTO EMPLOYERS (USER_ID, EMP_NAME, EMP_OVERVIEW, EMP_ADDRESS, EMP_NUMBER)
    VALUES (6, 'Manulife','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
            'Manila', '12345678912');

INSERT INTO JOBS (EMP_ID, JOB_TITLE, JOB_LOCATION, JOB_LEVEL,
        JOB_DESC, JOB_RESP, JOB_REQS, JOB_BENEFIT, INDUSTRY_ID,
        JOB_SALARY_MIN, JOB_SALARY_MAX, JOB_TYPE) VALUES (
        1,'Junior Web Developer', 'Manila', 0, 
        'We are looking for a highly skilled and experienced Web Developer with a strong focus on technical SEO, page speed optimization, and ad pixel implementation. The ideal candidate will be responsible for revamping our website, optimizing user engagement, and enhancing conversion rates through their deep technical expertise.',
        'Estimate workload and project delivery timeline.*Writing clean, high-quality, high-performance, maintainable code.*Develop applications in Vue.js.',
        'Fluent English communication skills are a must.*Experience in consuming and integrating restful APIs in a Single Page JS application*.Sc/B.Sc in Computer Science, Engineering or relevant fields is an advantage but not required',
        'Opportunities for promotion*Pay Raise*Promotion to Permanent Employee',
        1, '22000', '25000', 0
);

INSERT INTO JOBS (EMP_ID, JOB_TITLE, JOB_LOCATION, JOB_LEVEL,
        JOB_DESC, JOB_RESP, JOB_REQS, JOB_BENEFIT, INDUSTRY_ID,
        JOB_SALARY_MIN, JOB_SALARY_MAX, JOB_TYPE) VALUES (
        2,'Project Engineer', 'Manila', 3,
        'As a Teller, you will handle administrative, operations, marketing and financial experience by supporting the branch business. When it comes to career growth, it is an opportunity to get valuable corporate experience while learning from seasoned veterans of a highly competitive field.',
        'Collaborate with the Senior Engineers to create more efficient methods and maintain profitability*Develop the specifications for all equipment that is required for each project*Create the framework used to develop and monitor project metrics and manage the collection of project data',
        'Licensed Civil Engineer*At least 3 Years experience',
        'Opportunities for promotion*Pay Raise*Promotion to Permanent Employee',
        5, '21000', '24000', 4
);

INSERT INTO JOBS (EMP_ID, JOB_TITLE, JOB_LOCATION, JOB_LEVEL,
        JOB_DESC, JOB_RESP, JOB_REQS, JOB_BENEFIT, INDUSTRY_ID,
        JOB_SALARY_MIN, JOB_SALARY_MAX, JOB_TYPE) VALUES (
        3,'Financial Analyst', 'Manila', 2, 
        'The position is accountable for providing accurate, timely, and relevant monthly, quarterly and annual financial data production, reporting, analysis, planning and forecasting to different stakeholders of the Global Wealth and Asset Management & General Account (GWAM & GA) Finance Financial Planning & Analysis – Asia team.',
        'Actively involved with consolidating, analyzing, and synthesizing large amount of financial and non-financial information from various stakeholders*Initiates improvements by exploring, identifying, and implementing reporting, analysis, and process solutions',
        'Degree in BS Accountancy, preferably with Professional CPA license but not required*Knowledge of General Accounting principles*With 2-3 years of experience in the same field',
        'Opportunities for promotion*Pay Raise*Promotion to Permanent Employee',
        2, '20000', '23000', 3
);

INSERT INTO JOBSEEKERS(
    USER_ID, SEEKER_FNAME, SEEKER_LNAME, SEEKER_TITLE,
    SEEKER_ABOUT,
    SEEKER_EDUC_COURSE, SEEKER_EDUC_SCHOOL, SEEKER_EDUC_BATCH,
    SEEKER_EXP_TITLE, SEEKER_EXP_COMPANY, SEEKER_EXP_BATCH,
    SEEKER_SKILLS,
    SEEKER_ADDRESS, SEEKER_NUMBER, SEEKER_ZOOMID
) VALUES (
    1, 'JR Gregg', 'Lagman', 'Web Developer',
    'Experienced web developer with a strong background in front-end development and expertise in HTML, CSS, and JavaScript. Skilled in developing responsive and user-friendly websites and applications using modern frameworks such as React and Angular. Passionate about staying up-to-date with the latest web technologies and trends. A collaborative team player with excellent communication skills and a focus on delivering high-quality work.',
    'University of Santo Tomas', 'B.S. Computer Science', '2018 - 2022',
    'Web Developer Intern', 'Canva',' 2022 - Present',
    'Strong Problem Solving and analytical Skills*Excellent communication and collaboration skills*Experience working in Agile Environments',
    'Quezon City', '1234567890', 'jrgregglagman'
);

INSERT INTO JOBSEEKERS(
    USER_ID, SEEKER_FNAME, SEEKER_LNAME, SEEKER_TITLE,
    SEEKER_ABOUT,
    SEEKER_EDUC_COURSE, SEEKER_EDUC_SCHOOL, SEEKER_EDUC_BATCH,
    SEEKER_EXP_TITLE, SEEKER_EXP_COMPANY, SEEKER_EXP_BATCH,
    SEEKER_SKILLS,
    SEEKER_ADDRESS, SEEKER_NUMBER, SEEKER_ZOOMID
) VALUES (
    2, 'Lancelot', 'Bulan', 'Civil Engineer',
    'Dynamic civil engineer with experience in infrastructure design, construction and project management. Skilled in AutoCAD, SAP2000 and MS Project. Strong analytical and problem-solving abilities with a focus on ensuring projects are completed on time and within budget. Proven ability to work in a team and to communicate effectively with clients and stakeholders.',
    'University of Santo Tomas', 'B.S. Civil Engineering', '2018 - 2022',
    'Project Engineer', 'Ayala', '2022 - Present',
    'Strong Problem Solving and analytical Skills*Excellent communication and collaboration skills*Experience working in Agile Environments',
    'Quezon City', '1234567890', 'lancelotbulan'
);

INSERT INTO JOBSEEKERS(
    USER_ID, SEEKER_FNAME, SEEKER_LNAME, SEEKER_TITLE,
    SEEKER_ABOUT,
    SEEKER_EDUC_COURSE, SEEKER_EDUC_SCHOOL, SEEKER_EDUC_BATCH,
    SEEKER_EXP_TITLE, SEEKER_EXP_COMPANY, SEEKER_EXP_BATCH,
    SEEKER_SKILLS,
    SEEKER_ADDRESS, SEEKER_NUMBER, SEEKER_ZOOMID
) VALUES (
    3, 'Jay', 'Ambal', 'Financial Analyst',
    'Experienced financial analyst with expertise in financial modeling and analysis, forecasting, and budgeting. Skilled in Excel, Bloomberg Terminal, and other financial software. Strong analytical and problem-solving abilities with a focus on delivering accurate and actionable insights to support investment decisions. Proven ability to work independently and as part of a team.',
    'University of Santo Tomas', 'B.S. Accountancy', '2018 - 2022',
    'Finance Intern', 'Some Company', '2022 - Present',
    'Strong Problem Solving and analytical Skills*Excellent communication and collaboration skills*Experience working in Agile Environments',
    'Quezon City', '1234567890', 'jayambal'
);

INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Entry-Level');
INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Intermediate');
INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Mid-Level');
INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Senior-Level');
INSERT INTO LEVELS (LEVEL_NAME) VALUES ('Executive-Level');

--APP STATUSES
--0 = PENDING
--1 = ACCEPTED
--2 = REJECTED

--JOB TYPES
--0 = FRESH GRAD
--1 = CONTRACTUAL
--2 = INTERNSHIP
--3 = PART-TIME
--4 = FULL TIME

--JOB LEVEL
--0 = Entry Level
--1 = Intermediate
--3 = Mid Level
--4 = Senior Level
--5 = Executive Level


--JOB INDUSTRIES
--1 = INFORMATION TECHNOLOGY
--2 = HEALTHCARE
--1 = SALES
--2 = EDUCATION
--1 = FINANCE
--2 = MARKETING
--1 = ENGINEERING
--2 = HOSPITALITY

--JOB ISOPEN
--0 = TRUE
--1 = FALSE