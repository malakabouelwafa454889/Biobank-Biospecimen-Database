USE biobank_db;

-- DONOR SAMPLE INFORMATION
CREATE OR REPLACE VIEW donor_sample_view AS
SELECT
    d.donor_id,
    d.donor_code,
    d.sex,
    d.blood_type,
    d.status AS donor_status,
    s.sample_id,
    s.sample_code,
    st.type_name AS sample_type,
    s.initial_volume_ml,
    s.remaining_volume_ml,
    s.status AS sample_status,
    ce.collection_date,
    ce.collection_site
FROM donor AS d
JOIN collection_event AS ce
    ON d.donor_id = ce.donor_id
JOIN sample AS s
    ON ce.collection_id = s.collection_id
JOIN sample_type AS st
    ON s.sample_type_id = st.sample_type_id;
    
    
    SELECT *
FROM donor_sample_view;




-- TEST REQUEST INFORMATION
CREATE OR REPLACE VIEW test_request_view AS
SELECT
    tr.test_request_id,
    s.sample_code,
    CONCAT(r.first_name, ' ', r.last_name) AS researcher_name,
    r.department,
    tt.test_name,
    tt.standard_unit,
    tr.request_date,
    tr.completion_date,
    tr.result,
    tr.status AS test_status
FROM test_request AS tr
JOIN sample AS s
    ON tr.sample_id = s.sample_id
JOIN researcher AS r
    ON tr.researcher_id = r.researcher_id
JOIN test_type AS tt
    ON tr.test_type_id = tt.test_type_id;
    
    SELECT *
FROM test_request_view;



