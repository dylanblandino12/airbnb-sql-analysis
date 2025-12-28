-- =====================================
-- File: 02_business_questions.sql
-- Purpose: Answer key business questions using SQL
-- Dataset: Airbnb (Denver)
-- =====================================

-- Q2: What is the total number of Airbnb listings in the selected city?
SELECT COUNT(*) AS total_listings
FROM listings;

-- Result: 413 listings

-- Q3: What is the total number of Airbnb hosts?
SELECT COUNT(DISTINCT host_id) AS total_hosts
FROM listings;

-- Result: 339 unique hosts

-- Q4: What is the average Airbnb price per district?
SELECT
  neighbourhood_group AS district,
  ROUND(AVG(price), 2) AS avg_price
FROM listings
WHERE price IS NOT NULL
GROUP BY neighbourhood_group
ORDER BY avg_price DESC;

-- Result: Average prices vary significantly across districts

