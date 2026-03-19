CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

SELECT * 
FROM job_applied;

-- insert  rows in table
INSERT INTO job_applied 
            (job_id,
            application_sent_date,
            custom_resume,
            resume_file_name,
            cover_letter_sent,
            cover_letter_file_name,
            status)
VALUES      (1,
            '2024-02-01',
            true,
            'resume_01.pdf',
            true,
            'cover_letter_01.pdf',
            'submitted'),
            (2,
            '2024-02-05',
            false,
            'resume_generic.pdf',
            false,
            NULL,
            'submitted'),
            (3,
            '2024-02-10',
            true,
            'resume_03.pdf',
            true,
            'cover_letter_03.pdf',
            'interview_scheduled'),
            (4,
            '2024-02-15',
            false,
            'resume_generic.pdf',
            false,
            NULL,
            'rejected');

SELECT *
FROM job_applied;

-- add column
ALTER TABLE job_applied
ADD COLUMN contact VARCHAR(50);

-- conditional update       
UPDATE job_applied
SET contact = 'Jane Doe'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Susan Collins'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Nate Archibald'
WHERE job_id = 4;

SELECT *
FROM job_applied;

-- rename col name
ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

-- change col data type
ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

--remove column
ALTER TABLE job_applied 
DROP COLUMN contact_name;

-- remove table
DROP TABLE job_applied;