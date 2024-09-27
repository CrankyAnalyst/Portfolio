Overview - Web Scraping and Data Collection Using Python and Web Scraper

Objective:
The goal of this project was to extract structured information about companies listed in the FTSE 100 index from their individual Wikipedia pages. The data to be collected was located in the infobox on the right side of each company's Wikipedia page, containing important company details such as founding date, industry, key people, and financials. The project involved using two approaches: Python for manual scraping and Web Scraper for a more automated process.

Methodologies:

Python for Web Scraping:
Python is highly versatile and gives a lot of control over the scraping and data processing. I wanted to experiment with this flexibility by manually building a scraper using the requests library for fetching the page and BeautifulSoup for parsing HTML content.

Steps Taken:
I used Inspect Element in the browser to identify the location of the structured data (the HTML table class infobox ib-company vcard) and then applied Python to extract that table. Specifically, I searched for the tag 'table' with the class attribute 'infobox ib-company vcard', which is where Wikipedia stores company information.
I then extracted each label (such as "Founded," "Industry," and "Key People") and their corresponding information (such as "1945", "Private Equity", "David Hutchison"). These were stored in lists Labels and Information, respectively.
Once extracted, I cleaned the data to remove unwanted references and line breaks using regular expressions (regex).

Challenges and How I Overcame Them:
Wikipedia often includes references in the form of [1], [2], etc., in the text. To clean the data, I used regular expressions to remove these reference numbers, improving data readability.
Newline Characters: Some information in the table spanned multiple lines. I used Python's replace() function to clean these up by removing newline characters and combining everything into a single line for consistency.
Table Selection: The first step was identifying the correct HTML element (table) that contained the required data. Using browser tools like "Inspect Element" helped to narrow down the specific table class ('infobox ib-company vcard'), which was then extracted using BeautifulSoup.

What I Learned:
Python offers extensive control over how data is extracted, cleaned, and processed. However, scraping manually for each company can be time-consuming. For a smaller dataset, this method works well, but scaling this process would require additional automation, such as looping through URLs for all companies.
Error Handling: When pages did not contain the expected structure, the script could break. Therefore, implementing error handling using try-except blocks would be necessary for future improvements.

Web Scraper Tool:
I wanted to try a tool that could quickly scrape data from multiple pages with less manual coding. Web Scraper is a browser extension that allows visual navigation of web pages to collect data.

Steps Taken:
I configured Web Scraper to navigate through the FTSE 100 companies list, visiting each company's Wikipedia page and scraping the infobox data. I set it to target the right-hand side table on each page.
The tool worked effectively for bulk scraping but had limitations in terms of customization when handling data structures that weren’t uniform across companies.

Challenges Encountered:
One of the main issues with Web Scraper was that it would sometimes repeat categories, leading to multiple rows of the same information. For example, for one company, "Company Type" was extracted multiple times with slight variations in the data.
Structured Data Alignment: While Web Scraper made data collection quick, it required post-processing to structure the data correctly, as the tool sometimes did not handle nested tables or complex data layouts as cleanly as Python would.

What I Learned:
Web Scraper is a great tool for rapid extraction but lacks the granularity and control that Python offers. It’s efficient for projects that don’t require heavy customization of the data extraction process, but if precision and error handling are critical, a Python-based solution may be preferable.
Error Handling: Unlike Python, where errors can be caught and handled, Web Scraper might fail to extract data correctly if the table structure is inconsistent between different company pages.

Issues and Fixes:
When exporting the data to a CSV file, I encountered issues with characters like "Â" appearing incorrectly. This was resolved by ensuring the correct encoding (utf-8) was applied when saving the file
During the scraping, I noticed that some columns were misaligned in the output CSV. This occurred because of inconsistent data structures across different Wikipedia pages. By manually reviewing the data and ensuring uniformity in how the data was extracted (e.g., handling missing values or extra rows in the table), I improved the data integrity.

Conclusion:
Both Python and Web Scraper have their advantages depending on the scope and needs of the project. Python offers unparalleled flexibility and control for a custom scraping solution, making it ideal for projects requiring precise data manipulation or handling inconsistencies across pages. However, it requires more time and effort to set up and run for multiple pages. On the other hand, Web Scraper is a powerful tool for quickly gathering data across many pages without much coding effort, though it may require additional processing to clean and organize the data.
In this project, I learned the importance of balancing automation with customization, choosing the right tool for the job based on the dataset size and complexity.
