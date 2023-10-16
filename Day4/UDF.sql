-- user defined functions

-- scaler function
CREATE FUNCTION dbo.CalculateSquare(@input INT)
RETURNS INT
AS
BEGIN
	RETURN @input * @input
END;

SELECT dbo.CalculateSquare(7)

-- Table valued function
CREATE TABLE tbl_Employees (
	EmpId int primary key identity(1,1),
	first_name varchar(20),
	last_name varchar(20),
	salary int,
	department varchar(20),
	city varchar(20),
);

INSERT INTO tbl_Employees (first_name, last_name, salary, department, city)
VALUES
('Akshat', 'Kumar', 25000, '.NET', 'Delhi'),
('Govind', 'Sharma', 17000, 'Nodejs', 'Noida'),
('Ajay', 'Bohra', 20000, 'Python', 'Delhi'),
('Yash', 'Behl', 30000, 'Java', 'Gurugram'),
('Prine', 'Kumar', 19000, 'React Native', 'Greater Noida'),
('Utkarsh', 'Srivatsav', 18000, 'PHP', 'Noida');

select * from tbl_Employees

CREATE FUNCTION dbo.GetHigherSalary(@threshold INT)
RETURNS TABLE
AS
RETURN 
(
	SELECT first_name, department
	FROM tbl_Employees
	WHERE salary >= @threshold
);

SELECT * FROM dbo.GetHigherSalary(20000)
	