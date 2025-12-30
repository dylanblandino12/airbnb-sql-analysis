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

-- Q11: Average Price by Room Type and Neighbourhood
-- considering only groups with at least 3 listings
SELECT
  room_type,
  neighbourhood,
  ROUND(AVG(price), 2) AS avg_price,
  COUNT(*) AS listing_count
FROM listings
WHERE price IS NOT NULL
GROUP BY room_type, neighbourhood
HAVING COUNT(*) >= 3
ORDER BY room_type, avg_price DESC;

-- Result: Average prices vary significantly by room type and neighbourhood.
-- Note: Some high average prices may be driven by a small number of listings, which can introduce outliers in certain neighbourhoods.


-- Q12: Average Airbnb Availability by Neighbourhood

SELECT 
  neighbourhood,
  ROUND(AVG(availability_365)) AS avg_availability
FROM listings
GROUP BY neighbourhood
ORDER BY avg_availability DESC;

-- Result: Average availability varies significantly across neighbourhoods.
-- Note: High availability may indicate properties dedicated to year-round short-term rentals, while lower availability may reflect higher occupancy or more restricted hosting patterns.

-- Q13: Top 10 Listings by Number of Reviews

WITH reviews_cte AS(
SELECT
	l.id,
  l.name,
  COUNT(r.listing_id) AS total_reviews
FROM reviews r
JOIN listings l
  ON r.listing_id = l.id
GROUP BY l.id, l.name
ORDER BY total_reviews DESC),
ranking AS(
  SELECT 
    *, RANK() OVER (ORDER BY total_reviews DESC) AS rank_reviews
  FROM reviews_cte)
SELECT *
FROM ranking
WHERE rank_reviews <=10
ORDER BY
rank_reviews;

-- Results: The listings with the highest number of reviews show relatively similar engagement levels, suggesting no single listing dominates guest activity during the analyzed period.

-- Q14: Top 5 Neighbourhoods by Number of Airbnb Listings
WITH neighbourhood_cte AS (
  SELECT
    neighbourhood,
    COUNT(*) AS total_listings
  FROM listings
  GROUP BY neighbourhood
),
ranking AS (
  SELECT
    *,
    RANK() OVER (ORDER BY total_listings DESC) AS rank_neighbourhood
  FROM neighbourhood_cte
)
SELECT
  neighbourhood,
  total_listings,
  rank_neighbourhood
FROM ranking
WHERE rank_neighbourhood <= 5
ORDER BY rank_neighbourhood;

-- Results: A small number of neighbourhoods concentrate the highest number of Airbnb listings, suggesting a clear geographic clustering of short-term rentals within the city.

-- Q15: Top 5 Hosts by Number of Reviews

WITH reviews_cte AS(
SELECT
	l.host_id,
  l.host_name,
  COUNT(r.listing_id) AS total_reviews
FROM reviews r
JOIN listings l
  ON r.listing_id = l.id
GROUP BY l.host_id, l.host_name),
ranking AS(
	SELECT 
		*, RANK() OVER (ORDER BY total_reviews DESC) AS rank_reviews
	FROM reviews_cte)
SELECT 
  host_id,
  host_name,
  total_reviews,
  rank_reviews
FROM ranking
WHERE rank_reviews <=5
ORDER BY
rank_reviews;

-- Results: Hosts with the highest number of reviews show similar engagement levels, suggesting a competitive and evenly distributed hosting activity.

-- Q16: Top 10 Hosts with the Lowest Average Prices

WITH lower_price_cte AS(
SELECT
  host_id,
  host_name,
  ROUND(AVG(price),2) AS avg_price
FROM listings
GROUP BY host_id, host_name),
ranking AS(
	SELECT 
		*, RANK() OVER (ORDER BY avg_price ASC) AS rank_reviews
	FROM lower_price_cte)
SELECT 
	host_id,
	host_name,
	avg_price,
	rank_reviews
FROM ranking
WHERE rank_reviews <=10 AND avg_price IS NOT NULL
ORDER BY rank_reviews;

-- Results: Some hosts consistently offer significantly lower-priced listings, suggesting affordability-focused pricing strategies among certain owners.

-- Q17: Top 3 neighbourhoods by number of reviews

WITH reviews_cte AS(
SELECT
	l.neighbourhood,
  COUNT(r.listing_id) AS total_reviews
FROM reviews r
JOIN listings l
  ON r.listing_id = l.id
GROUP BY l.neighbourhood),
ranking AS(
	SELECT 
		*, RANK() OVER (ORDER BY total_reviews DESC) AS rank_neighbourhood
	FROM reviews_cte)
SELECT 
	neighbourhood,
	total_reviews,
    rank_neighbourhood
FROM ranking
WHERE rank_neighbourhood <=3
ORDER BY
rank_neighbourhood;

-- Results: A small number of neighbourhoods concentrate the highest volume of guest reviews, indicating higher visitor demand in these areas.


-- Final Insight:
-- Based on demand, pricing, and listing concentration, Five Points represents
-- the most attractive area for Airbnb investment due to consistent guest activity
-- and proven market demand.

