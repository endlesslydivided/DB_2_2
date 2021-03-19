use K_UNIVER;

go
CREATE VIEW Расписание
as select TOP 150 [Время],[22 группа],[23 группа]
					from (select TOP 150	DAYWEEK	+ ' ' + CAST(CLASS as varchar)		[Время],
					cast(IDGROUP as varchar)	+ ' группа'								[Группа],
					[SUBJECT] + ' ' + AUDITORIUM  [Дисциплина и аудитория]
					from TIMETABLE 
						 ) tbl
PIVOT
		( max([Дисциплина и аудитория]) 
		FOR Группа
		in ([22 группа],[23 группа])
		) as rt
		order by 
					(CASE
					 when [Время] like '%Понедельник%' then 1
					 when [Время] like '%Вторник%' then 2
					 when [Время] like '%Среда%' then 3
					 when [Время] like '%Четверг%' then 4
					 when [Время] like '%Пятница%' then 5
					 when [Время] like '%Суббота%' then 6
					 end) ;
			
--DROP VIEW Расписание;
