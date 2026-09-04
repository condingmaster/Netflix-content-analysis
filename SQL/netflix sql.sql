-- CREATE DATABASE netflix_analysis;
USE netflix_analysis;
-- CREATE TABLE netflix (
--     show_id VARCHAR(20),
--     type VARCHAR(20),
--     title VARCHAR(255),
--     director VARCHAR(255),
--     cast TEXT,
--     country VARCHAR(255),
--     date_added VARCHAR(50),
--     release_year INT,
--     rating VARCHAR(20),
--     duration VARCHAR(50),
--     listed_in VARCHAR(255),
--     description TEXT
-- );
-- DROP TABLE netflix;
-- Show Tables;
-- SELECT COUNT(*) AS total_rows
-- FROM netflix_titles;
-- DROP TABLE netflix_titles;
-- TRUNCATE TABLE netflix_titles;
 -- SELECT COUNT(*) AS total_rows
--  FROM netflix_titles;
-- SHOW VARIABLES LIKE 'local_infile';
-- SET GLOBAL local_infile = 1;
-- LOAD DATA LOCAL INFILE "E:/Netflix sql analysis/Data/netflix_titles.csv"
-- INTO TABLE netflix_titles
-- CHARACTER SET utf8mb4
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (show_id, type, title, director, cast, country, date_added,
--  release_year, rating, duration, listed_in, description);

-- SELECT COUNT(*) AS total_rows
-- FROM netflix_titles;

-- SELECT *
-- FROM netflix_titles
-- LIMIT 10;

-- DESCRIBE netflix_titles;

-- -- Check Movies vs TV Shows
-- SELECT
--     type,
--     COUNT(*) AS total_titles
-- FROM netflix_titles
-- GROUP BY type;

-- -- Check missing values
-- SELECT
--     COUNT(*) AS total_rows,
--     SUM(show_id IS NULL) AS missing_show_id,
--     SUM(type IS NULL) AS missing_type,
--     SUM(title IS NULL) AS missing_title,
--     SUM(director IS NULL) AS missing_director,
--     SUM(cast IS NULL) AS missing_cast,
--     SUM(country IS NULL) AS missing_country,
--     SUM(date_added IS NULL) AS missing_date_added,
--     SUM(release_year IS NULL) AS missing_release_year,
--     SUM(rating IS NULL) AS missing_rating,
--     SUM(duration IS NULL) AS missing_duration,
--     SUM(listed_in IS NULL) AS missing_genre,
--     SUM(description IS NULL) AS missing_description
-- FROM netflix_titles;

-- -- Step 3 — Check duplicates
-- SELECT
--     show_id,
--     COUNT(*) AS occurrences
-- FROM netflix_titles
-- GROUP BY show_id
-- HAVING COUNT(*) > 1;

-- -- check duplicate titles
-- SELECT
--     title,
--     COUNT(*) AS occurrences
-- FROM netflix_titles
-- GROUP BY title
-- HAVING COUNT(*) > 1
-- ORDER BY occurrences DESC;

-- ALTER TABLE netflix_titles
-- ADD COLUMN date_added_clean DATE;

-- SET SQL_SAFE_UPDATES = 0;

-- -- UPDATE netflix_titles
-- -- SET date_added_clean =
-- --     STR_TO_DATE(TRIM(date_added), '%M %d, %Y')
-- -- WHERE date_added IS NOT NULL;

-- SELECT COUNT(*) AS empty_dates
-- FROM netflix_titles
-- WHERE TRIM(date_added) = '';

-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE netflix_titles
-- SET date_added_clean =
--     STR_TO_DATE(TRIM(date_added), '%M %d, %Y')
-- WHERE date_added IS NOT NULL
--   AND TRIM(date_added) <> '';

-- SET SQL_SAFE_UPDATES = 1;

-- SELECT
--     date_added,
--     date_added_clean
-- FROM netflix_titles
-- WHERE date_added IS NOT NULL
--   AND TRIM(date_added) <> ''
-- LIMIT 10;

