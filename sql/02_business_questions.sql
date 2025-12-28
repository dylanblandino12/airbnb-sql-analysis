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

