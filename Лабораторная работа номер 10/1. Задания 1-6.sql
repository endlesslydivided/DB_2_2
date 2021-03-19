use master;

--							ЗАДАНИЕ 1
--exec sp_helpindex 'AUDITORIUM' 
--exec sp_helpindex 'AUDITORIUM TYPE'
--exec sp_helpindex 'FACULTY'
--exec sp_helpindex 'GROUP'
--exec sp_helpindex 'PROFESSION'
--exec sp_helpindex 'PROGRESS'
--exec sp_helpindex 'PULPIT'
--exec sp_helpindex 'STUDENT'
--exec sp_helpindex 'SUBJECT'
--exec sp_helpindex 'TEACHER'
--exec sp_helpindex 'TIMETABLE'

--CREATE TABLE #EXAMPLE
--(	
--	ID int identity(1,1),
--	STRING varchar(13)
--)

set nocount on;
--DECLARE @iter int = 0;
--WHILE @iter < 10000
--	begin
--	INSERT INTO #EXAMPLE values (REPLICATE('строка ',2));
--	SET @iter = @iter + 1;
--	end;

--DROP TABLE #EXAMPLE

--CREATE CLUSTERED INDEX #EXAMPLE_CL1 on #EXAMPLE(ID asc);
--DROP INDEX [#EXAMPLE].[#EXAMPLE_CL1]

SELECT * FROM #EXAMPLE where ID between 150 and 200 order by ID;
checkpoint;  
DBCC DROPCLEANBUFFERS;  

-- НАЧАЛЬНАЯ СТОИМОСТЬ: 0.042 ▬ КОНЕЧНАЯ СТОИМОСТЬ: 0.011

--							ЗАДАНИЕ 2

--CREATE index #EXAMPLE_CL2 on #EXAMPLE(ID,STRING);
--DROP index [#EXAMPLE].[#EXAMPLE_CL2]
checkpoint;  
DBCC DROPCLEANBUFFERS;
SELECT COUNT(*) from #EXAMPLE where STRING = 'строка' and ID = 2;

-- НАЧАЛЬНАЯ СТОИМОСТЬ: 0.043 ▬ КОНЕЧНАЯ СТОИМОСТЬ: 0.0032

--							ЗАДАНИЕ 3

--CREATE INDEX #EXAMPLE_ID_X on #EXAMPLE(ID) INCLUDE (STRING);
--DROP index [#EXAMPLE].[#EXAMPLE_ID_X]
SELECT STRING from #EXAMPLE where ID between 1 and 10;


-- НАЧАЛЬНАЯ СТОИМОСТЬ: 0.043 ▬ КОНЕЧНАЯ СТОИМОСТЬ: 0.0032

--							ЗАДАНИЕ 4

--CREATE INDEX #EXAMPLE_ID_WHERE on #EXAMPLE(ID) where (ID >= 1 and ID <= 10);
--DROP index [#EXAMPLE].[#EXAMPLE_ID_WHERE]
SELECT STRING from #EXAMPLE where ID >= 1 and ID <= 10;


-- НАЧАЛЬНАЯ СТОИМОСТЬ: 0.043 ▬ КОНЕЧНАЯ СТОИМОСТЬ: 0.0030

--							ЗАДАНИЕ 5

--CREATE index #EXAMPLE_UNCL on #EXAMPLE(ID);
--DROP index [#EXAMPLE].[#EXAMPLE_UNCL]
SELECT * FROM #EXAMPLE where ID between 150 and 200 order by ID; 

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
	FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
	OBJECT_ID(N'#EXAMPLE'),NULL,NULL,NULL) ss
	inner JOIN sys.indexes ii on ss.index_id = ii.index_id and ss.object_id = ii.object_id
											WHERE name is not null;

ALTER index #EXAMPLE_UNCL on #EXAMPLE reorganize;

ALTER index #EXAMPLE_UNCL on #EXAMPLE rebuild with (online = off);

--							ЗАДАНИЕ 6

--CREATE index #EXAMPLE_UNCL on #EXAMPLE(ID) with (fillfactor = 65);
--DROP index [#EXAMPLE].[#EXAMPLE_UNCL]

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
	FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
	OBJECT_ID(N'#EXAMPLE'),NULL,NULL,NULL) ss
	inner JOIN sys.indexes ii on ss.index_id = ii.index_id and ss.object_id = ii.object_id
											WHERE name is not null;
