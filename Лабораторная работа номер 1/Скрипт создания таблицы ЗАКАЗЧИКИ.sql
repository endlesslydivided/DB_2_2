USE [������� �������]
GO

/****** Object:  Table [dbo].[���������]    Script Date: 04.02.2021 20:58:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[���������](
	[������������_�����] [nvarchar](20) NOT NULL,
	[�����] [nvarchar](50) NULL,
	[���������_����] [nvarchar](15) NULL,
 CONSTRAINT [PK_���������] PRIMARY KEY CLUSTERED 
(
	[������������_�����] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


