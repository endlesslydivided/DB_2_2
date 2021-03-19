use K_UNIVER;

--						Задание 1

go
CREATE VIEW [Преподаватель]
as select   TEACHER			[Код],
				TEACHER_NAME    [Имя преподавателя],
				GENDER			[Пол],
				PULPIT			[Код кафедры]
				from TEACHER;

--						Задание 2

go
CREATE VIEW [Количество кафедр]
as select		FACULTY_NAME		[Факультет],
				count(PULPIT)		[Количество_кафедр]
				from FACULTY inner join PULPIT
				on FACULTY.FACULTY = PULPIT.FACULTY group by FACULTY_NAME;

--						Задание 3

go
CREATE VIEW Аудитории
as select		AUDITORIUM		[Код],
				AUDITORIUM_NAME [Наименование аудитории]
			from AUDITORIUM
			where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%'
          insert Аудитории values ('318-9','318-9')

--						Задание 4

go
CREATE VIEW [Лекционные аудитории]
as select		AUDITORIUM		[Код],
				AUDITORIUM_NAME [Наименование аудитории]
			from AUDITORIUM
			where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%'
			and AUDITORIUM_NAME = AUDITORIUM
			WITH CHECK OPTION
			insert [Лекционные аудитории] values ('318-9','318-9');

--						Задание 5

go 
CREATE VIEW Дисциплины
as select TOP 10	SUBJECT			[Код],
					SUBJECT_NAME	[Наименование дисциплины],
					PULPIT			[Код кафедры]
					from SUBJECT
					order by SUBJECT_NAME;

--						Задание 6

go
ALTER VIEW [Количество кафедр] with SCHEMABINDING
as select		fclt.FACULTY_NAME		[Факультет],
				count(plpt.PULPIT)		[Количество_кафедр]
				from dbo.FACULTY fclt inner join dbo.PULPIT plpt
				on fclt.FACULTY = plpt.FACULTY group by FACULTY_NAME;
INSERT into [Количество кафедр] values ('ИТ',3);


--DROP VIEW Преподаватель;
--DROP VIEW [Количество кафедр];
--DROP VIEW Аудитории;
--DROP VIEW [Лекционные аудитории];
--DROP VIEW Дисциплины;