use K_MyBase;


SELECT * From КОНТАКТЫ;

SELECT Название_показателя From ПОКАЗАТЕЛИ;

SELECT count(*) [Количество записей]From ОТЧЁТЫ;

SELECT * From ОТЧЁТЫ Where Название_предприятия = 'БГТУ';

SELECT  Дата_отчёта [Отчёты за 2020] , Название_предприятия From ОТЧЁТЫ 
Where YEAR(Дата_отчёта) = '2020' ;