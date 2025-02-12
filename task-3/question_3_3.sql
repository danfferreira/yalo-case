WITH customer_revenue AS (
    SELECT 
        customer_id,
        SUM(CASE WHEN item_status = 'returned' THEN number_items * purchase_price ELSE 0 END) AS returned_revenue,
        SUM(CASE WHEN item_status = 'sold' THEN number_items * purchase_price ELSE 0 END) AS original_revenue,
        SUM(CASE WHEN item_status IN ('sold', 'returned') THEN number_items * purchase_price ELSE 0 END) AS potential_revenue,
        SUM(CASE WHEN item_status = 'returned' THEN number_items ELSE 0 END) AS total_items_returned
    FROM public.test_order_details
    GROUP BY customer_id
)

SELECT 
    customer_id,
    original_revenue,
    potential_revenue,
    (potential_revenue - original_revenue) AS additional_money,
    ROUND(
        ((potential_revenue - original_revenue) / NULLIF(original_revenue, 0)) * 100, 
        2
    ) AS percentage_increase,
    ROUND(original_revenue / NULLIF(total_items_returned, 0), 2) AS average_ticket_per_customer,
    total_items_returned,
    ROUND(returned_revenue / NULLIF(total_items_returned, 0), 2) AS average_ticket_per_customer_returned
FROM customer_revenue
ORDER BY customer_id;


-- Why I did this query.
-- It shows the average ticket of the purchase and of the returned items. This is a metric to understand the customer behavior.
 
-- These resoltus below are the output of the query above:

--customer_id|original_revenue|potential_revenue|additional_money|percentage_increase|average_ticket_per_customer|total_items_returned|average_ticket_per_customer_returned|
-----------+----------------+-----------------+----------------+-------------------+---------------------------+--------------------+------------------------------------+
--          1|           99.95|           123.65|           23.70|              23.71|                      33.32|                   3|                                7.90|
--          2|          158.15|           165.39|            7.24|               4.58|                     158.15|                   1|                                7.24|
--          3|          113.66|           182.50|           68.84|              60.57|                      28.42|                   4|                               17.21|

-- As we can see, customer 3 returned the most items and have the highest average ticket per customer in terms of returned items. While number 2, whoch have the highest ticket for bought items, 
-- have the lowest average ticket per customer in terms of returned items.
-- Considering this scenario, we should focus on the customer 3, since he is the one that is returning the most items and have the highest average ticket, applying some retention strategies, such small discounts in next purchases