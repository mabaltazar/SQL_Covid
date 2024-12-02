Select *
From ProjectNo1.dbo.['CovidDeaths']
Order By 3,4

--Select *
--From ProjectNo1.dbo.['CovidVaccination']
--Order By 3,4

-- Data that we'll be using

Select Location,Date, total_cases, new_cases, total_deaths, Population
From ProjectNo1.dbo.['CovidDeaths']
Order By 1,2

-- Looking at total cases vs total deaths

Select Location,Date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPct
From ProjectNo1.dbo.['CovidDeaths']
--Where Location like '%Philippines%'
Order By 1,2

-- Look at total cases vs population
-- Percentage of population got covid

Select Location,Date, Population, total_cases, (total_cases/Population)*100 AS CovidPercentage
From ProjectNo1.dbo.['CovidDeaths']
--Where Location like '%Philippines%'
Order By 1,2

-- Countries with highest infection rate compared to total population

Select Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/Population))*100 AS InfectionPercentage
From ProjectNo1.dbo.['CovidDeaths']
--Where Location like '%Philippines%'
Group By Location, Population
Order By InfectionPercentage DESC

-- Countries with highest death count per population

Select Location, MAX(CAST(total_deaths AS BIGINT)) AS HighestDeathCount
From ProjectNo1.dbo.['CovidDeaths']
--Where Location like '%Philippines%'
Where continent IS NOT NULL
Group By Location
Order By HighestDeathCount DESC

-- Continent with highest death count

Select location, MAX(CAST(total_deaths AS BIGINT)) AS HighestDeathCount
From ProjectNo1.dbo.['CovidDeaths']
--Where Location like '%Philippines%'
Where continent IS NULL
Group By location
Order By HighestDeathCount DESC

Select continent, MAX(CAST(total_deaths AS BIGINT)) AS HighestDeathCount
From ProjectNo1.dbo.['CovidDeaths']
--Where Location like '%Philippines%'
Where continent IS NOT NULL
Group By continent
Order By HighestDeathCount DESC

-- Global Death Percentage

Select date, SUM(new_cases) AS total_case, SUM(Cast(new_deaths AS bigint)) AS total_deaths, SUM(Cast(new_deaths as bigint))/SUM(new_cases)*100 AS DeathPercentage
From ProjectNo1.dbo.['CovidDeaths']
Where continent IS NOT NULL
Group By date
Order By 1,2

-- Highest Global Death Percentage

Select SUM(new_cases) AS total_case, SUM(Cast(new_deaths AS bigint)) AS total_deaths, SUM(Cast(new_deaths as bigint))/SUM(new_cases)*100 AS DeathPercentage
From ProjectNo1.dbo.['CovidDeaths']
Where continent IS NOT NULL
--Group By date
Order By 1,2

-- Total population vs Vaccinated per Day

Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
From ProjectNo1..['CovidDeaths'] cd
Join ProjectNo1..['CovidVaccination'] cv
	ON cd.location = cv.location
	And cd.date = cv.date
Where cd.continent IS NOT NULL
Order By 2,3 

-- Total population vs Vaccinated Rolling Count

Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(cast(cv.new_vaccinations as bigint)) OVER (Partition By cd.Location Order By cd.Location, cd.Date) AS RollingCount
From ProjectNo1..['CovidDeaths'] cd
Join ProjectNo1..['CovidVaccination'] cv
	ON cd.location = cv.location
	And cd.date = cv.date
Where cd.continent IS NOT NULL
Order By 2,3 


-- CTE

With PopVsVac (Continent, Location, Date, Population, New_vaccinations, RollingCount)
AS
(
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(cast(cv.new_vaccinations as bigint)) OVER (Partition By cd.Location Order By cd.Location, cd.Date) AS RollingCount
From ProjectNo1..['CovidDeaths'] cd
Join ProjectNo1..['CovidVaccination'] cv
	ON cd.location = cv.location
	And cd.date = cv.date
Where cd.continent IS NOT NULL
)

Select *, (RollingCount/Population)*100 AS VaccinatedPercentage
From PopVsVac

-- Temp table

Drop table if exists PopulationVaccinated
Create table PopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingCount numeric
)

Insert Into PopulationVaccinated
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(cast(cv.new_vaccinations as bigint)) OVER (Partition By cd.Location Order By cd.Location, cd.Date) AS RollingCount
From ProjectNo1..['CovidDeaths'] cd
Join ProjectNo1..['CovidVaccination'] cv
	ON cd.location = cv.location
	And cd.date = cv.date
--Where cd.continent IS NOT NULL
Order by 2,3

Select *, (RollingCount/Population)*100 AS VaccinatedPercentage
From PopulationVaccinated

-- Create View 

Create View PopulationVax AS
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(cast(cv.new_vaccinations as bigint)) OVER (Partition By cd.Location Order By cd.Location, cd.Date) AS RollingCount
From ProjectNo1..['CovidDeaths'] cd
Join ProjectNo1..['CovidVaccination'] cv
	ON cd.location = cv.location
	And cd.date = cv.date
Where cd.continent IS NOT NULL
--Order by 2,3