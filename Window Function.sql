-- Window funcs are really powerful and are somewhat like a group by - except they don't roll everything up into 1 row when grouping.
-- To look at a partition or a group, but they keep their own unique rows in the output
-- Row Numbers, Rank, Dense Rank

SELECT gender, ROUND(AVG(salary),1)
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender;

SELECT dem.employee_id, dem.first_name, gender, salary, AVG(salary) OVER()
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id ;

SELECT dem.employee_id, dem.first_name, gender, salary, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id ;

SELECT dem.employee_id, dem.first_name, gender, salary, AVG(salary) OVER(PARTITION BY gender ORDER BY employee_id)
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id ;


SELECT dem.employee_id, dem.first_name, gender, salary, ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc)
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id ;

SELECT dem.employee_id, dem.first_name, gender, salary, ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
  RANK() OVER(PARTITION BY gender ORDER BY salary desc) rank_1 -- notice rank repeats on tom and jerry at 5, but then skips 6 to 7
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id ;



SELECT dem.employee_id, dem.first_name, gender, salary, ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
  RANK() OVER(PARTITION BY gender ORDER BY salary desc) rank_1,
  DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary desc) dense_rank_2 -- this is numericallly ordered instead of positional like rank
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id ;
