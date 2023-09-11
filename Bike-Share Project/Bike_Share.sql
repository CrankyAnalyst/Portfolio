-- Creating the tables for each data
CREATE TABLE tripdata_2022_12
(ride_id varchar (50),
rideable_type varchar (50),
started_at timestamp,
ended_at timestamp,
start_station_name varchar (100),
start_station_id varchar (100),
end_station_name varchar (100),
end_station_id varchar (100),
start_lat varchar (50),
start_lng varchar (50),
end_lat varchar (50),
end_lng varchar (50),
member_casual varchar (10)
);

-- Checking to see if the data imported correctly
SELECT * FROM tripdata_2022_12

-- Calculating the duration for each ride by substracting 'started_at' and 'ended_at'
SELECT 
    ride_id,
    started_at,
    ended_at,
    ended_at - started_at AS ride_duration
FROM 
    tripdata_2022_01;

-- Creating a new column to calculate the ride duration for each ride in each table
ALTER TABLE tripdata_2022_01
ADD COLUMN ride_duration interval;

-- Updating the new column 'ride_duration' with calculated ride durations
UPDATE tripdata_2022_01
SET 
    ride_duration = ended_at - started_at;

-- Repeating the process for the rest of the tables
-- Calculating the duration for each ride by substracting 'started_at' and 'ended_at'
SELECT 
    ride_id,
    started_at,
    ended_at,
    ended_at - started_at AS ride_duration
FROM 
    tripdata_2022_12;

-- Creating a new column to calculate the ride duration for each ride in each table
ALTER TABLE tripdata_2022_12
ADD COLUMN ride_duration interval;

-- Updating the new column 'ride_duration' with calculated ride durations
UPDATE tripdata_2022_12
SET 
    ride_duration = ended_at - started_at;
	
-- Calcuting the average distance traveled by both rider types. 
SELECT member_casual, AVG(ride_duration)
FROM tripdata_2022_01
GROUP BY member_casual

-- Calcuting the max distance traveled by both rider types. 
SELECT member_casual, MAX(ride_duration)
FROM tripdata_2022_01
GROUP BY member_casual

-- A more in-depth exploration of the distance traveled by both rider types. 
SELECT
    member_casual,
    CASE
        WHEN EXTRACT(EPOCH FROM ride_duration) < 1800 THEN '0-30 minutes'
        WHEN EXTRACT(EPOCH FROM ride_duration) < 3600 THEN '30-60 minutes'
        ELSE '60+ minutes'
    END AS ride_duration_bin,
    COUNT(*) AS ride_count
FROM
    tripdata_2022_01
GROUP BY
    member_casual, ride_duration_bin
ORDER BY
    member_casual, ride_duration_bin;

-- Checking the day of the week in the first month
SELECT EXTRACT(isodow FROM started_at) FROM tripdata_2022_01

-- Creating a new column to calculate the ride duration for each ride in each table
ALTER TABLE tripdata_2022_01
ADD COLUMN day_of_the_week integer;

-- Updating the new column 'ride_duration' with calculated ride durations
UPDATE tripdata_2022_01
SET 
    day_of_the_week = EXTRACT(isodow FROM started_at)

-- Repeating the process for the rest of the tables
-- Checking the day of the week in the first month
SELECT EXTRACT(isodow FROM started_at) FROM tripdata_2022_12

-- Creating a new column to calculate the ride duration for each ride in each table
ALTER TABLE tripdata_2022_12
ADD COLUMN day_of_the_week integer;

-- Updating the new column 'ride_duration' with calculated ride durations
UPDATE tripdata_2022_12
SET 
    day_of_the_week = EXTRACT(isodow FROM started_at)

-- Calculating the mode of day of the week
SELECT MODE() WITHIN GROUP (ORDER BY day_of_the_week) FROM tripdata_2022_10

-- Create a new table to store the combined data using the APPEND operation
CREATE TABLE tripdata_2022 AS
SELECT * FROM tripdata_2022_01
UNION ALL
SELECT * FROM tripdata_2022_02
UNION ALL
SELECT * FROM tripdata_2022_03
UNION ALL
SELECT * FROM tripdata_2022_04
UNION ALL
SELECT * FROM tripdata_2022_05
UNION ALL
SELECT * FROM tripdata_2022_06
UNION ALL
SELECT * FROM tripdata_2022_07
UNION ALL
SELECT * FROM tripdata_2022_08
UNION ALL
SELECT * FROM tripdata_2022_09
UNION ALL
SELECT * FROM tripdata_2022_10
UNION ALL
SELECT * FROM tripdata_2022_11
UNION ALL
SELECT * FROM tripdata_2022_12
;

SELECT * FROM tripdata_2022

-- Rechecking the calculations that are above
-- Calcuting the average distance traveled by both rider types. 
SELECT member_casual, AVG(ride_duration)
FROM tripdata_2022
GROUP BY member_casual

-- Calcuting the max distance traveled by both rider types. 
SELECT member_casual, MAX(ride_duration)
FROM tripdata_2022
GROUP BY member_casual

-- A more in-depth exploration of the distance traveled by both rider types. 
SELECT
    member_casual,
    CASE
        WHEN EXTRACT(EPOCH FROM ride_duration) < 1800 THEN '0-30 minutes'
        WHEN EXTRACT(EPOCH FROM ride_duration) < 3600 THEN '30-60 minutes'
        ELSE '60+ minutes'
    END AS ride_duration_bin,
    COUNT(*) AS ride_count
FROM
    tripdata_2022
GROUP BY
    member_casual, ride_duration_bin
ORDER BY
    member_casual, ride_duration_bin;

-- Calculating the mode of day of the week
SELECT MODE() WITHIN GROUP (ORDER BY day_of_the_week) FROM tripdata_2022

-- Calcuting the average distance traveled by both rider by day_of_the_week
SELECT day_of_the_week, member_casual, AVG(ride_duration)
FROM tripdata_2022
GROUP BY day_of_the_week, member_casual

-- Calcuting the number of rides for users by day_of_the_week
SELECT day_of_the_week, member_casual, COUNT(*) AS ride_count
FROM tripdata_2022
GROUP BY day_of_the_week, member_casual

-- Adding a new column to store the month of the ride
ALTER TABLE tripdata_2022
ADD COLUMN ride_month integer;

-- Updating the new column with the extracted month
UPDATE tripdata_2022
SET ride_month = EXTRACT(MONTH FROM started_at);

-- Calculating average ride duration and ride counts by month and rider type
SELECT
    ride_month,
    member_casual,
    AVG(ride_duration) AS avg_ride_duration,
    COUNT(*) AS ride_count
FROM
    tripdata_2022
GROUP BY
    ride_month, member_casual
ORDER BY
    ride_month, member_casual;

-- Calculating the correlation between ride duration and day of the week
SELECT
    CORR(EXTRACT(EPOCH FROM ride_duration), day_of_the_week) AS correlation
FROM
    tripdata_2022;


