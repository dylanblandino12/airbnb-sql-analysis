-- ==============================
-- Dataset Exploration
-- ==============================

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
