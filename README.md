# 🦠 COVID-19 Data Exploration Project  
This project features end-to-end data cleaning and exploratory analysis on global layoff data using SQL. The goal was to uncover patterns in workforce reduction across industries, companies, and countries over time. The project also applies advanced SQL techniques to track temporal trends, remove duplicates, standardize messy entries, and evaluate the scale and progression of layoffs.  

🎯 Objective  
To clean and analyze layoff data by:  
- Identifying key trends in layoffs across time and geography
- Profiling the most heavily affected companies and industries
- Applying SQL best practices for scalable and efficient exploratio

🧰 Tools Used
- Microsoft SQL Server
- SQL Window Functions, CTEs, Temp Tables  

⚙️ Steps Taken  
- Created Staging Tables to isolate and clean raw data
- Removed duplicate records using ROW_NUMBER() and deleted flagged rows
- Standardized text fields (trimming whitespace, fixing country and industry names)
- Formatted date column into proper DATE type using STR_TO_DATE()
- Imputed missing industry values using self-joins on company + location
- Deleted records with unusable NULL values
- Explored temporal trends by year, month, and rolling cumulative totals
- Ranked top companies per year by layoff volume using DENSE_RANK()  

📊 Analysis Highlights  
- Highest Total Layoffs: Identified top companies and industries affected
- Percentage-Based Layoffs: Flagged companies with 100% workforce reductions
- Industry & Country Breakdown: Analyzed layoffs by geography and sector
- Rolling Totals: Used window functions to compute cumulative monthly layoffs
- Yearly Rankings: Pinpointed top 5 companies with most layoffs per year

🗂️ Dataset  
- You can find the dataset [here](https://ourworldindata.org/covid-deaths)
- Fields include: company, industry, location, total_laid_off, percentage_laid_off, date, country, funds_raised_millions, etc.



