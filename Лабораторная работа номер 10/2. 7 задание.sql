use K_MyBase;

CREATE INDEX ДАТА_ОТЧЁТА_INDEX on ОТЧЁТЫ(ДАТА_ОТЧЁТА asc);
DROP INDEX [ОТЧЁТЫ].[ДАТА_ОТЧЁТА_INDEX];

SELECT ДАТА_ОТЧЁТА FROM ОТЧЁТЫ t where ДАТА_ОТЧЁТА > '04.04.2004' and Дата_отчёта < '05.05.2020';

-- НАЧАЛЬНАЯ СТОИМОСТЬ: 0.0032 ▬ КОНЕЧНАЯ СТОИМОСТЬ: 0.0032
-- ФРАГМЕНТАЦИЯ - 0%

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
	FROM sys.dm_db_index_physical_stats(DB_ID(N'K_MyBase'), 
	OBJECT_ID(N'ДАТА_ОТЧЁТА_INDEX'),NULL,NULL,NULL) ss
	inner JOIN sys.indexes ii on ss.index_id = ii.index_id and ss.object_id = ii.object_id
											WHERE name is not null;

CREATE INDEX ПРЕДПРИЯТИЯ_INDEX on ПРЕДПРИЯТИЯ(НАЗВАНИЕ_ПРЕДПРИЯТИЯ,БАНКОВСКИЕ_РЕКВИЗИТЫ);
DROP INDEX [ПРЕДПРИЯТИЯ].[ПРЕДПРИЯТИЯ_INDEX];

SELECT НАЗВАНИЕ_ПРЕДПРИЯТИЯ,БАНКОВСКИЕ_РЕКВИЗИТЫ FROM  ПРЕДПРИЯТИЯ ;

-- НАЧАЛЬНАЯ СТОИМОСТЬ: 0.0032853 ▬ КОНЕЧНАЯ СТОИМОСТЬ: 0.0032
-- ФРАГМЕНТАЦИЯ - 0%

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
	FROM sys.dm_db_index_physical_stats(DB_ID(N'K_MyBase'), 
	OBJECT_ID(N'ДАТА_ОТЧЁТА_INDEX'),NULL,NULL,NULL) ss
	inner JOIN sys.indexes ii on ss.index_id = ii.index_id and ss.object_id = ii.object_id
											WHERE name is not null;