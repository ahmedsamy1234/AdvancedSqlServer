--1-Create a scalar function that takes date and returns Month name of that date.

create function GetMonth(@Mydate Date) 
returns varchar(50)
	begin
		declare @month varchar(50)
			select @month= MONTH(@Mydate) 
		return @month
	end

select dbo.GetMonth('2017/08/25')

----------------------------------------
--2-Create a multi-statements table-valued function that takes 2 
--integers and returns the values between them.

create function GetBetween(@first int , @second int )
returns @t table
		(
		 numbers int
		 
		)
as
	begin

while @first<=@second
	begin

	insert into @t
			select @first

	set @first+=1
	end
	return 
	end


	select * from  dbo.GetBetween(5,10)
-------------------------------------------------
--3.Create inline function that takes Student No and returns Department 
--Name with Student full name.

create function getInfoStu(@num int)
returns table
as
	return
		(
		 select st.St_Fname+ st.St_Lname as 'fullName' , dept.Dept_Name
		 from Department as dept , Student as st
		 where st.Dept_Id=dept.Dept_Id and st.St_Id=@num
		)

select * from dbo.getInfoStu(5)


----------------------------------------------
 --Create a scalar function that takes Student ID and returns a message to 
--user 
--a. If first name and Last name are null then display 'First name & 
--last name are null'
--b. If First name is null then display 'first name is null'
--c. If Last name is null then display 'last name is null'
--d. Else display 'First name & last name are not null'
drop  function dbo.Display
 create function Display(@id int ) 
returns varchar(50)

	begin
	declare @first varchar(50)
	declare @second varchar(50)

	select @first=st.St_Fname,@second=st.St_Lname from Student as st where st.St_Id= @id
		IF ( @first is null and @second is null)
			return ' 2 and 1  is null'

		ELSE IF(@first is null)
			return '1 is nul'
		else If (@second is null)
			return '2 is null'
		else	return  ' has name '

		return 'noo'
	end 


	select dbo.Display(13)

--------------------------------------
--5-Create inline function that takes integer which represents manager ID 
--and displays department name, Manager Name and hiring date

create function getManager(@num int)
returns table
as
	return
		(
		 select dept.Manager_hiredate ,dept.Dept_Manager, dept.Dept_Name
		 from Department as dept , Instructor as ins
		 where dept.Dept_Manager=@num and dept.Dept_Name= ins.Dept_Id
		)



		select * from  dbo.getManager(5)

-----------------------------------------------
--- Create multi-statements table-valued function that takes a string
--If string='first name' returns student first name
--If string='last name' returns student last name 
--If string='full name' returns Full Name from student table 
create function getstuds(@format varchar(20))
returns @t table
		(
		 id int,
		 sname varchar(20)
		)
as
	begin
		if @format='first'
			insert into @t
			select st_id,isnull(st_fname,'Default') from Student
		else if @format='last'
			insert into @t
			select st_id,isnull(st_lname,'Default') from Student
		else if @format='fullname'
			insert into @t
			select st_id,(isnull (st_fname,'Default')+' '+isnull (st_lname,' Default')) from Student
		return 
	end

	------------------------------------------------------------
--7)7.	Write a query that returns the Student No and
--Student first name without the last char

Declare @name as varchar(30)='Rohatash'  
Select left(@name, len(@name)-1) as AfterRemoveLastCharacter  

create function GetNameWithoutLastNum(@num int)
returns table
as
	return
		(
		 select st.St_Id, left(st.St_Fname, len(st.St_Fname)-1) as 'Trimed First Name' 
		 from  Student as st
		 where st.St_Id=@num
	
		)

Select * from GetNameWithoutLastNum(5)

--------------------------------------------------------
--8)Wirte query to delete all grades for the students Located in SD 
Department

Delete from Stud_Course
where Stud_Course.St_Id in (select std.St_Id from  Student as std, Department as dept
													where std.Dept_Id= dept.Dept_Id  and dept.Dept_Name='SD')


----------------------------------------
create table hirchId
(Node hierarchyid not null,  
[Position Name] nvarchar(30) not null);
 
insert hirchId 
values
('/', 'CEO') ----root  
 ,('/1/','Projecet Leader')
,('/2/','Hr Manager')----- lv 1
,('/1/1/','developers')
,('/2/1/','Secartary')----- lv 2

select * from hirchId




