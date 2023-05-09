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
--     SEEKER_TITLE VARCHAR(50),
--     SEEKER_ABOUT VARCHAR(2000),
--     SEEKER_EDUC_COURSE VARCHAR(100),
--     SEEKER_EDUC_SCHOOL VARCHAR(50),
--     SEEKER_EDUC_BATCH VARCHAR(50),
--     SEEKER_EXP_TITLE VARCHAR(50),
--     SEEKER_EXP_COMPANY VARCHAR(100),
--     SEEKER_EXP_BATCH VARCHAR(50),
--     SEEKER_SKILLS VARCHAR(2000),
    SEEKER_ADDRESS VARCHAR(50),
    SEEKER_NUMBER VARCHAR(50)
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
    VALUES (5, 'BDO','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
            'Quezon City', '12345678912');
INSERT INTO EMPLOYERS (USER_ID, EMP_NAME, EMP_OVERVIEW, EMP_ADDRESS, EMP_NUMBER)
    VALUES (6, 'Philippine General Hospital','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
            'Manila', '12345678912');

INSERT INTO JOBSEEKERS(USER_ID, SEEKER_FNAME, SEEKER_LNAME, SEEKER_ADDRESS, SEEKER_NUMBER)
    VALUES(1, 'Jay', 'Ambal', 'Quezon City', '12345678910');
INSERT INTO JOBSEEKERS(USER_ID, SEEKER_FNAME, SEEKER_LNAME, SEEKER_ADDRESS, SEEKER_NUMBER)
    VALUES(2, 'JR Gregg', 'Lagman', 'Quezon City', '12345678910');
INSERT INTO JOBSEEKERS(USER_ID, SEEKER_FNAME, SEEKER_LNAME, SEEKER_ADDRESS, SEEKER_NUMBER)
    VALUES(3, 'Lancelot', 'Bulan', 'Quezon City', '12345678910');

INSERT INTO JOBS (EMP_ID, JOB_TITLE, JOB_LOCATION, JOB_LEVEL,
        JOB_DESC, JOB_RESP, JOB_REQS, JOB_BENEFIT, INDUSTRY_ID,
        JOB_SALARY_MIN, JOB_SALARY_MAX, JOB_TYPE) VALUES (
        1,'Junior Web Developer', 'Manila', 0, 
        'We are looking for a highly skilled and experienced Web Developer with a strong focus on technical SEO, page speed optimization, and ad pixel implementation. The ideal candidate will be responsible for revamping our website, optimizing user engagement, and enhancing conversion rates through their deep technical expertise.',
        'insert job resp here',
        'insert job reqs here',
        'insert job benefits here',
        1, '22000', '25000', 0
);

INSERT INTO JOBS (EMP_ID, JOB_TITLE, JOB_LOCATION, JOB_LEVEL,
        JOB_DESC, JOB_RESP, JOB_REQS, JOB_BENEFIT, INDUSTRY_ID,
        JOB_SALARY_MIN, JOB_SALARY_MAX, JOB_TYPE) VALUES (
        2,'Bank Teller', 'Manila', 3,
        'As a Teller, you will handle administrative, operations, marketing and financial experience by supporting the branch business. When it comes to career growth, it is an opportunity to get valuable corporate experience while learning from seasoned veterans of a highly competitive field.',
        'insert job resp here',
        'insert job reqs here',
        'insert job benefits here',
        5, '21000', '24000', 4
);

INSERT INTO JOBS (EMP_ID, JOB_TITLE, JOB_LOCATION, JOB_LEVEL,
        JOB_DESC, JOB_RESP, JOB_REQS, JOB_BENEFIT, INDUSTRY_ID,
        JOB_SALARY_MIN, JOB_SALARY_MAX, JOB_TYPE) VALUES (
        3,'Nurse Staff', 'Manila', 2, 
        'Responsible for the delivery of patient care through the utilization of the nursing process and competency based nursing practice standards. He/ she is responsible for managing records, supplies and equipment. He/ she provides health education to patients and families, collaborates with other professional disciplines to ensure effective patient care delivery and the achievement of desired patient outcomes. Contributes to the provision of quality nursing care through continuous quality improvement.',
        'insert job resp here',
        'insert job reqs here',
        'insert job benefits here',
        2, '20000', '23000', 3
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

-- INSERT INTO USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES ('user3@gmail.com', 'user3', 1);
-- 
-- INSERT INTO USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES ('user4@gmail.com', 'user4', 1);
-- 
-- INSERT INTO JOBSEEKERS (USER_ID, SEEKER_FNAME, SEEKER_LNAME, SEEKER_ADDRESS, SEEKER_NUMBER) VALUES (4, 'JAY', 'AMBAL', 'PROJECT 6', 123);

-- SELECT * FROM JOBS INNER JOIN EMPLOYERS ON JOBS.EMP_ID = EMPLOYERS.EMP_ID INNER JOIN INDUSTRIES ON INDUSTRY_ID = IND_ID;