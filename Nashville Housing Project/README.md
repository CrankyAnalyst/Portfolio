# Report

Summary

This report outlines the data cleaning and transformation process performed on the nashville_housing dataset. The objective of this project was to ensure data quality and consistency for further analysis. The process involved identifying missing data, splitting and reformatting columns, and removing duplicates. This report provides an overview of the SQL queries and actions taken to achieve these goals.

Data Verification

Query 1: Verifying Data Import
The first SQL query, SELECT * FROM nashville_housing, was executed to ensure that all data was successfully imported. This query provides a quick overview of the dataset's structure.

Query 2: Populating 'propertyaddress' Data
The second query, SELECT propertyaddress FROM nashville_housing, extracted data from the propertyaddress column, allowing us to examine its contents.

Query 3: Identifying Missing Data
Query 3, SELECT * FROM nashville_housing WHERE propertyaddress IS NULL, was used to identify rows with missing propertyaddress values. These missing values were flagged for further attention.

Data Transformation

Query 4: Analyzing Rows with the Same Parcel ID
The fourth query, SELECT * FROM nashville_housing ORDER BY parcelid, was executed to identify rows with the same parcel ID. This analysis revealed potential duplicate records.

Query 5: Combining Data from Duplicate Rows
Query 5 involved a self-join operation on the nashville_housing table to combine data from duplicate rows with different unique IDs but the same parcel ID. The COALESCE function was used to prioritize non-null values during the combination.

Query 6: Updating Missing 'propertyaddress'
The sixth query aimed to update missing propertyaddress values. It utilized a subquery (source) to find distinct non-null propertyaddress values by parcelid and then applied these values to rows with missing propertyaddress values in the main table (target).

Query 7: Splitting 'propertyaddress'
The next set of queries, Queries 7, 8, and 9, focused on breaking down the propertyaddress column into separate columns for address and city. This process involved string manipulation functions like SUBSTRING and STRPOS to extract the desired information.

Query 10: Splitting 'owneraddress'
Similar to the previous step, Queries 10, 11, and 12 split the owneraddress column into individual columns for address, city, and state.

Data Quality Assurance

Query 13: Identifying Distinct 'soldasvacant' Values
Query 13, SELECT DISTINCT(soldasvacant), COUNT(soldasvacant) FROM nashville_housing GROUP BY soldasvacant ORDER BY COUNT(soldasvacant), was used to identify distinct values in the soldasvacant column and count their occurrences. This helped ensure data consistency and identify any anomalies.

Query 14: Changing 'Y' and 'N' to 'Yes' and 'No'
Queries 14 and 15 aimed to improve data clarity by changing 'Y' and 'N' values in the soldasvacant column to 'Yes' and 'No' using a CASE statement.
Data Deduplication

Queries 16 and 17: Removing Duplicates
Queries 16 and 17 were designed to identify and remove duplicate rows from the dataset. A Common Table Expression (CTE) was used to assign row numbers to records based on certain criteria. Rows with row numbers greater than 1 were considered duplicates and were subsequently deleted from the main table.

Data Cleanup

Query 18: Deleting Unused Columns
The final query, ALTER TABLE nashville_housing DROP COLUMN owneraddress, DROP COLUMN propertyaddress, removed the owneraddress and propertyaddress columns that were no longer needed, thereby reducing data redundancy.

Conclusion
The data cleaning and transformation process successfully improved the quality and structure of the nashville_housing dataset. This prepared dataset is now ready for further analysis and reporting. The use of SQL queries and careful data manipulation techniques was instrumental in achieving these results.
