USE biobank_db;

SHOW TABLES;


SELECT *
FROM donor;


SELECT
    d.donor_code,
    d.sex,
    d.blood_type,
    s.sample_code,
    st.type_name AS sample_type,
    s.status AS sample_status
FROM donor AS d
JOIN collection_event AS ce
    ON d.donor_id = ce.donor_id
JOIN sample AS s
    ON ce.collection_id = s.collection_id
JOIN sample_type AS st
    ON s.sample_type_id = st.sample_type_id;
    
    
    
    SELECT
    r.researcher_code,
    CONCAT(r.first_name, ' ', r.last_name) AS researcher_name,
    rp.project_code,
    rp.project_name,
    rpj.project_role
FROM researcher AS r
JOIN researcher_project AS rpj
    ON r.researcher_id = rpj.researcher_id
JOIN research_project AS rp
    ON rpj.project_id = rp.project_id;
    
    
    
    SELECT
    d.donor_code,
    COUNT(s.sample_id) AS number_of_samples
FROM donor AS d
JOIN collection_event AS ce
    ON d.donor_id = ce.donor_id
JOIN sample AS s
    ON ce.collection_id = s.collection_id
GROUP BY
    d.donor_id,
    d.donor_code;
    
    
    SELECT
    sample_code,
    remaining_volume_ml
FROM sample
WHERE remaining_volume_ml >
(
    SELECT AVG(remaining_volume_ml)
    FROM sample
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
    'EVIDENCE001',
    'Evidence',
    'Test',
    'evidence.test@biobank.com',
    'Testing',
    'Temporary'
);

SELECT *
FROM researcher
WHERE researcher_code = 'EVIDENCE001';




UPDATE researcher
SET department = 'Biomedical Research'
WHERE researcher_code = 'EVIDENCE001';

SELECT *
FROM researcher
WHERE researcher_code = 'EVIDENCE001';



DELETE FROM researcher
WHERE researcher_code = 'EVIDENCE001';

SELECT *
FROM researcher
WHERE researcher_code = 'EVIDENCE001';



SELECT *
FROM donor_sample_view;

SELECT *
FROM test_request_view;


CALL get_donor_samples(1);


SHOW TRIGGERS;

