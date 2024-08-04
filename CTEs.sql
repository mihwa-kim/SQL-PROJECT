-- Using Common Table Expressions (CTE)
-- A CTE allows you to define a subquery block that can be referenced within the main query.
-- It is particularly useful for recursive queries or queries that require referencing a higher level


WITH CTE_Example AS
(
SELECT gender, SUM(salary), AVG(salary), COUNT(salary), MIN(salary), MAX(salary)
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- directly after using it we can query the CTE
SELECT * FROM CTE_Example;

-- Now we can use the columns within this CTE to do calculations on this data that
-- we couldn't have done without it

WITH CTE_Example AS
(
SELECT gender, SUM(salary), AVG(salary), COUNT(salary), MIN(salary), MAX(salary)
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender 
)
SELECT gender, ROUND(AVG(`SUM(salary)`/`COUNT(salary)`),2)
FROM CTE_Example
GROUP BY gender;


-- We can also create multiple CTEs with just one WITH Expression
WITH CTE_Example AS (
SELECT employee_id, gender, birth_date
FROM employee_demographics dem
WHERE birth_date > '1985-01-01'
), -- just have to separate by using comma
CTE_Example2 AS(
SELECT employee_id, salary
FROM employee_ssalary sal
WHERE salary >= 50000
)
SELECT *
FROM CTE_Example t1
LEFT JOIN CTE_Example2 t2
ON t1.employee_id = t2.employee_id;


-- The last thing is that we can actually make our life easier by renaming the columns in the CTE

WITH CTE_Example (gender, sum_salary, min_salary, max_salary, count_salary) AS (
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT gender, ROUND(AVG(sum_salary/count_salary),2)
FROM CTE_Example
GROUP BY gender;




