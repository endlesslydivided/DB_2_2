--							ЗАДАНИЕ 3

use K_MyBase;
go
create PROCEDURE PCONTACTS @find_comp varchar(20)
as
begin
	select Контактное_лицо 'Контактное лицо',Название_предприятия 'Предприятие', Телефон 'Телефон' from КОНТАКТЫ where Название_предприятия= @find_comp;
	print 'параметры: @find_comp=' +@find_comp;
	declare @k int = (select count(*) from КОНТАКТЫ);
	return @k ;
end;

CREATE TABLE #CONTACTS
(Контактное_лицо		nvarchar(50)		not null,
Название_предприятия	nvarchar(20)			,
Телефон		nvarchar(13)		not null
);

INSERT #CONTACTS exec PCONTACTS @find_sub = 'Apple';

SELECT * FROM #CONTACTS;

DROP PROCEDURE PCONTACTS;
DROP TABLE #CONTACTS;


--							ЗАДАНИЕ 4

go
CREATE PROCEDURE PREPORTS_INSERT @rd nvarchar(20), @nc nvarchar(20), @ni nvarchar(50), @v real
as

	declare @ret int = 1;

	begin try
		INSERT into ОТЧЁТЫ(Дата_отчёта,Название_предприятия,Название_показателя,Значение_показателя)
			values(@rd,@nc,@ni,@v);
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
EXEC @paud = PREPORTS_INSERT @rd='16/05/21',@nc='БГТУ',@ni='Бюджет',@v='4,3';			
DELETE ОТЧЁТЫ where Дата_отчёта='16/05/21';

DROP PROCEDURE PREPORTS_INSERT;

--							ЗАДАНИЕ 5

go
CREATE PROCEDURE COMPANY_REPORT @p nvarchar(100)
as 
	declare @ret int = 0;
	begin try
		declare @dates nvarchar(300) ='',@date nvarchar(10), @name nvarchar (50);
		DECLARE  Date_Report CURSOR LOCAL for
		select Дата_отчёта,Название_Показателя from ОТЧЁТЫ where Название_предприятия = @p ;
		if not exists (select Дата_отчёта,Название_Показателя from ОТЧЁТЫ where Название_предприятия = @p)
			raiserror('Ошибка',11,1);
		else
			open Date_Report;
			fetch Date_Report into @date,@name;
			while @@FETCH_STATUS = 0
				begin	
					set @dates = RTRIM(@date) +' ' + RTRIM(@name) +  CHAR(10) + @dates;
					set @ret = @ret + 1;
					fetch Date_Report into @date,@name;
				end;
			print 'Даты отчётов для фирмы ' + @p;
			print @dates;
			close Date_Report;
			return @ret;
	end try

	begin catch
		print 'Код ошибки: ' + cast(ERROR_NUMBER() as varchar(6));
		print 'Сообщение об ошибке: ' + ERROR_MESSAGE();
		print 'Строка ошибки: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры ошибки: ' + ERROR_PROCEDURE();
		print 'Уровень серьёзности ошибки: ' + cast(ERROR_SEVERITY()as varchar(6));
		print 'Метка ошибки: ' + cast(ERROR_STATE()as varchar(8));
		return @ret;
	end catch;

DECLARE @res_rep int;
exec @res_rep = COMPANY_REPORT @p = 'БГТУ';
print 'Количество отчётов: ' + cast(@res_rep as varchar(3));

DROP PROCEDURE COMPANY_REPORT;
		


--							ЗАДАНИЕ 6

go
CREATE PROCEDURE PREPORTS_INSERTX @rd nvarchar(20), @nc nvarchar(20), @ni nvarchar(50), @v real, @nii nvarchar(50), @vpi real
as

	declare @ret int = 1;

	begin try
		set transaction isolation level SERIALIZABLE;
			begin tran
				EXEC PREPORTS_INSERT @rd='16/05/21',@nc='БГТУ',@ni='Бюджет',@v='4,3';	
				INSERT ПОКАЗАТЕЛИ values(@nii,@vpi);
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
EXEC @paud = PREPORTS_INSERTX @rd='16/05/21',@nc='БГТУ',@ni='Бюджет',@v='4,3',@nii = 'Популярность',@vpi = '0,3';			
DELETE ОТЧЁТЫ where Дата_отчёта='16/05/21';

DROP PROCEDURE PREPORTS_INSERTX;