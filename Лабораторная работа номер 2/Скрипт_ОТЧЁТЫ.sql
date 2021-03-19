USE [K_MyBase]
GO

/****** Object:  Table [dbo].[��ר��]    Script Date: 05.02.2021 14:48:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[��ר��](
	[����_������] [date] NOT NULL,
	[��������_�����������] [nvarchar](20) NULL,
	[��������_����������] [nvarchar](20) NULL,
	[��������_����������] [real] NULL,
 CONSTRAINT [PK_������] PRIMARY KEY CLUSTERED 
(
	[����_������] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[��ר��]  WITH CHECK ADD  CONSTRAINT [FK_��ר��_����������] FOREIGN KEY([��������_�����������])
REFERENCES [dbo].[����������] ([��������_����������])
GO

ALTER TABLE [dbo].[��ר��] CHECK CONSTRAINT [FK_��ר��_����������]
GO

ALTER TABLE [dbo].[��ר��]  WITH CHECK ADD  CONSTRAINT [FK_��ר��_�����������] FOREIGN KEY([��������_�����������])
REFERENCES [dbo].[�����������] ([��������_�����������])
GO

ALTER TABLE [dbo].[��ר��] CHECK CONSTRAINT [FK_��ר��_�����������]
GO


