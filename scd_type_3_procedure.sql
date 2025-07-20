DELIMITER //
CREATE PROCEDURE scd_type_3()
BEGIN
    UPDATE dim_customer d
    JOIN stg_customer s ON d.customer_id = s.customer_id
    SET d.prev_address = d.address, d.address = s.address
    WHERE d.address <> s.address;

    INSERT INTO dim_customer (customer_id, name, address, prev_address, city, state, zip)
    SELECT s.customer_id, s.name, s.address, NULL, s.city, s.state, s.zip
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id
    WHERE d.customer_id IS NULL;
END //
DELIMITER;