use master;

go
create table WEATHER 
(
	City varchar(50),
	start_dat smalldatetime,
	end_dat smalldatetime,
	Temperature float
)

go 
create trigger TR_WEATHER 
	on WEATHER for INSERT, UPDATE
	as declare @a1 varchar(50), @a2 smalldatetime, @a3 smalldatetime, @a4 float, @count int, @in varchar(300)
	begin
	  set @a1 = (select City from INSERTED);
      set @a2= (select start_dat from INSERTED);
      set @a3= (select end_dat from INSERTED);
	  set @a4 = (select Temperature from INSERTED);
	  set @in = 'Неверная запись: '+ @a1 + ' '+ cast(@a2 as varchar(20)) +' '+ cast(@a3 as varchar(20))+ ' ' +cast(@a4 as varchar(20));
	  set @count = (select count(*) from WEATHER as W where W.City = @a1 and (W.start_dat >= @a2 or W.end_dat <= @a3)) 
	  if @count > 1
		begin
			raiserror(@in, 11, 1);  
			rollback;
		end
	end
	return

go
insert into WEATHER values ('Минск','01-01-2017 00:00','01-01-2017 23:59', -6);
insert into WEATHER values ('Минск','01-01-2017 00:00','01-01-2017 23:58', -2);

select * from WEATHER;
delete from WEATHER;

drop table WEATHER;
drop trigger TR_WEATHER;