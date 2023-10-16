-- views
select * from tbl_Students

CREATE VIEW vw_students 
AS
select StdId, first_name, city
from tbl_Students

select * from vw_students

insert into vw_students (first_name, city)
values
('ABC', 'Delhi'),
('XYZ', 'Mumbai');