--					������� 1

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

--					������� 2
use K_UNIVER;
DECLARE @capacity int = (select cast(sum(AUDITORIUM_CAPACITY) as int) from AUDITORIUM),
		@q int = (select cast(count(*) as int) from AUDITORIUM),
		@avg int = (select cast(avg(AUDITORIUM_CAPACITY) as int) from AUDITORIUM);

DECLARE	@lessavg int =  (select cast(count(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY < @avg);
DECLARE	@percent float =  cast(cast(@lessavg as float) / cast(@q as float) * 100  as float);
		
	IF @capacity > 200
		begin 
		SELECT @q '���������� ���������',			@avg '������� ����������� ���������',
			   @lessavg  '����������� < �������',		cast(@percent as varchar) + '%'   '������� �� ����� ���-�� ���������'
		end
	ELSE IF @capacity < 200
		begin
		PRINT @capacity
		end;

--					������� 3

print '����� ������������ �����: ' +										cast(@@ROWCOUNT as varchar);
print '������ SQL Server: ' +												@@VERSION  ;
print '��������� ������������� �������� ' +
	  '����������� �������� �������� ���-��������: ' +						cast(@@SPID  as varchar);
print '��� ��������� ������: ' +											cast(@@ERROR as varchar);	
print '��� �������: ' +														@@SERVERNAME  ;
print '������� ����������� ����������: ' +									cast(@@TRANCOUNT as varchar);
print '�������� ���������� ���������� ����� ��������������� ������: ' +		cast(@@FETCH_STATUS as varchar);
print '������� ����������� ������� ���������: ' +							cast(@@NESTLEVEL as varchar);

--					������� 4

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

select * from (select *, DATEDIFF(YEAR,BDAY,GETDATE()) ������� from STUDENT where MONTH(BDAY)  = MONTH(GETDATE()) + 1) as tr;

select * from (select *,
						(CASE 
							when DATEPART(weekday,PDATE) = 1 then '�����������'
							when DATEPART(weekday,PDATE) = 2 then '�������'
							when DATEPART(weekday,PDATE) = 3 then '�����'
							when DATEPART(weekday,PDATE) = 4 then '�������'
							when DATEPART(weekday,PDATE) = 5 then '�������'
							when DATEPART(weekday,PDATE) = 6 then '�������'
							when DATEPART(weekday,PDATE) = 7 then '�����������'
						end) [���� ������] from PROGRESS where [SUBJECT] like '%����%') as tr;

--					������� 5

SELECT STUDENT.IDGROUP, round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
			From STUDENT inner join [GROUP]
				on [GROUP].IDGROUP = STUDENT.IDGROUP
				inner join PROGRESS
				on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT 
				group by STUDENT.IDGROUP

DECLARE @gr varchar(3) = '28';
DECLARE @ttp float(2) = (SELECT round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
			From STUDENT inner join [GROUP]
				on [GROUP].IDGROUP = STUDENT.IDGROUP
				inner join PROGRESS
				on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT  where STUDENT.IDGROUP = @gr
				group by STUDENT.IDGROUP);

IF (@ttp  < 4)
	begin 
	PRINT '������������ ������ ����� ' + cast(@gr as varchar) + ' ������. ������� ����: ' +  cast(@ttp as varchar);
	end
ELSE IF (@ttp  > 4 and @ttp  < 8)
	begin 
	PRINT '������������ ������ ����� ' + cast(@gr as varchar) + ' �������. ������� ����: ' + cast(@ttp as varchar);
	end
ELSE IF (@ttp  > 8)
	begin 
	PRINT '������������ ������ ����� ' + cast(@gr as varchar) + ' �������. ������� ����: ' + cast(@ttp as varchar);
	end

--					������� 6			

SELECT IDSTUDENT,
		CASE 
			WHEN avg (PROGRESS.NOTE) = 4 then '��������� �� ��������' 
			WHEN avg (PROGRESS.NOTE) between 5 and 6 then '����������� 1.2' 
			WHEN avg (PROGRESS.NOTE) between 7 and 8 then '����������� 1.3' 
			WHEN avg (PROGRESS.NOTE) between 9 and 10 then '����������� 1.4' 
			else '��� ���������'
		end [��������� ���������]
		FROM PROGRESS
		GROUP BY IDSTUDENT 

--					������� 7
DROP TABLE #TEMP1;
CREATE TABLE #TEMP1
		(
			ID int identity(1,1),
			RANDOM_NUMBER int,
			WORD varchar(50) default '�������� ��-���������'
		);

DECLARE  @iter int = 0;
WHILE @iter < 10
	begin
	INSERT #TEMP1(RANDOM_NUMBER)
			values(rand() * 1000);
	SET @iter = @iter + 1;
	end
SELECT * from #TEMP1;

--					������� 8
begin try
Select * from STUDENT where STUDENT.BDAY =  @sdfsd;
end try
begin catch
print '��� ������: ' + ERROR_NUMBER()
print '��������� �� ������: ' + ERROR_MESSAGE()
print '������ ������: ' + ERROR_LINE()
print '��� ��������� ������: ' + ERROR_PROCEDURE()
print '������� ����������� ������: ' + ERROR_SEVERITY()
print '����� ������: ' + ERROR_STATE()

end catch
 