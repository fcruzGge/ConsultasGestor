SELECT id, created
FROM bb_courses_gradebook_columns_attempts
ORDER BY id ASC
LIMIT 1000;

SELECT id,courseid,bbid,columnid,userid,status,score,attemptdate,attemptreceipt_submissiondate,modified
FROM bb_courses_gradebook_columns_attempts
WHERE created >= '2025-09-29' OR modified >= '2025-09-29' OR attemptreceipt_submissiondate >= '2025-09-29'
LIMIT 10

SELECT created, modified, attemptreceipt_submissiondate 
FROM bb_courses_gradebook_columns_attempts
ORDER BY id DESC
LIMIT 100;

SELECT id,courseid,bbid,columnid,userid,status,score,attemptdate,attemptreceipt_submissiondate,modified
FROM bb_courses_gradebook_columns_attempts
WHERE created >= '2025-10-07'
LIMIT 100

SHOW CREATE TABLE bb_courses_gradebook_columns_attempts;

SHOW INDEX FROM bb_courses_gradebook_columns_attempts;

SELECT id, created
FROM bb_courses_gradebook_columns_attempts
WHERE id = 2800000;


