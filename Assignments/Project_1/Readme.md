Overview - Data Cleaning and Merging Process

Objective:
The goal of this project was to merge multiple data sources into a single clean and accurate record for each company. Each record should contain one correct location, phone number, website, and business activity for each company. The challenge lies in the fact that the data provided by the various sources had varying levels of accuracy (around 80%), and required careful cleaning and validation.

Initial Challenges:
Full Address (Source 1): Many entries had incomplete or inconsistent addresses, sometimes containing odd characters, like the "#" sign, which I decided to remove for better uniformity and clarity. Uniform formatting of addresses can be crucial for data consistency, especially when the data is used for searching or location-based analysis.
Phone Numbers (Source 1, 2, 3): There were different formats, some numbers missing the international code "+1" for Canada, and sometimes multiple phone numbers for the same entry across sources.
Regions (Source 1, 2, 3): Regions were often abbreviated (ON, AB, etc.), and we needed to map these abbreviations to their full names for clarity, particularly for users outside of Canada.
Cities (Source 1, 2, 3): Some city names were missing or written in lowercase or with inconsistent spelling.
Countries (Source 1, 2, 3): While most entries were for Canada, I noticed some entries for the United States and other countries, which required some extra care in matching the data correctly.
Website and Activity (Source 2, 3): Many entries had missing websites or incomplete business activity descriptions. Sometimes Source 2 and Source 3 offered slightly different business activities for the same company.

Steps Taken:

1. Power Query for Initial Cleaning
I initially used Power Query to handle basic formatting issues, as it allows for faster bulk operations:

Trim & Clean: Removed unnecessary spaces, special characters, and extra line breaks.
Uppercase First Letters: Applied proper casing (first letter capitalized) to company names, regions, and cities to maintain consistency.
Uniform Phone Format: Used formulas in Excel to ensure all phone numbers were in the "+1 (XXX) XXX-XXXX" format, specifically for Canadian numbers.
I used the CONCATENATE function in Excel to format the phone numbers. If a number was present in Source 1, it was formatted first. If there were discrepancies between sources, I took numbers from Source 2 and Source 3, concatenating them in the format "+1 (XXX) XXX-XXXX"

2. Address Cleaning and Formatting
   
I removed the "#" symbol in front of addresses (e.g., #120-3605) to maintain a uniform format across all addresses. This was done to avoid confusion, especially since some addresses also contained numbers in the street name (e.g., 1234 Main St #5), which could create ambiguity.
I filtered out duplicates based on full addresses, while ensuring that if a duplicate address had multiple phone numbers, they were all included in the final record.

3. Region and City Matching
   
For regions, I mapped abbreviations (e.g., AB, ON) to their full names (e.g., Alberta, Ontario) to ensure clarity. This is particularly important since the data could be accessed by people from different countries who may not be familiar with Canadian abbreviations.
I applied matching functions (MATCH, SEARCH) in Excel to compare regions and cities across the sources. If the regions or cities matched, I kept that value. If they differed or were missing, I marked them as "N/A" for further review.

4. Handling Missing Data
   
Website: I gave priority to Source 1 for the website field. If it was missing in Source 1, I checked Source 2, and if all were missing, I marked the website as "N/A".
Activity: Since different sources might describe the same business in slightly different ways, I opted to keep the description that seemed the most complete. For instance, "Electrical & Wiring Contractors" was kept over "Electricians."

5. Final Adjustments and Considerations
   
Phone Numbers: In cases where duplicate records existed, I ensured that if multiple unique phone numbers were found for the same company, they were all included in a single combined field.
Uniformity: Although I didn’t perform full uniformity adjustments on all columns (like region and city), this is an important step to consider for a future stage of the project, especially if the database will be queried internationally.

Conclusion:
The goal was to create a clean and reliable dataset by combining the best information from multiple sources. The process involved extensive cleaning, standardizing, and merging of data to ensure accuracy and consistency. Although I worked within a limited timeframe, further steps could involve a deeper dive into verifying the correctness of phone numbers and regions, perhaps through external validation or web scraping tools.

