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
    EMP_OVERVIEW VARCHAR(800),
    EMP_ADDRESS VARCHAR(50),
    EMP_NUMBER VARCHAR(50)
);

CREATE TABLE JOBSEEKERS(
    SEEKER_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    USER_ID INTEGER references USERS(USER_ID) ON DELETE CASCADE,
    SEEKER_FNAME VARCHAR(50),
    SEEKER_LNAME VARCHAR(50),
    SEEKER_ADDRESS VARCHAR(50),
    SEEKER_NUMBER VARCHAR(50)
);

CREATE TABLE JOBS(
    JOB_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    EMP_ID INTEGER references EMPLOYERS(EMP_ID),
    JOB_TITLE VARCHAR(50),
    JOB_LOCATION VARCHAR(100),
    JOB_LEVEL INTEGER references LEVELS(LEVEL_ID),
    JOB_DESC VARCHAR(500),
    JOB_RESP VARCHAR(500),
    JOB_REQS VARCHAR(500),
    JOB_BENEFIT VARCHAR(500),
    INDUSTRY_ID INTEGER references INDUSTRIES(IND_ID),
    JOB_SALARY_MIN VARCHAR(50),    
    JOB_SALARY_MAX VARCHAR(50),
    JOB_TYPE INTEGER references TYPES(TYPE_ID),
    JOB_ISACTIVE INT DEFAULT 0
);

CREATE TABLE APPLICATIONS(
    APP_ID INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    SEEKER_ID INTEGER REFERENCES JOBSEEKERS(SEEKER_ID),
    JOB_ID INTEGER REFERENCES JOBS(JOB_ID),
    APP_STATUS INT DEFAULT 0,
    APP_REMARKS VARCHAR(500)
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
    VALUES (4, 'EMPLOYER 1','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum', 'MANILA', '12345678912');
INSERT INTO EMPLOYERS (USER_ID, EMP_NAME, EMP_OVERVIEW, EMP_ADDRESS, EMP_NUMBER)
    VALUES (5, 'EMPLOYER 2','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum', 'MANILA', '12345678912');
INSERT INTO EMPLOYERS (USER_ID, EMP_NAME, EMP_OVERVIEW, EMP_ADDRESS, EMP_NUMBER)
    VALUES (6, 'EMPLOYER 3','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum', 'MANILA', '12345678912');


INSERT INTO JOBS (EMP_ID, JOB_TITLE, JOB_LOCATION, JOB_LEVEL,
        JOB_DESC, JOB_RESP, JOB_REQS, JOB_BENEFIT, INDUSTRY_ID,
        JOB_SALARY_MIN, JOB_SALARY_MAX, JOB_TYPE) VALUES 
        (1,'Junior Web Developer', 'Manila', 0, 'TITE', 'TITE', 'TITE','TITE', 1, '22000', '25000', 1
);







--APP STATUSES
--0 = PENDING
--1 = ACCEPTED
--3 = REJECTED

--JOB TYPES
--0 = FRESH GRAD
--1 = CONTRACTUAL
--2 = INTERNSHIP
--3 = PART-TIME
--4 = FULL TIME

--JOB LEVEL

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