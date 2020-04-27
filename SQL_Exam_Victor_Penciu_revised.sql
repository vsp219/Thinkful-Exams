-- 
-- SQL self-sufficiency exam
-- Victor Penciu


-- 1.
-- Write a query that allows you to inspect the schema 
-- of the naep table.

SELECT
	COLUMN_NAME
FROM
	information_schema.COLUMNS
WHERE
	TABLE_NAME = 'naep';



-- 2.
-- Write a query that returns the first 50 records 
-- of the naep table
--
SELECT * 
FROM naep 
LIMIT 50



-- 3.
-- Write a query that returns summary statistics for 
-- avg_math_4_score by state. Make sure to sort the results 
-- alphabetically by state name.

SELECT state, 
COUNT (avg_math_4_score) AS count_score, 
AVG (avg_math_4_score) AS avg_score,
MIN (avg_math_4_score) AS min_score,
MAX (avg_math_4_score) AS max_score
FROM naep
GROUP BY state
ORDER BY state



-- 4.
-- Write a query that alters the previous query so that 
-- it returns only the summary statistics for avg_math_4_score 
-- by state with differences in max and min values that are 
-- greater than 30.

SELECT *
FROM (
SELECT state, 
COUNT (avg_math_4_score) AS count_score, 
AVG (avg_math_4_score) AS avg_score,
MIN (avg_math_4_score) AS min_score,
MAX (avg_math_4_score) AS max_score
FROM naep
GROUP BY state 
ORDER BY state) AS a
WHERE (max_score - min_score) >30




-- Analyzing data
-- You want to report the bottom 10 performing states for avg_math_4_score in the year 2000. 
-- You also want to report the states that scored below the average avg_math_4_score over 
-- all states in the year 2000.

-- 5.
-- Write a query that returns a field called bottom_10_states that lists the states 
-- in the bottom 10 for avg_math_4_score in the year 2000.

SELECT state AS bottom_10_states, avg_math_4_score, year
FROM naep
WHERE avg_math_4_score IS NOT NULL AND year = 2000
ORDER BY avg_math_4_score
Limit 10



-- 6. 
-- Write a query that calculates the average avg_math_4_score rounded to the 
-- nearest 2 decimal places over all states in the year 2000.

SELECT year, ROUND(AVG(avg_math_4_score), 2) AS avg_score_all_states
FROM naep
WHERE year = 2000
GROUP BY year



-- 7.
-- Write a query that returns a field called below_average_states_y2000 that lists all states 
-- with an avg_math_4_score less than the average over all states in the year 2000.

SELECT state AS below_average_states_y2000, avg_math_4_score
FROM naep
WHERE avg_math_4_score < 
      (SELECT AVG(avg_math_4_score)
	   FROM naep
	  WHERE year = 2000) AND year = 2000
GROUP BY state, avg_math_4_score
ORDER BY avg_math_4_score



-- 8. 
-- Write a query that returns a field called scores_missing_y2000 that lists any states with 
-- missing values in the avg_math_4_score column of the naep data table for the year 2000.

SELECT state AS scores_missing_y2000, avg_math_4_score
FROM naep
WHERE avg_math_4_score IS NULL AND year = 2000
GROUP BY state, avg_math_4_score



-- 9.
-- Write a query that returns for the year 2000 the state, avg_math_4_score, and 
-- total_expenditure from the naep table left outer joined with the finance table, 
-- using id as the key and ordered by total_expenditure greatest to least. 
-- Be sure to round avg_math_4_score to the nearest 2 decimal places, and then 
-- filter out NULL avg_math_4_scores in order to see any correlation more clearly.

SELECT n.state, ROUND(n.avg_math_4_score, 2) AS avg_math_4_score, f.total_expenditure AS total_expenditures
FROM naep AS n
LEFT OUTER JOIN
finance AS f
ON n.id = f.id
WHERE n.year = 2000 AND avg_math_4_score IS NOT NULL
ORDER BY total_expenditures DESC



