-- IMPORTANT: I considered Revenue the Net revenue, so we can have deeper information about the profit of the company.

WITH quarterly_revenue AS (
  SELECT 
    CONCAT(EXTRACT(YEAR FROM date), '-', EXTRACT(QUARTER FROM date)) AS date_quarter,
    ROUND(SUM((state_bottle_retail - state_bottle_cost) * bottles_sold), 2) AS net_revenue
  FROM `bigquery-public-data.iowa_liquor_sales.sales`
  GROUP BY date_quarter
)

SELECT 
  date_quarter,
  net_revenue,
  ROUND(AVG(net_revenue) OVER (), 2) AS global_avg_revenue,
  CASE WHEN net_revenue > (ROUND(AVG(net_revenue) OVER (), 2)*1.1) THEN "Above 10%" ELSE "-" END AS above_10_check 
FROM quarterly_revenue
ORDER BY date_quarter DESC;
