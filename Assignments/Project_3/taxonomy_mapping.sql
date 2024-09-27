-- Step 1: Create a table to store the taxonomy data
CREATE TABLE taxonomy_mapping (
    company_id INT,         -- A unique ID for each company
    taxonomy1 TEXT,         -- The category from Taxonomy1 (the company's taxonomy)
    taxonomy2 TEXT          -- The category from Taxonomy2 (client's taxonomy)
);

-- Step 2: Select all the data from the table to check what's inside
SELECT * FROM taxonomy_mapping;

-- Step 3: Count how many unique categories are in each taxonomy
SELECT COUNT(DISTINCT taxonomy1) AS unique_taxonomy1, 
       COUNT(DISTINCT taxonomy2) AS unique_taxonomy2
FROM taxonomy_mapping;
-- This will tell you how many distinct categories there are in each taxonomy (Taxonomy1 and Taxonomy2).

-- Step 4: Check for missing data (NULL values) in either taxonomy1 or taxonomy2
SELECT * FROM taxonomy_mapping 
WHERE taxonomy1 IS NULL OR taxonomy2 IS NULL;
-- This will help find if there are any entries where one of the taxonomies is missing data (i.e., NULL).

-- Step 5: Find duplicate rows (where the same mapping appears more than once)
SELECT taxonomy1, taxonomy2, COUNT(*)
FROM taxonomy_mapping
GROUP BY taxonomy1, taxonomy2
HAVING COUNT(*) > 1;
-- This query finds cases where the same pair of categories from Taxonomy1 and Taxonomy2 appears more than once.

-- Step 6: Find cases where one category from Taxonomy1 is mapped to multiple categories in Taxonomy2
SELECT taxonomy1, COUNT(DISTINCT taxonomy2) AS numar_mapari
FROM taxonomy_mapping
GROUP BY taxonomy1
HAVING COUNT(DISTINCT taxonomy2) > 1;
-- This query checks if any category in Taxonomy1 has more than one corresponding category in Taxonomy2 (i.e., many-to-one relationships).

-- Step 7: Find cases where one category from Taxonomy2 is mapped to multiple categories in Taxonomy1
SELECT taxonomy2, COUNT(DISTINCT taxonomy1) AS numar_mapari
FROM taxonomy_mapping
GROUP BY taxonomy2
HAVING COUNT(DISTINCT taxonomy1) > 1;
-- Similar to Step 6, but this time checking if any category in Taxonomy2 maps to multiple categories in Taxonomy1.

-- Step 8: Find the pairs that only appear once in the mapping (no duplicates)
SELECT taxonomy1, taxonomy2, COUNT(*) AS numar_aparitii
FROM taxonomy_mapping
GROUP BY taxonomy1, taxonomy2
HAVING COUNT(*) = 1;
-- This query helps find the unique pairs that exist only once in the data (no duplicates).

-- Step 9: Similar to Step 8, but now checking Taxonomy2 first
SELECT taxonomy2, taxonomy1, COUNT(*) AS numar_aparitii
FROM taxonomy_mapping
GROUP BY taxonomy2, taxonomy1
HAVING COUNT(*) = 1;
-- This checks for unique pairs but looks at the relationship from Taxonomy2 to Taxonomy1.

-- Step 10: Enable the pg_trgm extension for similarity matching
CREATE EXTENSION pg_trgm;
-- This allows us to use the `similarity()` function in PostgreSQL to measure how closely two text strings match.

-- Step 11: Calculate the similarity score for each pair of categories (from 0 to 1, where 1 is an exact match)
SELECT taxonomy1, taxonomy2, similarity(taxonomy1, taxonomy2) AS score
FROM taxonomy_mapping
ORDER BY score DESC;
-- This will rank the pairs from the most similar to the least similar based on the similarity score.

-- Step 12: Find pairs of categories with a low similarity score (less than 0.7)
SELECT taxonomy1, taxonomy2, similarity(taxonomy1, taxonomy2) AS score
FROM taxonomy_mapping
WHERE similarity(taxonomy1, taxonomy2) < 0.7;
-- This query finds pairs that don't match very well (i.e., they have a similarity score below 0.7).
