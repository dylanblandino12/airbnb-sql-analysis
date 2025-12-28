# airbnb-sql-analysis
SQL analysis of Airbnb data to identify pricing trends and investment opportunities

## Data Model

### Primary Key
The original CSV import did not define a primary key.  
After validating that the `id` column contains unique and non-null values, it was defined as the primary key to ensure data integrity and support joins across tables.
