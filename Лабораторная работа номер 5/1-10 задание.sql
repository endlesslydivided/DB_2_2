use K_UNIVER;
--						������� 1

SELECT AUDITORIUM.AUDITORIUM, [AUDITORIUM TYPE].AUDITORIUM_TYPENAME
		From AUDITORIUM Inner Join [AUDITORIUM TYPE]	
		On AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE;

--						������� 2

SELECT AUDITORIUM.AUDITORIUM,[AUDITORIUM TYPE].AUDITORIUM_TYPENAME
		From AUDITORIUM Inner Join [AUDITORIUM TYPE]
		On AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE AND
		[AUDITORIUM TYPE].AUDITORIUM_TYPENAME Like '%���������%';

--						������� 3

SELECT AUDITORIUM.AUDITORIUM, [AUDITORIUM TYPE].AUDITORIUM_TYPENAME
		From AUDITORIUM, [AUDITORIUM TYPE]	
		Where AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE;

SELECT AUDITORIUM.AUDITORIUM,[AUDITORIUM TYPE].AUDITORIUM_TYPENAME
		From AUDITORIUM, [AUDITORIUM TYPE]
		Where AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE AND
		[AUDITORIUM TYPE].AUDITORIUM_TYPENAME Like '%���������%';

--						������� 4

SELECT STUDENT.[NAME]		[��� ��������],
	PROFESSION.PROFESSION_NAME		�������������,
	FACULTY.FACULTY	���������,
	PULPIT.PULPIT			�������,
	[SUBJECT].SUBJECT_NAME	����������,
Case
	when (PROGRESS.NOTE = 6) then '�����'
	when (PROGRESS.NOTE = 7) then '����'
	when (PROGRESS.NOTE = 8) then '������'
	end ������
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

--						������� 5

SELECT STUDENT.[NAME]		[��� ��������],
	PROFESSION.PROFESSION_NAME		�������������,
	FACULTY.FACULTY	���������,
	PULPIT.PULPIT			�������,
	[SUBJECT].SUBJECT_NAME	����������,
Case
	when (PROGRESS.NOTE = 6) then '�����'
	when (PROGRESS.NOTE = 7) then '����'
	when (PROGRESS.NOTE = 8) then '������'
	end ������
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

--						������� 6

SELECT isnull(TEACHER.TEACHER_NAME,'***') �������������,PULPIT.PULPIT_NAME �������
	From PULPIT Left Outer JOIN TEACHER
	on TEACHER.PULPIT = PULPIT.PULPIT;

--						������� 7

SELECT isnull(TEACHER.TEACHER_NAME,'***') �������������,PULPIT.PULPIT_NAME �������
	From TEACHER Left Outer JOIN PULPIT
	on TEACHER.PULPIT = PULPIT.PULPIT;

SELECT isnull(TEACHER.TEACHER_NAME,'***') �������������,PULPIT.PULPIT_NAME �������
	From TEACHER Right Outer JOIN PULPIT
	on TEACHER.PULPIT = PULPIT.PULPIT;

--						������� 8

SELECT isnull(TEACHER.TEACHER_NAME,'***') �������������,[SUBJECT].SUBJECT_NAME ���������� 
		FROM TEACHER Inner JOIN PULPIT
		On TEACHER.PULPIT = PULPIT.PULPIT
		FULL outer Join [SUBJECT]
		On PULPIT.PULPIT = [SUBJECT].PULPIT
		where TEACHER.TEACHER_NAME is NULL

SELECT TEACHER.TEACHER_NAME �������������,isnull([SUBJECT].SUBJECT_NAME,'***') ���������� 
		FROM PULPIT Inner JOIN TEACHER
		On TEACHER.PULPIT = PULPIT.PULPIT
		FULL outer Join [SUBJECT]
		On PULPIT.PULPIT = [SUBJECT].PULPIT
		where [SUBJECT].SUBJECT_NAME is NULL

SELECT TEACHER.TEACHER_NAME �������������,[SUBJECT].SUBJECT_NAME ���������� 
		FROM PULPIT Inner JOIN TEACHER
		On TEACHER.PULPIT = PULPIT.PULPIT
		FULL outer Join [SUBJECT]
		On PULPIT.PULPIT = [SUBJECT].PULPIT
		where [SUBJECT].SUBJECT_NAME is not NULL AND TEACHER.TEACHER_NAME is not NULL

--						������� 9

SELECT AUDITORIUM.AUDITORIUM,[AUDITORIUM TYPE].AUDITORIUM_TYPE
		From AUDITORIUM Cross JOIN [AUDITORIUM TYPE]
		Where AUDITORIUM.AUDITORIUM_TYPE = [AUDITORIUM TYPE].AUDITORIUM_TYPE
			and AUDITORIUM.AUDITORIUM is not NULL;

--						������� 10

use K_MyBase;

SELECT ��ר��.����_������,��ר��.��������_�����������,��ר��.��������_����������,��ר��.��������_����������, 
CASE

	when(����������.��������_���������� between 0.1 and 0.4) then '������'
	when(����������.��������_���������� between 0.6 and 0.9) then '�������'
	when(����������.��������_���������� = 0.5) then '�������'
	end [�������� ����������]
		From ��ר�� Inner Join ����������	
		On ��ר��.��������_���������� = ����������.��������_����������
		Order by
		(CASE
			when(����������.��������_���������� between 0.1 and 0.4) then 2
			when(����������.��������_���������� between 0.6 and 0.9) then 1
			when(����������.��������_���������� = 0.5) then 3
			end
		);

SELECT  isnull(��ר��.����_������,'���������� �������')[���� ������],�����������.��������_�����������, �����������.����������_���������
		From ��ר�� Right Outer Join �����������	
		On ��ר��.��������_����������� = �����������.��������_�����������;

SELECT  isnull(��ר��.����_������,'���������� �������') [���� ������],�����������.��������_�����������, �����������.����������_���������
		From ��ר�� FULL Outer Join �����������	
		On ��ר��.��������_����������� = �����������.��������_�����������
		where ��ר��.����_������ is not NULL;
		

SELECT DISTINCT ��ר��.����_������,�����������.��������_�����������, �����������.����������_���������
		From ��ר�� Left Outer Join �����������	
		On ��ר��.��������_����������� = �����������.��������_�����������;
