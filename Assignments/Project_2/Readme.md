Overview - Web Scraping and Data Collection Using Python and Web Scraper

Objective:
The main goal of this project was to collect important company information from their Wikipedia pages, specifically for companies in the FTSE 100 Index. The data was located in a table on the right side of each company's page, called an "infobox," which includes details like the company's founding date, industry, key people, and finances. I used two different methods: Python and Web Scraper.

Method 1: Python Web Scraping
Python was my first approach because it allows for full control over how to extract and clean the data.

Steps I Followed:

Requests and BeautifulSoup Libraries: I started by sending a request to the company's Wikipedia page and then used a library called BeautifulSoup to look through the page's HTML code and find the table containing company details.
Identifying the Table: I used the browser's "Inspect Element" tool to find the correct table class on the page ('infobox ib-company vcard'), and then I told the code to search for this table and extract its data.
Extracting Labels and Information: I pulled each company detail like "Founded" or "Industry" and their related information (e.g., "1945" or "Private Equity"). These were stored in lists.
Cleaning the Data: Wikipedia adds references (e.g., [1], [2]) that needed to be removed. I also cleaned up any extra line breaks so all the data was neatly in one line.

Challenges and Solutions:
References: Wikipedia adds references (e.g., [1], [2]) within the text. To remove them, I used a tool called "regular expressions" that finds and deletes these references automatically.
Line Breaks: Some data had extra line breaks, so I wrote a function to replace them with spaces, making the data look cleaner.
Table Selection: Finding the right table on the page was tricky, but using the browser's "Inspect Element" helped identify the correct class name of the table.


Method 2: Web Scraper Tool
Web Scraper is a browser extension that can automatically extract data from multiple pages without needing a lot of code.

Steps I Followed:
I set up the Web Scraper tool to visit each FTSE 100 company’s Wikipedia page and collect the information in the infobox. This allowed me to scrape data much faster than doing it manually with Python.
The tool worked well for bulk scraping but had some limitations in handling more complex or inconsistent tables.

Challenges and Solutions:
Repeated Categories: In some cases, Web Scraper repeated the same category multiple times (e.g., "Company Type" appeared with slightly different values). This meant I had to spend extra time cleaning up the data after it was collected.
Structured Data Alignment: Sometimes, Web Scraper didn’t handle tables with complex layouts as neatly as Python, so I needed to review and adjust the data afterward.
Issues and Fixes:

Misaligned Data in CSV: When exporting the data to CSV format, some columns didn’t line up correctly. This happened because Wikipedia pages have slightly different table formats. While I didn’t fix this for the current version, I’ve noted that future versions will need better handling of missing or extra rows to improve data accuracy.

Conclusion:
Python gave me full control over the scraping process, which allowed me to clean and manipulate the data exactly how I wanted. However, it required more manual effort. Web Scraper, on the other hand, was faster for collecting data from multiple pages but didn’t offer as much customization or control. Overall, each tool has its strengths: Python is great for precision and cleaning, while Web Scraper is good for speed. Moving forward, depending on the project’s complexity, I’ll choose the tool that balances speed and customization best.
