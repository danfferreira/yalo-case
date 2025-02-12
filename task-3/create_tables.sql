DROP TABLE IF EXISTS test_orders;

CREATE TABLE test_orders 
(
    customer_id INT,
    purchase_date TIMESTAMP,
    purchase_revenue DECIMAL(10,2)
);

DROP TABLE IF EXISTS test_order_details;

CREATE TABLE test_order_details (
    customer_id INT,
    order_id INT,
    purchase_timestamp TIMESTAMP,
    number_items INT,
    purchase_price DECIMAL(10,2),
    item_status VARCHAR(20)
);