use K_UNIVER;

go
CREATE VIEW ����������
as select TOP 150 [�����],[22 ������],[23 ������]
					from (select TOP 150	DAYWEEK	+ ' ' + CAST(CLASS as varchar)		[�����],
					cast(IDGROUP as varchar)	+ ' ������'								[������],
					[SUBJECT] + ' ' + AUDITORIUM  [���������� � ���������]
					from TIMETABLE 
						 ) tbl
PIVOT
		( max([���������� � ���������]) 
		FOR ������
		in ([22 ������],[23 ������])
		) as rt
		order by 
					(CASE
					 when [�����] like '%�����������%' then 1
					 when [�����] like '%�������%' then 2
					 when [�����] like '%�����%' then 3
					 when [�����] like '%�������%' then 4
					 when [�����] like '%�������%' then 5
					 when [�����] like '%�������%' then 6
					 end) ;
			
--DROP VIEW ����������;
