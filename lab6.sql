

declare t_cur cursor
for select EmpNo ,Salary
from HumanResource.Employee
for update;

declare @id int;
declare @s int;

open t_cur;

fetch t_cur into @id,@s;
	begin
		While @@fetch_status=0
		begin
			if @s<3000
			begin
				update HumanResource.Employee set Salary= @s*1.10
				where current of t_cur;
				fetch t_cur into @id,@s
			end
			else 
				begin
				update HumanResource.Employee set Salary= @s*1.20
				where current of t_cur;
				fetch t_cur into @id,@s
			end
		end
	end;
close t_cur;
deallocate t_cur;

use ITI;


declare t_cur cursor
for select Dept_Name,Dept_Manager
from Department
for read only;

declare @DN varchar(50);
declare @DM int;

open t_cur;

fetch t_cur into @DN,@DM;
	begin
		While @@fetch_status=0
		begin
			
				if (@DN is not null and @DM is not null)
					select @DN as [departmen name] , Ins_Name
					from Instructor
					where Ins_Id = @DM;

				fetch t_cur into @DN,@DM;
		
		end
	end;
close t_cur;
deallocate t_cur;





declare t_cur cursor
for select St_Fname
from Student_course.Student
for read only;

declare @names varchar(1000);
declare @name varchar(50);

open t_cur;

fetch t_cur into @name;
	begin
		While @@fetch_status=0
		begin
			
				if (@name is not null)
					set @names = CONCAT( @names , ',' , @name );
				fetch t_cur into @name;		
		end
	end;
close t_cur;
deallocate t_cur;
select @names;


