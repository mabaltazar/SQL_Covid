-- Data Exploration

-- Let's check our data
SELECT *
FROM PortfolioProject.dbo.Covid_Deaths

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.Covid_Deaths
WHERE continent IS NOT NULL 
ORDER BY 1, 2

-- Look at total cases, total deaths and the percent
SELECT location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject.dbo.Covid_Deaths
-- Where Location like '%Philippines%'
ORDER BY 1, 2

-- Look at the population, the total covid case and the percentage
SELECT location,date, population, total_cases, (total_cases/population)*100 AS CovidPercentage
FROM PortfolioProject.dbo.Covid_Deaths
-- Where Location like '%Philippines%'
ORDER BY 1, 2

-- Countries with highest infection rate compared to total population
SELECT location, population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject.dbo.Covid_Deaths
-- Where Location like '%Philippines%'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

-- Let's look at countries with the highest death count
SELECT location, MAX(CAST(total_deaths AS BIGINT)) AS HighestDeathCount
FROM PortfolioProject.dbo.Covid_Deaths
--Where Location like '%Philippines%'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY HighestDeathCount DESC

-- Continent with highest death count
SELECT continent, MAX(CAST(total_deaths AS BIGINT)) AS HighestDeathCount
FROM PortfolioProject.dbo.Covid_Deaths
--Where Location like '%Philippines%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY HighestDeathCount DESC

-- Global Death Percentage
SELECT date, SUM(new_cases) AS total_case, SUM(CAST(new_deaths AS BIGINT)) AS total_deaths, SUM(CAST(new_deaths AS BIGINT))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject.dbo.Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2

-- Highest Global Death Percentage
SELECT SUM(new_cases) AS total_case, SUM(CAST(new_deaths AS BIGINT)) AS total_deaths, SUM(CAST(new_deaths AS BIGINT))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject.dbo.Covid_Deaths
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2

-- Total population vs Vaccinated per Day
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
FROM PortfolioProject.dbo.Covid_Deaths cd
JOIN PortfolioProject.dbo.Covid_Vaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
-- AND cv.new_vaccinations IS NOT NULL
ORDER BY 2, 3

-- Total population vs Vaccinated Rolling Count
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
	SUM(CAST(cv.new_vaccinations AS BIGINT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS RollingCount
FROM PortfolioProject.dbo.Covid_Deaths cd
JOIN PortfolioProject.dbo.Covid_Vaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
-- AND cv.new_vaccinations IS NOT NULL
ORDER BY 2, 3 

-- CTE

WITH PopVsVac (continent, location, date, population, new_vaccinations_smoothed, RollingCount)
AS
(
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations_smoothed,
SUM(CAST(cv.new_vaccinations_smoothed AS BIGINT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS RollingCount
FROM PortfolioProject.dbo.Covid_Deaths cd
JOIN PortfolioProject.dbo.Covid_Vaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
)

SELECT *, (RollingCount/Population)*100 AS VaccinatedPercentage
FROM PopVsVac
WHERE RollingCount IS NOT NULL

-- Temp table

DROP TABLE IF exists PopulationVaccinated
CREATE TABLE PopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingCount numeric
)

INSERT INTO PopulationVaccinated
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(CAST(cv.new_vaccinations AS BIGINT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS RollingCount
FROM PortfolioProject.dbo.Covid_Deaths cd
JOIN PortfolioProject.dbo.Covid_Vaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
--Where cd.continent IS NOT NULL
ORDER BY 2, 3

SELECT *, (RollingCount/Population)*100 AS VaccinatedPercentage
FROM PopulationVaccinated


-- Create View 

CREATE VIEW PopulationVax AS
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(CAST(cv.new_vaccinations AS BIGINT)) OVER (PARTITION BY cd.Location ORDER BY cd.location, cd.date) AS RollingCount
FROM PortfolioProject.dbo.Covid_Deaths cd
JOIN PortfolioProject.dbo.Covid_Vaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL