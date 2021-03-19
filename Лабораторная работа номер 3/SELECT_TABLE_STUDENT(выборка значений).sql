USE KOVALEV_UNIVER
SELECT * From STUDENT

SELECT Фамилия_студента,Номер_зачётки From STUDENT;

SELECT count(*) [Количество записей]From STUDENT;

SELECT TOP 2  Фамилия_студента [4 и 3 группы]From STUDENT
		Where Номер_группы = 4 OR Номер_группы = 3 ;

SELECT DISTINCT  Фамилия_студента [4 и 3 группы]From STUDENT
		Where Номер_группы = 4 OR Номер_группы = 3 ;