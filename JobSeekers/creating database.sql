--creating database

CREATE TABLE companies (
    company_id serial,
    company_name varchar(255) NOT NULL,
    website varchar(255),
    industry varchar(255),
    city varchar(255),
    state varchar(255),
    country varchar(255),
    PRIMARY KEY (company_id)
);

CREATE TABLE jobs (
    job_id serial,
    title varchar(255),
    description text,
    requirements text,
    salary numeric(10,2),
    work_schedule varchar(50),
    employment_type varchar(50),
    company_id int,
    PRIMARY KEY (job_id),
    CONSTRAINT fk_jobs_companies
    FOREIGN KEY (company_id)
    REFERENCES companies(company_id)
);

CREATE TABLE applicants (
    applicant_id serial,
    full_name varchar(255),
    country varchar(100),
    email varchar(100),
    phone_number varchar(20),
    skills text,
    work_experience text,
    education text,
    PRIMARY KEY (applicant_id)
);

CREATE TABLE applications (
    application_id serial,
    job_id integer,
    applicant_id integer,
    application_status text,
    PRIMARY KEY (application_id),
    CONSTRAINT fk_applications_jobs
    FOREIGN KEY (job_id)
    REFERENCES jobs(job_id),
    CONSTRAINT fk_applications_applicant
    FOREIGN KEY (applicant_id)
    REFERENCES applicants(applicant_id)
);

-- then I fill it with data previously randomly generated on www.mockaroo.com, as follows

COPY companies(company_name,website,industry,city,state,country)
FROM 'E:\MOCK_companies.csv'
DELIMITER ','
CSV HEADER; 

COPY jobs(title, description, requirements, salary, work_schedule, employment_type, company_id) 
FROM 'E:\MOCK_jobs.csv' 
DELIMITER ',' 
CSV HEADER;

COPY applicants(full_name, country, email, phone_number, skills, work_experience, education) 
FROM 'E:\MOCK_applicants.csv' 
DELIMITER ',' 
CSV HEADER;

COPY applications(job_id, applicant_id, application_status) 
FROM 'E:\MOCK_applications.csv' 
DELIMITER ',' 
CSV HEADER;

