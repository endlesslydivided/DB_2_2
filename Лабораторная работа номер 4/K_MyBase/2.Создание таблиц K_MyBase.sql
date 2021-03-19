use K_MyBase


CREATE table �����������
(
	��������_����������� nvarchar(20) NOT NULL constraint PK_����������� primary key(��������_�����������),
	����������_��������� nvarchar(50) default '???'
)ON [PRIMARY];

CREATE table ����������
(
	��������_���������� nvarchar(50) NOT NULL constraint PK_���������� primary key(��������_����������),
	��������_���������� real NOT NULL,
)ON [PRIMARY];

CREATE table ��ר��
(
	�����_������ int constraint PK_��ר�� primary key(�����_������) identity(1,1),
	����_������ nvarchar(20) NOT NULL,
	��������_����������� nvarchar(20) NOT NULL constraint FK_��ר��_����������� foreign key(��������_�����������) references �����������(��������_�����������),
	��������_���������� nvarchar(50) NOT NULL constraint FK_��ר��_���������� foreign key(��������_����������) references ����������(��������_����������),
	��������_���������� real NOT NULL
)on [FG1];

CREATE table ��������
(
	����������_���� nvarchar(50) NOT NULL constraint PK_�������� primary key(����������_����),
	��������_����������� nvarchar(20) NOT NULL constraint FK_��������_����������� foreign key(��������_�����������) references �����������(��������_�����������),
	������� nvarchar(13) NULL
)on [FG2];

