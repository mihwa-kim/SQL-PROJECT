-- Case Statements
-- A case Statement allows you to add logic to your SELECT statements, sort of like an if else statement in other programming languages or even things like Excel

SELECT * FROM employee_demographics;

SELECT first_name, last_name,
CASE 
  WHEN age <= 30 THEN 'Young'
END
FROM employee_demographics;


SELECT first_name, last_name,
CASE
  WHEN age <= 30 THEN 'Young'
  WHEN age BETWEEN 31 AND 50 THEN 'Old'
  WHEN age >= 51 THEN "On Death's Door"
END
FROM employee_demographics;

-- Simple Labeling
SELECT first_name, last_name, salary,
CASE
  WHEN salary > 45000 THEN salary + (salary * 0.05)
  WHEN salary < 45000 THEN salary + (salary * 0.07)
END AS new_salary
FROM employee_salary;

-- Plus account for Bonuses
SELECT first_name, last_name, salary,
CASE
  WHEN salary > 45000 THEN salary + (salary * 0.05)
  WHEN salary < 45000 THEN salary + (salary * 0.07) 
END AS new_salary,
CASE
  WHEN dept_id = 6 THEN salary * .10
END AS Bonus
FROM employee_salary;

