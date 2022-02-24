-- Create a view that displays student full name, 
--course name if the student has a grade more than 50.  


create view vgrades(myName,Coursename)
as
select st.St_Fname + ' ' +st.St_Lname ,mycourse.Crs_Name
from Student st, Stud_Course cour, course mycourse
	where st.St_Id=cour.St_Id and cour.Grade>50 and mycourse.Crs_Id=cour.Crs_Id


--------------------------------------------------------
--2Create an Encrypted view that displays manager names and the topics they teach. 

alter  view MangerName(mangerName,Topic)
with encryption
as
   select ins.Ins_Name,Topic.Top_Name
   from Department dept,Instructor ins,Ins_Course insCour,Course course,Topic topic
   where dept.Dept_Id=ins.Dept_Id and ins.Ins_Id=insCour.Ins_Id and insCour.Crs_Id=course.Crs_Id and course.Top_Id =topic.Top_Id
-- elperfromance fef zema el-llah

------------------------------------
--4Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department  
Create View Instructor_Dept
as 
Select Instructor.Ins_Name,Department.Dept_Name
from Instructor,Department
where Instructor.Dept_Id=Department.Dept_Id and Department.Dept_Name='SD' and Department.Dept_Name='Java'
---------------------------------------------
-- 5-Create a view “V1” that displays student data for student who lives in Alex or Cairo.  

alter  View V1 (stid,Fname,Lname,adder,Age,deptid,st_super)
as 
Select *
from Student 
where Student.St_Address='Alex' or Student.St_Address='Cairo'
-----------------------------------------------
select * from V1
--Create a view that will display the project name and 
--the number of employees work on it. “Use SD database” 
alter View EmpNum(projName,NumOfEmp)
as 
Select Company.Project.ProjectNO,count(Employee.EmpNo)
from Employee , Works_on,Company.Project
where Employee.EmpNo=Works_on.EmpNo and Company.Project.ProjectNO=Works_on.projectNo
group by Company.Project.ProjectNO

 select * from EmpNum


--------------------------------------

--6-Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen? 

create nonclustered index i2
on Department(Manager_hiredate)

-- can't do more than  Clustered index in schema , there are a index on primary key 

--7-Create index that allow u to enter unique ages in student table. What will happen?  
CREATE UNIQUE INDEX uidx_pid
ON Student (St_Age);
there are a duplication in AGE we shoud use non cluster 
----------------------------------------------------------
--8

Merge into lastt  as T
Using dailyt      as S
on T.id = S.did

when Matched Then
	update
		set T.val = S.dval
when Not matched Then         
	insert 
	values(S.did,S.dname,S.dval)
----------------------

-------------Part 2 
---------------------------------
--1Create view named   “v_clerk” that will display employee#,project#, the date of hiring of all the jobs of the type 'Clerk'. 

 Create View v_cleerk 
 as 
 select w.EmpNo,w.projectNo,w.Enter_date
 from Works_on as w
 where w.Job='Clerk'

-----------------------------------------------------

 -----Create view named  “v_without_budget” that will 
 --			display all the projects data without budget 
 Create View v_without_budget 
 as 
 select P.ProjectNO,p.ProjectName
 from Company.Project as P
 --------------------------------------------------------
 

--Create view named  “v_count “ that will display the project name and the # of jobs in it 
Create View  v_count (projectName,NameOfJobs)

as 
select p.ProjectName,count(W.job)

from Company.Project as p , Works_on  as W
where p.ProjectNO =W.projectNo
group by p.ProjectName
 --------------------------------------------------------
-- Create view named ” v_project_p2” that will display the emp#  for the project# ‘p2’ 
		--use the previously created view  “v_clerk” 
Create view v_cleerk_p2
as 
Select *
from v_cleerk
where v_cleerk.projectNo='p2'
 -----------------------------
 --modifey the view named  “v_without_budget”  to display all DATA in project p1 and p2  

 alter   View v_without_budget 
 as 
 select P.ProjectNO,p.ProjectName
 from Company.Project as P
 where  P.ProjectNO in ('P1','P2')
---------------------------------------
--Delete the views  “v_ clerk” and “v_count” 

drop view v_count
drop view v_cleerk
-------------------------------------------------

--Create view that will display the emp# and emp lastname who works on dept# is ‘d2’ 

Create  View EmployeesInDeptD2 
 as 
 select emp.EmpLname, D.DeptName
 from Employee as emp , Company.Department as D
 where  emp.FDeptNo=D.DeptNo and D.DeptNo='d2'
 ------------------


--Display the employee  lastname that contains letter “J” 

Create View EmployeesInDeptD2andStartWithLetterJ
as 
 select *
 from EmployeesInDeptD2
 where  EmployeesInDeptD2.EmpLname like 'j%'

-----------------------------------------------------------------
--Create view named “v_dept” that will display the department# and department name 

Create View V_dept
as 
Select   *
from Company.Department as dept
where dept.DeptNo='d4' and dept.DeptName='Development'
------------------------------------------------------------------

--using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’ 
select * from V_dept
INSERT INTO V_dept (DeptNo,DeptName)
VALUES ('d4','Devel');
---------------------------------------------------------
--Create view name “v_2006_check” that will display employee#, 
--the project #where he works and the date of joining the project which
--must be from the first of January and the last of December 2006.this view will be used to insert data so make sure that the coming new data must match the condition
Create View v_2006_check
as 
Select P.ProjectName,P.ProjectNO,Emp.EmpNo,Emp.EmpLname
from Company.Project as P , Works_on as W, Employee as Emp
where P.ProjectNO=W.projectNo and W.EmpNo=Emp.EmpNo and W.Enter_date >='1/1/2006' and W.Enter_date <='31/12/2006' 
