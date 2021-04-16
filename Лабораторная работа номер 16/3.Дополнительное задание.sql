use K_UNIVER;

--				ДОПОЛНИТЕЛЬНОЕ ЗАДАНИЕ 
select 
	rtrim(F.FACULTY) as "@код",
	(
		select COUNT(*) from PULPIT as P where P.FACULTY = F.FACULTY
	) as "количество_кафедр",
	(
		select 
			rtrim(p.PULPIT) as "@код",
			(
				select 
					rtrim(T.TEACHER) as "преподаватель/@код",
					T.TEACHER_NAME as "преподаватель"
				from 
					TEACHER as T where T.PULPIT = p.PULPIT
				for xml path(''),type, root('преподаватели')
			)
		from 
			PULPIT as p where p.FACULTY = F.FACULTY 
		for xml path('кафедра'), type, root('кафедры')
	) 
from
	FACULTY as F
for xml path('факультет'), type, root('университет')
