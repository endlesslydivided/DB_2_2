--							������� 1

use K_UNIVER;

go
create PROCEDURE PSUBJECT
as
begin
	select SUBJECT '���',SUBJECT_NAME '����������', PULPIT '�������' from SUBJECT;
	declare @q int = (select count(*) from SUBJECT);
	return @q;
end;

DROP PROCEDURE PSUBJECT;

declare @result int = 0, @r int = 0
EXEC @result = PSUBJECT @p='����',@c = @r output;
print '���������� ���������:' + cast(@result as varchar(5));
print '���������� �������� ������� ����:' + cast(@r as varchar(5));
end

--							������� 3

use K_UNIVER;
go
create PROCEDURE PSUBJECT_3 @find_sub varchar(20)
as
begin
	select [SUBJECT] '���',SUBJECT_NAME '����������', PULPIT '�������' from [SUBJECT] where PULPIT= @find_sub;
	print '���������: @p=' +@find_sub;
	declare @k int = (select count(*) from SUBJECT);
	return @k ;
end;

CREATE TABLE #SUBJECTS
(���		char(10)		not null,
����������	varchar(100)			,
�������		char(20)		not null
);

INSERT #SUBJECTS exec PSUBJECT_3 @find_sub = '����';

SELECT * FROM #SUBJECTS;

DROP PROCEDURE PSUBJECT_3;
DROP TABLE #SUBJECTS;
end

--							������� 4

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
		print '��� ������: ' + cast(ERROR_NUMBER() as varchar(6));
		print '��������� �� ������: ' + ERROR_MESSAGE();
		print '������ ������: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print '��� ��������� ������: ' + ERROR_PROCEDURE();
		print '������� ����������� ������: ' + cast(ERROR_SEVERITY()as varchar(6));
		print '����� ������: ' + cast(ERROR_STATE()as varchar(8));
		return -1;
	end catch;

DECLARE @paud int = 0;
EXEC @paud = PAUDITORIUM_INSERT @a='423-1',@n='423-1',@c='90',@t='��-�';
DELETE AUDITORIUM where AUDITORIUM_NAME='423-1';

DROP PROCEDURE PAUDITORIUM_INSERT;

--							������� 5

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
			raiserror('������',11,1);
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
			print '���������� ������� ' + @p;
			print @subjects;
			close Sub_Rep;
			return @ret;
	end try

	begin catch
		print '������ � ����������.'
		if ERROR_PROCEDURE() is not null
			print '��� ���������:' + error_procedure();
		return @ret;
	end catch;

DECLARE @res_rep int;
exec @res_rep = SUBJECT_REPORT @p = '����';
print '���������� ���������: ' + cast(@res_rep as varchar(3));

DROP PROCEDURE SUBJECT_REPORT;
		


--							������� 6

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
				EXEC PAUDITORIUM_INSERT @a='423-1',@n='423-1',@c='90',@t='��-�';
			commit tran;
			return  @ret;
	end try

	begin catch
		print '��� ������: ' + cast(ERROR_NUMBER() as varchar(6));
		print '��������� �� ������: ' + ERROR_MESSAGE();
		print '������ ������: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print '��� ��������� ������: ' + ERROR_PROCEDURE();
		print '������� ����������� ������: ' + cast(ERROR_SEVERITY()as varchar(6));
		print '����� ������: ' + cast(ERROR_STATE()as varchar(8));
		if @@TRANCOUNT > 0 rollback tran;
		return -1;
	end catch;

DECLARE @paud int = 0;
EXEC @paud = PAUDITORIUM_INSERTX @a='423-1',@n='423-1',@c='90',@t='��-�', @tn ='������������ �����';
DELETE AUDITORIUM where AUDITORIUM_NAME='423-1';

DROP PROCEDURE PAUDITORIUM_INSERTX;