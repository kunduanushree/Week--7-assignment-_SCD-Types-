DELIMITER //
CREATE PROCEDURE scd_type_4()
BEGIN
    -- 1. Insert old versions of changed records into dim_customer_history
    INSERT INTO dim_customer_history
    SELECT
        d.customer_id,
        d.name,
        d.address,
        d.city,
        d.state,
        d.zip,
        d.prev_address, 
        d.effective_date,
        d.end_date,
        d.current_flag,
        d.version
    FROM dim_customer d
    JOIN stg_customer s ON d.customer_id = s.customer_id
    WHERE d.name <> s.name OR d.address <> s.address;

    -- 2. Update existing records in dim_customer with new current values
    UPDATE dim_customer d
    JOIN stg_customer s ON d.customer_id = s.customer_id
    SET
        d.name = s.name,         
        d.address = s.address,   
        d.city = s.city,         
        d.state = s.state,      
        d.zip = s.zip            
    WHERE d.name <> s.name OR d.address <> s.address;

    -- 3. Insert new records into dim_customer
    INSERT INTO dim_customer (customer_id, name, address, city, state, zip)
    SELECT s.customer_id, s.name, s.address, s.city, s.state, s.zip
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id
    WHERE d.customer_id IS NULL;
END //
DELIMITER;
