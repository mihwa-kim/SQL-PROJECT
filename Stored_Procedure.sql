-- Stored Procedures

CREATE PROCEDURE large_salaries()
SELECT * 
FROM employee_salary
WHERE salary >= 60000;

CALL large_salaries();


-- wrong way to use stored procedure to store several queries.
-- If we tried to add another query to this stored procedure it wouldn't work. It's a separate query:
CREATE PROCEDURE large_salary2()
SELECT *
FROM employee_salary
WHERE salary >= 60000;
SELECT *
FROM employee_salary
WHERE salary >= 100000;

DELIMITER $$
CREATE PROCEDURE large_salary2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 100000;
END $$
DELIMITER ;


USE `parks_and_recreation`;
DROP procedure IF EXISTS `large_salaries3`; 
DELIMITER $$
CREATE PROCEDURE large_salary2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 100000;
END $$
DELIMITER ;

-- We can also add params
USE `parks_and_recreation`;
DROP procedure IF EXISTS `large_salaries3`; 

DELIMITER $$
CREATE PROCEDURE large_salaries3(employee_id_param INT)
BEGIN
	SELECT * FROM employee_salary
    WHERE salary >= 60000 
    AND employee_id = employee_id_param;
END $$
DELIMITER ;

CALL large_salaries3(1);









