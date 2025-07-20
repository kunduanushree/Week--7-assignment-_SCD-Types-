DELIMITER //
CREATE PROCEDURE scd_type_2()
BEGIN
    UPDATE dim_customer d
    JOIN stg_customer s ON d.customer_id = s.customer_id
    SET d.end_date = CURDATE(), d.current_flag = 0
    WHERE d.current_flag = 1 AND (d.name <> s.name OR d.address <> s.address);

    INSERT INTO dim_customer (customer_id, name, address, city, state, zip, effective_date, end_date, current_flag, version)
    SELECT s.customer_id, s.name, s.address, s.city, s.state, s.zip, CURDATE(), NULL, 1, COALESCE(d.version, 0) + 1
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id AND d.current_flag = 1
    WHERE d.customer_id IS NULL OR (d.name <> s.name OR d.address <> s.address);
END //
DELIMITER;