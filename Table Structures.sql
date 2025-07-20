CREATE TABLE dim_customer (
    customer_id INT,
    name VARCHAR(100),
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    zip VARCHAR(10),
    prev_address VARCHAR(200),
    effective_date DATE,
    end_date DATE,
    current_flag BOOLEAN DEFAULT 1,
    version INT DEFAULT 1
);

CREATE TABLE stg_customer (
    customer_id INT,
    name VARCHAR(100),
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    zip VARCHAR(10)
);

CREATE TABLE dim_customer_history AS
SELECT * FROM dim_customer WHERE 1=0; 