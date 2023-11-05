-- Creating new database called university
create database university;
use university;
-- Creating new table called students
create table students(
	id int primary key,
    name varchar(100) not null,
    age int not null,
    department varchar(10) not null,
    city varchar(30) not null
);
-- insert data in the students table
insert into students
(id, name, age, department, city)
values
(190601, "Mitu kundu", 24, "ICE", "Pabna"),
(190602, "Zamiul Islam", 20, "ICE", "Panchagar"),
(190631, "Sohag Hossain", 19, "ICE", "Kurigram");
-- to view the table
select * from students;
-- update the students table
update students set age=25 where id=190631;
select * from students;
-- delete a row from the students table
delete from students where id=190601;
select * from students;
-- delete table
drop table students;
-- delete database
drop database university;
