use K_MyBase;

go
DECLARE @number varchar(100), @name varchar (11), @rek varchar (2);
DECLARE ПРЕДПРИЯТИЯ_CURSOR_SCROLL CURSOR LOCAL DYNAMIC SCROLL
	for select ROW_NUMBER() over (order by Название_предприятия) Номер,
	ПРЕДПРИЯТИЯ.Название_предприятия,ПРЕДПРИЯТИЯ.Банковские_реквизиты from ПРЕДПРИЯТИЯ;

OPEN ПРЕДПРИЯТИЯ_CURSOR_SCROLL
FETCH ПРЕДПРИЯТИЯ_CURSOR_SCROLL into @number,@name,@rek;
print 'Первая выбранная строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number)  +
'. Название предприятия: '  + rtrim(@name) + 
'. Реквизиты: ' + rtrim(@rek);

FETCH LAST from ПРЕДПРИЯТИЯ_CURSOR_SCROLL into @number,@name,@rek;
print 'Последняя строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number)  +
'. Название предприятия: '  + rtrim(@name) + 
'. Реквизиты: ' + rtrim(@rek);

FETCH RELATIVE -1  from ПРЕДПРИЯТИЯ_CURSOR_SCROLL into @number,@name,@rek;
print 'Первая до предыдущей строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number)  +
'. Название предприятия: '  + rtrim(@name) + 
'. Реквизиты: ' + rtrim(@rek);

close ПРЕДПРИЯТИЯ_CURSOR_SCROLL
-----------------------------------------------------------------------------------------------------------------------
go
DECLARE ОТЧЁТЫ_CURSOR CURSOR LOCAL STATIC for select * from ОТЧЁТЫ where YEAR(ОТЧЁТЫ.Дата_отчёта) = '2020';
DECLARE @number varchar(100),@date varchar(11), @name varchar (50),@indicator_name varchar(50), @value varchar(5);

OPEN ОТЧЁТЫ_CURSOR;
print 'Отчёты за 2020:';
FETCH ABSOLUTE 1 from ОТЧЁТЫ_CURSOR into @number,@date,@name,@indicator_name,@value;
while @@FETCH_STATUS = 0
	begin
		print  CHAR(10) +
'Номер отчёта: '+ rtrim(@number)  +
'. Дата отчёта: '  + rtrim(@date) + 
'. Название предприятия: '  + rtrim(@name) + 
'. Имя показателя: ' + rtrim(@indicator_name)+ 
'. Значение показатля: '  + rtrim(@value);
	FETCH ОТЧЁТЫ_CURSOR into @number,@date,@name,@indicator_name,@value;
	end;
CLOSE ОТЧЁТЫ_CURSOR;