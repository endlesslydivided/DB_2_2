 use KOVALEV_UNIVER

 CREATE Table RESULTS
 (
	ID int primary key identity(1,1),
	DENT_NAME nvarchar(20),
	EXAM_MATH int check (EXAM_MATH Between 0 AND 10),
	EXAM_OOP int check (EXAM_OOP Between 0 AND 10),
	AVER_VALUE as (EXAM_MATH+EXAM_OOP)/2
)

INSERT into RESULTS(DENT_NAME,EXAM_MATH,EXAM_OOP)
VALUES('�������',8,9),
		('�������',6,4),
		('��������',8,7),
		('����',8,9),
		('���������',7,10);
