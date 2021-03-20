USE [K_UNIVER]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 19.03.2021 14:27:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20), @c int output
as
begin
	select SUBJECT 'Код',SUBJECT_NAME 'Дисциплина', PULPIT 'Кафедра' from SUBJECT where PULPIT= @p;
	set @c  = @@ROWCOUNT;
	print 'параметры: @p=' + @p + ',@c =' + cast(@c as varchar(3));
	declare @k int = (select count(*) from SUBJECT);
	return @k ;
end;