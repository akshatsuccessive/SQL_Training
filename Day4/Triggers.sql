-- triggers
select db_name()

select name, crdate
from SYSOBJECTS
WHERE xtype = 'U'

create table tbl_Employees2(
	Empid int,
	first_name varchar(20),
	second_name varchar(20),
	salary int
);
create table tbl_EmployeeAuditLog(
	Logid int primary key identity(1,1),
	Action Nvarchar(20),
	Empid INT,
	LogDate DATETIME
);
drop table tbl_EmployeeAuditLog


Create Trigger AuditEmployeeChanges
ON tbl_Employees2
After INSERT, UPDATE, DELETE
as 
begin
	Declare @Action nvarchar(50)

	If exists (Select * from inserted)
	begin
		If exists (Select * from deleted)
			Set @Action = 'UPDATE';
		else
			Set @Action = 'INSERT';
	end
	else
		Set @Action = 'DELETE';

	Insert Into tbl_EmployeeAuditLog(Action, Empid, LogDate)
	select @Action, Empid, GETDATE()
	From inserted;
end;

Insert into tbl_Employees2
values
(1, 'Akshat', 'Kumar', 25000);

select * from tbl_Employees2
select * from tbl_EmployeeAuditLog

update tbl_Employees2 set salary = 50000 where Empid = 1

delete from tbl_Employees2 where Empid = 1