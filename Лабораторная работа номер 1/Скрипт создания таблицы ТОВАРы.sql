USE [������� �������]
GO

/****** Object:  Table [dbo].[������]    Script Date: 04.02.2021 20:59:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[������](
	[������������] [nvarchar](20) NOT NULL,
	[����] [real] NULL,
	[����������] [int] NULL,
 CONSTRAINT [PK_������] PRIMARY KEY CLUSTERED 
(
	[������������] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


