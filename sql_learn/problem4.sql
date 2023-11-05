use university;
create table instructor(

	ID varchar(20),
	name varchar(20) not null,
	dept_name varchar(20),
	salary numeric(8,2),
	primary key(ID)
);
insert into instructor  
values 
('10101','Srinivasan','Comp.Sci',65000),
('12121','Wu','Finance',90000),
('15151','Mozart','Music',40000),
('22222','Einstein','Physics',95000),
('32343','EI Said','History',60000),
('33456','Gold','Physics',87000);
select * from instructor;

-- group by clause
select name from instructor group by name;
select dept_name,avg(salary) as AVG 
	from instructor group by dept_name;
select dept_name,count(*) as cout from instructor  group by dept_name;

-- having clause
select dept_name,avg(salary) as AVG 
	from instructor group by dept_name having avg(salary)>70000;

-- order by clause
select * from instructor order by salary asc,name desc;

-- view
create view faculty as 
select ID,name,dept_name 
from instructor;

select * from faculty;

-- index
create index index_dept_name 
on instructor(dept_name);
desc instructor;

-- procedure
DELIMITER $$
create procedure get_instructor_info (in salary numeric(8,2))
begin
select * from instructor where instructor.salary >= salary;
end
$$
DELIMITER ;

call get_instructor_info(65000);
