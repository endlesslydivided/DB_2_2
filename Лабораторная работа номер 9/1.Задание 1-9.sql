--					ЗАДАНИЕ 1

DECLARE @c char = 'c',
		@vc varchar(10) = 'Hi!',
		@dt datetime,
		@tm time(0),
		@i int,
		@smi smallint,
		@tni tinyint,
		@nmrc numeric(12,5);
SET @dt = getdate();
SET @tm = (SELECT @dt dt);
DECLARE @h TABLE
			(
			num int identity(1,1)
			);
INSERT @h default values;
INSERT @h default values;
INSERT @h default values;
INSERT @h default values;
SET @i =	(SELECT * from @h where num = 1);
SET	@smi =	(SELECT * from @h where num = 2);
SET	@tni =	(SELECT * from @h where num = 3);
SET	@nmrc =	(SELECT * from @h where num = 4);

SELECT @c, @vc,@dt,@tm;
print @i;print @smi;print @tni;print @nmrc;

--					ЗАДАНИЕ 2
use K_UNIVER;
DECLARE @capacity int = (select cast(sum(AUDITORIUM_CAPACITY) as int) from AUDITORIUM),
		@q int = (select cast(count(*) as int) from AUDITORIUM),
		@avg int = (select cast(avg(AUDITORIUM_CAPACITY) as int) from AUDITORIUM);

DECLARE	@lessavg int =  (select cast(count(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY < @avg);
DECLARE	@percent float =  cast(cast(@lessavg as float) / cast(@q as float) * 100  as float);
		
	IF @capacity > 200
		begin 
		SELECT @q 'Количество аудиторий',			@avg 'Средняя вместимость аудиторий',
			   @lessavg  'Вместимость < средней',		cast(@percent as varchar) + '%'   'Процент от всего кол-ва аудиторий'
		end
	ELSE IF @capacity < 200
		begin
		PRINT @capacity
		end;

--					ЗАДАНИЕ 3

print 'Число обработанных строк: ' +										cast(@@ROWCOUNT as varchar);
print 'Версия SQL Server: ' +												@@VERSION  ;
print 'Системный идентификатор процесса ' +
	  'назначенный сервером текущему под-ключению: ' +						cast(@@SPID  as varchar);
print 'Код последней ошибки: ' +											cast(@@ERROR as varchar);	
print 'Имя сервера: ' +														@@SERVERNAME  ;
print 'Уровень вложенности транзакции: ' +									cast(@@TRANCOUNT as varchar);
print 'Проверка результата считывания строк результирующего набора: ' +		cast(@@FETCH_STATUS as varchar);
print 'Уровень вложенности текущей процедуры: ' +							cast(@@NESTLEVEL as varchar);

--					ЗАДАНИЕ 4

DECLARE @t int = 3, @x int = 4, @z int;
IF (@t > @x)
	begin
	SET @z  = POWER(SIN(@t),2);
	end
ELSE IF (@t < @x)
	begin
	SET @z  = 4 * (@t + @x);
	end
ELSE IF (@t = @x)
	begin 
	SET @z  = 1 - EXP(@x-2);
	end
SELECT @z z;

DECLARE @tableFIO varchar(50) = (select top 1 [NAME] from STUDENT)
DECLARE @resultFIO varchar(50);
		SET @resultFIO = (select substring(@tableFIO, 1, charindex(' ', @tableFIO)) +
								 substring(@tableFIO, charindex(' ', @tableFIO)+1,1)+'.'+
								 substring(@tableFIO, charindex(' ', @tableFIO, charindex(' ', @tableFIO)+1)+1,1)+'.');
print @resultFIO;

select * from (select *, DATEDIFF(YEAR,BDAY,GETDATE()) Возраст from STUDENT where MONTH(BDAY)  = MONTH(GETDATE()) + 1) as tr;

select * from (select *,
						(CASE 
							when DATEPART(weekday,PDATE) = 1 then 'Понедельник'
							when DATEPART(weekday,PDATE) = 2 then 'Вторник'
							when DATEPART(weekday,PDATE) = 3 then 'Среда'
							when DATEPART(weekday,PDATE) = 4 then 'Четверг'
							when DATEPART(weekday,PDATE) = 5 then 'Пятница'
							when DATEPART(weekday,PDATE) = 6 then 'Суббота'
							when DATEPART(weekday,PDATE) = 7 then 'Воскресенье'
						end) [День недели] from PROGRESS where [SUBJECT] like '%ОАиП%') as tr;

--					ЗАДАНИЕ 5

SELECT STUDENT.IDGROUP, round(avg(cast(PROGRESS.NOTE as float(2))),2) [Средняя оценка]
			From STUDENT inner join [GROUP]
				on [GROUP].IDGROUP = STUDENT.IDGROUP
				inner join PROGRESS
				on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT 
				group by STUDENT.IDGROUP

DECLARE @gr varchar(3) = '28';
DECLARE @ttp float(2) = (SELECT round(avg(cast(PROGRESS.NOTE as float(2))),2) [Средняя оценка]
			From STUDENT inner join [GROUP]
				on [GROUP].IDGROUP = STUDENT.IDGROUP
				inner join PROGRESS
				on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT  where STUDENT.IDGROUP = @gr
				group by STUDENT.IDGROUP);

IF (@ttp  < 4)
	begin 
	PRINT 'Успеваемость группы номер ' + cast(@gr as varchar) + ' низкая. Средний балл: ' +  cast(@ttp as varchar);
	end
ELSE IF (@ttp  > 4 and @ttp  < 8)
	begin 
	PRINT 'Успеваемость группы номер ' + cast(@gr as varchar) + ' средняя. Средний балл: ' + cast(@ttp as varchar);
	end
ELSE IF (@ttp  > 8)
	begin 
	PRINT 'Успеваемость группы номер ' + cast(@gr as varchar) + ' средняя. Средний балл: ' + cast(@ttp as varchar);
	end

--					ЗАДАНИЕ 6			

SELECT IDSTUDENT,
		CASE 
			WHEN avg (PROGRESS.NOTE) = 4 then 'Стипендия не повышена' 
			WHEN avg (PROGRESS.NOTE) between 5 and 6 then 'Коэффициент 1.2' 
			WHEN avg (PROGRESS.NOTE) between 7 and 8 then 'Коэффициент 1.3' 
			WHEN avg (PROGRESS.NOTE) between 9 and 10 then 'Коэффициент 1.4' 
			else 'Нет стипендии'
		end [Повышение стипендии]
		FROM PROGRESS
		GROUP BY IDSTUDENT 

--					ЗАДАНИЕ 7
DROP TABLE #TEMP1;
CREATE TABLE #TEMP1
		(
			ID int identity(1,1),
			RANDOM_NUMBER int,
			WORD varchar(50) default 'Значение по-умолчанию'
		);

DECLARE  @iter int = 0;
WHILE @iter < 10
	begin
	INSERT #TEMP1(RANDOM_NUMBER)
			values(rand() * 1000);
	SET @iter = @iter + 1;
	end
SELECT * from #TEMP1;

--					ЗАДАНИЕ 8
begin try
Select * from STUDENT where STUDENT.BDAY =  @sdfsd;
end try
begin catch
print 'Код ошибки: ' + ERROR_NUMBER()
print 'Сообщение об ошибке: ' + ERROR_MESSAGE()
print 'Строка ошибки: ' + ERROR_LINE()
print 'Имя процедуры ошибки: ' + ERROR_PROCEDURE()
print 'Уровень серьёзности ошибки: ' + ERROR_SEVERITY()
print 'Метка ошибки: ' + ERROR_STATE()

end catch
 