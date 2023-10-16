-- procedures
select * from tbl_Employees

Create Procedure GetHighSalary
	@threshold int
as
Begin
	select first_name, salary, department
	from tbl_Employees
	where salary >= @threshold
end;

Exec GetHighSalary @threshold = 20000