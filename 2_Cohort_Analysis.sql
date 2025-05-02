SELECT
	cohort_year,
	COUNT(DISTINCT customerkey) AS total_customers,
	SUM(total_net_revenue) AS total_revenue
FROM cohort_analysis
GROUP BY
	cohort_year