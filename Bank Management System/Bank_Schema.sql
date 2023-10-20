create database DB_BANK
use DB_BANK

create table tbl_customers(
	CustomerId int identity(1,1) primary key,
	FirstName varchar(50),
	LastName varchar(50),
	Age int,
	Date_of_birth date,
	Cust_Address varchar(100),
	MobileNo bigint,
	BranchId int,
	Foreign key (BranchId) references tbl_branch(BranchId)
)

create table tbl_employees(
	EmpId int identity(1,1) primary key,
	FirstName varchar(50),
	LastName varchar(50),
	Age int,
	Date_of_birth date,
	Emp_Address varchar(100),
	MobileNo bigint,
	BranchId int,
	Foreign key (BranchId) references tbl_branch(BranchId)
)

create table tbl_accounts(
	Acc_Number bigint primary key,
	Acc_Type varchar(50),
	Balance int,
	Date_of_opening date,
	Acc_Status varchar(50),
	CustomerId int,
	Foreign key (CustomerId) references tbl_customers(CustomerId)
)

create table tbl_transactions(
	TransactionId int identity(1,1) primary key,
	TransactionType varchar(50),
	Amount int,
	TransactionDate datetime,
	Sender_Acc_Number bigint,
	Receiver_Acc_Number bigint,
	Foreign key (Sender_Acc_Number) references tbl_accounts(Acc_Number),
	Foreign key (Receiver_Acc_Number) references tbl_Accounts(Acc_Number)
)


create table tbl_Loan(
	LoanId int identity(1,1) primary key,
	Loan_Amount int,
	Interest_Rate float,
	Time_In_Year int,
	Starting_Date date,
	Ending_Date date,
	Loan_Type varchar(50),
	CustomerId int,
	Foreign key(CustomerId) references tbl_customers(CustomerId)
)


create table tbl_branch(
	BranchId int identity(1,1) primary key,
	BranchName varchar(50),
	BranchAddress varchar(50),
	IFSC bigint,
	MobileNo bigint
)


select * from tbl_branch
select * from tbl_customers
select * from tbl_employees
select * from tbl_accounts
select * from tbl_transactions
select * from tbl_Loan


insert into tbl_branch 
values
('HDFC', 'Noida sec 18', 2983, 01123747635),
('HDFC', 'Sarojini Nagar', 2984, 01123747438),
('HDFC', 'Dwarka mor', 2985, 01123749024),
('HDFC', 'Greater Noida', 2986, 01123749033),
('HDFC', 'Rohini', 2987, 01123742782)

insert into tbl_customers 
values
('Akshat', 'Kumar', 21, '2002-01-24', 'Laxmi Bai Nagar', 9043279341, 3),
('Govind', 'Sarmah', 22, '2001-09-10', 'Sultanpuri', 9203142902, 3),
('Yash', 'Behl', 20, '2002-02-10', 'Faridabad', 8028037299, 3),
('Utkarsh', 'Srivatsav', 21, '2001-12-20', 'Dwarka', 9038279272, 1),
('Ajay', 'Bohra', 22, '2001-07-31', 'Pallam', 9193736828, 2),
('Price', 'Kumar', 21, '2001-12-04', 'Noida', 7862991789, 5)


insert into tbl_employees
values
('John', 'Doe', 54, '1970-09-18', 'Noida', 9327011922, 1),
('Ash', 'Ketchum', 50, '1973-01-10', 'Gurugram', 8920012473, 3),
('Ramesh', 'Kumar', 35, '1998-02-26', 'Greater Noida', 8792992130, 1),
('Suresh', 'Kumar', 41, '1982-11-11', 'Dwarka', 81382792256, 2),
('Ajay', 'Singh', 40, '1983-05-06', 'Rohini', 8073736866, 4)


insert into tbl_accounts
values
(8941771, 'Savings', 25000, getdate(), 'open', 2),
(8948932, 'Savings', 100, getdate(), 'closed', 1),
(8942002, 'Current', 100000, getdate(), 'open', 5),
(8949001, 'Savings', 90000, getdate(), 'open', 6),
(8947712, 'Savings', 7500, getdate(), 'open', 4),
(8941790, 'Savings', 50000, getdate(), 'open', 3)


insert into tbl_transactions
values
('UPI', 1000, getdate(), 8947712, 8941790),
('Debit card', 1500, getdate(), 8947712, 8941771),
('Cheque', 5000, getdate(), 8942002, 8948932)


insert into tbl_Loan
values
(100000, 7.5, 5, getdate(), '2028-10-20', 'House', 4),
(200000, 9.8, 10, getdate(), '2033-10-20', 'Personal', 1),
(700000, 10.0 , 5, getdate(), '2028-10-20', 'Car', 2),
(50000, 11.5, 4, getdate(), '2027-10-20', 'Personal', 1),
(1000000, 12.5, 20, getdate(), '2043-10-20', 'House', 5)