-- SELECT STR_TO_DATE('September 25, 2021', '%M %d, %Y') AS test_date;

-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE netflix_titles
-- SET date_added_clean = STR_TO_DATE(
--     TRIM(date_added),
--     '%M %d, %Y'
-- )
-- WHERE date_added IS NOT NULL
--   AND TRIM(date_added) <> '';

-- SET SQL_SAFE_UPDATES = 1;

-- SELECT
--     date_added,
--     date_added_clean
-- FROM netflix_titles
-- WHERE date_added_clean IS NOT NULL
-- LIMIT 10;

-- SELECT COUNT(*) AS converted_dates
-- FROM netflix_titles
-- WHERE date_added_clean IS NOT NULL;

-- SELECT COUNT(*) AS total_rows
-- FROM netflix_titles;

-- SELECT COUNT(*) AS converted_dates
-- FROM netflix_titles
-- WHERE date_added_clean IS NOT NULL;

-- SELECT COUNT(DISTINCT show_id) AS unique_show_ids
-- FROM netflix_titles;

-- SELECT COUNT(*) AS converted_dates
-- FROM netflix_titles
-- WHERE date_added_clean IS NOT NULL;

-- CREATE TABLE netflix_titles_backup AS
-- SELECT *
-- FROM netflix_titles;

-- SELECT COUNT(*) AS backup_rows
-- FROM netflix_titles_backup;

-- CREATE TABLE netflix_titles_clean LIKE netflix_titles;

-- INSERT INTO netflix_titles_clean
-- SELECT DISTINCT *
-- FROM netflix_titles;

-- SELECT COUNT(*) AS clean_rows
-- FROM netflix_titles_clean;

-- SELECT
--     COUNT(*) AS total_rows,
--     COUNT(DISTINCT show_id) AS unique_show_ids
-- FROM netflix_titles_clean;

-- RENAME TABLE netflix_titles
-- TO netflix_titles_duplicate;

-- RENAME TABLE netflix_titles_clean
-- TO netflix_titles;

-- SELECT COUNT(*) AS total_rows
-- FROM netflix_titles;

-- SELECT COUNT(DISTINCT show_id) AS unique_show_ids
-- FROM netflix_titles;

-- SELECT 
--     COUNT(*) AS total_rows,
--     COUNT(date_added_clean) AS converted_dates,
--     COUNT(DISTINCT show_id) AS unique_show_ids
-- FROM netflix_titles;

-- SELECT
--     date_added,
--     date_added_clean
-- FROM netflix_titles
-- LIMIT 10;

-- SELECT DISTINCT duration
-- FROM netflix_titles
-- ORDER BY duration;

-- Add two new columns

-- We want:

-- duration_minutes → for Movies
-- seasons → for TV Shows

-- ALTER TABLE netflix_titles
-- ADD COLUMN duration_minutes INT,
-- ADD COLUMN seasons INT;

-- DESCRIBE netflix_titles;

-- 	EXTRACT MOVIE DURATION
-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE netflix_titles
-- SET duration_minutes =
--     CASE
--         WHEN type = 'Movie'
--         THEN CAST(REPLACE(TRIM(duration), ' min', '') AS UNSIGNED)
--         ELSE NULL
--     END
-- WHERE type = 'Movie'
--   AND duration IS NOT NULL
--   AND TRIM(duration) <> '';

-- SET SQL_SAFE_UPDATES = 1;

-- Extract TV-show seasons
-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE netflix_titles
-- SET seasons =
--     CASE
--         WHEN type = 'TV Show'
--         THEN CAST(
--             REPLACE(
--                 REPLACE(TRIM(duration), ' Seasons', ''),
--                 ' Season',
--                 ''
--             ) AS UNSIGNED
--         )
--         ELSE NULL
--     END
-- WHERE type = 'TV Show'
--   AND duration IS NOT NULL
--   AND TRIM(duration) <> '';

-- SET SQL_SAFE_UPDATES = 1;

-- SELECT
--     title,
--     type,
--     duration,
--     duration_minutes,
--     seasons
-- FROM netflix_titles
-- LIMIT 20;

