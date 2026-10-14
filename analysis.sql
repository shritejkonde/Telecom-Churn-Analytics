-- 1. Overall churn rate
SELECT COUNT(*) AS customers,
       SUM(Churn) AS churned,
       ROUND(100.0 * SUM(Churn) / COUNT(*), 1) AS churn_pct
FROM customers;

-- 2. Churn rate by contract type
SELECT Contract, COUNT(*) AS customers,
       ROUND(100.0 * SUM(Churn) / COUNT(*), 1) AS churn_pct
FROM customers
GROUP BY Contract
ORDER BY churn_pct DESC;

-- 3. Rank payment methods by churn (window function)
SELECT PaymentMethod,
       ROUND(100.0 * SUM(Churn) / COUNT(*), 1) AS churn_pct,
       RANK() OVER (ORDER BY SUM(Churn) * 1.0 / COUNT(*) DESC) AS churn_rank
FROM customers
GROUP BY PaymentMethod;

-- 4. Churn by internet service
SELECT InternetService, COUNT(*) AS customers,
       ROUND(100.0 * SUM(Churn) / COUNT(*), 1) AS churn_pct
FROM customers
GROUP BY InternetService
ORDER BY churn_pct DESC;

-- 5. Monthly revenue lost to churn by tenure group
SELECT tenure_group,
       COUNT(*) AS churned_customers,
       ROUND(SUM(MonthlyCharges), 0) AS monthly_revenue_lost
FROM customers
WHERE Churn = 1
GROUP BY tenure_group
ORDER BY monthly_revenue_lost DESC;

-- 6. Contract types with above-average churn (CTE + join)
WITH contract_churn AS (
    SELECT Contract, 100.0 * SUM(Churn) / COUNT(*) AS churn_pct
    FROM customers GROUP BY Contract
),
overall AS (
    SELECT 100.0 * SUM(Churn) / COUNT(*) AS avg_churn FROM customers
)
SELECT c.Contract, ROUND(c.churn_pct, 1) AS churn_pct, ROUND(o.avg_churn, 1) AS overall_churn_pct
FROM contract_churn c JOIN overall o ON c.churn_pct > o.avg_churn;

-- 7. Highest-spending customers who churned (top 10)
SELECT customerID, tenure, MonthlyCharges, Contract
FROM customers
WHERE Churn = 1
ORDER BY MonthlyCharges DESC
LIMIT 10;
