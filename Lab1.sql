
--------------------------Part1-----------------------------------------------------------
--1.	Retrieve number of students who have a value in their age. 
select COUNT(*)
from Student
where St_Age is not null

--------------------------------------------------------------------------

--2.	Get all instructors Names without repetition
select distinct  Ins_Name
from Instructor

-------------------------------------------------------------------------
--3.	Display student with the following Format (use isNull function)

select St_id ,isnull(st_fname,'Smsm')+' ' +isnull(St_Lname,'Smsm'),D.Dept_Name
from  Student S,Department D
where D.Dept_Id= S.Dept_Id
---------------------------------------------------------------------------------------
--4.	Display instructor Name and Department Name 
SELECT ins.Ins_Name,Dept.Dept_Name
FROM Instructor as ins
LEFT JOIN Department as Dept
ON ins.Dept_Id = Dept.Dept_Id
------------------------------------------------
--5.    5.	Display student full name and the name of the course he is taking
--For only courses which have a grade  

 select s.St_Id as Student_id, CONCAT( ISNULL(s.St_Fname,'no name'),' ',ISNULL(s.St_Lname,' no name')) as Student_FullName,cs.Crs_Name
from Student s,Stud_Course c,Course cs
where s.St_Id =c.St_Id and c.Crs_Id=cs.Crs_Id and c.Grade is not null
 

---------------------
--6.	Display number of courses for each topic name

SELECT t.Top_Name ,COUNT(c.Crs_Name)
FROM Topic as t, Course as c
WHERE t.Top_Id= c.Top_Id
GROUP BY t.Top_Name
-----------------------------------
--7.	Display max and min salary for instructors
 
select MIN(s.Salary) as 'min' ,MAX(s.salary) as 'max'
from Instructor as s
--------------------------------------------------------------------
--8.Display instructors who have salaries less than the average salary of all instructors.

select *
from Instructor as ins
where ins.Salary<(select avg (Salary)
					from Instructor)

	----------------------------------------------------------------
--9 Display the Department name that contains the instructor who receives the minimum salary.
select dept.Dept_Name
from Department as dept , Instructor as ins
where dept.Dept_Id=ins.Dept_Id and ins.Salary= (select  min (Salary) from Instructor)
--------------------------------------------------------------------------------------------
--10	Select max two salaries in instructor table. 

select top(2)* 
from Instructor 
order by 
Salary desc 


--------------------------------------------------
--11 Select instructor name and his salary but if there is no salary display instructor bonus keyword. 
--“use coalesce Function”
select ins_name, coalesce(convert(varchar(20),salary),'bouns') as salary
from Instructor

-------------------------------------
--12.	Select Average Salary for instructors 
 select AVG(salary) as salary_avg
from Instructor
---------------------------------------------------
--13.Select Student first name and the data of his supervisor 

select st.St_Fname as 'student first Name ' , supervisor.*
from Student as st ,Student as supervisor 
where st.St_super= supervisor.St_Id
-------------------------------------------
--14.	Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”


select newtable.Dept_Name,newtable.Salary
from  (select dept.Dept_Name, ins.Salary, Row_number() over(partition by dept.Dept_Name order by ins.Salary desc) as Rn
	  from Instructor as ins ,Department as dept where ins.Dept_Id= dept.Dept_Id) as newtable 
		where Rn <=2 
		-------------------------------------------
--15.	 Write a query to select a random  student from each department.  “using one of Ranking Functions”
 select *
from (select * ,ROW_NUMBER() over(partition by Dep_id order by newid() desc) RN
from Student) as tabl
where RN=1




----------------------------Part2-------------------------------------------------------

--1.	Display the SalesOrderID, ShipDate of the SalesOrderHeader 
--table (Sales schema) to show SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’
 select SalesOrderID, shipdate
from Sales.SalesOrderHeader
where OrderDate >='2002-07-28' and  OrderDate <='2014-07-29'

------------------------
--2.	Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
select pro.ProductID,pro.Name
from Production.Product as pro
where pro.StandardCost < '$110.00'
----------------

------3.	Display ProductID, Name if its weight is unknown

select pro.ProductID,pro.Name
from Production.Product as pro
where pro.Weight is not null

-----------------------------------------
---------4-Display all Products with a Silver, Black, or Red Color
select * 
from Production.Product as pro
where pro.Color in ('Red','Black','Blue')

------------------------------------------------------------------
--5.	 Display any Product with a Name starting with the letter B
select * 
from Production.Product as pro
where pro.Name like 'B%' 

------------------------------------------
------------6)6.	Run the following Query
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3
Then write a query that displays any Product description with underscore value in its description.

select * 
from Production.ProductDescription as pro
where pro.Description like '%[_]%'
-----------------------------------------------
--7)

 select sum(totaldue)
from AdventureWorks2012.Sales.SalesOrderHeader
where OrderDate>='2001-01-07' and OrderDate <='2014-07-31'


----------------------------------
--8)Display the Employees HireDate (note no repeated values are allowed)

select distinct emp.HireDate
from HumanResources.Employee as emp
------------------------------------------------

--9.	 Calculate the average of the unique ListPrices in the Product table

select AVG (distinct ListPrice)
from AdventureWorks2012.Production.Product


----------------------------------------
--10)
--10.	Display the Product Name and its ListPrice within the values of 100 and 120 the list should has the following format "The [product name] is only! 
--[List price]" (the list will be sorted according to its ListPrice value)
 select CONCAT('the ',name ,'is only! ', Listprice)
from AdventureWorks2012.Production.Product
where ListPrice <=120 and ListPrice >=100
----------------------------------------
--11)a)	
--Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive]
 CREATE TABLE AdventureWorks2012.Sales.store_Archive 

select rowguid, name,SalespersonID
into AdventureWorks2012.Sales.store_Archive
from AdventureWorks2012.Sales.Store



select rowguid, name,SalespersonID
from AdventureWorks2012.Sales.store_Archive2


----------------------------------
--12)

 select convert(varchar, getdate(), 1)	
	 union select convert(varchar, getdate(), 2)	
	union select convert(varchar, getdate(), 3)	
	union select convert(varchar, getdate(), 4)	
	union select convert(varchar, getdate(), 5)	
	union select convert(varchar, getdate(), 6)
	union select convert(varchar, getdate(), 7)
	union select convert(varchar, getdate(), 8)