-- Check for missing duration

-- SELECT
--     COUNT(*) AS missing_duration
-- FROM netflix_titles
-- WHERE duration IS NULL
--    OR TRIM(duration) = '';
   
  --  Check movie duration statistics
  
  -- SELECT
--     MIN(duration_minutes) AS shortest_movie,
--     MAX(duration_minutes) AS longest_movie,
--     ROUND(AVG(duration_minutes), 2) AS average_movie_duration
-- FROM netflix_titles
-- WHERE type = 'Movie'
--   AND duration_minutes IS NOT NULL;
  
 --  Check TV-show season statistics
 
 -- SELECT
--     MIN(seasons) AS minimum_seasons,
--     MAX(seasons) AS maximum_seasons,
--     ROUND(AVG(seasons), 2) AS average_seasons
-- FROM netflix_titles
-- WHERE type = 'TV Show'
--   AND seasons IS NOT NULL;

-- Analyze Release Year & Netflix Additions

-- Create release_decade

-- ALTER TABLE netflix_titles
-- ADD COLUMN release_decade INT;

-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE netflix_titles
-- SET release_decade = FLOOR(release_year / 10) * 10
-- WHERE release_year IS NOT NULL;

-- SET SQL_SAFE_UPDATES = 1;

-- SELECT
--     title,
--     release_year,
--     release_decade
-- FROM netflix_titles
-- LIMIT 20;

-- Step 6 — Your First Real Analysis

-- Now we're moving from data cleaning → analysis.

-- Question 1: Movies vs TV Shows

-- SELECT
--     type,
--     COUNT(*) AS total_titles
-- FROM netflix_titles
-- GROUP BY type
-- ORDER BY total_titles DESC;

-- Question 2: Percentage of each type

-- SELECT
--     type,
--     COUNT(*) AS total_titles,
--     ROUND(
--         COUNT(*) * 100.0 /
--         (SELECT COUNT(*) FROM netflix_titles),
--         2
--     ) AS percentage
-- FROM netflix_titles
-- GROUP BY type;

-- Question 3: Content by release decade

-- SELECT
--     release_decade,
--     COUNT(*) AS total_titles
-- FROM netflix_titles
-- WHERE release_decade IS NOT NULL
-- GROUP BY release_decade
-- ORDER BY release_decade;

-- Question 4: Top 10 release years

-- SELECT
--     release_year,
--     COUNT(*) AS total_titles
-- FROM netflix_titles
-- GROUP BY release_year
-- ORDER BY total_titles DESC
-- LIMIT 10;

-- Question 5: Netflix additions by year

-- ALTER TABLE netflix_titles
-- ADD COLUMN date_added_year INT;

-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE netflix_titles
-- SET date_added_year = YEAR(date_added_clean)
-- WHERE date_added_clean IS NOT NULL;

-- SET SQL_SAFE_UPDATES = 1;

-- SELECT
--     date_added_year,
--     COUNT(*) AS titles_added
-- FROM netflix_titles
-- WHERE date_added_year IS NOT NULL
-- GROUP BY date_added_year
-- ORDER BY date_added_year;

-- Analyze Ratings

-- SELECT
--     rating,
--     COUNT(*) AS total_titles
-- FROM netflix_titles
-- WHERE rating IS NOT NULL
--   AND TRIM(rating) <> ''
-- GROUP BY rating
-- ORDER BY total_titles DESC;

-- SELECT
--     type,
--     rating,
--     COUNT(*) AS total_titles
-- FROM netflix_titles
-- WHERE rating IS NOT NULL
-- GROUP BY type, rating
-- ORDER BY type, total_titles DESC;

-- Analyze Netflix additions over time

-- Titles added each year

-- SELECT
--     date_added_year,
--     COUNT(*) AS titles_added
-- FROM netflix_titles
-- WHERE date_added_year IS NOT NULL
-- GROUP BY date_added_year
-- ORDER BY date_added_year;

-- Top years for Netflix additions

