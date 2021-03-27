use K_UNIVER;

--							ЗАДАНИЕ 6
go 
create function COUNT_PULPIT(@faculty varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(PULPIT) from 
			PULPIT where FACULTY = @faculty);
return @ret;
end;

go 
create function COUNT_GROUP(@faculty varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(IDGROUP) from 
			[GROUP] where FACULTY = @faculty);
return @ret;
end;

go 
create function COUNT_PROFESSION(@faculty varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(PROFESSION) from 
			PROFESSION where FACULTY = @faculty);
return @ret;
end;

--DROP FUNCTION COUNT_PULPIT;
--DROP FUNCTION COUNT_GROUP;
--DROP FUNCTION COUNT_PROFESSION;

go
create function FACULTY_REPORT(@c int) returns @fr table
([Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int,[Количество студентов] int, [Количество специальностей] int )
as begin 
           declare cc CURSOR static for select FACULTY from FACULTY where dbo.COUNT_STUDENTS(FACULTY) > @c; 
	       declare @f varchar(30);
	       open cc;  
           fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  dbo.COUNT_PULPIT(@f),
	            dbo.COUNT_GROUP(@f),   dbo.COUNT_STUDENTS(@f),
	            dbo.COUNT_PROFESSION(@f)); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;

--DROP FUNCTION FACULTY_REPORT;

go
SELECT * from  dbo.FACULTY_REPORT(0);

