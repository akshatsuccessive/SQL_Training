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
