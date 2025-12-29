# airbnb-sql-analysis

![Project Workflow](images/airbnb_sql_project_overview.png)

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
- `neighbourhood_group` exists as a geographical attribute; however, its population in the listings table is limited and therefore not used for district-level analysis.

Foreign key constraints were not physically enforced, as this is an analytical dataset.


### Data Quality Notes

During validation, one listing was found with a `neighbourhood_group` value that does not match any record in the `neighbourhoods` table.  
This inconsistency was kept in the dataset and handled appropriately during analysis.

## Data Limitations

- The `neighbourhood_group` field in the listings table contains mostly null values, with only one populated district.
- Due to this limitation, district-level analysis was not meaningful for this dataset.
- The analysis focuses primarily on neighbourhood-level insights, where sufficient data granularity is available.


## SQL Files
- 00_schema_setup.sql
- 01_exploration.sql
- 02_business_questions.sql

## Key Findings

- The selected city has **413 active Airbnb listings**.
- The city has **413 Airbnb listings managed by 339 unique hosts**, indicating that some hosts operate multiple properties.
- Airbnb pricing varies by neighbourhood, with **Hampden showing the highest average prices**.


