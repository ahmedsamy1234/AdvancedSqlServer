
CREATE TABLE Department (
      DeptNo varchar(5) PRIMARY KEY,
      DeptLocation nchar(2) default 'NY',
	  DeptName varchar(10),

	   constraint c1 check(DeptLocation in ('NY','DS','KW'))

      
      
)


Create TABLE Employee (

EmpNo INT NOT NULL PRIMARY KEY,
EmpFname varchar(20),
EmpLname varchar(20),

Salary INT not null ,
FDeptNo varchar(5) not null,

foreign key(FDeptNo)
references Department	(DeptNo)
)
 -- other Tables using Weziard 

----------
2.	Create the following schema and transfer the following tables to it 
a.	Company Schema 
i.	Department table (Programmatically)
ii.	Project table (using wizard)
b.	Human Resource Schema
i.	  Employee table (Programmatically)
---------------------
a)
create schema Company ;

alter schema Company transfer Department
alter schema Company transfer Project
-----------------------------------------
B) 
create schema HR ; 

create table HR.Employee
(

EmpNo INT NOT NULL PRIMARY KEY,
EmpFname varchar(20),
EmpLname varchar(20),

Salary INT not null ,
FDeptNo varchar(5) not null,


)
---------------------------------------
3)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='HR.Employee';

-----------------------------------------
4)
create synonym Emp
for Employee

Select * from Employee // ok 
Select * from HR.Employee //ok
Select * from Emp // ok 
Select * from HR.Emp // error 
---------------------------------


--5)
update Company.Project
set Budget=Budget*1.1
where ProjectNO= (Select projectNo from Works_on 
			where Job='Manager' and EmpNo=10102)
-----------------------------
--6)
update Company.Department 
set DeptName= 'Sales'
where DeptNo = (select  emp.FDeptNo
				
			from Employee as emp
			where emp.EmpFname='james')
-------
--7)
 select * 
 from Works_on

 select * 
 from  Company.Department 
 
 update Works_on
 set Enter_Date='12.12.2007'
 where projectNo ='p1' and EmpNo=  (select  emp.EmpNo from  Employee as emp
 
	where emp.FDeptNo =( select   dept.DeptNo from Company.Department as dept
	where DeptName='Sales'))

	-----------------------

--	8.	Delete the information in the works_on table for all employees who work 
	--for the department located in KW.

	-----------------------
	DELETE FROM Works_on  where  EmpNo  in (select distinct emp.EmpNo from  Employee as emp
 
	where emp.FDeptNo =( select distinct   dept.DeptNo from Company.Department as dept
	where DeptLocation='KW'))


   

grant select,insert   
on Student 
to mohamed
grant select,insert   
on Course  
to mohamed

revoke Delete,update 
on Student 
to mohamed
revoke Delete,update 
on course 
to mohamed