-- SELECT
--     date_added_year,
--     COUNT(*) AS titles_added
-- FROM netflix_titles
-- WHERE date_added_year IS NOT NULL
-- GROUP BY date_added_year
-- ORDER BY titles_added DESC
-- LIMIT 10;

-- Titles by decade

-- SELECT
--     release_decade,
--     COUNT(*) AS total_titles
-- FROM netflix_titles
-- WHERE release_decade IS NOT NULL
-- GROUP BY release_decade
-- ORDER BY release_decade;

-- Top release years

-- SELECT
--     release_year,
--     COUNT(*) AS total_titles
-- FROM netflix_titles
-- GROUP BY release_year
-- ORDER BY total_titles DESC
-- LIMIT 10;

-- Movie duration analysis

-- Average movie duration
-- SELECT
--     ROUND(AVG(duration_minutes), 2) AS average_movie_duration
-- FROM netflix_titles
-- WHERE type = 'Movie'
--   AND duration_minutes IS NOT NULL;
  
 --  Shortest and longest movies
 
 -- SELECT
--     MIN(duration_minutes) AS shortest_movie,
--     MAX(duration_minutes) AS longest_movie,
--     ROUND(AVG(duration_minutes), 2) AS average_movie_duration
-- FROM netflix_titles
-- WHERE type = 'Movie'
--   AND duration_minutes IS NOT NULL;
  
--   Top 10 longest movies

-- SELECT
--     title,
--     release_year,
--     duration_minutes
-- FROM netflix_titles
-- WHERE type = 'Movie'
--   AND duration_minutes IS NOT NULL
-- ORDER BY duration_minutes DESC
-- LIMIT 10;

-- TV Show season analysis

-- Average seasons

-- SELECT
--     ROUND(AVG(seasons), 2) AS average_seasons
-- FROM netflix_titles
-- WHERE type = 'TV Show'
--   AND seasons IS NOT NULL;
--   
 --  Shows with the most seasons
 
 -- SELECT
--     title,
--     release_year,
--     seasons
-- FROM netflix_titles
-- WHERE type = 'TV Show'
--   AND seasons IS NOT NULL
-- ORDER BY seasons DESC
-- LIMIT 10;

-- Countries with the most Movies

-- WITH RECURSIVE country_split AS (
--     SELECT
--         show_id,
--         type,
--         TRIM(SUBSTRING_INDEX(country, ',', 1)) AS country,
--         SUBSTRING(country, LENGTH(SUBSTRING_INDEX(country, ',', 1)) + 2) AS remaining
--     FROM netflix_titles
--     WHERE country IS NOT NULL
--       AND TRIM(country) <> ''

--     UNION ALL

--     SELECT
--         show_id,
--         type,
--         TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS country,
--         SUBSTRING(remaining, LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2) AS remaining
--     FROM country_split
--     WHERE remaining <> ''
-- )

-- SELECT
--     country,
--     COUNT(*) AS movie_count
-- FROM country_split
-- WHERE type = 'Movie'
-- GROUP BY country
-- ORDER BY movie_count DESC
-- LIMIT 10;

-- Countries with the most TV Shows

-- WITH RECURSIVE country_split AS (
--     SELECT
--         show_id,
--         type,
--         TRIM(SUBSTRING_INDEX(country, ',', 1)) AS country,
--         SUBSTRING(country, LENGTH(SUBSTRING_INDEX(country, ',', 1)) + 2) AS remaining
--     FROM netflix_titles
--     WHERE country IS NOT NULL
--       AND TRIM(country) <> ''

--     UNION ALL

--     SELECT
--         show_id,
--         type,
--         TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS country,
--         SUBSTRING(remaining, LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2) AS remaining
--     FROM country_split
--     WHERE remaining <> ''
-- )

-- SELECT
--     country,
--     COUNT(*) AS tv_show_count
-- FROM country_split
-- WHERE type = 'TV Show'
-- GROUP BY country
-- ORDER BY tv_show_count DESC
-- LIMIT 10;

