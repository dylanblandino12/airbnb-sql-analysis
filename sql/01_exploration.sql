-- File: 01_exploration.sql
-- Description: Initial exploration and data quality validation
-- Dataset: Airbnb (Denver)
-- Notes: Focused on understanding structure and relationships

-- Validate primary key candidate

-- Query to identify null ids
SELECT COUNT(*) AS null_id_count
FROM listings
WHERE id IS NULL;

-- Query to identify duplicate ids
SELECT id, COUNT(*) AS duplicates
FROM listings
GROUP BY id
HAVING COUNT(*) > 1;

-- Total number of listings
SELECT COUNT(*) AS total_listings
FROM listings;

-- Validate logical FK: listings.neighbourhood_group → neighbourhoods.neighbourhood_group
SELECT COUNT(*) AS orphan_listings
FROM listings l
LEFT JOIN neighbourhoods n
  ON l.neighbourhood_group = n.neighbourhood_group
WHERE n.neighbourhood_group IS NULL;
-- Result: 1 orphan listing detected


-- Row counts
SELECT COUNT(*) AS total_listings FROM listings;
SELECT COUNT(*) AS total_reviews FROM reviews;
SELECT COUNT(*) AS total_neighbourhoods FROM neighbourhoods;

-- Check NULLs in key analytical columns
SELECT
  SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price,
  SUM(CASE WHEN neighbourhood_group IS NULL THEN 1 ELSE 0 END) AS null_neighbourhood_group
FROM listings;
