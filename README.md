# 🦠 COVID-19 Global Data Exploration Project
This project demonstrates in-depth exploration of global COVID-19 case and vaccination data using Microsoft SQL Server. The analysis investigates the pandemic’s impact on population infection rates, mortality, and vaccination progress across countries and continents.

🎯 Objective  
To:
- Analyze global infection, death, and vaccination trends
- Calculate death and infection percentages relative to population
- Use SQL techniques such as joins, window functions, temp tables, and views
- Summarize global and per-country insights over time

🧰 Tools Used  
- Microsoft SQL Server
- SQL Concepts:
- Window Functions (OVER, PARTITION BY)
- Common Table Expressions (CTEs)
- Temporary Tables
- Aggregations & Joins
- Data Type Conversion & Filtering

🪜 Steps Taken
- Selected core fields (location, date, total_cases, population, total_deaths)
- Calculated:
- Death rate = (total_deaths / total_cases) * 100
- Infection rate = (total_cases / population) * 100
- Identified:
- Countries with highest infection and death counts
- Continents with highest death totals
- Aggregated global stats to assess total mortality rates
- Joined Covid_Deaths and Covid_Vaccinations to:
- Track total vaccinations over time
- Create a rolling vaccinated count using window functions
- Estimate vaccination coverage by calculating % population vaccinated
- Created:
- CTE for calculating rolling and percent vaccinated
- Temporary Table PopulationVaccinated for reusability
- View PopulationVax for simplified downstream reporting

🗂️ Dataset
- Tables: Covid_Deaths and Covid_Vaccinations
- Fields Used:
- location, date, population, total_cases, total_deaths, new_vaccinations, new_vaccinations_smoothed
- Source: Public COVID-19 global datasets [(Our World in Data)](https://ourworldindata.org/covid-deaths)

📊 Data Visualization
- You can check my visualization for this project here -> [Covid Dashboard](https://public.tableau.com/app/profile/mark.anthony.baltazar/viz/CovidDashboard_17398551448910/Dashboard1)
