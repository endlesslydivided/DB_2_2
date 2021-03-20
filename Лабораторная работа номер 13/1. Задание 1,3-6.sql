--							ЗАДАНИЕ 1

use K_UNIVER;

go
create PROCEDURE PSUBJECT
as
begin
	select SUBJECT 'Код',SUBJECT_NAME 'Дисциплина', PULPIT 'Кафедра' from SUBJECT;
	declare @q int = (select count(*) from SUBJECT);
	return @q;
end;

DROP PROCEDURE PSUBJECT;

declare @result int = 0, @r int = 0
EXEC @result = PSUBJECT @p='ИСИТ',@c = @r output;
print 'Количество дисциплин:' + cast(@result as varchar(5));
print 'Количество дициплин кафедры ИСИТ:' + cast(@r as varchar(5));
end

--							ЗАДАНИЕ 3

use K_UNIVER;
go
create PROCEDURE PSUBJECT_3 @find_sub varchar(20)
as
begin
	select [SUBJECT] 'Код',SUBJECT_NAME 'Дисциплина', PULPIT 'Кафедра' from [SUBJECT] where PULPIT= @find_sub;
	print 'параметры: @p=' +@find_sub;
	declare @k int = (select count(*) from SUBJECT);
	return @k ;
end;

CREATE TABLE #SUBJECTS
(Код		char(10)		not null,
Дисциплина	varchar(100)			,
Кафедра		char(20)		not null
);

INSERT #SUBJECTS exec PSUBJECT_3 @find_sub = 'ИСИТ';

SELECT * FROM #SUBJECTS;

DROP PROCEDURE PSUBJECT_3;
DROP TABLE #SUBJECTS;
end

--							ЗАДАНИЕ 4

use K_UNIVER;

go
CREATE PROCEDURE PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int = 0, @t char(10)
as

	declare @ret int = 1;

	begin try
		INSERT into AUDITORIUM (AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_CAPACITY,AUDITORIUM_TYPE)
			values(@a,@n,@c,@t);
		return  @ret;
	end try

	begin catch
		print 'Код ошибки: ' + cast(ERROR_NUMBER() as varchar(6));
		print 'Сообщение об ошибке: ' + ERROR_MESSAGE();
		print 'Строка ошибки: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры ошибки: ' + ERROR_PROCEDURE();
		print 'Уровень серьёзности ошибки: ' + cast(ERROR_SEVERITY()as varchar(6));
		print 'Метка ошибки: ' + cast(ERROR_STATE()as varchar(8));
		return -1;
	end catch;

DECLARE @paud int = 0;
EXEC @paud = PAUDITORIUM_INSERT @a='423-1',@n='423-1',@c='90',@t='ЛБ-К';
DELETE AUDITORIUM where AUDITORIUM_NAME='423-1';

DROP PROCEDURE PAUDITORIUM_INSERT;

--							ЗАДАНИЕ 5

use K_UNIVER;

go
CREATE PROCEDURE SUBJECT_REPORT @p CHAR(10)
as 
	declare @ret int = 0;
	begin try
		declare @subjects nvarchar(300) ='',@subject nvarchar(10);
		DECLARE  Sub_Report CURSOR LOCAL for
		select [SUBJECT] from [SUBJECT] where PULPIT = @p;
		if not exists (select [SUBJECT] from [SUBJECT] where PULPIT = @p)
			raiserror('Ошибка',11,1);
		else
			open Sub_Rep;
			fetch Sub_Rep into @subject;
			set @subjects += RTRIM(@subject);
			while @@FETCH_STATUS = 0
				begin	
					fetch Sub_Rep into @subject;
					set @subjects = RTRIM(@subject) + ',' +@subjects;
					set @ret = @ret + 1;
				end;
			print 'Дисциплины кафедры ' + @p;
			print @subjects;
			close Sub_Rep;
			return @ret;
	end try

	begin catch
		print 'Ошибка в параметрах.'
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры:' + error_procedure();
		return @ret;
	end catch;

DECLARE @res_rep int;
exec @res_rep = SUBJECT_REPORT @p = 'ИСиТ';
print 'Количество дисциплин: ' + cast(@res_rep as varchar(3));

DROP PROCEDURE SUBJECT_REPORT;
		


--							ЗАДАНИЕ 6

use K_UNIVER;

go
CREATE PROCEDURE PAUDITORIUM_INSERTX @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn varchar(50)
as

	declare @ret int = 1;

	begin try
		set transaction isolation level SERIALIZABLE;
			begin tran
				INSERT into [AUDITORIUM TYPE](AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
					values(@t,@tn);
				EXEC PAUDITORIUM_INSERT @a='423-1',@n='423-1',@c='90',@t='ЛБ-К';
			commit tran;
			return  @ret;
	end try

	begin catch
		print 'Код ошибки: ' + cast(ERROR_NUMBER() as varchar(6));
		print 'Сообщение об ошибке: ' + ERROR_MESSAGE();
		print 'Строка ошибки: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры ошибки: ' + ERROR_PROCEDURE();
		print 'Уровень серьёзности ошибки: ' + cast(ERROR_SEVERITY()as varchar(6));
		print 'Метка ошибки: ' + cast(ERROR_STATE()as varchar(8));
		if @@TRANCOUNT > 0 rollback tran;
		return -1;
	end catch;

DECLARE @paud int = 0;
EXEC @paud = PAUDITORIUM_INSERTX @a='423-1',@n='423-1',@c='90',@t='ЛБ-К', @tn ='Компьютерный класс';
DELETE AUDITORIUM where AUDITORIUM_NAME='423-1';

DROP PROCEDURE PAUDITORIUM_INSERTX;