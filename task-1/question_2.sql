SELECT 
    county,
    ROUND(SUM(sale_dollars),2) AS sales_total
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
GROUP BY county
HAVING SUM(sale_dollars) > 100000
ORDER BY sales_total DESC;


-- In case of a single transaction above USD 100k


WITH sales_invoice_above_100k AS(
    SELECT
        county,
        invoice_and_item_number,
        ROUND(SUM(sale_dollars),2) AS sales_total
    FROM `bigquery-public-data.iowa_liquor_sales.sales`
    GROUP BY county, invoice_and_item_number
    HAVING SUM(sale_dollars) > 100000
)

SELECT 
    DISTINCT (county)
FROM sales_invoice_above_100k;