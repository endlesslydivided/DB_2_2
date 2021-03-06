use K_UNIVER;

INSERT into FACULTY(FACULTY,FACULTY_NAME)
VALUES('????','?????????? ? ??????? ?????? ??????????????'),
('???','?????????? ???????????? ???????'),
('????','?????????? ?????????? ? ???????'),
('??','?????????-?????????????'),
('??','?????????????????'),
('????','???????????? ???? ? ??????????'),
('??','?????????????? ??????????');

INSERT into PROFESSION(PROFESSION,FACULTY,PROFESSION_NAME,QUALIFICATION)
VALUES('1-36 06 01','????','??????????????? ???????????? ? ??????? ????????? ??????????','???????-??????????????'),
('1-36 07 01','????','?????? ? ???????? ?????????? ??????????? ? ??????????? ???????????? ??????????','???????-???????'),
('1-40 01 02','??','?????????????? ??????? ? ??????????','???????-???????????-?????????????'),
('1-46 01 01','????','?????????????? ????','???????-????????'),
('1-47 01 01','????','???????????? ????','????????-????????'),
('1-48 01 02','???','?????????? ?????????? ???????????? ???????, ?????????? ? ???????','???????-?????-????????'),
('1-48 01 05','???','?????????? ?????????? ??????????? ?????????','???????-?????-????????'),
('1-54 01 03','???','??????-?????????? ?????? ? ??????? ???????? ???????? ?????????','??????? ?? ????????????'),
('1-75 01 01','??','?????? ?????????','??????? ??????? ?????????'),
('1-75 02 01','??','??????-???????? ?????????????','??????? ??????-????????? ?????????????'),
('1-89 02 02','??','?????? ? ??????????????????','?????????? ? ????? ???????');

INSERT into [GROUP](IDGROUP,FACULTY,PROFESSION,YEAR_FIRST)
VALUES
(22,'??','1-40 01 02',2011),
(23,'??','1-40 01 02',2012),
(24,'??','1-40 01 02',2011),
(27,'??','1-40 01 02',2012),
(28,'????','1-47 01 01',2012),
(29,'????','1-47 01 01',2012),
(30,'????','1-36 07 01',2012);

INSERT into PULPIT(PULPIT,PULPIT_NAME,FACULTY)
VALUES('???','???????????-???????????? ??????????','????'),
('??????','??????????, ?????????????? ?????, ??????? ? ??????','??'),
('???','?????????? ??????????????????? ???????????','????'),
('?????','?????????? ? ??????? ??????? ?? ?????????','????'),
('???','??????? ? ??????????????????','??'),
('??','?????????? ????','????'),
('??','??????????? ?????????','??'),
('???????','?????????? ?????????????? ??????? ? ????? ?????????? ??????????','????'),
('????????','?????????? ???????????????? ??????? ? ??????????? ?????????? ??????????','???'),
('???','?????????? ??????????? ?????????','???'),
('????????','?????, ?????????? ????????????????? ??????????? ? ?????????? ??????????? ???????','????'),
('????','????????????? ?????? ? ??????????','??'),
('????','?????????? ? ??????? ?????? ??????????????','????'),
('????','?????????????? ?????? ? ??????????','??');

INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
VALUES ('????','?????? ?????? ??????????',NULL,'????'),
('????','?????????? ??????? ????????',NULL,'????????'),
('????','???????? ????? ??????????',NULL,'????'),
('????','??????? ??????? ??????????',NULL,'????'),
('????','?????? ???????? ?????????????',NULL,'????'),
('???','????? ??????? ????????????',NULL,'??'),
('???','??????? ??????? ????????',NULL,'????'),
('????','?????? ????? ????????',NULL,'????'),
('???','??????? ???? ??????????',NULL,'???');

INSERT into [SUBJECT]([SUBJECT],SUBJECT_NAME,PULPIT)
VALUES('??','????????????? ?????? ? ???????????? ????????','????'),
('???','?????????????? ?????????????? ??????','????'),
('???','???????????????? ??????? ??????????','????'),
('????','????????-??????????????? ???????????????? ? ????????? ??????????????','??'),
('???','?????????? ????????????','????????'),
('????','??????? ?????????? ?????? ??????','????'),
('??','???? ??????','????'),
('???','?????????? ????????? ???????','????????'),
('??','????????????? ??????','????'),
('????','?????? ?????????????? ? ????????????????','????');

INSERT into [AUDITORIUM TYPE](AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
VALUES('??-?','?????????? ???????????'),
('??-?','???????????? ?????'),
('??-??','????. ???????????? ?????'),
('??','??????????'),
('??-?','?????????? ? ???. ??????????');

INSERT into AUDITORIUM(AUDITORIUM,AUDITORIUM_TYPE,AUDITORIUM_CAPACITY,AUDITORIUM_NAME)
VALUES('301-1','??-?',15,'301-1'),
('304-4','??-?',90,'304-4'),
('313-1','??-?',60,'313-1'),
('314-4','??',90,'314-4'),
('320-4','??',90,'320-4'),
('324-1','??-?',50,'324-1'),
('413-1','??-?',15,'413-1'),
('423-1','??-?',90,'423-1');


INSERT into STUDENT(IDGROUP,[NAME],BDAY)
VALUES
(22,'????? ?????? ??????????','12/01/1996'),
(23,'?????? ??????? ????????','19/07/1996'),
(24,'?????? ????? ??????????','22/05/1996'),
(27,'??????? ????????? ?????????????','09/04/1997'),
(24,'???????? ??????? ??????????','22/06/1998'),
(28,'???????? ????????? ?????????','23/04/1996'),
(28,'?????? ???? ??????????','24/02/1999'),
(29,'????????? ????????? ????????????','09/01/1998'),
(30,'???? ???? ????????','09/01/1999'),
(28,'????? ???? ?????????','09/04/1995'),
(30,'?????? ??????? ??????????','01/05/1996');

INSERT into PROGRESS([SUBJECT],IDSTUDENT,PDATE,NOTE)
VALUES('????',1000,'12/01/2014',4),
('????',1001,'19/01/2014',5),
('????',1002,'08/01/2014',9),
('??',1003,'11/01/2014',9),
('????',1003,'15/01/2014',8),
('??',1005,'15/01/2014',6),
('??',1006,'15/01/2014',7),
('???',1006,'15/01/2014',7);