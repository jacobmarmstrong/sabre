USE [master]
GO
/****** Object:  Database [SABRE]    Script Date: 11/5/2018 12:24:38 AM ******/
CREATE DATABASE [SABRE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SABRE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\SABRE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SABRE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\SABRE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SABRE] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SABRE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SABRE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SABRE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SABRE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SABRE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SABRE] SET ARITHABORT OFF 
GO
ALTER DATABASE [SABRE] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SABRE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SABRE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SABRE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SABRE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SABRE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SABRE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SABRE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SABRE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SABRE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SABRE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SABRE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SABRE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SABRE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SABRE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SABRE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SABRE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SABRE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SABRE] SET  MULTI_USER 
GO
ALTER DATABASE [SABRE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SABRE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SABRE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SABRE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SABRE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SABRE] SET QUERY_STORE = OFF
GO
USE [SABRE]
GO
/****** Object:  Table [dbo].[Flights]    Script Date: 11/5/2018 12:24:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flights](
	[flightID] [bigint] IDENTITY(1,1) NOT NULL,
	[airline] [varchar](2) NOT NULL,
	[flightNum] [int] NOT NULL,
	[deptCity] [varchar](3) NOT NULL,
	[arrivalCity] [varchar](3) NOT NULL,
	[deptDate] [datetime] NOT NULL,
	[arrivalDate] [datetime] NOT NULL,
	[status] [int] NOT NULL,
	[deptGate] [varchar](5) NULL,
	[equipment] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[flightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Passengers]    Script Date: 11/5/2018 12:24:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passengers](
	[passengerID] [bigint] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](50) NOT NULL,
	[lastName] [varchar](50) NOT NULL,
	[pnrID] [varchar](6) NULL,
	[primaryPassenger] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[passengerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PNR]    Script Date: 11/5/2018 12:24:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNR](
	[pnrID] [varchar](6) NOT NULL,
	[dateCreated] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pnrID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Priority]    Script Date: 11/5/2018 12:24:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Priority](
	[priorityID] [bigint] IDENTITY(1,1) NOT NULL,
	[abbreviation] [varchar](5) NULL,
	[summaryAbbreviation] [varchar](2) NOT NULL,
	[NRSA] [bit] NOT NULL,
	[description] [varchar](100) NULL,
	[through] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[priorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seats]    Script Date: 11/5/2018 12:24:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seats](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[seat] [varchar](4) NOT NULL,
	[emergencyExit] [bit] NOT NULL,
	[class] [varchar](1) NOT NULL,
	[equipment] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempPassengers]    Script Date: 11/5/2018 12:24:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempPassengers](
	[tempPassengerID] [bigint] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](50) NOT NULL,
	[lastName] [varchar](50) NOT NULL,
	[tempPNRID] [varchar](6) NOT NULL,
	[primaryPassenger] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tempPassengerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempPNR]    Script Date: 11/5/2018 12:24:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempPNR](
	[tempPNRID] [varchar](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tempPNRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempTickets]    Script Date: 11/5/2018 12:24:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempTickets](
	[tempTicketID] [bigint] IDENTITY(1,1) NOT NULL,
	[tempPassengerID] [bigint] NOT NULL,
	[flightID] [bigint] NOT NULL,
	[status] [int] NOT NULL,
	[seat] [varchar](4) NULL,
	[priorityID] [bigint] NOT NULL,
	[class] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tempTicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 11/5/2018 12:24:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[ticketID] [bigint] IDENTITY(183284,24) NOT NULL,
	[passengerID] [bigint] NOT NULL,
	[flightID] [bigint] NOT NULL,
	[status] [int] NOT NULL,
	[seat] [varchar](4) NULL,
	[comments] [varchar](1000) NULL,
	[priorityID] [bigint] NOT NULL,
	[class] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ticketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/5/2018 12:24:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userID] [bigint] IDENTITY(10001,1) NOT NULL,
	[firstName] [varchar](50) NOT NULL,
	[lastName] [varchar](50) NOT NULL,
	[dutyCode] [varchar](1) NOT NULL,
	[active] [bit] NULL,
	[password] [varchar](50) NOT NULL,
	[pseudoLocation] [varchar](4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Flights] ON 

INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (1, N'AA', 1090, N'TUL', N'DFW', CAST(N'2018-10-31T06:42:00.000' AS DateTime), CAST(N'2018-10-31T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (2, N'F9', 382, N'TUL', N'DFW', CAST(N'2018-11-01T06:42:00.000' AS DateTime), CAST(N'2018-10-20T07:35:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (3, N'AA', 1091, N'DFW', N'LAX', CAST(N'2018-11-02T06:42:00.000' AS DateTime), CAST(N'2018-10-21T09:42:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (4, N'AA', 1092, N'TUL', N'DFW', CAST(N'2018-11-03T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (5, N'AA', 1093, N'TUL', N'DFW', CAST(N'2018-11-04T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (6, N'AA', 1094, N'TUL', N'DFW', CAST(N'2018-11-05T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (7, N'AA', 1095, N'TUL', N'DFW', CAST(N'2018-11-06T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (8, N'AA', 1096, N'TUL', N'DFW', CAST(N'2018-11-07T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (9, N'AA', 1097, N'TUL', N'DFW', CAST(N'2018-11-08T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (10, N'AA', 1098, N'TUL', N'DFW', CAST(N'2018-11-06T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (11, N'AA', 1099, N'TUL', N'DFW', CAST(N'2018-11-10T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (12, N'AA', 1100, N'TUL', N'DFW', CAST(N'2018-11-11T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (13, N'AA', 1101, N'TUL', N'DFW', CAST(N'2018-11-12T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
INSERT [dbo].[Flights] ([flightID], [airline], [flightNum], [deptCity], [arrivalCity], [deptDate], [arrivalDate], [status], [deptGate], [equipment]) VALUES (14, N'AA', 1102, N'TUL', N'DFW', CAST(N'2018-11-13T06:42:00.000' AS DateTime), CAST(N'2018-10-20T08:04:00.000' AS DateTime), 0, NULL, N'B737')
SET IDENTITY_INSERT [dbo].[Flights] OFF
SET IDENTITY_INSERT [dbo].[Passengers] ON 

INSERT [dbo].[Passengers] ([passengerID], [firstName], [lastName], [pnrID], [primaryPassenger]) VALUES (1, N'INA', N'GARTEN', N'ABCDEF', 1)
INSERT [dbo].[Passengers] ([passengerID], [firstName], [lastName], [pnrID], [primaryPassenger]) VALUES (2, N'MICHAEL', N'GARTEN', N'ABCDEF', 0)
INSERT [dbo].[Passengers] ([passengerID], [firstName], [lastName], [pnrID], [primaryPassenger]) VALUES (3, N'RACHEL', N'RAY', N'ABCDEF', 0)
INSERT [dbo].[Passengers] ([passengerID], [firstName], [lastName], [pnrID], [primaryPassenger]) VALUES (4, N'INA', N'GARTEN', N'AAAAAA', 1)
SET IDENTITY_INSERT [dbo].[Passengers] OFF
INSERT [dbo].[PNR] ([pnrID], [dateCreated]) VALUES (N'AAAAAA', CAST(N'2018-10-22T22:57:57.523' AS DateTime))
INSERT [dbo].[PNR] ([pnrID], [dateCreated]) VALUES (N'ABCDEF', CAST(N'2018-10-20T16:33:57.393' AS DateTime))
SET IDENTITY_INSERT [dbo].[Priority] ON 

INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (1, N'CTT', N'HK', 0, N'Confirmed/Ticketed', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (2, N'CT', N'HK', 0, N'Confirmed/Ticketed', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (3, N'OS1T', N'HK', 0, N'Oversale Economy (Concierge Key) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (4, N'OS1', N'HK', 0, N'Oversale Economy (Concierge Key)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (5, N'OS2T', N'HK', 0, N'Oversale Economy (Executive Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (6, N'OS2', N'HK', 0, N'Oversale Economy (Executive Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (7, N'OS3T', N'HK', 0, N'Oversale Economy (Platinum Pro) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (8, N'OS3', N'HK', 0, N'Oversale Economy (Platinum Pro)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (9, N'OS4T', N'HK', 0, N'Oversale Economy (Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (10, N'OS4', N'HK', 0, N'Oversale Economy (Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (11, N'OS5T', N'HK', 0, N'Oversale Economy (Gold) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (12, N'OS5', N'HK', 0, N'Oversale Economy (Gold)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (13, N'OST', N'HK', 0, N'Oversale Economy - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (14, N'OS', N'HK', 0, N'Oversale Economy', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (15, N'RFT', N'HK', 0, N'Oversale First Class - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (16, N'RF', N'HK', 0, N'Oversale First Class', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (17, N'DSR1T', N'HK', 0, N'First Class Standby (Concierge Key) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (18, N'DSR1', N'HK', 0, N'First Class Standby (Concierge Key)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (19, N'DSR2T', N'HK', 0, N'First Class Standby (Executive Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (20, N'DSR2', N'HK', 0, N'First Class Standby (Executive Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (21, N'DSR3T', N'HK', 0, N'First Class Standby (Platinum Pro) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (22, N'DSR3', N'HK', 0, N'First Class Standby (Platinum Pro)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (23, N'DSR4T', N'HK', 0, N'First Class Standby (Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (24, N'DSR4', N'HK', 0, N'First Class Standby (Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (25, N'DSR5T', N'HK', 0, N'First Class Standby (Gold) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (26, N'DSR5', N'HK', 0, N'First Class Standby (Gold)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (27, N'DSRT', N'HK', 0, N'First Class Standby - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (28, N'DSR', N'HK', 0, N'First Class Standby', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (29, N'VIP1T', N'HK', 0, N'System Wide Upgrade (Concierge Key) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (30, N'VIP1', N'HK', 0, N'System Wide Upgrade (Concierge Key)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (31, N'VIP2T', N'HK', 0, N'System Wide Upgrade (Executive Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (32, N'VIP2', N'HK', 0, N'System Wide Upgrade (Executive Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (33, N'VIP3T', N'HK', 0, N'System Wide Upgrade (Platinum Pro) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (34, N'VIP3', N'HK', 0, N'System Wide Upgrade (Platinum Pro)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (35, N'VIP4T', N'HK', 0, N'System Wide Upgrade (Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (36, N'VIP4', N'HK', 0, N'System Wide Upgrade (Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (37, N'VIP5T', N'HK', 0, N'System Wide Upgrade (Gold) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (38, N'VIP5', N'HK', 0, N'System Wide Upgrade (Gold)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (39, N'VIPT', N'HK', 0, N'System Wide Upgrade - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (40, N'VIP', N'HK', 0, N'System Wide Upgrade', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (41, N'UPG1T', N'HK', 0, N'Sticker Upgrade (Concierge Key) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (42, N'UPG1', N'HK', 0, N'Sticker Upgrade (Concierge Key)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (43, N'UPG2T', N'HK', 0, N'Sticker Upgrade (Executive Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (44, N'UPG2', N'HK', 0, N'Sticker Upgrade (Executive Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (45, N'UPG3T', N'HK', 0, N'Sticker Upgrade (Platinum Pro) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (46, N'UPG3', N'HK', 0, N'Sticker Upgrade (Platinum Pro)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (47, N'UPG4T', N'HK', 0, N'Sticker Upgrade (Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (48, N'UPG4', N'HK', 0, N'Sticker Upgrade (Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (49, N'UPG5T', N'HK', 0, N'Sticker Upgrade (Gold) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (50, N'UPG5', N'HK', 0, N'Sticker Upgrade (Gold)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (51, N'UPGT', N'HK', 0, N'Sticker Upgrade - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (52, N'UPG', N'HK', 0, N'Sticker Upgrade', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (53, N'RI1T', N'SS', 0, N'Revenue Involuntary Standby (Concierge Key) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (54, N'RI1', N'SS', 0, N'Revenue Involuntary Standby (Concierge Key)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (55, N'RI2T', N'SS', 0, N'Revenue Involuntary Standby (Executive Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (56, N'RI2', N'SS', 0, N'Revenue Involuntary Standby (Executive Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (57, N'RI3T', N'SS', 0, N'Revenue Involuntary Standby (Platinum Pro) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (58, N'RI3', N'SS', 0, N'Revenue Involuntary Standby (Platinum Pro)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (59, N'RI4T', N'SS', 0, N'Revenue Involuntary Standby (Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (60, N'RI4', N'SS', 0, N'Revenue Involuntary Standby (Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (61, N'RI5T', N'SS', 0, N'Revenue Involuntary Standby (Gold) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (62, N'RI5', N'SS', 0, N'Revenue Involuntary Standby (Gold)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (63, N'RIT', N'SS', 0, N'Revenue Involuntary Standby - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (64, N'RI', N'SS', 0, N'Revenue Involuntary Standby', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (65, N'RV1T', N'SS', 0, N'Revenue Voluntary Standby (Concierge Key) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (66, N'RV1', N'SS', 0, N'Revenue Voluntary Standby (Concierge Key)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (67, N'RV2T', N'SS', 0, N'Revenue Voluntary Standby (Executive Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (68, N'RV2', N'SS', 0, N'Revenue Voluntary Standby (Executive Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (69, N'RV3T', N'SS', 0, N'Revenue Voluntary Standby (Platinum Pro) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (70, N'RV3', N'SS', 0, N'Revenue Voluntary Standby (Platinum Pro)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (71, N'RV4T', N'SS', 0, N'Revenue Voluntary Standby (Platinum) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (72, N'RV4', N'SS', 0, N'Revenue Voluntary Standby (Platinum)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (73, N'RV5T', N'SS', 0, N'Revenue Voluntary Standby (Gold) - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (74, N'RV5', N'SS', 0, N'Revenue Voluntary Standby (Gold)', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (75, N'RVT', N'SS', 0, N'Revenue Voluntary Standby - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (76, N'RV', N'SS', 0, N'Revenue Voluntary Standby', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (77, N'D1T', N'SS', 1, N'Non-revenue Standby, Higher Priority - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (78, N'D1', N'SS', 1, N'Non-revenue Standby, Higher Priority', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (79, N'D2T', N'SS', 1, N'Non-revenue Standby, Employee Pass - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (80, N'D2', N'SS', 1, N'Non-revenue Standby, Employee Pass', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (81, N'D3T', N'SS', 1, N'Non-revenue Standby, Buddy Pass - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (82, N'D3', N'SS', 1, N'Non-revenue Standby, Buddy Pass', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (83, N'D6UT', N'SS', 1, N'Non-revenue Standby, Unlimited Jumpseat Access - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (84, N'D6U', N'SS', 1, N'Non-revenue Standby, Unlimited Jumpseat Access', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (85, N'D6LT', N'SS', 1, N'Non-revenue Standby, Limited Jumpseat Access - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (86, N'D6L', N'SS', 1, N'Non-revenue Standby, Limited Jumpseat Access', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (87, N'DGT', N'HK', 0, N'Involuntary Downgrade of Service - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (88, N'DG', N'HK', 0, N'Involuntary Downgrade of Service', 0)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (89, N'RLT', N'SS', 0, N'"Flat Tire Rule" - Through', 1)
INSERT [dbo].[Priority] ([priorityID], [abbreviation], [summaryAbbreviation], [NRSA], [description], [through]) VALUES (90, N'RL', N'SS', 0, N'"Flat Tire Rule"', 0)
SET IDENTITY_INSERT [dbo].[Priority] OFF
SET IDENTITY_INSERT [dbo].[Seats] ON 

INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (1, N'1A', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (2, N'1C', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (3, N'1D', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (4, N'1F', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (5, N'2A', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (6, N'2C', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (7, N'2D', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (8, N'2F', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (9, N'3A', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (10, N'3C', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (11, N'3D', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (12, N'3F', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (13, N'4A', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (14, N'4C', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (15, N'4D', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (16, N'4F', 0, N'F', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (17, N'8A', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (18, N'8B', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (19, N'8C', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (20, N'8D', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (21, N'8E', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (22, N'8F', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (23, N'9A', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (24, N'9B', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (25, N'9C', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (26, N'9D', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (27, N'9E', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (28, N'9F', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (29, N'10A', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (30, N'10B', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (31, N'10C', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (32, N'10D', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (33, N'10E', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (34, N'10F', 0, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (35, N'11A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (36, N'11B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (37, N'11C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (38, N'11D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (39, N'11E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (40, N'11F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (41, N'12A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (42, N'12B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (43, N'12C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (44, N'12D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (45, N'12E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (46, N'12F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (47, N'13A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (48, N'13B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (49, N'13C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (50, N'13D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (51, N'13E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (52, N'13F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (53, N'14A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (54, N'14B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (55, N'14C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (56, N'14D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (57, N'14E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (58, N'14F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (59, N'15A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (60, N'15B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (61, N'15C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (62, N'15D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (63, N'15E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (64, N'15F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (65, N'16A', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (66, N'16B', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (67, N'16C', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (68, N'16D', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (69, N'16E', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (70, N'16F', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (71, N'17A', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (72, N'17B', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (73, N'17C', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (74, N'17D', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (75, N'17E', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (76, N'17F', 1, N'M', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (77, N'18A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (78, N'18B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (79, N'18C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (80, N'18D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (81, N'18E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (82, N'18F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (83, N'19A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (84, N'19B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (85, N'19C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (86, N'19D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (87, N'19E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (88, N'19F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (89, N'20A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (90, N'20B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (91, N'20C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (92, N'20D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (93, N'20E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (94, N'20F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (95, N'21A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (96, N'21B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (97, N'21C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (98, N'21D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (99, N'21E', 0, N'Y', N'B737')
GO
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (100, N'21F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (101, N'22A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (102, N'22B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (103, N'22C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (104, N'22D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (105, N'22E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (106, N'22F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (107, N'23A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (108, N'23B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (109, N'23C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (110, N'23D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (111, N'23E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (112, N'23F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (113, N'24A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (114, N'24B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (115, N'24C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (116, N'24D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (117, N'24E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (118, N'24F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (119, N'25A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (120, N'25B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (121, N'25C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (122, N'25D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (123, N'25E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (124, N'25F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (125, N'26A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (126, N'26B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (127, N'26C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (128, N'26D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (129, N'26E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (130, N'26F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (131, N'27A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (132, N'27B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (133, N'27C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (134, N'27D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (135, N'27E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (136, N'27F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (137, N'28A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (138, N'28B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (139, N'28C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (140, N'28D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (141, N'28E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (142, N'28F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (143, N'29A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (144, N'29B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (145, N'29C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (146, N'29D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (147, N'29E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (148, N'29F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (149, N'30A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (150, N'30B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (151, N'30C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (152, N'30D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (153, N'30E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (154, N'30F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (155, N'31A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (156, N'31B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (157, N'31C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (158, N'31D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (159, N'31E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (160, N'31F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (161, N'32A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (162, N'32B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (163, N'32C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (164, N'32D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (165, N'32E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (166, N'32F', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (167, N'33A', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (168, N'33B', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (169, N'33C', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (170, N'33D', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (171, N'33E', 0, N'Y', N'B737')
INSERT [dbo].[Seats] ([id], [seat], [emergencyExit], [class], [equipment]) VALUES (172, N'33F', 0, N'Y', N'B737')
SET IDENTITY_INSERT [dbo].[Seats] OFF
SET IDENTITY_INSERT [dbo].[Tickets] ON 

INSERT [dbo].[Tickets] ([ticketID], [passengerID], [flightID], [status], [seat], [comments], [priorityID], [class]) VALUES (183284, 1, 1, 0, N'1A', NULL, 1, N'F')
INSERT [dbo].[Tickets] ([ticketID], [passengerID], [flightID], [status], [seat], [comments], [priorityID], [class]) VALUES (183308, 2, 1, 0, N'1C', NULL, 1, N'F')
INSERT [dbo].[Tickets] ([ticketID], [passengerID], [flightID], [status], [seat], [comments], [priorityID], [class]) VALUES (183332, 3, 1, 0, N'1D', NULL, 1, N'F')
INSERT [dbo].[Tickets] ([ticketID], [passengerID], [flightID], [status], [seat], [comments], [priorityID], [class]) VALUES (183356, 1, 3, 0, NULL, NULL, 1, N'F')
INSERT [dbo].[Tickets] ([ticketID], [passengerID], [flightID], [status], [seat], [comments], [priorityID], [class]) VALUES (183380, 2, 3, 0, NULL, NULL, 1, N'F')
INSERT [dbo].[Tickets] ([ticketID], [passengerID], [flightID], [status], [seat], [comments], [priorityID], [class]) VALUES (183404, 3, 3, 0, NULL, NULL, 1, N'F')
INSERT [dbo].[Tickets] ([ticketID], [passengerID], [flightID], [status], [seat], [comments], [priorityID], [class]) VALUES (183428, 4, 1, 0, NULL, NULL, 1, N'Y')
SET IDENTITY_INSERT [dbo].[Tickets] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([userID], [firstName], [lastName], [dutyCode], [active], [password], [pseudoLocation]) VALUES (10001, N'JACOB', N'ARMSTRONG', N'*', 1, N'password', N'L234')
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Flights] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[PNR] ADD  DEFAULT (getdate()) FOR [dateCreated]
GO
ALTER TABLE [dbo].[TempTickets] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[Tickets] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[Tickets] ADD  DEFAULT ((1)) FOR [priorityID]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[Passengers]  WITH CHECK ADD FOREIGN KEY([pnrID])
REFERENCES [dbo].[PNR] ([pnrID])
GO
ALTER TABLE [dbo].[TempPassengers]  WITH CHECK ADD FOREIGN KEY([tempPNRID])
REFERENCES [dbo].[TempPNR] ([tempPNRID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TempTickets]  WITH CHECK ADD FOREIGN KEY([flightID])
REFERENCES [dbo].[Flights] ([flightID])
GO
ALTER TABLE [dbo].[TempTickets]  WITH CHECK ADD FOREIGN KEY([priorityID])
REFERENCES [dbo].[Priority] ([priorityID])
GO
ALTER TABLE [dbo].[TempTickets]  WITH CHECK ADD FOREIGN KEY([tempPassengerID])
REFERENCES [dbo].[TempPassengers] ([tempPassengerID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([flightID])
REFERENCES [dbo].[Flights] ([flightID])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([passengerID])
REFERENCES [dbo].[Passengers] ([passengerID])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([priorityID])
REFERENCES [dbo].[Priority] ([priorityID])
GO
USE [master]
GO
ALTER DATABASE [SABRE] SET  READ_WRITE 
GO
