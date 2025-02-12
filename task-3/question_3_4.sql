SELECT 
    t.*,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY purchase_date ASC) AS order_rn
FROM public.test_orders t;


-- Using the column order_rn makes the join much more safe
-- It is not a good practice to use a date as a join condition, since it is not guaranteed that the date will be unique
-- Specially a timestamp, which have a deeper detail and any issue in a queue service could make the timestamp to be duplicated or breaking the join condition
-- Using the transaction order, as whe have in the other table, makes it safer to join the tables