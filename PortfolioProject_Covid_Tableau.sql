-- Queries used for Tableau Visualization

-- 1. Table 1
SELECT date, SUM(new_cases) AS total_case, SUM(CAST(new_deaths AS BIGINT)) AS total_deaths, SUM(CAST(new_deaths AS BIGINT))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject.dbo.Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2


-- 2. Table 2
-- European Union is part of Europe

SELECT location, SUM(CAST(new_deaths AS BIGINT)) AS TotalDeathCount
FROM PortfolioProject.dbo.Covid_Deaths
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount DESC


-- 3. Table 3
SELECT location, population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject.dbo.Covid_Deaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC


-- 4. Table 4
SELECT location, population,date, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject.dbo.Covid_Deaths
GROUP BY location, population, date
ORDER BY PercentPopulationInfected DESC