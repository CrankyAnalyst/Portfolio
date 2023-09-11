/*
Coronavirus (COVID-19) Data Exploration - August 4th 2023

Skills used: Joins, CTE's, Windows Functions, Aggregate Functions, Converting Data Types

*/

-- Checking if the data was imported correctly, and if each column have the correct data type for both tables.
-- Excluding NULL values from continent because they are grouped (as continents, and income) in "location" column.
SELECT *
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY location, date;

SELECT *
FROM covid_vaccinations
WHERE continent IS NOT NULL
ORDER BY location, date;

-- Checking the data regarding all the cases, and deaths.
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-- Looking at total cases versus population
-- Shows what percentage of population got COVID-19.
SELECT location, date, population, total_cases, CAST(total_cases AS float)/population*100 AS population_percentage
FROM covid_deaths
ORDER BY location, date;

--Shows what percentage of population got COVID-19 in Romania.
SELECT location, date, population, total_cases, CAST(total_cases AS float)/population*100 AS population_percentage
FROM covid_deaths
WHERE location LIKE 'Romania'
ORDER BY location, date;

-- Looking at countries with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX(CAST(total_cases AS float)/population*100) AS population_infected_percentage
FROM covid_deaths
GROUP BY location, population
ORDER BY population_infected_percentage DESC;

-- A few countries doesn't have any values (NULL) in our dataset. Deciding to exclude the NULL values. 
SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX(CAST(total_cases AS float)/population*100) AS population_infected_percentage
FROM covid_deaths
WHERE total_deaths IS NOT NULL
GROUP BY location, population 
ORDER BY population_infected_percentage DESC;

-- Showing Countries with highest death count per population, excluding the NULL values. 
SELECT location, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS NOT NULL AND total_deaths IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;

-- Looking at total cases versus total deaths 
-- Shows the percentage of death for each country.
SELECT location, date, total_cases, total_deaths, CAST(total_deaths AS float)/total_cases*100 AS death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-- Shows the percentage of death for Romania.
SELECT location, date, total_cases, total_deaths, CAST(total_deaths AS float)/total_cases*100 AS death_percentage
FROM covid_deaths
WHERE location LIKE 'Romania' and continent IS NOT NULL
ORDER BY location, date;

-- Looking at the "continent" column
-- The numbers aren't correct. The "total_death_count" for North America it's the results that include only United States of America.
SELECT continent, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS not NULL
GROUP BY continent
ORDER BY total_death_count DESC;

-- Showing continents with the highest death count per population (it includes the income)
-- The numbers are correct because it was included all values. 
SELECT location, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_death_count DESC;

-- Showing the global numbers.
-- It was necessary to add NULLIF() because it would show an erorr : division by zero
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, NULLIF(CAST(SUM(new_deaths) AS FLOAT),0)/NULLIF(SUM(new_cases),0)*100 AS death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- The final results overall
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, NULLIF(CAST(SUM(new_deaths) AS FLOAT),0)/NULLIF(SUM(new_cases),0)*100 AS death_percentage
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY total_cases, total_deaths

-- Looking at the number of ICU patients, hospitalization rates, and their relation to deaths to understand the healthcare system's capacity to handle cases.
SELECT location, date, icu_patients, hosp_patients, total_deaths, NULLIF((total_deaths/NULLIF((icu_patients + hosp_patients),0)),0) AS death_per_hospitalization
FROM covid_deaths
WHERE icu_patients IS NOT NULL AND hosp_patients IS NOT NULL AND total_deaths IS NOT NULL
ORDER BY location, date;

-- Looking at the relationship between the reproduction rate, new cases, new deaths, case fatality rate, and stringency index (control measures).
-- This will show how the control measures impact the spread of the virus, new cases, and finally, the case fatality rate.
-- Joining the two tables
SELECT covid_deaths.location, covid_deaths.date, covid_deaths.reproduction_rate, covid_deaths.new_cases, covid_deaths.new_deaths, (covid_deaths.new_deaths/NULLIF(CAST(covid_deaths.new_cases AS FLOAT),0)) AS case_fatality_rate, covid_vaccinations.stringency_index
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.reproduction_rate IS NOT NULL AND covid_deaths.new_cases IS NOT NULL 
	AND covid_deaths.new_deaths IS NOT NULL AND covid_vaccinations.stringency_index IS NOT NULL
ORDER BY covid_deaths.location,covid_deaths.date;

-- Looking at Total Population vs Vaccinations (At least one COVID-19 vaccine)
-- Joining the covid_deaths table and covid_vaccinations table
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.new_vaccinations 
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;

-- The cumulative number of new vaccinations changed over time for different locations
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.new_vaccinations,
SUM(covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date) AS rolling_people_vaccinated
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;

-- The number of people who got vaccinated in relation to the total population for each location and date.
-- Using CTE (Common Table Expression) in order to be easier to calculate the percentage of rolling people vaccinated
-- CTEs are often used to break down complex queries into smaller, more manageable parts (temporary result)
WITH pop_vs_vac(continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
AS
(
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.new_vaccinations,
SUM(covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date) AS rolling_people_vaccinated
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date
)
SELECT *, (rolling_people_vaccinated/CAST(population AS FLOAT))*100 AS people_vaccinated_percentage FROM pop_vs_vac;

-- Looking at the vaccationat progress: tracking the total vaccinations, people vaccinated, and people fully vaccinated over time.
-- This will show how vaccination efforts have evolved, and the percetange of the population that has been fully vaccinated
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.total_vaccinations, covid_vaccinations.people_vaccinated, covid_vaccinations.people_fully_vaccinated, CAST(people_fully_vaccinated AS float)/population*100 AS population_fully_vaccinated_percentage
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;

-- Looking at tests and positivity rates
-- This will make us understand the testing efforts and how they relate to the spread of the virus
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_vaccinations.new_tests, covid_vaccinations.total_tests, covid_vaccinations.positive_rate,  (covid_vaccinations.new_tests / CAST(covid_deaths.population AS float)) * 1000000 AS new_tests_per_million,
    (covid_vaccinations.total_tests / CAST(covid_deaths.population AS float)) * 1000000 AS total_tests_per_million,
    (covid_vaccinations.total_tests / NULLIF(covid_vaccinations.new_tests, 0)) AS tests_per_positive 
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;

-- Comparing vaccination with new cases and deaths to observe any correlation between vaccination and disease control
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_deaths.new_cases, covid_deaths.new_deaths, covid_vaccinations.total_vaccinations, covid_vaccinations.people_vaccinated,
    covid_vaccinations.people_fully_vaccinated,
    (covid_vaccinations.people_fully_vaccinated / CAST(covid_deaths.population AS float)) * 100 AS population_fully_vaccinated_percentage
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;

-- Studying the demographic factors: median age, population density, and the economic indicators (GDP per capita, poverty rate).
-- This will show the vaccination progress and disease impact.
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_deaths.new_cases, covid_deaths.new_deaths, covid_vaccinations.population_density, covid_vaccinations.median_age,
    covid_vaccinations.gdp_per_capita, covid_vaccinations.extreme_poverty, covid_vaccinations.total_vaccinations,
	(covid_vaccinations.total_vaccinations / CAST(covid_deaths.population AS float)) * 100 AS vaccination_coverage_percentage
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;

-- Exploring how health indicators (cardiovascular death rate, diabetes prevalence, and smoking habits) may influence COVID-19 outcomes.
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_deaths.total_cases, covid_vaccinations.cardiovasc_death_rate, covid_vaccinations.diabetes_prevalence,
    covid_vaccinations.female_smokers, covid_vaccinations.male_smokers,  (covid_vaccinations.cardiovasc_death_rate / CAST(covid_deaths.total_cases AS float)) AS death_rate_per_case
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;

-- Exploring the excess mortality data to understand the overall impact of the pandemic
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_deaths.total_cases, covid_vaccinations.excess_mortality,
	(covid_vaccinations.excess_mortality / CAST(covid_deaths.total_cases AS float)) * 100 AS excess_mortality_rate_per_case
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;

-- Exploring the excess mortality data to understand the overall impact of the pandemic excluding the NULLs.
SELECT covid_deaths.continent, covid_deaths.location, covid_deaths.date, covid_deaths.population, covid_deaths.total_cases, covid_vaccinations.excess_mortality,
	(covid_vaccinations.excess_mortality / CAST(covid_deaths.total_cases AS float)) * 100 AS excess_mortality_rate_per_case
FROM covid_deaths
JOIN covid_vaccinations
ON covid_deaths.location = covid_vaccinations.location AND covid_deaths.date = covid_vaccinations.date
WHERE covid_deaths.continent IS NOT NULL AND total_cases IS NOT NULL AND excess_mortality IS NOT NULL AND (covid_vaccinations.excess_mortality / CAST(covid_deaths.total_cases AS float)) IS NOT NULL
ORDER BY covid_deaths.location, covid_deaths.date;