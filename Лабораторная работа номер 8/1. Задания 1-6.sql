use K_UNIVER;

--						������� 1

go
CREATE VIEW [�������������]
as select   TEACHER			[���],
				TEACHER_NAME    [��� �������������],
				GENDER			[���],
				PULPIT			[��� �������]
				from TEACHER;

--						������� 2

go
CREATE VIEW [���������� ������]
as select		FACULTY_NAME		[���������],
				count(PULPIT)		[����������_������]
				from FACULTY inner join PULPIT
				on FACULTY.FACULTY = PULPIT.FACULTY group by FACULTY_NAME;

--						������� 3

go
CREATE VIEW ���������
as select		AUDITORIUM		[���],
				AUDITORIUM_NAME [������������ ���������]
			from AUDITORIUM
			where AUDITORIUM.AUDITORIUM_TYPE like '��%'
          insert ��������� values ('318-9','318-9')

--						������� 4

go
CREATE VIEW [���������� ���������]
as select		AUDITORIUM		[���],
				AUDITORIUM_NAME [������������ ���������]
			from AUDITORIUM
			where AUDITORIUM.AUDITORIUM_TYPE like '��%'
			and AUDITORIUM_NAME = AUDITORIUM
			WITH CHECK OPTION
			insert [���������� ���������] values ('318-9','318-9');

--						������� 5

go 
CREATE VIEW ����������
as select TOP 10	SUBJECT			[���],
					SUBJECT_NAME	[������������ ����������],
					PULPIT			[��� �������]
					from SUBJECT
					order by SUBJECT_NAME;

--						������� 6

go
ALTER VIEW [���������� ������] with SCHEMABINDING
as select		fclt.FACULTY_NAME		[���������],
				count(plpt.PULPIT)		[����������_������]
				from dbo.FACULTY fclt inner join dbo.PULPIT plpt
				on fclt.FACULTY = plpt.FACULTY group by FACULTY_NAME;
INSERT into [���������� ������] values ('��',3);


--DROP VIEW �������������;
--DROP VIEW [���������� ������];
--DROP VIEW ���������;
--DROP VIEW [���������� ���������];
--DROP VIEW ����������;