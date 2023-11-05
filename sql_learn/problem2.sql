use university;
-- create new table called employe
create table employe(
	id int primary key,
    name varchar(100) not null
);
insert into employe values(101, "Abdul Karim");
insert into employe values(102, "Hamid Khan");
select * from employe;
-- add new column i the employe table
alter table employe
	add email varchar(100);
insert into employe values(103, "Sami Rahaman", "sami1023@gail.com");
select * from employe;
-- delete table
drop table employe;