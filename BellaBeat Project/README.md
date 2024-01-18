# Report

Summary:

Bellabeat is a high-tech manufacturer of health-focused products for women. Urška Sršen, co-founder and Chief Creative Officer of Bellabeat believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. She asked the analyst to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. The insights will then help guide the marketing strategy for the company. 

Section 1: Business Task and Objectives

1.1 Business Task Summary:

Bellabeat co-founder believes that analyzing one of the company’s smart device fitness data could help unlock new growth opportunities for the company. The objectives given by the cofounder of the company are to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their devices. The insights will help guide a marketing strategy for the company.

1.2 Data Sources:

The cofounder encouraged to use of public data that explores smart device users’ daily habits. A specified data was found on Kaggle, named Fitbit Fitness Tracker Data (the license is CC0 Public Domain (Creative Commons 1.0). The Kaggle data contains a personal fitness tracker from thirty users (physical activity, heart rate, sleep monitoring). It also includes information about daily activity, steps, and heart rate that can be used to explore users’ habits. The data have some limitations. The type of data in the data set is quantitative data (it can be expressed in numerical values, making it countable and including statistical data analysis. These kinds of data are also known as numerical data: how much, how many, how often).

Section 2: Data Preparation

2.1 Data Cleaning and Preprocessing:

Data cleaning is an important process of identifying and correcting or removing errors, inconsistencies and inaccuracies in data. Data cleaning ensures that the data is accurate, complete, and consistent, which is essential for making informed decisions and producing reliable insights. 
Before cleaning and processing the data, I had to check them first. I needed first to install and activate the libraries: tidyverse (a collection of R packages that work together to make data manipulation, visualization, and analysis more efficient – ggplot2 for data visualization, dplyr for data manipulation, tidyr for data tidying), here (is used for managing file paths in R projects), skimr (is a package for generating summary statistics and visualizations), janitor (is a package that is used for cleaning and tidying data frames), dplyr (package for manipulation – it provides functions like mutate, select, group_by, filter), hms (package for working with time of day data, specifically hours, minutes and seconds) and rmarkdown (package that can create dynamic documents that combine R code, text and visualization).  

I checked the tables by using the following functions: head() – it shows the first 6 rows of the data frame, but you can specify if you want more, colnames() – it shows the column names of the data frame and you can also use it to assign new column names, skim_without_charts() – it generates a summary of data frame without creating visualizations – it provides statistics like mean, median, min, max, glimpse() – it provides a compact summary of data structure. It displays the first few rows, along with the data types of each column, and str() – it provides a detailed summary of the structure (information about the data types of each element, as well as the first few values in each column). These functions are used to examine the tables, to get a sense of the data’s content and structure.

The first problem that I spotted was that the date had the character type instead of date type. I decided to change the type from character to date by using mutate() function. -It’s important to have the correct data type because we will not receive errors when we use a specific function.

The second problem was that we had rows with missing values. I decided to remove missing rows by using na.omit(). – Missing data is a common problem in datasets and can occur for a variety of reasons, such as data entry errors, system failure, or non-response. Missing data can impact the accuracy and reliability of analysis. 
The third problem was the column names weren’t standardized, and I had to clean them by using clean_names(). This will remove leading and trailing whitespaces, converting to lowercase. – Standardizing data helps to avoid variables with higher magnitudes dominating the analysis.

Section 3: Data Analysis

3.1 Trends in Smart Device Usage:

First, I checked how many unique users there are in each dataframe – Distinct values in the “id” column:
33 users – Activity data set
33 users – Intensity data set
24 users – Sleep data set
33 users – Steps data set
8 users – Weight data set

Insight: The analysis shows that there are different numbers of unique users in each dataset, with some users present in multiple datasets. This suggests that some users may have data for both their activity level and sleep, while others may have data only in specific categories like weight measurements.

Second, I checked the summary for each dataset and I received the following information:
Activity DF (minutes):
Total steps: Min. 0, Mean 7638, Max 36019, Median 7406.
Total distance: Min. 0, Mean 5490, Max 28030
Sedentary: Min. 0, Mean 991.2, Max. 1440
Steps: The min 0 represents that some records have 0 steps. The max suggests a wide range of step counts. The median is 7,406 indicating that half of the records have steps below these values, and the average is 7,638
Total distance: The median is 5.245 miles which is around 8.44 km
Sedentary: The median is 1.057,5 (about 17.6 hours)

Sleep DF (unique registration, minutes):
Total sleep records: Min. 1, Mean 1,119, Max. 3
Total minutes asleep: Min. 58, Mean. 419,5, Max. 796
Total time in bed: Min. 61, Mean, 458,6, Max. 961
Sleep records: Most records have 1 sleep record. The maximum is 3, suggesting some days with multiple sleep records.
Total minutes asleep: The minimum is 58 minutes, indicating very little sleep. The maximum is 796 (About 13 hours). The median is 433 minutes (about 7.2 hours). 

Insight: In the activity dataset, there is a wide range of step counts, and some records have no sedentary time. In the sleep dataset, most records have one sleep record, but there are days with multiple sleep records, and sleep duration varies widely. 

Finally, I checked the correlations between datasets. 
There is a positive correlation between total_minutes_asleep and total_time_in_bed, with a correlation of 0.93044575. 

Insight: This means that as the total time spent in bed increases, the total minutes of sleep also tend to increase. There is a strong relationship between time spent in bed and actual sleep duration.
As people spend more time in bed, they generally have more opportunity to sleep, leading to a positive linear relationship. 

There is a mix of correlation between calories and different levels of activity. The highest correlation matrix is between calories and very_active_minutes having the result 0.6158383, then it drops with each activity that has less intensity: fairly_active_mintes (0.2976235), lightly_activity_minutes (0.2867175), sedentary_minutes (-0.1069730). 

Insight: Very active minutes have a positive correlation indicating that more very active minutes are associated with higher calories burned. On the other side, sedentary_minutes has a negative correlation, suggesting that more sedentary time is associated with lower calorie burn. 

There is also a negative correlation or no correlation between total_steps and sedentary_minutes. The result is -0.3274835.

Insight: The correlation between these two  in the final_activity dataset shows a weak negative correlation. This means that as several steps increase, sedentary minutes tend to decrease which makes intuitive sense. 

Another weak negative correlation or no correlation is between total_steps and total_minutes_asleep. The result is -0.09854146.

Insight: After we merged sleep and activity data, I checked the correlation between these two, and it’s a weak negative correlation, implying that, on average, more steps are associated with slightly less sleep duration. 
That means the people who are more active during the day might have an easier time falling asleep and maintain longer sleep duration. Having more steps doesn’t cause longer sleep, but rather an active lifestyle might contribute to better sleep. But also, this doesn’t imply (the weak correlation) that fewer active leads to better sleep. There are likely more complex factors at play, and correlation alone might not provide a complete understanding of the relationship between these variables.

Another negative correlation or no correlation is between total_minutes_asleep and calories. The result is 0.02253083. 

Insight: This correlation indicates a very positive correlation. This suggests that there is almost no linear relationship between sleep duration and calories burned.

There is a mix of correlation between sleep_efficiency and different levels of activity. The highest correlation matrix is between sleep_efficiency and lightly_activity_minutes (0.07524030), then it drops with each activity: very_active_minutes (0.04578836), fairly_active_mintes (-0.41588265), sedentary_minutes (0.05362159).

Insight: Sleep efficiency is negatively correlated with fairly_active_minutes, meaning that more fairly active means are associated with lower sleep efficiency. 

Overall, the correlation coefficients are relatively close to zero for most of the variables, which suggests that there is no strong linear relationship between them. This doesn’t mean that there is no relationship at all; it means that any associations are weak and may not captured well by linear correlations. 

6 unique users are interested in weight/sleep management. The correlation between weight and total_minutes_asslep is a negative or no correlation, having the result -0,02583607.

Insight: We have a weak negative correlation between them and it means that there’s almost no linear relationship between them.

8 unique users are interested in weight/activity management. There is a mix of correlation between weight and different levels of activity. The highest correlation matrix is between weight and sedentary_minutes (0.6674876), then it drops with each activity: very_active_minutes (0.4089736), fairly_active_mintes (-0.2658307), and lightly_activity_minutes (-0.2866395).

Reminder: Correlation doesn’t imply causation, and other factors could be influencing these relationships. 

3.2 Application to Bellabeat Customers:

Trends:
Increase in Physical Activity: The trend could suggest that people are becoming more conscious of their fitness and overall health.
In recent years, there has been a noticeable surge in people’s commitment to their fitness and overall health. This trend is reflected in the data, showing an increase in physical activity levels among users of smart devices. The company can leverage this trend to align with its mission of empowering women with knowledge  about their health and habits.
Sleep duration: The average is 7.2 hours. The recommendation for an adult is 7 or more hours per night. 
Adequate sleep is a cornerstone of good health, and the data shows that users are averaging around 7.2 hours of sleep per night. This aligns with recommendations for adults, further emphasizing the importance of quality sleep.
The company can provide customers with tools to monitor and improve their sleep patterns. Features like sleep tracking, and sleep quality assessments. 
The correlation between sleep and activity: There is a mix of weak positive, and negative correlation between them. 
The company can offer insights into how physical activity impacts sleep quality and duration. For example, users can receive recommendations on the timing and intensity of workouts to optimize their sleep patterns. 

Customers:
The sleep duration is an important factor for Bellabeat customers, and it should have a feature that will help the customer view how they sleep and if the quality of their sleep is good or bad, giving information on how to improve it or to congratulate them for their having a good sleep quality. 
The increase in physical activity is an important factor for Bellabeat customers because the majority of them care about their fitness. It would be good to create features that help them track their health while they exercise, to offer them features that suggest which type of exercise will be good for them based on their weight.

3.3 Impact on Bellabeat Marketing Strategy:

The identified trends can significantly influence Bellabeat's marketing strategy. By aligning marketing efforts with these trends, Bellabeat can better cater to its customers' interests and needs. Here are specific recommendations and strategies based on these insights:

Increase in Physical Activity:
Targeted Fitness Campaigns: Launch marketing campaigns that highlight Bellabeat's products as essential tools for tracking and improving physical activity. Showcase success stories from users who have achieved their fitness goals using Bellabeat devices.
Collaborations with Fitness Influencers: Partner with fitness influencers to promote Bellabeat products. Their endorsements can build credibility and reach a broader audience of health-conscious consumers.

Sleep Duration:
Sleep Wellness Campaigns: Create marketing campaigns that focus on the importance of quality sleep and how Bellabeat's products can assist in achieving it. Educate customers on the correlation between sleep and overall health.
Sleep Improvement Guides: Offer informative content such as blog posts, videos, or ebooks on improving sleep quality. This positions Bellabeat as a trusted source of sleep-related knowledge.

Section 4: Content Recommendations

4.1 High-Level Content Recommendations:

Fitness Guides: Develop comprehensive fitness guides that users can access through the Bellabeat app. These guides can include workout routines, nutrition tips, and wellness advice.

Sleep Improvement Series: Create a series of content focusing on sleep improvement. This can include blog articles, videos, or podcasts covering topics like creating a sleep-friendly environment and managing stress for better sleep.

Customer Success Stories: Share in-depth stories of Bellabeat users who have experienced significant improvements in their health and wellness through the use of Bellabeat products. Humanize the brand and showcase real-life transformations.
