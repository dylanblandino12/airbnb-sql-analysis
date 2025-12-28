-- ==============================
-- Dataset Exploration
-- ==============================

-- Validate primary key candidate

-- Query to identify null ids
SELECT COUNT(*) AS null_id_count
FROM listings
WHERE id IS NULL;

--Query to idenify duplicate ids
SELECT id, COUNT(*) AS occurrences
FROM listings
GROUP BY id
HAVING COUNT(*) > 1;

-- Total number of listings
SELECT COUNT(*) AS total_listings
FROM listings;
