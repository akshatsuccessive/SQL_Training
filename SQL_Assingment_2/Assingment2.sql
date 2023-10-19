use Test_Students
create table tbl_students (
	StudentId int identity(1,1) primary key,
	FirstName varchar(20),
	LastName varchar(20)
)

create table tbl_courses (
	CourseId int identity(1,1) primary key,
	CourseName varchar(50),
	DepartmentId int
	Foreign key (DepartmentId) references tbl_departments(DepartmentId)
)

create table tbl_departments (
	DepartmentId int identity(1,1) primary key,
	DepartmentName varchar(50)
)

create table tbl_enrollments (
	EnrollmentId int identity(1,1) primary key,
	StudentId int,
	CourseId int,
	EnrollmentDate datetime
	Foreign key (StudentId) references tbl_students(StudentId),
	Foreign key (CourseId) references tbl_courses(CourseId)
)

insert into tbl_students
values
('Akshat', 'Kumar'),
('Ajay', 'Bohra'),
('Utkarsh', 'Srivatsav'),
('Govind', 'Sharma'),
('Yash', 'Behl'),
('Prince', 'Kumar')

insert into tbl_departments
values
('Computer Science'),
('Information Technology'),
('Mechanical Engineering'),
('Electrical Engineering'),
('Electronics and Communication'),
('Civil Engineering'),
('Chemical Engineering'),
('Bio-technology')



insert into tbl_courses
values
('Web Development', 1)

insert into tbl_courses
values
('Java', 1),
('Python', 2),
('C#', 1),
('Thermodynamics', 3),
('Fluid Mechanics', 3),
('Electric motor', 4),
('Transformer', 4),
('Microprocessor', 5),
('Communication systems', 5),
('Digial Electronics', 5),
('Properties of matter', 6),
('Equillibrium', 7),
('Organic', 7),
('Biotech', 8)

insert into tbl_enrollments
values
(4, 2, getdate()),
(6, 7, getdate()),
(1, 8, getdate()),
(2, 3, getdate()),
(5, 5, getdate()),
(3, 1, getdate())

select * from tbl_students
select * from tbl_departments
select * from tbl_courses
select * from tbl_enrollments


-- 1. Retrieve the full names of students who are enrolled in more than one course in the "Computer Science" department
select S.StudentId, S.FirstName, S.LastName from tbl_students as S
inner join tbl_enrollments as E on E.StudentId = S.StudentId
inner join tbl_courses as C on C.CourseId = E.CourseId
inner join tbl_departments as D on C.DepartmentId = D.DepartmentId
where D.DepartmentName = 'Computer Science'
group by S.StudentId, S.FirstName, S.LastName 
having count(E.StudentId) > 1


-- 2. List the names of courses that have at least one student enrolled but have not yet started.
select distinct C.CourseName from tbl_courses as C
inner join tbl_enrollments as E on E.CourseId = C.CourseId
where E.EnrollmentDate < '2023-10-15 15:55:02.383'                            -- let the couse start date is 15 oct 2023


-- 3. Find the students who are enrolled in courses from more than one department.
select S.StudentId, S.FirstName, S.LastName from tbl_students as S
inner join tbl_enrollments as E on E.StudentId = S.StudentId
inner join tbl_courses as C on C.CourseId = E.CourseId
group by S.StudentId, S.FirstName, S.LastName 
having count(distinct C.DepartmentId) > 1


-- 4. Retrieve the names of students who are enrolled in all courses offered by the "Engineering" department.
select S.StudentId, S.FirstName, S.LastName from tbl_students as S
inner join tbl_enrollments as E on E.StudentId = S.StudentId
inner join tbl_courses as C on E.CourseId = C.CourseId
inner join tbl_departments as D on C.DepartmentId = D.DepartmentId
where D.DepartmentName like '%Engineering'
group by S.StudentId, S.FirstName, S.LastName


-- 5. Calculate the total number of students enrolled in each department for each course.
select D.DepartmentName, C.CourseName, count(Distinct S.StudentId) as total from tbl_departments as D
inner join tbl_courses as C on C.DepartmentId = D.DepartmentId
inner join tbl_enrollments as E on C.CourseId = E.CourseId
inner join tbl_students as S on E.StudentId = S.StudentId
group by D.DepartmentName, C.CourseName


-- 6. List the students who have the same first name as the department they are enrolled in.
select S.StudentId, S.FirstName, S.LastName from tbl_students as S
inner join tbl_enrollments as E on S.StudentId = E.StudentId
inner join tbl_courses as C on E.CourseId = C.CourseId
inner join tbl_departments as D on C.DepartmentId = D.DepartmentId
where CONCAT(S.FirstName, ' ', S.LastName) = D.DepartmentName


-- 7. Find the department with the highest average number of students enrolled per course.
select top(1) D.DepartmentName, avg(total_student) as average_student
from (
	select C.DepartmentId, C.CourseId, count(C.CourseId) as total_student
	from tbl_enrollments as E
	inner join tbl_courses as C on E.CourseId = C.CourseId
	group by C.CourseId, C.DepartmentId
)as subquerry                                                 -- subquery will give us the count of enrolled student per course of a department
inner join tbl_departments as D on D.DepartmentId = subquerry.DepartmentId
group by D.DepartmentName
order by average_student desc



-- 8. Retrieve the students who have not enrolled in any courses offered by the "Science" department.
select S.StudentId, S.FirstName, S.LastName from tbl_students as S 
where S.StudentId not in 
(select E.StudentId from tbl_enrollments as E
inner join tbl_courses as C on E.CourseId = C.CourseId
inner join tbl_departments as D on D.DepartmentId = C.DepartmentId
where D.DepartmentName = 'Computer Science')


-- 9. List the courses with the most recent enrolment date for each department.
select D.DepartmentName, C.CourseName, max(E.EnrollmentDate) as Recent from tbl_departments as D
inner join tbl_courses as C on C.DepartmentId = D.DepartmentId
inner join tbl_enrollments as E on E.CourseId = C.CourseId
group by D.DepartmentName, C.CourseName


-- 10. Calculate the total number of students in the "Engineering" department who have enrolled in more courses than the average number of courses per student in that department.
select top(1) D.DepartmentName, avg(total_student) as average_student
from (
	select C.DepartmentId, C.CourseId, count(C.CourseId) as total_student
	from tbl_enrollments as E
	inner join tbl_courses as C on E.CourseId = C.CourseId
	group by C.CourseId, C.DepartmentId
)as subquerry 
inner join tbl_departments as D on D.DepartmentId = subquerry.DepartmentId
where D.DepartmentName like '%Engineering'
group by D.DepartmentName
order by average_student desc