-- First, inspect your genre data

SELECT listed_in
FROM netflix_titles
LIMIT 20;

WITH RECURSIVE genre_split AS (

    -- First genre
    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''

    UNION ALL

    -- Remaining genres
    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
)

SELECT
    genre,
    COUNT(*) AS total_titles
FROM genre_split
GROUP BY genre
ORDER BY total_titles DESC;

-- Find the top 10 genres

WITH RECURSIVE genre_split AS (
    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
)

SELECT
    genre,
    COUNT(*) AS total_titles
FROM genre_split
GROUP BY genre
ORDER BY total_titles DESC
LIMIT 10;

-- Movies vs TV Shows by genre

WITH RECURSIVE genre_split AS (
    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
)

SELECT
    genre,
    type,
    COUNT(*) AS total_titles
FROM genre_split
GROUP BY genre, type
ORDER BY genre, total_titles DESC;

-- Find the most popular genre for Movies

WITH RECURSIVE genre_split AS (
    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
)

SELECT
    genre,
    COUNT(*) AS movie_count
FROM genre_split
WHERE type = 'Movie'
GROUP BY genre
ORDER BY movie_count DESC
LIMIT 10;

-- Find the most popular genre for TV Shows

WITH RECURSIVE genre_split AS (
    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
)

SELECT
    genre,
    COUNT(*) AS tv_show_count
FROM genre_split
WHERE type = 'TV Show'
GROUP BY genre
ORDER BY tv_show_count DESC
LIMIT 10;

-- Which movie genres have the highest total catalog runtime?

WITH RECURSIVE genre_split AS (
    SELECT
        show_id,
        type,
        duration_minutes,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        duration_minutes,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
)

SELECT
    genre,
    COUNT(*) AS movie_count,
    ROUND(SUM(duration_minutes) / 60, 2) AS total_catalog_hours,
    ROUND(AVG(duration_minutes), 2) AS avg_movie_duration
FROM genre_split
WHERE type = 'Movie'
  AND duration_minutes IS NOT NULL
GROUP BY genre
ORDER BY total_catalog_hours DESC
LIMIT 10;

-- Top 10 countries overall

