use K_MyBase;

go
DECLARE @number varchar(100), @name varchar (11), @rek varchar (2);
DECLARE �����������_CURSOR_SCROLL CURSOR LOCAL DYNAMIC SCROLL
	for select ROW_NUMBER() over (order by ��������_�����������) �����,
	�����������.��������_�����������,�����������.����������_��������� from �����������;

OPEN �����������_CURSOR_SCROLL
FETCH �����������_CURSOR_SCROLL into @number,@name,@rek;
print '������ ��������� ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number)  +
'. �������� �����������: '  + rtrim(@name) + 
'. ���������: ' + rtrim(@rek);

FETCH LAST from �����������_CURSOR_SCROLL into @number,@name,@rek;
print '��������� ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number)  +
'. �������� �����������: '  + rtrim(@name) + 
'. ���������: ' + rtrim(@rek);

FETCH RELATIVE -1  from �����������_CURSOR_SCROLL into @number,@name,@rek;
print '������ �� ���������� ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number)  +
'. �������� �����������: '  + rtrim(@name) + 
'. ���������: ' + rtrim(@rek);

close �����������_CURSOR_SCROLL
-----------------------------------------------------------------------------------------------------------------------
go
DECLARE ��ר��_CURSOR CURSOR LOCAL STATIC for select * from ��ר�� where YEAR(��ר��.����_������) = '2020';
DECLARE @number varchar(100),@date varchar(11), @name varchar (50),@indicator_name varchar(50), @value varchar(5);

OPEN ��ר��_CURSOR;
print '������ �� 2020:';
FETCH ABSOLUTE 1 from ��ר��_CURSOR into @number,@date,@name,@indicator_name,@value;
while @@FETCH_STATUS = 0
	begin
		print  CHAR(10) +
'����� ������: '+ rtrim(@number)  +
'. ���� ������: '  + rtrim(@date) + 
'. �������� �����������: '  + rtrim(@name) + 
'. ��� ����������: ' + rtrim(@indicator_name)+ 
'. �������� ���������: '  + rtrim(@value);
	FETCH ��ר��_CURSOR into @number,@date,@name,@indicator_name,@value;
	end;
CLOSE ��ר��_CURSOR;