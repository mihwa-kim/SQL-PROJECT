-- Triggers
-- a Trigger is a block of code that executes automatically executes when an event takes place in a table.

-- for example, we have these 2 tables, invoice and payments - when a client makes a payment we want it to update the invoice field "total paid"
-- to reflect that the Client has indeed paid their invoice

SELECT * FROM employee_salary;

SELECT * FROM employee_demographics;

-- so really when we get a new row or data is inserted into the payments table we want a trigger to update the correct invoice
-- with the amount that was paid
-- so let's write this out
USE parks_and_recreation;

DELIMITER $$
CREATE TRIGGER employee_insert2
		AFTER INSERT ON employee_salary
        FOR EACH ROW
        BEGIN
			INSERT INTO employee_demographics (employee_id, first_name, last_name)
            VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
        END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

DELETE FROM employee_salary
WHERE employee_id = 13;

-- Events (Jobs in MSSQL)
-- Now I usually call these "Jobs" because I called them that for years in MSSQL, but in MySQL they're called Events

-- Events are task or block of code that gets executed according to a schedule. These are fantastic for so many reasons. Importing data on a schedule.
-- Scheduling reports to be exported to files and so many other things
-- you can schedule all of this to happen every day, every monday, every first of the month at 10am. Really whenever you want
-- This really helps with automation in MySQL

SELECT * FROM parks_and_recreation.employee_demographics;

SHOW EVENTS;
DROP EVENT IF EXISTS delete_retirees;
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 MINUTE
DO BEGIN
	DELETE
    FROM parks_and_recreation.employee_demographics
    WHERE age >= 60;
END $$

SELECT *
FROM employee_demographics;















