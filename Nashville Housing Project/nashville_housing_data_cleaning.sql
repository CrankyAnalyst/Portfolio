-- Verifying if it imported everything. Checking the data.
SELECT * FROM nashville_housing

-- Populate 'propertyaddress' data
SELECT propertyaddress 
FROM nashville_housing

SELECT * 
FROM nashville_housing
WHERE propertyaddress IS NULL

-- Same parcelid. 
SELECT * 
FROM nashville_housing
ORDER BY parcelid

-- Self joining table, it's not the same unique ID 
SELECT nashville_a.parcelid, nashville_a.propertyaddress, nashville_b.parcelid, nashville_b.propertyaddress, COALESCE(nashville_a.propertyaddress, nashville_b.propertyaddress) AS combined_address 
FROM nashville_housing AS nashville_a
JOIN nashville_housing AS nashville_b
ON nashville_a.parcelid = nashville_b.parcelid AND nashville_a.uniqueid <> nashville_b.uniqueid
WHERE nashville_a.propertyaddress IS NULL

-- Updating the table
UPDATE nashville_housing AS target
SET propertyaddress = COALESCE(source.propertyaddress, target.propertyaddress)
FROM (
    SELECT DISTINCT ON (parcelid) parcelid, propertyaddress
    FROM nashville_housing
    WHERE propertyaddress IS NOT NULL
) AS source
WHERE target.parcelid = source.parcelid
  AND target.propertyaddress IS NULL;

-- Breaking out propertyaddress into individual columns(address, city)
SELECT propertyaddress 
FROM nashville_housing

SELECT 
	SUBSTRING(propertyaddress, 1, strpos(propertyaddress,',') -1) AS address, 
	SUBSTRING(propertyaddress, strpos(propertyaddress,',') +1, LENGTH(propertyaddress)) AS city
FROM nashville_housing

ALTER TABLE nashville_housing
ADD COLUMN property_split_address text,
ADD COLUMN property_split_city text;

UPDATE nashville_housing
SET 
    property_split_address = SUBSTRING(propertyaddress, 1, strpos(propertyaddress, ',') - 1),
    property_split_city = SUBSTRING(propertyaddress, strpos(propertyaddress, ',') + 1, LENGTH(propertyaddress));

-- Checking the table
SELECT * FROM nashville_housing

-- Breaking out owneraddress into individual columns(address, city, state)
SELECT owneraddress,
	SPLIT_PART(owneraddress, ',',1) AS owneraddress_split_address,
	SPLIT_PART(owneraddress, ',',2) AS owneraddress_split_city,
	SPLIT_PART(owneraddress, ',',3) AS owneraddress_split_state
FROM nashville_housing;

ALTER TABLE nashville_housing
ADD COLUMN owneraddress_split_address text,
ADD COLUMN owneraddress_split_city text,
ADD COLUMN owneraddress_split_state text;

UPDATE nashville_housing
SET 
    owneraddress_split_address = SPLIT_PART(owneraddress, ',', 1),
    owneraddress_split_city = SPLIT_PART(owneraddress, ',', 2),
    owneraddress_split_state = SPLIT_PART(owneraddress, ',', 3);

-- Checking the table
SELECT * FROM nashville_housing

SELECT DISTINCT(soldasvacant), COUNT(soldasvacant)
FROM nashville_housing
GROUP BY soldasvacant
ORDER BY COUNT(soldasvacant)

-- Changing 'Y' and 'N' to 'Yes' and 'No' with CASE statement
SELECT soldasvacant,
 CASE 
 	WHEN soldasvacant = 'Y' THEN 'Yes'
	WHEN soldasvacant = 'N' THEN 'No'
	ELSE soldasvacant
	END
FROM nashville_housing

UPDATE nashville_housing
SET soldasvacant = 
	CASE 
 		WHEN soldasvacant = 'Y' THEN 'Yes'
		WHEN soldasvacant = 'N' THEN 'No'
		ELSE soldasvacant
	END;

-- Checking the table
SELECT DISTINCT(soldasvacant), COUNT(soldasvacant)
FROM nashville_housing
GROUP BY soldasvacant
ORDER BY COUNT(soldasvacant)


-- Removing duplicates (A standard parctice is to create a temp table that removes the duplicates)
-- Creating a CTE in order to make it easier to look where the number 2 is (WHERE CLAUSE)
WITH row_num_cte AS(
SELECT *, 
	ROW_NUMBER() OVER(
	PARTITION BY parcelid,propertyaddress, saleprice, saledate, legalreference
		ORDER BY uniqueid) AS row_num
FROM nashville_housing
ORDER BY parcelid)
	
SELECT *
FROM row_num_cte
WHERE row_num > 1	

-- Deleting the duplicates
WITH row_num_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY parcelid, propertyaddress, saleprice, saledate, legalreference
               ORDER BY uniqueid
           ) AS row_num
    FROM nashville_housing
)
DELETE FROM nashville_housing
WHERE uniqueid IN (
    SELECT uniqueid
    FROM row_num_cte
    WHERE row_num > 1
);

-- Checking the table
SELECT * FROM nashville_housing

-- Deleting unused columns
ALTER TABLE nashville_housing
DROP COLUMN owneraddress, 
DROP COLUMN propertyaddress;



