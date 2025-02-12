WITH customer_revenue_data AS (
    SELECT 
        customer_id,
        SUM(CASE WHEN item_status = 'sold' THEN number_items * purchase_price ELSE 0 END) AS original_revenue,  -- I consider this the original revenue, mostly because this is the sales that went invoiced
        SUM(CASE WHEN item_status IN ('sold', 'returned') THEN number_items * purchase_price ELSE 0 END) AS potential_revenue -- Original premise: the customer would take everything
    FROM public.test_order_details
    GROUP BY customer_id
)

SELECT 
    customer_id,
    original_revenue,
    potential_revenue,
    (potential_revenue - original_revenue) AS additional_revenue,
    ROUND(((potential_revenue - original_revenue) / NULLIF(original_revenue, 0)) * 100, 2 )  AS increased_percentage
FROM customer_revenue_data
ORDER BY customer_id;