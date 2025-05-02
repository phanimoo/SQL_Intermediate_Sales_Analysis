WITH cohort_year AS (
SELECT
	DATE_TRUNC('month', orderdate)::date AS year_month,
	SUM(total_net_revenue) AS total_revenue,
	COUNT(DISTINCT customerkey) AS total_customers,
	SUM(total_net_revenue) / COUNT(DISTINCT customerkey) AS avg_rev_customer
FROM cohort_analysis
GROUP BY year_month
ORDER BY year_month 
)

SELECT
	year_month,
	total_revenue,
	avg_rev_customer,
	AVG(total_revenue) OVER (ORDER BY year_month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS roll_avg_3mo_total_rev,
	AVG(total_customers) OVER (ORDER BY year_month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS roll_avg_3mo_total_cus,
	AVG(avg_rev_customer) OVER (ORDER BY year_month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS roll_avg_3mo_rev_cus
FROM cohort_year