WITH RECURSIVE country_split AS (
    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(country, ',', 1)) AS country,
        SUBSTRING(
            country,
            LENGTH(SUBSTRING_INDEX(country, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE country IS NOT NULL
      AND TRIM(country) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS country,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM country_split
    WHERE remaining <> ''
)

SELECT
    country,
    COUNT(*) AS total_titles
FROM country_split
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Movies vs TV Shows by country

WITH RECURSIVE country_split AS (
    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(country, ',', 1)) AS country,
        SUBSTRING(
            country,
            LENGTH(SUBSTRING_INDEX(country, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE country IS NOT NULL
      AND TRIM(country) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS country,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM country_split
    WHERE remaining <> ''
)

SELECT
    country,
    SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movies,
    SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS tv_shows,
    COUNT(*) AS total_titles
FROM country_split
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Top 3 genres in each release decade

WITH RECURSIVE genre_split AS (

    -- Get the first genre
    SELECT
        show_id,
        release_decade,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''
      AND release_decade IS NOT NULL

    UNION ALL

    -- Get remaining genres
    SELECT
        show_id,
        release_decade,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
),

genre_counts AS (

    SELECT
        release_decade,
        genre,
        COUNT(*) AS total_titles
    FROM genre_split
    GROUP BY release_decade, genre
),

ranked_genres AS (

    SELECT
        release_decade,
        genre,
        total_titles,
        RANK() OVER (
            PARTITION BY release_decade
            ORDER BY total_titles DESC
        ) AS genre_rank
    FROM genre_counts
)

SELECT
    release_decade,
    genre,
    total_titles,
    genre_rank
FROM ranked_genres
WHERE genre_rank <= 3
ORDER BY release_decade, genre_rank;

-- Year-over-Year Growth

WITH yearly_content AS (
    SELECT
        date_added_year,
        COUNT(*) AS titles_added
    FROM netflix_titles
    WHERE date_added_year IS NOT NULL
    GROUP BY date_added_year
)

SELECT
    date_added_year,
    titles_added,
    
    LAG(titles_added) OVER (
        ORDER BY date_added_year
    ) AS previous_year_titles,

    titles_added -
    LAG(titles_added) OVER (
        ORDER BY date_added_year
    ) AS change_from_previous_year

FROM yearly_content
ORDER BY date_added_year;

WITH yearly_content AS (
    SELECT
        date_added_year,
        COUNT(*) AS titles_added
    FROM netflix_titles
    WHERE date_added_year IS NOT NULL
    GROUP BY date_added_year
)

SELECT
    date_added_year,
    titles_added,

    LAG(titles_added) OVER (
        ORDER BY date_added_year
    ) AS previous_year_titles,

    titles_added -
    LAG(titles_added) OVER (
        ORDER BY date_added_year
    ) AS change_from_previous_year,

    ROUND(
        (
            titles_added -
            LAG(titles_added) OVER (
                ORDER BY date_added_year
            )
        )
        /
        LAG(titles_added) OVER (
            ORDER BY date_added_year
        ) * 100,
        2
    ) AS growth_percentage

FROM yearly_content
ORDER BY date_added_year;

-- FIND TOP 10 DIRECTORS

WITH RECURSIVE director_split AS (

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(director, ',', 1)) AS director,
        SUBSTRING(
            director,
            LENGTH(SUBSTRING_INDEX(director, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE director IS NOT NULL
      AND TRIM(director) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS director,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM director_split
    WHERE remaining <> ''
)

SELECT
    director,
    COUNT(*) AS total_titles
FROM director_split
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

WITH RECURSIVE director_split AS (

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(director, ',', 1)) AS director,
        SUBSTRING(
            director,
            LENGTH(SUBSTRING_INDEX(director, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE director IS NOT NULL
      AND TRIM(director) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS director,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM director_split
    WHERE remaining <> ''
)

SELECT
    director,
    SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movies,
    SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS tv_shows,
    COUNT(*) AS total_titles
FROM director_split
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

-- Top 10 actors

WITH RECURSIVE cast_split AS (

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(cast, ',', 1)) AS actor,
        SUBSTRING(
            cast,
            LENGTH(SUBSTRING_INDEX(cast, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE cast IS NOT NULL
      AND TRIM(cast) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS actor,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM cast_split
    WHERE remaining <> ''
)

SELECT
    actor,
    COUNT(*) AS total_titles
FROM cast_split
GROUP BY actor
ORDER BY total_titles DESC
LIMIT 10;

-- Movies vs TV Shows for each actor

WITH RECURSIVE cast_split AS (

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(cast, ',', 1)) AS actor,
        SUBSTRING(
            cast,
            LENGTH(SUBSTRING_INDEX(cast, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE cast IS NOT NULL
      AND TRIM(cast) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS actor,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM cast_split
    WHERE remaining <> ''
)

SELECT
    actor,
    SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movies,
    SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS tv_shows,
    COUNT(*) AS total_titles
FROM cast_split
GROUP BY actor
ORDER BY total_titles DESC
LIMIT 10;

-- Country + Genre

WITH RECURSIVE genre_split AS (

    SELECT
        show_id,
        country,
        type,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''

    UNION ALL

    SELECT
        show_id,
        country,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
)

SELECT
    country,
    genre,
    COUNT(*) AS total_titles
FROM genre_split
GROUP BY country, genre
ORDER BY total_titles DESC
LIMIT 20;

-- Which year had the highest content growth?

WITH yearly_content AS (
    SELECT
        date_added_year,
        COUNT(*) AS titles_added
    FROM netflix_titles
    WHERE date_added_year IS NOT NULL
    GROUP BY date_added_year
),

growth AS (
    SELECT
        date_added_year,
        titles_added,
        LAG(titles_added) OVER (
            ORDER BY date_added_year
        ) AS previous_year_titles
    FROM yearly_content
)

SELECT
    date_added_year,
    titles_added,
    previous_year_titles,
    titles_added - previous_year_titles AS growth
FROM growth
WHERE previous_year_titles IS NOT NULL
ORDER BY growth DESC
LIMIT 1;

-- Top 3 genres by decade

WITH RECURSIVE genre_split AS (

    -- Step 1: Extract the first genre
    SELECT
        show_id,
        release_decade,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining

    FROM netflix_titles

    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''
      AND release_decade IS NOT NULL


    UNION ALL


    -- Step 2: Extract the remaining genres
    SELECT
        show_id,
        release_decade,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining

    FROM genre_split

    WHERE remaining <> ''
),


-- Step 3: Count titles for each genre in each decade
genre_counts AS (

    SELECT
        release_decade,
        genre,
        COUNT(*) AS total_titles

    FROM genre_split

    GROUP BY
        release_decade,
        genre
),


-- Step 4: Rank genres within each decade
ranked_genres AS (

    SELECT
        release_decade,
        genre,
        total_titles,

        RANK() OVER (
            PARTITION BY release_decade
            ORDER BY total_titles DESC
        ) AS genre_rank

    FROM genre_counts
)


-- Step 5: Show only the top 3
SELECT
    release_decade,
    genre,
    total_titles,
    genre_rank

FROM ranked_genres

WHERE genre_rank <= 3

ORDER BY
    release_decade,
    genre_rank;
    
   --  Which countries specialize in TV Shows vs Movies?
   
   WITH RECURSIVE country_split AS (

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(country, ',', 1)) AS country,
        SUBSTRING(
            country,
            LENGTH(SUBSTRING_INDEX(country, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE country IS NOT NULL
      AND TRIM(country) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS country,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM country_split
    WHERE remaining <> ''
),

country_counts AS (

    SELECT
        country,

        SUM(CASE
            WHEN type = 'Movie' THEN 1
            ELSE 0
        END) AS movies,

        SUM(CASE
            WHEN type = 'TV Show' THEN 1
            ELSE 0
        END) AS tv_shows,

        COUNT(*) AS total_titles

    FROM country_split
    GROUP BY country
)

SELECT
    country,
    movies,
    tv_shows,
    total_titles,

    ROUND(movies * 100.0 / total_titles, 2) AS movie_percentage,

    ROUND(tv_shows * 100.0 / total_titles, 2) AS tv_show_percentage

FROM country_counts
WHERE total_titles >= 50
ORDER BY tv_show_percentage DESC;

-- Which genres have the highest catalog runtime?

WITH RECURSIVE genre_split AS (
    SELECT
        show_id,
        type,
        duration_minutes,
        TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre,
        SUBSTRING(
            listed_in,
            LENGTH(SUBSTRING_INDEX(listed_in, ',', 1)) + 2
        ) AS remaining
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''

    UNION ALL

    SELECT
        show_id,
        type,
        duration_minutes,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS genre,
        SUBSTRING(
            remaining,
            LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2
        ) AS remaining
    FROM genre_split
    WHERE remaining <> ''
)

SELECT
    genre,
    COUNT(*) AS movie_count,
    ROUND(SUM(duration_minutes) / 60, 2) AS total_catalog_hours,
    ROUND(AVG(duration_minutes), 2) AS avg_movie_duration
FROM genre_split
WHERE type = 'Movie'
  AND duration_minutes IS NOT NULL
GROUP BY genre
ORDER BY total_catalog_hours DESC
LIMIT 10;

-- Which ratings dominate each content type?

SELECT
    type,
    rating,
    COUNT(*) AS total_titles,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY type),
        2
    ) AS percentage_of_type

FROM netflix_titles
WHERE rating IS NOT NULL
  AND TRIM(rating) <> ''

GROUP BY type, rating
ORDER BY type, total_titles DESC;

USE netflix_analysis;

CREATE OR REPLACE VIEW netflix_clean AS
SELECT *
FROM netflix_titles;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT *
FROM netflix_clean
LIMIT 10;



