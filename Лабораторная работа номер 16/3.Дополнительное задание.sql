use K_UNIVER;

--				�������������� ������� 
select 
	rtrim(F.FACULTY) as "@���",
	(
		select COUNT(*) from PULPIT as P where P.FACULTY = F.FACULTY
	) as "����������_������",
	(
		select 
			rtrim(p.PULPIT) as "@���",
			(
				select 
					rtrim(T.TEACHER) as "�������������/@���",
					T.TEACHER_NAME as "�������������"
				from 
					TEACHER as T where T.PULPIT = p.PULPIT
				for xml path(''),type, root('�������������')
			)
		from 
			PULPIT as p where p.FACULTY = F.FACULTY 
		for xml path('�������'), type, root('�������')
	) 
from
	FACULTY as F
for xml path('���������'), type, root('�����������')
