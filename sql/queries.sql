USE biobank_db;

SELECT *
FROM donor;

SELECT *
FROM researcher;

SELECT *
FROM sample;



SELECT *
FROM donor
WHERE status = 'Active';

SELECT *
FROM sample
WHERE status = 'Available';

SELECT *
FROM researcher
WHERE department = 'Genetics';



SELECT *
FROM donor
ORDER BY registration_date DESC;

SELECT
    sample_code,
    initial_volume_ml,
    remaining_volume_ml,
    status
FROM sample
ORDER BY remaining_volume_ml DESC;



SELECT
    s.sample_code,
    st.type_name,
    s.initial_volume_ml,
    s.remaining_volume_ml,
    s.status
FROM sample AS s
JOIN sample_type AS st
    ON s.sample_type_id = st.sample_type_id;
    
    
    
    SELECT
    d.donor_code,
    d.sex,
    d.blood_type,
    ce.collection_date,
    ce.collection_site,
    s.sample_code,
    s.status
FROM donor AS d
JOIN collection_event AS ce
    ON d.donor_id = ce.donor_id
JOIN sample AS s
    ON ce.collection_id = s.collection_id;
    
    
    
    SELECT
    d.donor_code,
    s.sample_code,
    st.type_name,
    s.remaining_volume_ml,
    s.status
FROM donor AS d
JOIN collection_event AS ce
    ON d.donor_id = ce.donor_id
JOIN sample AS s
    ON ce.collection_id = s.collection_id
JOIN sample_type AS st
    ON s.sample_type_id = st.sample_type_id;
    
    
    
    SELECT
    r.researcher_code,
    r.first_name,
    r.last_name,
    rp.project_code,
    rp.project_name,
    rpj.project_role
FROM researcher AS r
JOIN researcher_project AS rpj
    ON r.researcher_id = rpj.researcher_id
JOIN research_project AS rp
    ON rpj.project_id = rp.project_id;
    
    
    
    
SELECT
    tr.test_request_id,
    s.sample_code,
    CONCAT(r.first_name, ' ', r.last_name) AS researcher_name,
    tt.test_name,
    tr.request_date,
    tr.completion_date,
    tr.status,
    tr.result
FROM test_request AS tr
JOIN sample AS s
    ON tr.sample_id = s.sample_id
JOIN researcher AS r
    ON tr.researcher_id = r.researcher_id
JOIN test_type AS tt
    ON tr.test_type_id = tt.test_type_id;
    
    
    
    SELECT
    COUNT(*) AS total_donors
FROM donor;

SELECT
    COUNT(*) AS total_samples
FROM sample;

SELECT
    COUNT(*) AS active_projects
FROM research_project
WHERE status = 'Active';



SELECT
    SUM(initial_volume_ml) AS total_initial_volume
FROM sample;

SELECT
    SUM(remaining_volume_ml) AS total_remaining_volume
FROM sample;



SELECT
    AVG(remaining_volume_ml) AS average_remaining_volume
FROM sample;



SELECT
    st.type_name,
    COUNT(s.sample_id) AS number_of_samples
FROM sample AS s
JOIN sample_type AS st
    ON s.sample_type_id = st.sample_type_id
GROUP BY st.type_name;

SELECT
    blood_type,
    COUNT(*) AS number_of_donors
FROM donor
GROUP BY blood_type;

SELECT
    status,
    COUNT(*) AS number_of_projects
FROM research_project
GROUP BY status;



SELECT
    blood_type,
    COUNT(*) AS number_of_donors
FROM donor
GROUP BY blood_type
HAVING COUNT(*) > 1;



SELECT
    sample_code,
    remaining_volume_ml
FROM sample
WHERE remaining_volume_ml >
(
    SELECT AVG(remaining_volume_ml)
    FROM sample
);



SELECT
    researcher_id,
    first_name,
    last_name
FROM researcher
WHERE researcher_id IN
(
    SELECT researcher_id
    FROM researcher_project
);




INSERT INTO researcher
(
    researcher_code,
    first_name,
    last_name,
    email,
    department,
    role
)
VALUES
(
    'TEST001',
    'Test',
    'Researcher',
    'test.researcher@biobank.com',
    'Testing',
    'Temporary'
);

SELECT *
FROM researcher
WHERE researcher_code = 'TEST001';

UPDATE researcher
SET department = 'Database Testing'
WHERE researcher_code = 'TEST001';

SELECT *
FROM researcher
WHERE researcher_code = 'TEST001';



UPDATE research_project
SET status = 'Active'
WHERE project_code = 'P010';

SELECT
    project_code,
    project_name,
    status
FROM research_project
WHERE project_code = 'P010';



DELETE FROM researcher
WHERE researcher_code = 'TEST001';

SELECT *
FROM researcher
WHERE researcher_code = 'TEST001';



SELECT
    (SELECT COUNT(*) FROM donor) AS total_donors,
    (SELECT COUNT(*) FROM sample) AS total_samples,
    (SELECT COUNT(*) FROM researcher) AS total_researchers,
    (SELECT COUNT(*) FROM research_project) AS total_projects,
    (SELECT COUNT(*) FROM test_request) AS total_test_requests;
    
    










