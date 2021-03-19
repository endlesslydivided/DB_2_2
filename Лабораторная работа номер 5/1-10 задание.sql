use K_UNIVER;
--						ЗАДАНИЕ 1

SELECT AUDITORIUM.AUDITORIUM, [AUDITORIUM TYPE].AUDITORIUM_TYPENAME
		From AUDITORIUM Inner Join [AUDITORIUM TYPE]	
		On AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE;

--						ЗАДАНИЕ 2

SELECT AUDITORIUM.AUDITORIUM,[AUDITORIUM TYPE].AUDITORIUM_TYPENAME
		From AUDITORIUM Inner Join [AUDITORIUM TYPE]
		On AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE AND
		[AUDITORIUM TYPE].AUDITORIUM_TYPENAME Like '%компьютер%';

--						ЗАДАНИЕ 3

SELECT AUDITORIUM.AUDITORIUM, [AUDITORIUM TYPE].AUDITORIUM_TYPENAME
		From AUDITORIUM, [AUDITORIUM TYPE]	
		Where AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE;

SELECT AUDITORIUM.AUDITORIUM,[AUDITORIUM TYPE].AUDITORIUM_TYPENAME
		From AUDITORIUM, [AUDITORIUM TYPE]
		Where AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE AND
		[AUDITORIUM TYPE].AUDITORIUM_TYPENAME Like '%компьютер%';

--						ЗАДАНИЕ 4

SELECT STUDENT.[NAME]		[Имя студента],
	PROFESSION.PROFESSION_NAME		Специальность,
	FACULTY.FACULTY	Факультет,
	PULPIT.PULPIT			Кафедра,
	[SUBJECT].SUBJECT_NAME	Дисциплина,
Case
	when (PROGRESS.NOTE = 6) then 'шесть'
	when (PROGRESS.NOTE = 7) then 'семь'
	when (PROGRESS.NOTE = 8) then 'восемь'
	end Оценка
		From STUDENT Inner Join  PROGRESS
		On STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		inner join [SUBJECT]
		On PROGRESS.[SUBJECT] = [SUBJECT].[SUBJECT] and (PROGRESS.NOTE between 6 and 8)
		inner join [GROUP]
		On STUDENT.IDGROUP = [GROUP].IDGROUP
		inner join PULPIT
		On [SUBJECT].PULPIT = PULPIT.PULPIT
		inner join PROFESSION
		On PROFESSION.PROFESSION = [GROUP].PROFESSION
		inner join FACULTY
		On [GROUP].FACULTY = FACULTY.FACULTY
		Order by FACULTY.FACULTY,PULPIT.PULPIT,PROFESSION.PROFESSION,STUDENT.[NAME] ASC,PROGRESS.NOTE DESC;

--						ЗАДАНИЕ 5

SELECT STUDENT.[NAME]		[Имя студента],
	PROFESSION.PROFESSION_NAME		Специальность,
	FACULTY.FACULTY	Факультет,
	PULPIT.PULPIT			Кафедра,
	[SUBJECT].SUBJECT_NAME	Дисциплина,
Case
	when (PROGRESS.NOTE = 6) then 'шесть'
	when (PROGRESS.NOTE = 7) then 'семь'
	when (PROGRESS.NOTE = 8) then 'восемь'
	end Оценка
		From STUDENT Inner Join  PROGRESS
		On STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		inner join [SUBJECT]
		On PROGRESS.[SUBJECT] = [SUBJECT].[SUBJECT] and (PROGRESS.NOTE between 6 and 8)
		inner join [GROUP]
		On STUDENT.IDGROUP = [GROUP].IDGROUP
		inner join PULPIT
		On [SUBJECT].PULPIT = PULPIT.PULPIT
		inner join PROFESSION
		On PROFESSION.PROFESSION = [GROUP].PROFESSION
		inner join FACULTY
		On [GROUP].FACULTY = FACULTY.FACULTY
		Order by 
		(CASE
				when(PROGRESS.NOTE = 7) then 1
				when(PROGRESS.NOTE = 8) then 2
				when(PROGRESS.NOTE = 6) then 3
				end
		);

--						ЗАДАНИЕ 6

SELECT isnull(TEACHER.TEACHER_NAME,'***') Преподаватель,PULPIT.PULPIT_NAME Кафедра
	From PULPIT Left Outer JOIN TEACHER
	on TEACHER.PULPIT = PULPIT.PULPIT;

--						ЗАДАНИЕ 7

SELECT isnull(TEACHER.TEACHER_NAME,'***') Преподаватель,PULPIT.PULPIT_NAME Кафедра
	From TEACHER Left Outer JOIN PULPIT
	on TEACHER.PULPIT = PULPIT.PULPIT;

