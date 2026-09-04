# Netflix Content Analysis 

A data analysis project exploring trends in Netflix's content catalog using **SQL** for data querying and **Power BI** for interactive dashboard visualization.

## Project Overview

This project analyzes Netflix's library of movies and TV shows to uncover patterns in content type, genre distribution, release trends, and country of origin. The goal was to derive actionable insights into how Netflix's catalog has evolved over time.

## Tools & Technologies

- SQL – Data cleaning, querying, and aggregation
- Power BI – Interactive dashboard and data visualization

## Dataset

- Source: [ Kaggle "Netflix Movies and TV Shows"]
- Size: [8807] titles, [17] columns
- Fields: title, type (Movie/TV Show), genre, country, release year, rating,date_added_clean,duration_time, seasons, show_id, 
  director

## What I Did

- Cleaned and transformed raw data using SQL (handled nulls, duplicates, inconsistent formatting)
- Wrote SQL queries using **[ window functions / CTEs / aggregations,RAG , LAG]** 
  - How has the Movie vs. TV Show ratio changed over time?
  - Which genres and countries contribute the most content?
  - What are the trends in content additions year-over-year?
- Built a multi-page Power BI dashboard with **[Add number]** visuals and interactive slicers/filters

## Dashboard Preview

![Dashboard Overview]("C:\Users\SHAURYA\Pictures\Screenshots\Screenshot 2026-09-04 215326.png")

## Repository Structure

```
netflix-content-analysis-sql-powerbi/
├── README.md
├── netflix_analysis.pbix
├── queries/
│   └── analysis sql.sql
├── images/
│   ├── dashboard-overview.png
└── DATA
    └── netflix_titles.csv 
```

## How to View

1. Clone or download this repository
2. Open `netflix_analysis.pbix` in Power BI Desktop to explore the interactive dashboard
3. SQL queries used for analysis are available in the `queries/` folder

## Contact

**Shaurya Bisht**
📧 bishtshaurya003@gmail.com
🔗  [condingmaster]
