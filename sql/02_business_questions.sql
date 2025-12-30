-- =====================================
-- File: 02_business_questions.sql
-- Purpose: Answer key business questions using SQL
-- Dataset: Airbnb (Denver)
-- =====================================

-- Q2: What is the total number of Airbnb listings in the selected city?
SELECT 
  COUNT(*) AS total_listings
FROM listings;

-- Result: 413 listings

-- Q3: What is the total number of Airbnb hosts?
SELECT 
  COUNT(DISTINCT host_id) AS total_hosts
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

-- Note: This analysis was not meaningful due to limited population of the neighbourhood_group field (mostly NULL values).

-- Q5: What is the average Airbnb price per neighbourhood?
SELECT
  neighbourhood AS neighborhood,
  ROUND(AVG(price), 2) AS avg_price
FROM listings
WHERE price IS NOT NULL
GROUP BY neighbourhood
ORDER BY avg_price DESC;

-- Result: Significant price variation observed across neighbourhoods

-- Q6: Top 10 most visited neighbourhoods based on number of reviews
SELECT
  l.neighbourhood,
  COUNT(r.listing_id) AS total_reviews
FROM reviews r
JOIN listings l
  ON r.listing_id = l.id
GROUP BY l.neighbourhood
ORDER BY total_reviews DESC
LIMIT 10;

-- Note: Number of reviews is used as a proxy for visit popularity

-- Q7: Distribution of Airbnb listings per host
SELECT
  total_listings_per_owner,
  COUNT(host_id) AS number_of_hosts
FROM (
  SELECT
    host_id,
    COUNT(*) AS total_listings_per_owner
  FROM listings
  GROUP BY host_id
) t
GROUP BY total_listings_per_owner
ORDER BY total_listings_per_owner;

-- Q8: Number of Airbnb listings per neighbourhood
SELECT
  neighbourhood,
  COUNT(*) AS total_listings_per_neighbourhood
FROM listings
GROUP BY neighbourhood
ORDER BY total_listings_per_neighbourhood DESC;

-- Result: A small number of neighbourhoods concentrate most Airbnb listings, while the majority have limited supply.


-- Q9: Number of Airbnb Listings by Room Type
SELECT 
  room_type,
  COUNT(*) AS total_listings_per_room
FROM listings
GROUP BY room_type
ORDER BY total_listings_per_room DESC;

-- Result: Entire home/apartment listings dominate the market, suggesting limited prevalence of shared accommodation models.

-- Q10: Average Price by Room Type
SELECT 
  room_type,
  ROUND(AVG(price), 2) AS avg_price_per_room_type
FROM listings
WHERE price IS NOT NULL
GROUP BY room_type
ORDER BY avg_price_per_room_type DESC;


-- Result: Entire homes and hotel rooms have the highest average prices, while private and shared rooms are significantly cheaper.
-- Note: Price differences by room type highlight clear market segmentation based on accommodation offering.