SELECT isnull(TEACHER.TEACHER_NAME,'***') Преподаватель,PULPIT.PULPIT_NAME Кафедра
	From TEACHER Right Outer JOIN PULPIT
	on TEACHER.PULPIT = PULPIT.PULPIT;

--						ЗАДАНИЕ 8

SELECT isnull(TEACHER.TEACHER_NAME,'***') Преподаватель,[SUBJECT].SUBJECT_NAME Дисциплина 
		FROM TEACHER Inner JOIN PULPIT
		On TEACHER.PULPIT = PULPIT.PULPIT
		FULL outer Join [SUBJECT]
		On PULPIT.PULPIT = [SUBJECT].PULPIT
		where TEACHER.TEACHER_NAME is NULL

SELECT TEACHER.TEACHER_NAME Преподаватель,isnull([SUBJECT].SUBJECT_NAME,'***') Дисциплина 
		FROM PULPIT Inner JOIN TEACHER
		On TEACHER.PULPIT = PULPIT.PULPIT
		FULL outer Join [SUBJECT]
		On PULPIT.PULPIT = [SUBJECT].PULPIT
		where [SUBJECT].SUBJECT_NAME is NULL

SELECT TEACHER.TEACHER_NAME Преподаватель,[SUBJECT].SUBJECT_NAME Дисциплина 
		FROM PULPIT Inner JOIN TEACHER
		On TEACHER.PULPIT = PULPIT.PULPIT
		FULL outer Join [SUBJECT]
		On PULPIT.PULPIT = [SUBJECT].PULPIT
		where [SUBJECT].SUBJECT_NAME is not NULL AND TEACHER.TEACHER_NAME is not NULL

--						ЗАДАНИЕ 9

SELECT AUDITORIUM.AUDITORIUM,[AUDITORIUM TYPE].AUDITORIUM_TYPE
		From AUDITORIUM Cross JOIN [AUDITORIUM TYPE]
		Where AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE
			and AUDITORIUM.AUDITORIUM is not NULL;

--						ЗАДАНИЕ 10

use K_MyBase;

SELECT ОТЧЁТЫ.Дата_отчёта,ОТЧЁТЫ.Название_предприятия,ОТЧЁТЫ.Название_показателя,ОТЧЁТЫ.Значение_показателя, 
CASE

	when(ПОКАЗАТЕЛИ.Важность_показателя between 0.1 and 0.4) then 'низкая'
	when(ПОКАЗАТЕЛИ.Важность_показателя between 0.6 and 0.9) then 'высокая'
	when(ПОКАЗАТЕЛИ.Важность_показателя = 0.5) then 'средняя'
	end [Важность показателя]
		From ОТЧЁТЫ Inner Join ПОКАЗАТЕЛИ	
		On ОТЧЁТЫ.Название_показателя = ПОКАЗАТЕЛИ.Название_показателя
		Order by
		(CASE
			when(ПОКАЗАТЕЛИ.Важность_показателя between 0.1 and 0.4) then 2
			when(ПОКАЗАТЕЛИ.Важность_показателя between 0.6 and 0.9) then 1
			when(ПОКАЗАТЕЛИ.Важность_показателя = 0.5) then 3
			end
		);

SELECT  isnull(ОТЧЁТЫ.Дата_отчёта,'отсутствие отчётов')[Дата отчёта],ПРЕДПРИЯТИЯ.Название_предприятия, ПРЕДПРИЯТИЯ.Банковские_реквизиты
		From ОТЧЁТЫ Right Outer Join ПРЕДПРИЯТИЯ	
		On ОТЧЁТЫ.Название_предприятия = ПРЕДПРИЯТИЯ.Название_предприятия;

SELECT  isnull(ОТЧЁТЫ.Дата_отчёта,'отсутствие отчётов') [Дата отчёта],ПРЕДПРИЯТИЯ.Название_предприятия, ПРЕДПРИЯТИЯ.Банковские_реквизиты
		From ОТЧЁТЫ FULL Outer Join ПРЕДПРИЯТИЯ	
		On ОТЧЁТЫ.Название_предприятия = ПРЕДПРИЯТИЯ.Название_предприятия
		where ОТЧЁТЫ.Дата_отчёта is not NULL;
		

SELECT DISTINCT ОТЧЁТЫ.Дата_отчёта,ПРЕДПРИЯТИЯ.Название_предприятия, ПРЕДПРИЯТИЯ.Банковские_реквизиты
		From ОТЧЁТЫ Left Outer Join ПРЕДПРИЯТИЯ	
		On ОТЧЁТЫ.Название_предприятия = ПРЕДПРИЯТИЯ.Название_предприятия;
