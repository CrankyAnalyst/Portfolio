# Report

1. Introduction

Cyclistic is a forward-thinking bike-share program in Chicago, dedicated to providing inclusive mobility solutions. With over 5,800 bicycles and 600 docking stations, Cyclistic caters to a wide range of riders, including those with disabilities and daily commuters. While the majority of riders opt for traditional bikes, approximately 8% utilize the program's assistive options. Cyclistic bikes serve both leisure and daily commuting purposes, with 30% of users relying on them for their daily work commutes.

The future of Cyclistic hinges on maximizing annual memberships, as these members are significantly more profitable than casual riders. In the past, Cyclistic's marketing strategy focused on building general awareness and appealing to broad consumer segments, offering pricing plans that include single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are considered casual riders, while those with annual memberships are Cyclistic members.

However, Cyclistic's marketing director, Lily Moreno, believes the company can take its growth to the next level by targeting casual riders and encouraging them to become annual members. Casual riders are already familiar with Cyclistic and have experienced the program firsthand, making them a prime target for conversion.

To achieve this goal, the marketing analyst team must first understand how annual members and casual riders use Cyclistic bikes differently. This report aims to provide insights into their distinctive behaviors, shedding light on why casual riders would consider purchasing annual memberships. The analysis also explores the potential role of digital media in influencing this transition.

2. Data Sources

For this analysis, we utilize historical bike trip data collected by Cyclistic. The data spans multiple months and includes information on ride duration, user type (annual member or casual rider), ride start and end locations, and more. This dataset provides valuable insights into user behavior and preferences.

3. Data Cleaning and Preparation

Before conducting the analysis, we performed several data cleaning and preparation steps:

Handling missing data: We addressed missing or incomplete records by removing them from the dataset to ensure data integrity.
Data transformation: We converted relevant columns into appropriate formats, such as datetime for timestamps and numerical values for ride durations.
Outlier management: We identified and addressed outliers that could skew our analysis.
These steps ensure that our analysis is based on clean and reliable data.

4. Analysis

4.1 Rider Behavior Overview

Our analysis revealed that annual members and casual riders exhibit distinct usage patterns. Annual members account for a significant portion of ridership and tend to use Cyclistic bikes for daily commuting, while casual riders often use them for leisure purposes.

Number of riders: Annual members constitute a substantial portion of Cyclistic's user base.

Usage patterns: Annual members rely heavily on Cyclistic for daily commuting, indicating a strong need for convenient and affordable transportation.

How do annual members and casual riders use Cyclistic bikes differently?
- Analysis of Average Ride Duration by Rider Type:
On average, casual riders have a ride duration of approximately 29 minutes, while annual members' rides are much shorter, with an average duration of about 12 minutes.

- Analysis of Maximum Ride Duration by Rider Type:
The maximum ride duration for casual riders was remarkably long, reaching 28 days and 17 hours. In contrast, annual members had a much shorter maximum ride duration of 1 day and 1 hour.

- Exploration of Ride Duration Bins:
When we analyze the ride duration by segmenting it into bins, we observe that casual riders tend to have a significant number of rides in the "0-30 minutes" and "60+ minutes" categories. For annual members, most rides fall within the "0-30 minutes" category.

- Mode of Day of the Week:
The mode (most frequently occurring) day of the week for bike rides is Sunday (represented by the number 6).

- Analysis of Average Ride Duration by Day of the Week:
The average ride duration varies by day of the week, with the longest rides typically occurring on Saturdays (day 6), with an average duration of approximately 32 minutes for casual riders and 14 minutes for annual members. On the other hand, annual members tend to have shorter average ride durations throughout the week.

- Number of Rides by Day of the Week:
The data shows variations in the number of rides by day of the week. Both casual riders and annual members have a higher number of rides on weekdays (1-5), with the highest number of rides for both groups on day 7 (Sunday).

- Analysis of Average Ride Duration and Ride Counts by Month and Rider Type:
The analysis revealed variations in ride duration by month. Casual riders tend to have slightly longer average ride durations than annual members. The number of rides is also variable across months.

- Correlation between Ride Duration and Day of the Week:
The correlation between ride duration and the day of the week is relatively low, indicating that the day of the week has a limited influence on the duration of bike rides.

5. Recommendations

Based on our analysis, we offer the following recommendations to convert casual riders into annual members:

Tailored Marketing Campaigns: Develop targeted marketing campaigns that highlight the benefits of annual memberships for daily commuters, such as cost savings, convenience, and access to exclusive features.

Promote Short Trips: Encourage casual riders to take shorter trips by offering incentives such as discounted rates or promotions for rides under 30 minutes.

Enhanced User Experience: Improve the user experience by optimizing bike availability at popular ride locations and enhancing the Cyclistic app for smoother transactions and route planning.

Implementing these recommendations can help Cyclistic achieve its goal of increasing annual memberships and driving long-term growth.

6. Conclusion

In conclusion, understanding the differences in behavior between annual members and casual riders is crucial for Cyclistic's growth strategy. Our analysis provides valuable insights into user patterns, ride duration, frequency, and popular locations. By tailoring marketing efforts, promoting shorter trips, and enhancing the user experience, Cyclistic has the potential to convert casual riders into loyal annual members, securing a brighter future for the bike-share program.
