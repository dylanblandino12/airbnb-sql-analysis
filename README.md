# airbnb-sql-analysis
SQL analysis of Airbnb data to identify pricing trends and investment opportunities

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
