

--								ЗАДАНИЕ 1
use K_MyBase;

go 
create function COUNT_REPORTS(@firm varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(ПРЕДПРИЯТИЯ.Название_предприятия) from 
			ОТЧЁТЫ inner join ПРЕДПРИЯТИЯ 
			on ПРЕДПРИЯТИЯ.Название_предприятия = ОТЧЁТЫ.Название_предприятия where ПРЕДПРИЯТИЯ.Название_предприятия = @firm);
return @ret;
end;

--DROP FUNCTION COUNT_REPORTS;

declare @firm_name char(10) = 'БГТУ';
declare @f_result int = dbo.COUNT_REPORTS(@firm_name);
print 'Количество отчётов фирмы ' + rtrim(@firm_name) + ': ' + cast(@f_result as varchar);

--								ЗАДАНИЕ 2
use K_MyBase;

go
create function FDATES(@p varchar(50)) returns varchar(300)
as begin
DECLARE Reports_Dates CURSOR LOCAL for  select DISTINCT  Дата_отчёта,Название_показателя from ОТЧЁТЫ 
						where ОТЧЁТЫ.Название_предприятия = @p;
DECLARE @date varchar(30),@name_ind varchar(200), @date_result varchar(300) ='';
OPEN Reports_Dates;
FETCH Reports_Dates into @date,@name_ind;
while @@FETCH_STATUS = 0
	begin
		set @date_result += RTRIM(@date) + '('+ RTRIM(@name_ind) +')'+', ' +  @date_result;
		FETCH  Reports_Dates into @date,@name_ind;
	end;
CLOSE Reports_Dates;
set @date_result = 'Даты отчётов: ' + @date_result ;
return @date_result;
end;

--DROP FUNCTION FDATES;

select DISTINCT ОТЧЁТЫ.Название_предприятия 'Фирма', dbo.FDATES(ОТЧЁТЫ.Название_предприятия) 'Отчёты' from ОТЧЁТЫ;

--								ЗАДАНИЕ 3
use K_MyBase;

go
create function FFDATES(@name varchar(50), @name_ind varchar(50)) returns table
as return 
	select ОТЧЁТЫ.Название_показателя,ОТЧЁТЫ.Название_предприятия,ОТЧЁТЫ.Дата_отчёта from
		ОТЧЁТЫ 
		where ОТЧЁТЫ.Название_показателя = isnull(@name_ind,ОТЧЁТЫ.Название_показателя) and
			ОТЧЁТЫ.Название_предприятия = isnull(@name,ОТЧЁТЫ.Название_предприятия);

--DROP FUNCTION FFDATES;
go
select * from dbo.FFDATES(NULL,NULL);
select * from dbo.FFDATES('БГТУ',NULL);
select * from dbo.FFDATES(NULL,'Бюджет');
select * from dbo.FFDATES('БГТУ','БЮДЖЕТ');
select * from dbo.FFDATES('1','2');

--								ЗАДАНИЕ 4
use K_MyBase;

go
create function FCOUNTREPORTS (@name varchar(20)) returns int
as begin
		declare @result int = 0;
		set @result  = (select count(*) from
									ОТЧЁТЫ 
									where ОТЧЁТЫ.Название_предприятия = isnull(@name,ОТЧЁТЫ.Название_предприятия ));
		return @result;
end;

--DROP FUNCTION FTEACHER;
go
select DISTINCT ОТЧЁТЫ.Название_предприятия, dbo.FCOUNTREPORTS(ОТЧЁТЫ.Название_предприятия) 'Количество отчётов' from ОТЧЁТЫ;
select dbo.FCOUNTREPORTS(NULL) 'Всего отчётов';