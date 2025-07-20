DELIMITER //
CREATE PROCEDURE scd_type_1()
BEGIN
    UPDATE dim_customer d
    JOIN stg_customer s ON d.customer_id = s.customer_id
    SET d.name = s.name, d.address = s.address, d.city = s.city, d.state = s.state, d.zip = s.zip;

    INSERT INTO dim_customer (customer_id, name, address, city, state, zip)
    SELECT s.customer_id, s.name, s.address, s.city, s.state, s.zip
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id
    WHERE d.customer_id IS NULL;
END //
DELIMITER;