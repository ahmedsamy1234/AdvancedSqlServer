--1-Create a stored procedure without parameters to show the number of students
--per department name.[use ITI DB]  

 drop setstbyadd

 create   proc StdPErDept
as
	select dept.Dept_Name,count(std.St_Id)
	from Department as dept , Student std
	where dept.Dept_Id=std.Dept_Id
	group by dept.Dept_Name

	StdPErDept

-------------------------------------------------
--2

2.	Create a stored procedure that will check for the # of employees in the project p1
if they are more than 3 print message to the user “'The number of employees in the project p1 is 3 or more'” 
if they are less display a message to the user “'The following employees work for the project p1'” in 
addition to the first name and last name of each one. [Company DB] 

alter proc CheckIf 
as
	declare @CounterX int 
	select  @CounterX= Count(emp.EmpNo)
	from HR.Employee as emp ,Works_on as w
	where emp.EmpNo
	=w.EmpNo and w.projectNo='p3'
			
	
		if (@CounterX>3)
		begin 
		select 'The number of employees in the project p1 is 3 or more'
		end 
		else 
		select 'The following employees work for the project p1'

	
	select  w.EmpNo
	from HR.Employee as emp ,Works_on as w
	where emp.EmpNo
	=w.EmpNo and w.projectNo='p3'

---------------------------------------------------------
3)

create  Proc updateEmpl( @empidOld int ,@empidNew int ,@IdProj varchar(20))
as 
            UPDATE Works_on
            SET   EmpNo= @empidNew
            WHERE  EmpNo=@empidOld and projectNo=@IdProj
   ProjectNo 	UserName 	ModifiedDate 	Budget_Old 	Budget_New     

   drop table  AuditX
create  TABLE AuditX (
    ProjectNo varchar(50),
    UserName varchar(255),
    ModifiedDate varchar(255),
    Budget_Old int,
    Budget_New int
);
select * from Company

---------------------------------------------------------------------------------------------
4)
Create trigger T6
 on Company.Project
 for update 
as 
declare @oldBudget int 
declare @newBudget int 
declare @ProjectNoX varchar (100) 
declare @ProjectName varchar (100)

if update(Budget)
	select @ProjectNoX=ProjectNO, @ProjectName=ProjectName
	,
	@newBudget=Budget from inserted as ins
	select  @oldBudget=Budget from  deleted as ins

	INSERT INTO AuditX (ProjectNo, UserName, ModifiedDate,Budget_Old,Budget_New)
VALUES (@ProjectNoX, suser_name(), getdate(), @oldBudget,@newBudget);


------------------------------------------------------------
5.	Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
“Print a message for user to tell him that he can’t insert a new record in that table”

create trigger t11
on Company.Department
instead of insert 
as
	select 'You Canot do this ya bn 3my'


-----------------------------------------------------------------
6)
Create a trigger that prevents the insertion Process for Employee table in March [Company DB].

create trigger t12q
on Employee
instead of insert
as
	if (MONTH(getdate())='March')
		select 'not allowed'
	else
	begin 
		insert into Employee
		select * from inserted

	end 

		-------------------------------------------------------------
(Server User Name , Date, Note) 
CREATE TABLE StudentAudit
(  
 id_num int IDENTITY(1,1),  
 userName varchar (100),  
 Date varChar(100),  
 Note varchar(30)  
);  

Create trigger T6
 on Student
 for insert 
as 

	INSERT INTO StudentAudit 
VALUES (suser_name(), getdate(), 'b5')

----------------------------------------------------------
8)
Create trigger T61
 on Student
 instead of  Delete  
as 

	INSERT INTO StudentAudit 
VALUES (suser_name(), getdate(), suser_name()+ 'ana fehemt-ha kda wallahy' )
-----------------------------------------


9.	Display all the data from the Employee table (HumanResources Schema) 
As an XML document “Use XML Raw”. “Use Adventure works DB” 
A)	Elements
B)	Attributes
--A)
select 
	* 
from AdventureWorks2012.HumanResources.Employee as emp
for xml path('Employee')
 -----
 --B)
 SELECT *
FROM HumanResources.Employee
FOR XML RAW

------------------
10)
Use XML Auto

SELECT Dept_Name, Ins_Name
FROM Department d , Instructor i
WHERE d.Dept_Id = i.Dept_Id
FOR XML AUTO, ELEMENTS
Use XML Path
SELECT Dept_Name "DepartmentName",
	(
		SELECT Ins_Name 
		FROM Instructor i
		WHERE d.Dept_Id = i.Dept_Id
		FOR XML PATH('Instructor'), TYPE
	)
FROM Department d 
FOR XML PATH('Department')
--------------------------
--11)
declare @handler int
Exec sp_xml_preparedocument @handler output, @docs

SELECT * 
FROM OPENXML (@handler, '//customer') 
WITH (CustomerFname varchar(50) '@FirstName',
	  Zipcode int '@Zipcode', 
	  OrderID int 'order/@ID',
	  OrderName varchar(50) 'order'
	  )

Exec sp_xml_removedocument @handler
