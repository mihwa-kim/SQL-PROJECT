-- These help us change and look at strings differently.

SELECT LENGTH('sky');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics;

SELECT UPPER('sky');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

SELECT LOWER('sky');

SELECT first_name, LOWER(first_name)
FROM employee_demographics;

SELECT TRIM('     sky');
SELECT LTRIM('     I      love    you    ');
SELECT RTRIM('     I      love    you    ');

-- LEFT is going to allow us to take a certain amount of strings from the left hand side.
SELECT LEFT('mihwakim',4);
SELECT first_name, LEFT(first_name,4)
FROM employee_demographics;

SELECT RIGHT('mihwakim',4);
SELECT first_name, RIGHT(first_name,4)
FROM employee_demographics;

-- SUBSTRING, specify a starting point and how many chars you want so you can take chars from anywhere in the string.
SELECT SUBSTRING('Lecture today was about researching.',2,3);
SELECT birth_date, SUBSTRING(birth_date, 1,4) AS birth_year
FROM employee_demographics;

-- REPLACE
SELECT REPLACE(first_name,'a','z')
  FROM employee_demographics;


-- LOCATE: It will return the position of the character in the string.
SELECT LOCATE('x', 'Alexander');

SELECT LOCATE('e', 'Alexander');
-- It will return the location of just the first pos.

SELECT first_name, LOCATE('a', first_name)
FROM employee_demographics;

SELECT first_name, LOCATE('Mic', first_name)
FROM employee_demographics;

SELECT CONCAT('Mihwa','Kim');

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;







