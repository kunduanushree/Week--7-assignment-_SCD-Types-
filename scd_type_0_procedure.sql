DELIMITER //
CREATE PROCEDURE scd_type_0()
BEGIN
    INSERT INTO dim_customer (customer_id, name, address, city, state, zip)
    SELECT s.customer_id, s.name, s.address, s.city, s.state, s.zip
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id
    WHERE d.customer_id IS NULL;
END //
DELIMITER;