
-- =====================================
-- Schema setup and data preparation
-- =====================================

-- Define primary key for listings
ALTER TABLE listings
ADD PRIMARY KEY (id);

-- =====================================
-- Logical Relationships (Not Enforced)
-- =====================================
-- reviews.listing_id → listings.id
-- listings.neighbourhood_group → neighbourhoods.neighbourhood_group
--
-- Foreign key constraints are not enforced
-- as this is an analytical dataset.
