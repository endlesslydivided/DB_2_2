use K_UNIVER;
--						������� 1
SELECT min(AUDITORIUM.AUDITORIUM_CAPACITY) [����������� �����������],
	   max(AUDITORIUM.AUDITORIUM_CAPACITY) [������������ �����������],
	   avg(AUDITORIUM.AUDITORIUM_CAPACITY) [������� �����������],
	   sum(AUDITORIUM.AUDITORIUM_CAPACITY) [����� ������������]
FROM AUDITORIUM;

--						������� 2

SELECT [AUDITORIUM TYPE].AUDITORIUM_TYPE,
	   min(AUDITORIUM.AUDITORIUM_CAPACITY) [����������� �����������],
	   max(AUDITORIUM.AUDITORIUM_CAPACITY) [������������ �����������],
	   avg(AUDITORIUM.AUDITORIUM_CAPACITY) [������� �����������],
	   sum(AUDITORIUM.AUDITORIUM_CAPACITY) [����� ������������]
FROM AUDITORIUM inner join [AUDITORIUM TYPE]
	ON AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE
	Group By [AUDITORIUM TYPE].AUDITORIUM_TYPE

--						������� 3

SELECT * 
	FROM (select CASE 
					when NOTE between 4 and 5 then '4-5'
					when NOTE between 6 and 7 then '6-7'
					when NOTE between 8 and 9 then '8-9'
					when NOTE = 10 then '10'
		 end [������], COUNT(*) [����������]
		 From PROGRESS Group By Case
					when NOTE between 4 and 5 then '4-5'
					when NOTE between 6 and 7 then '6-7'
					when NOTE between 8 and 9 then '8-9'
					when NOTE = 10 then '10' 
		 end) as T  
	order by CASE [������] 
		when '10' then 1
		when '8-9' then 2
		when '6-7' then 3
		when '4-5' then 4
		else 0
		end;

--						������� 4

SELECT FACULTY.FACULTY, [GROUP].PROFESSION, [GROUP].COURSE, 
			round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
			From FACULTY inner join [GROUP]
				on FACULTY.FACULTY = [GROUP].FACULTY
				inner join STUDENT
				on [GROUP].IDGROUP = STUDENT.IDGROUP
				inner join PROGRESS
				on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
				group by FACULTY.FACULTY,[GROUP].PROFESSION,[GROUP].COURSE
				order by [������� ������]
			
SELECT FACULTY.FACULTY, [GROUP].PROFESSION, [GROUP].COURSE, 
			round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
			From FACULTY inner join [GROUP]
				on FACULTY.FACULTY = [GROUP].FACULTY
				inner join STUDENT
				on [GROUP].IDGROUP = STUDENT.IDGROUP
				inner join PROGRESS
				on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT and (PROGRESS.[SUBJECT] ='����' or PROGRESS.[SUBJECT] ='��')
				group by FACULTY.FACULTY,[GROUP].PROFESSION ,[GROUP].COURSE
				order by [������� ������]
			
--						������� 5 � 6	

SELECT FACULTY.FACULTY, [GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP
		inner join FACULTY
		on [GROUP].FACULTY = FACULTY.FACULTY 
		where FACULTY.FACULTY = '��'
		group by ROLLUP([GROUP].PROFESSION,FACULTY.FACULTY, PROGRESS.[SUBJECT]);

SELECT FACULTY.FACULTY, [GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP
		inner join FACULTY
		on [GROUP].FACULTY = FACULTY.FACULTY 
		where FACULTY.FACULTY = '��'
		group by CUBE([GROUP].PROFESSION,FACULTY.FACULTY, PROGRESS.[SUBJECT]);

--						������� 7 - 9

SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '��'
		GROUP BY [GROUP].FACULTY ,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		UNION
SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '����'
		GROUP BY [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		order by [������� ������] desc;
		
SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '��'
		GROUP BY [GROUP].FACULTY ,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		UNION ALL
SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '����'
		GROUP BY [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		order by [������� ������] desc;

SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '��'
		GROUP BY [GROUP].FACULTY ,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		INTERSECT
SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '����'
		GROUP BY [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		order by [������� ������] desc;

SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '��'
		GROUP BY [GROUP].FACULTY ,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		UNION
SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '����'
		GROUP BY [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		EXCEPT
SELECT [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT], round(avg(cast(PROGRESS.NOTE as float(2))),2) [������� ������]
		FROM PROGRESS inner join STUDENT
		on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
		inner join [GROUP]
		on STUDENT.IDGROUP = [GROUP].IDGROUP and [GROUP].FACULTY = '��'
		GROUP BY [GROUP].FACULTY,[GROUP].PROFESSION, PROGRESS.[SUBJECT]
		order by [������� ������] desc;


--						������� 10

SELECT DISTINCT  t1.[SUBJECT], (SELECT count(*) from PROGRESS t2
			where t1.[SUBJECT] = t2.[SUBJECT]
				and( NOTE = '8' or  NOTE = '9') ) [���������� 8 � 9]
			From Progress t1	
						GROUP BY [SUBJECT],NOTE HAVING NOTE = '8' or  NOTE = '9' 
						
