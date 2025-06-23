# 🦠 COVID-19 Data Exploration Project  
This project showcases exploratory data analysis on global COVID-19 data using Microsoft SQL Server. The analysis was conducted on publicly available datasets containing case counts, deaths, population figures, and vaccination statistics. The goal was to uncover patterns in infections, death rates, population impact, and vaccine rollout trends across countries and continents.

🧰 Tools Used
- Microsoft SQL Server
- SQL Window Functions, CTEs, Temp Tables, Views
- COVID-19 Datasets (Deaths and Vaccinations)

📊 Key Explorations
- Total cases and deaths by country, with calculated death percentages
- Infection rates as a percentage of country population
- Top countries by infection rate and death count
- Death rates by continent and aggregated global death percentage
- Analysis of vaccination rollout by location and time
- Rolling vaccination totals using window functions
- Percentage of population vaccinated using CTEs and temp tables

🧮 SQL Logic Summary
- Joins between deaths and vaccination tables on location and date
- Aggregations for daily and cumulative trends
- Window functions to compute running totals and vaccination rollouts
- CTEs and Temp Tables to cleanly structure staged calculations
- Views created for reusable vaccination metrics per country



