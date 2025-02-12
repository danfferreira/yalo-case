   WITH details_data AS (
   ----------- Create a CTE for aggregates, since we need to breakdown by each single transaction------------------
   	
   SELECT 
        customer_id,
        order_id,
        MIN(purchase_timestamp) AS purchase_timestamp, 
        SUM(number_items) AS number_items, 
        SUM(purchase_price) AS purchase_price, 
        SUM(number_items * purchase_price) AS calculated_revenue 
    FROM public.test_order_details
    WHERE item_status = 'sold' 
    GROUP BY 
        customer_id, 
        order_id
)

SELECT 
    dd.customer_id,
    dd.order_id,
    dd.purchase_timestamp,
    dd.number_items,
    dd.purchase_price,
    dd.calculated_revenue,
    t.purchase_revenue AS order_purchase_revenue,
    (dd.calculated_revenue - t.purchase_revenue) AS revenue_difference 
FROM details_data dd
LEFT JOIN public.test_orders t 
    ON dd.customer_id = t.customer_id 
    AND dd.purchase_timestamp = t.purchase_date
WHERE dd.calculated_revenue <> t.purchase_revenue 
ORDER BY 
    dd.customer_id, 
    dd.order_id ASC;