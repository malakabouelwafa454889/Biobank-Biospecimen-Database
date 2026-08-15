USE biobank_db;

DELIMITER $$

CREATE TRIGGER check_sample_usage_volume
BEFORE INSERT ON sample_usage
FOR EACH ROW
BEGIN

    DECLARE available_volume DECIMAL(10,2);

    SELECT remaining_volume_ml
    INTO available_volume
    FROM sample
    WHERE sample_id = NEW.sample_id;

    IF available_volume IS NULL THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sample does not exist.';

    ELSEIF NEW.volume_used_ml <= 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Volume used must be greater than zero.';
ELSEIF NEW.volume_used_ml > available_volume THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Requested volume exceeds the remaining sample volume.';

    END IF;

END$$

DELIMITER ;




INSERT INTO sample_usage
(
    sample_id,
    researcher_id,
    project_id,
    usage_date,
    volume_used_ml,
    purpose,
    notes
)
VALUES
(
    1,
    1,
    1,
    '2026-08-15',
    100.00,
    'Trigger Test',
    'Testing excessive sample usage'
);



INSERT INTO sample_usage
(
    sample_id,
    researcher_id,
    project_id,
    usage_date,
    volume_used_ml,
    purpose,
    notes
)
VALUES
(
    1,
    1,
    1,
    '2026-08-15',
    2.00,
    'Valid Trigger Test',
    'Testing valid sample usage'
);





DELIMITER $$

CREATE PROCEDURE get_donor_samples(IN p_donor_id INT)
BEGIN

    SELECT
        d.donor_code,
        d.sex,
        d.blood_type,
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
        ON s.sample_type_id = st.sample_type_id
    WHERE d.donor_id = p_donor_id;

END$$

DELIMITER ;


CALL get_donor_samples(1);
CALL get_donor_samples(5);


SHOW TRIGGERS;
