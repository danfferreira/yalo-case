-- IMPORTANT: I considered Revenue the Net revenue, so we can have deeper information about the profit of the company.

WITH store_revenue AS (
  SELECT 
    store_name,
    ROUND(SUM((state_bottle_retail - state_bottle_cost) * bottles_sold), 2) AS net_revenue,
 FROM `bigquery-public-data.iowa_liquor_sales.sales` 
 GROUP BY store_name
),

ranked_table AS (
SELECT
  store_name,
  net_revenue,
  ROW_NUMBER() OVER (ORDER BY net_revenue DESC) AS rn_revenue,
  'Top 10' AS Ranking
  FROM store_revenue
  QUALIFY rn_revenue BETWEEN 1 AND 10

  UNION ALL

SELECT
  store_name,
  net_revenue,
  ROW_NUMBER() OVER (ORDER BY net_revenue ASC) AS rn_revenue,
  'Bottom 10' AS Ranking
  FROM store_revenue 
  QUALIFY rn_revenue BETWEEN 1 AND 10
)

SELECT
  store_name,
  CASE 
    WHEN Ranking = 'Top 10' THEN CONCAT ("Top ", rn_revenue, " revenue" )
    WHEN Ranking = 'Bottom 10' THEN CONCAT ("Bottom ", rn_revenue, " revenue" )
  END AS ranking  
FROM ranked_table
