Overview - Data Cleaning and Merging Process

Objective:
The goal was to combine data from several sources into a single, clean record for each company. Each record needed one correct address, phone number, website, and business activity. The challenge was that the data had different levels of accuracy (around 80%), so it needed careful cleaning.

Challenges:
Address (Source 1): Many addresses were incomplete or inconsistent, some with strange characters like "#", which I removed to keep things uniform.
Phone Numbers (Source 1, 2, 3): Different formats, some missing the "+1" for Canada. Some entries had multiple phone numbers across sources.
Regions (Source 1, 2, 3): Regions were often abbreviated (like ON for Ontario). These needed to be converted to full names for better clarity.
Cities (Source 1, 2, 3): Some city names were incomplete, lowercase, or spelled incorrectly.
Website (Source 2, 3) and Activity (Source 2, 3, 4, 5, 6): Some entries had missing websites or business descriptions. Different sources sometimes gave slightly different activities.

Steps Taken:
Initial Cleaning with Power Query
I first used Power Query to reorganize columns for easier review and bulk formatting:

Trim & Clean: Removed extra spaces and special characters.
Uppercase Letters: Formatted names, regions, and cities to use proper case.
Rearranged Columns: Made sure all data from the same sources were grouped together to improve clarity and processing.

Phone Numbers
After Power Query, I used Excel’s CONCATENATE function to ensure all phone numbers followed the format "+1 (XXX) XXX-XXXX." I prioritized Source 3, but if it was missing, I added numbers from Source 1 and 2. I also combined multiple phone numbers into a single field where necessary.

Address Formatting
I removed "#" from addresses for uniformity and to avoid confusion. If an address had duplicates but different phone numbers, I kept all numbers.

Region and City Matching
I converted region abbreviations (like ON, AB) into full names for clarity. For cities and regions, I compared data across sources and kept the most consistent values. If no match existed, I marked them as "N/A."

Handling Missing Data
Website: I prioritized websites from Source 1, checking Source 2 if missing, and marking as "N/A" when necessary.
Activity: I kept the most complete description of business activity when sources differed.

Conclusion:
The goal was to produce a clean, reliable dataset by combining the best data from multiple sources. Further steps, such as verifying phone numbers and regions using external tools, could improve accuracy even further in future stages.
