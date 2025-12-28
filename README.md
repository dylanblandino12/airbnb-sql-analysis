# airbnb-sql-analysis
SQL analysis of Airbnb data to identify pricing trends and investment opportunities

## Dataset
Source: Inside Airbnb  
https://insideairbnb.com/denver/

### Data Scope
- The original dataset contains historical data across multiple years.
- Due to size constraints, only reviews from **September 2025** were used in this analysis.

## Data Model

### Primary Key
The original CSV import did not define a primary key.  
After validating that the `id` column contains unique and non-null values, it was defined as the primary key to ensure data integrity and support joins across tables.

## Data Model & Relationships

- `listings.id` is the primary key of the listings table.
- `reviews.listing_id` acts as a logical foreign key referencing `listings.id`.
- `neighbourhoods.neighbourhood_group` acts as a logical primary key for neighbourhood classification.
- `listings.neighbourhood_group` acts as a logical foreign key referencing `neighbourhoods.neighbourhood_group`.

Foreign key constraints were not physically enforced, as this is an analytical dataset.


### Data Quality Notes

During validation, one listing was found with a `neighbourhood_group` value that does not match any record in the `neighbourhoods` table.  
This inconsistency was kept in the dataset and handled appropriately during analysis.

## SQL Files
- 00_schema_setup.sql
- 01_exploration.sql
- 02_business_questions.sql

## Key Findings

- The selected city has **413 active Airbnb listings**.

- The city has **413 Airbnb listings managed by 339 unique hosts**, indicating that some hosts operate multiple properties.
