-- Joins

-- Joins allow you to combine 2 tables together (or more) if they have a common column.
-- doesn't mean they need the same column name, but the data in it are the same and can be used to join the tables together
-- inner joins, outer join, self join

SELECT * FROM employee_demographics;

SELECT * FROM employee_salary;

-- INNTER JOIN
SELECT * FROM employee_demographics
JOIN employee_salary
ON employee_demographics.employee_id = employee_salary.employee_id;

-- use aliasing
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
ON dem.employee_id = sal.employee_id;

-- OUTER JOIN
SELECT * FROM employee_salary sal
LEFT JOIN employee_demographics dem
ON dem.employee_id = sal.employee_id;

-- RIGHT JOIN
SELECT * FROM employee_salary sal
RIGHT JOIN employee_demographics dem
ON dem.employee_id = sal.employee_id;

-- SELF JOIN
SELECT * FROM employee_salary;

SELECT * FROM employee_salary t1
JOIN employee_salary t2
ON t1.employee_id = t2.employee_id;

-- now let's change it to give them their secret santa
SELECT * FROM employee_salary t1 JOIN employee_salary t2
ON t1.employee_id + 1 = t2.employee_id;

SELECT t1.employee_id as emp_santa, t1.first_name as santa_first_name, t1.last_name as santa_last_name, t2.employee_id, t2.first_name, t2.last_name
FROM employee_salary t1 JOIN employee_salary t2 
ON t1.employee_id + 1 = t2.employee_id;

-- Joining multiple tables
-- now we have on other table we can join 
SELECT * FROM parks_and_recreation.parks_departments;

SELECT * FROM employee_demographics dem
  INNER JOIN employee_salary sal
  ON dem.employee_id = sal.employee_id
  JOIN parks_departments dept
  ON dept.department_id = sal.dept_id;


-- now notice when we did that, since it's an inner join it got rid of and because he wasn't a part of any department
-- if we do a left join we would still include him because we are taking everything from the left table which is the salary table in this instance
SELECT * FROM employee_demographics dem
INNER JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
ON dept.department_id = sal.dept_id;



