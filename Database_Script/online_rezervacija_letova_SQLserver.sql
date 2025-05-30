USE [online_rezervacija_karata]
GO
ALTER TABLE [dbo].[Sediste] DROP CONSTRAINT [Sediste_Avion_Registracija_fk]
GO
ALTER TABLE [dbo].[Rezervisana_Sedista] DROP CONSTRAINT [Rezervisana_Sedista_Sediste_Br_Sedista_Registracija_fk]
GO
ALTER TABLE [dbo].[Rezervisana_Sedista] DROP CONSTRAINT [Rezervisana_Sedista_Rezervacija_Datum_Polaska_Br_Leta_ICAO_Kod_ID_Korisnika_fk]
GO
ALTER TABLE [dbo].[Rezervacija] DROP CONSTRAINT [Rezervacija_Korisnik_ID_Korisnika_fk]
GO
ALTER TABLE [dbo].[Rezervacija] DROP CONSTRAINT [Rezervacija_Instanca_Leta_Datum_Polaska_ICAO_Kod_Br_Leta_fk]
GO
ALTER TABLE [dbo].[Nalog] DROP CONSTRAINT [Nalog_Rezervacija_Datum_Polaska_Br_Leta_ICAO_Kod_ID_Korisnika_fk]
GO
ALTER TABLE [dbo].[Let] DROP CONSTRAINT [Let_Avio_kompanija_ICAO_Kod_fk]
GO
ALTER TABLE [dbo].[Let] DROP CONSTRAINT [Let_Aerodrom_ICAO_Kod_Aerodroma_fk_2]
GO
ALTER TABLE [dbo].[Let] DROP CONSTRAINT [Let_Aerodrom_ICAO_Kod_Aerodroma_fk]
GO
ALTER TABLE [dbo].[Instanca_Leta] DROP CONSTRAINT [Instanca_Leta_Let_ICAO_Kod_Br_Leta_fk]
GO
ALTER TABLE [dbo].[Instanca_Leta] DROP CONSTRAINT [Instanca_Leta_Avion_Registracija_fk]
GO
ALTER TABLE [dbo].[Avion] DROP CONSTRAINT [Avion_Avio_kompanija_ICAO_Kod_fk]
GO
/****** Object:  Index [Korisnik_Korisnicko_Ime_uindex]    Script Date: 29.5.2025. 14:07:19 ******/
DROP INDEX [Korisnik_Korisnicko_Ime_uindex] ON [dbo].[Korisnik]
GO
/****** Object:  Index [Korisnik_Email_uindex]    Script Date: 29.5.2025. 14:07:19 ******/
DROP INDEX [Korisnik_Email_uindex] ON [dbo].[Korisnik]
GO
/****** Object:  Table [dbo].[Sediste]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sediste]') AND type in (N'U'))
DROP TABLE [dbo].[Sediste]
GO
/****** Object:  Table [dbo].[Rezervisana_Sedista]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rezervisana_Sedista]') AND type in (N'U'))
DROP TABLE [dbo].[Rezervisana_Sedista]
GO
/****** Object:  Table [dbo].[Rezervacija]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rezervacija]') AND type in (N'U'))
DROP TABLE [dbo].[Rezervacija]
GO
/****** Object:  Table [dbo].[Promocija]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Promocija]') AND type in (N'U'))
DROP TABLE [dbo].[Promocija]
GO
/****** Object:  Table [dbo].[Nalog]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Nalog]') AND type in (N'U'))
DROP TABLE [dbo].[Nalog]
GO
/****** Object:  Table [dbo].[Let]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Let]') AND type in (N'U'))
DROP TABLE [dbo].[Let]
GO
/****** Object:  Table [dbo].[Korisnik]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Korisnik]') AND type in (N'U'))
DROP TABLE [dbo].[Korisnik]
GO
/****** Object:  Table [dbo].[Instanca_Leta]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Instanca_Leta]') AND type in (N'U'))
DROP TABLE [dbo].[Instanca_Leta]
GO
/****** Object:  Table [dbo].[Avion]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Avion]') AND type in (N'U'))
DROP TABLE [dbo].[Avion]
GO
/****** Object:  Table [dbo].[Avio_kompanija]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Avio_kompanija]') AND type in (N'U'))
DROP TABLE [dbo].[Avio_kompanija]
GO
/****** Object:  Table [dbo].[Aerodrom]    Script Date: 29.5.2025. 14:07:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Aerodrom]') AND type in (N'U'))
DROP TABLE [dbo].[Aerodrom]
GO
USE [master]
GO
/****** Object:  Database [online_rezervacija_karata]    Script Date: 29.5.2025. 14:07:19 ******/
DROP DATABASE [online_rezervacija_karata]
GO
/****** Object:  Database [online_rezervacija_karata]    Script Date: 29.5.2025. 14:07:19 ******/
CREATE DATABASE [online_rezervacija_karata]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'online_rezervacija_karata', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\online_rezervacija_karata.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'online_rezervacija_karata_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\online_rezervacija_karata_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [online_rezervacija_karata] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [online_rezervacija_karata].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [online_rezervacija_karata] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET ARITHABORT OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [online_rezervacija_karata] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [online_rezervacija_karata] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET  DISABLE_BROKER 
GO
ALTER DATABASE [online_rezervacija_karata] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [online_rezervacija_karata] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET RECOVERY FULL 
GO
ALTER DATABASE [online_rezervacija_karata] SET  MULTI_USER 
GO
ALTER DATABASE [online_rezervacija_karata] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [online_rezervacija_karata] SET DB_CHAINING OFF 
GO
ALTER DATABASE [online_rezervacija_karata] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [online_rezervacija_karata] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [online_rezervacija_karata] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [online_rezervacija_karata] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'online_rezervacija_karata', N'ON'
GO
ALTER DATABASE [online_rezervacija_karata] SET QUERY_STORE = ON
GO
ALTER DATABASE [online_rezervacija_karata] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [online_rezervacija_karata]
GO
/****** Object:  Table [dbo].[Aerodrom]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aerodrom](
	[ICAO_Kod_Aerodroma] [nvarchar](6) NOT NULL,
	[Grad] [nvarchar](60) NULL,
	[Ime] [nvarchar](120) NULL,
	[Drzava] [nvarchar](60) NULL,
 CONSTRAINT [Aerodrom_pk] PRIMARY KEY CLUSTERED 
(
	[ICAO_Kod_Aerodroma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Avio_kompanija]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Avio_kompanija](
	[ICAO_Kod] [nvarchar](6) NOT NULL,
	[Ime] [nvarchar](60) NOT NULL,
	[Drzava_Porekla] [nvarchar](40) NOT NULL,
 CONSTRAINT [Avio_kompanija_pk] PRIMARY KEY CLUSTERED 
(
	[ICAO_Kod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Avion]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Avion](
	[Registracija] [nvarchar](20) NOT NULL,
	[ICAO_Kod] [nvarchar](6) NULL,
	[Proizvodjac] [nvarchar](100) NULL,
	[Model] [nvarchar](60) NOT NULL,
 CONSTRAINT [table_name_pk] PRIMARY KEY CLUSTERED 
(
	[Registracija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instanca_Leta]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instanca_Leta](
	[Datum_Polaska] [date] NOT NULL,
	[Br_Leta] [nvarchar](20) NOT NULL,
	[ICAO_Kod] [nvarchar](6) NOT NULL,
	[Registracija] [nvarchar](20) NOT NULL,
	[Cena_Ekonomija] [float] NULL,
	[Cena_Premium_Ekonomija] [float] NULL,
	[Cena_Biznis] [float] NULL,
	[Benefiti_Ekonomija] [nvarchar](max) NULL,
	[Benefiti_Premium_Ekonomija] [nvarchar](max) NULL,
	[Benefiti_Biznis] [nvarchar](max) NULL,
 CONSTRAINT [Instanca_Leta_pk] PRIMARY KEY CLUSTERED 
(
	[Datum_Polaska] ASC,
	[ICAO_Kod] ASC,
	[Br_Leta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Korisnik]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Korisnik](
	[ID_Korisnika] [int] IDENTITY(1,1) NOT NULL,
	[Korisnicko_Ime] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](40) NOT NULL,
	[Sifra] [nvarchar](100) NOT NULL,
	[Password_Reset_Token] [nvarchar](100) NULL,
	[Ime] [nvarchar](30) NULL,
	[Prezime] [nvarchar](30) NULL,
	[Adresa] [nvarchar](100) NULL,
	[Administrator] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
	[Password_Reset_Timestamp] [datetime] NULL,
 CONSTRAINT [Korisnik_pk] PRIMARY KEY CLUSTERED 
(
	[ID_Korisnika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Let]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Let](
	[Br_Leta] [nvarchar](20) NOT NULL,
	[ICAO_Kod] [nvarchar](6) NOT NULL,
	[Polazni_Aerodrom] [nvarchar](6) NOT NULL,
	[Dolazni_Aerodrom] [nvarchar](6) NOT NULL,
	[Vreme_Polaska] [time](7) NOT NULL,
 CONSTRAINT [Let_pk] PRIMARY KEY CLUSTERED 
(
	[ICAO_Kod] ASC,
	[Br_Leta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nalog]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nalog](
	[ID_Naloga] [int] IDENTITY(1,1) NOT NULL,
	[Datum_Polaska] [date] NOT NULL,
	[ICAO_Kod] [nvarchar](6) NOT NULL,
	[Br_Leta] [nvarchar](20) NOT NULL,
	[ID_Korisnika] [int] NOT NULL,
	[Iznos] [float] NOT NULL,
 CONSTRAINT [Nalog_pk] PRIMARY KEY CLUSTERED 
(
	[ID_Naloga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promocija]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promocija](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Destinacija] [nvarchar](40) NOT NULL,
	[Tekst] [varchar](max) NOT NULL,
	[Aktivan_Slot] [int] NULL,
 CONSTRAINT [Promocija_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rezervacija]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rezervacija](
	[Datum_Polaska] [date] NOT NULL,
	[Br_Leta] [nvarchar](20) NOT NULL,
	[ICAO_Kod] [nvarchar](6) NOT NULL,
	[ID_Korisnika] [int] NOT NULL,
	[Br_Karata] [int] NOT NULL,
	[Klasa] [nvarchar](40) NOT NULL,
	[Ime] [nvarchar](40) NOT NULL,
	[Prezime] [nvarchar](40) NOT NULL,
	[Otkazana] [tinyint] NULL,
	[Adresa] [nvarchar](100) NOT NULL,
 CONSTRAINT [Rezervacija_pk] PRIMARY KEY CLUSTERED 
(
	[Datum_Polaska] ASC,
	[Br_Leta] ASC,
	[ICAO_Kod] ASC,
	[ID_Korisnika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rezervisana_Sedista]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rezervisana_Sedista](
	[Datum_Polaska] [date] NOT NULL,
	[Br_Leta] [nvarchar](20) NOT NULL,
	[ICAO_Kod] [nvarchar](6) NOT NULL,
	[ID_Korisnika] [int] NOT NULL,
	[Br_Sedista] [nvarchar](4) NOT NULL,
	[Registracija] [nvarchar](20) NOT NULL,
 CONSTRAINT [Rezervisana_Sedista_pk] PRIMARY KEY CLUSTERED 
(
	[Datum_Polaska] ASC,
	[Br_Leta] ASC,
	[ICAO_Kod] ASC,
	[ID_Korisnika] ASC,
	[Br_Sedista] ASC,
	[Registracija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sediste]    Script Date: 29.5.2025. 14:07:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sediste](
	[Br_Sedista] [nvarchar](4) NOT NULL,
	[Registracija] [nvarchar](20) NOT NULL,
	[Klasa] [nvarchar](30) NOT NULL,
	[Doplata] [float] NULL,
 CONSTRAINT [Sediste_pk] PRIMARY KEY CLUSTERED 
(
	[Br_Sedista] ASC,
	[Registracija] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma], [Grad], [Ime], [Drzava]) VALUES (N'EGGW', N'London', N'London Luton Airport', N'Velika Britanija')
INSERT [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma], [Grad], [Ime], [Drzava]) VALUES (N'EGLL', N'London', N'London Heathrow Airport', N'Velika Britanija')
INSERT [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma], [Grad], [Ime], [Drzava]) VALUES (N'EHAM', N'Amsterdam', N'Amsterdam Schiphol Airport', N'Holandija')
INSERT [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma], [Grad], [Ime], [Drzava]) VALUES (N'LIRF', N'Rim', N'Rome Fiumicino Airport', N'Italija')
INSERT [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma], [Grad], [Ime], [Drzava]) VALUES (N'LTFJ ', N'Istanbul', N'Istanbul Sabiha Gokcen International Airport', N'Turska')
INSERT [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma], [Grad], [Ime], [Drzava]) VALUES (N'LTFM', N'Istanbul', N'Istanbul Airport', N'Turska')
INSERT [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma], [Grad], [Ime], [Drzava]) VALUES (N'LYBE', N'Beograd', N'Belgrade Nikola Tesla Airport', N'Srbija')
INSERT [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma], [Grad], [Ime], [Drzava]) VALUES (N'ZGGG', N'Guangdžou', N'Guangzhou Baiyun International Airport', N'Kina')
GO
INSERT [dbo].[Avio_kompanija] ([ICAO_Kod], [Ime], [Drzava_Porekla]) VALUES (N'ASL', N'Air Serbia', N'Srbija')
INSERT [dbo].[Avio_kompanija] ([ICAO_Kod], [Ime], [Drzava_Porekla]) VALUES (N'CSN', N'China Southern Airlines', N'Kina')
INSERT [dbo].[Avio_kompanija] ([ICAO_Kod], [Ime], [Drzava_Porekla]) VALUES (N'KLM', N'KLM', N'Holandija')
INSERT [dbo].[Avio_kompanija] ([ICAO_Kod], [Ime], [Drzava_Porekla]) VALUES (N'PGT', N'Pegasus', N'Turska')
INSERT [dbo].[Avio_kompanija] ([ICAO_Kod], [Ime], [Drzava_Porekla]) VALUES (N'THY', N'Turkish Airlines', N'Turska')
INSERT [dbo].[Avio_kompanija] ([ICAO_Kod], [Ime], [Drzava_Porekla]) VALUES (N'WZZ', N'Wizz Air', N'Madarska')
GO
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'9H-WBT', N'WZZ', N'Airbus', N'A320')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'B-1168', N'CSN', N'Boeing', N'787-9')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'PH-NXA', N'KLM', N'Embraer', N'E195-E2')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'TC-JPH', N'THY', N'Airbus', N'A320')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'TC-JYB', N'THY', N'Boeing', N'737-900')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'TC-LPA', N'THY', N'Airbus', N'A321neo')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'TC-RBB', N'PGT', N'Airbus', N'A320neo')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'YU-APB', N'ASL', N'Airbus', N'A319')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'YU-APH', N'ASL', N'Airbus', N'A320')
INSERT [dbo].[Avion] ([Registracija], [ICAO_Kod], [Proizvodjac], [Model]) VALUES (N'YU-ARC', N'ASL', N'Airbus', N'A330-200')
GO
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-07-25' AS Date), N'JU400', N'ASL', N'YU-APB', 130, NULL, 720, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-08-17' AS Date), N'JU426', N'ASL', N'YU-APB', 191.03, NULL, 955.16, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-08-21' AS Date), N'KL1984', N'KLM', N'PH-NXA', 222, NULL, 770, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-08-30' AS Date), N'KL1984', N'KLM', N'PH-NXA', 218, NULL, 760, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-04' AS Date), N'KL1984', N'KLM', N'PH-NXA', 218, NULL, 765, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-05' AS Date), N'KL1984', N'KLM', N'PH-NXA', 223, NULL, 770, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-05' AS Date), N'W94001', N'WZZ', N'9H-WBT', 290, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-06' AS Date), N'KL1984', N'KLM', N'PH-NXA', 227.99, NULL, 756, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-06' AS Date), N'W94001', N'WZZ', N'9H-WBT', 300, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-07' AS Date), N'KL1984', N'KLM', N'PH-NXA', 222, NULL, 757, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-07' AS Date), N'W94001', N'WZZ', N'9H-WBT', 288.99, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-08' AS Date), N'KL1984', N'KLM', N'PH-NXA', 225, NULL, 758.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-08' AS Date), N'W94001', N'WZZ', N'9H-WBT', 301, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-09' AS Date), N'JU210', N'ASL', N'YU-APH', 480, NULL, 1005, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-09' AS Date), N'W94001', N'WZZ', N'9H-WBT', 295, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-10' AS Date), N'JU210', N'ASL', N'YU-APB', 478.99, NULL, 1010, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-10' AS Date), N'W94001', N'WZZ', N'9H-WBT', 297, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-11' AS Date), N'JU210', N'ASL', N'YU-APH', 490, NULL, 1010, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-11' AS Date), N'JU400', N'ASL', N'YU-APB', 135, NULL, 750, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-11' AS Date), N'W94001', N'WZZ', N'9H-WBT', 290, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-12' AS Date), N'JU210', N'ASL', N'YU-APB', 483.99, NULL, 1005, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-12' AS Date), N'JU260', N'ASL', N'YU-APH', 210, NULL, 750, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-12' AS Date), N'JU400', N'ASL', N'YU-APB', 140, NULL, 760, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-13' AS Date), N'JU210', N'ASL', N'YU-APH', 488, NULL, 998.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-13' AS Date), N'JU400', N'ASL', N'YU-APH', 137, NULL, 741, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-13' AS Date), N'TK1080', N'THY', N'TC-JYB', 223.3, NULL, 990, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-14' AS Date), N'JU210', N'ASL', N'YU-APB', 490, NULL, 1010, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-14' AS Date), N'JU260', N'ASL', N'YU-APH', 213.99, NULL, 755.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-14' AS Date), N'JU400', N'ASL', N'YU-APB', 133, NULL, 720, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-14' AS Date), N'JU404', N'ASL', N'YU-APH', 130.09, NULL, 733.33, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-14' AS Date), N'CZ668', N'CSN', N'B-1168', 779.99, 1015.99, 1450, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- 2 x 32kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-14' AS Date), N'PC374', N'PGT', N'TC-RBB', 195, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-15' AS Date), N'JU210', N'ASL', N'YU-APH', 482, NULL, 1000, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-15' AS Date), N'JU400', N'ASL', N'YU-APH', 131, NULL, 742.49, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-15' AS Date), N'JU404', N'ASL', N'YU-APB', 129.9, NULL, 740, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-15' AS Date), N'KL1982', N'KLM', N'PH-NXA', 220, NULL, 770, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-15' AS Date), N'PC374', N'PGT', N'TC-RBB', 188, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-15' AS Date), N'TK1080', N'THY', N'TC-JPH', 219, NULL, 970, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-16' AS Date), N'JU260', N'ASL', N'YU-APB', 208.99, NULL, 740, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-16' AS Date), N'JU404', N'ASL', N'YU-APH', 129.9, NULL, 740, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-16' AS Date), N'JU422', N'ASL', N'YU-APH', 197, NULL, 930, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-16' AS Date), N'KL1982', N'KLM', N'PH-NXA', 216.99, NULL, 777.77, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-16' AS Date), N'PC374', N'PGT', N'TC-RBB', 190.9, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-16' AS Date), N'TK1080', N'THY', N'TC-LPA', 222, NULL, 993, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-17' AS Date), N'JU404', N'ASL', N'YU-APB', 129.9, NULL, 740, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-17' AS Date), N'JU422', N'ASL', N'YU-APH', 194, NULL, 935, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-17' AS Date), N'CZ668', N'CSN', N'B-1168', 790, 1010, 1460, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- 2 x 32kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-17' AS Date), N'KL1982', N'KLM', N'PH-NXA', 219, NULL, 760, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-17' AS Date), N'PC374', N'PGT', N'TC-RBB', 193, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-17' AS Date), N'TK1080', N'THY', N'TC-LPA', 227, NULL, 1010, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-18' AS Date), N'JU260', N'ASL', N'YU-APB', 212, NULL, 760, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-18' AS Date), N'JU404', N'ASL', N'YU-APH', 129.9, NULL, 740, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-18' AS Date), N'JU422', N'ASL', N'YU-APB', 192, NULL, 952, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-18' AS Date), N'KL1982', N'KLM', N'PH-NXA', 230, NULL, 755, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-18' AS Date), N'PC374', N'PGT', N'TC-RBB', 192.2, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-18' AS Date), N'TK1080', N'THY', N'TC-JYB', 229, NULL, 997.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-19' AS Date), N'JU404', N'ASL', N'YU-APB', 129.9, NULL, 740, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-19' AS Date), N'JU422', N'ASL', N'YU-APH', 196, NULL, 943, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-19' AS Date), N'JU988', N'ASL', N'YU-ARC', 790, NULL, 1420, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-19' AS Date), N'KL1982', N'KLM', N'PH-NXA', 222.4, NULL, 740, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-19' AS Date), N'PC374', N'PGT', N'TC-RBB', 189.99, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-19' AS Date), N'TK1080', N'THY', N'TC-LPA', 219.99, NULL, 995.55, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-19' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 107, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'JU260', N'ASL', N'YU-APH', 209.59, NULL, 770, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'JU404', N'ASL', N'YU-APB', 129.9, NULL, 740, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'JU422', N'ASL', N'YU-APB', 200.99, NULL, 944.59, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'CZ668', N'CSN', N'B-1168', 785, 1012, 1455, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- 2 x 32kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'KL1982', N'KLM', N'PH-NXA', 221, NULL, 730, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'TK1080', N'THY', N'TC-JYB', 220, NULL, 990.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'TK1082', N'THY', N'TC-JYB', 222, NULL, 980, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'TK1084', N'THY', N'TC-LPA', 220, NULL, 970, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-20' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 110, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-21' AS Date), N'JU422', N'ASL', N'YU-APB', 195, NULL, 930, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-21' AS Date), N'JU426', N'ASL', N'YU-APB', 190, NULL, 950, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-21' AS Date), N'KL1982', N'KLM', N'PH-NXA', 225, NULL, 745, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-21' AS Date), N'PC374', N'PGT', N'TC-RBB', 195, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-21' AS Date), N'TK1080', N'THY', N'TC-JPH', 225.99, NULL, 990, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-21' AS Date), N'TK1084', N'THY', N'TC-LPA', 222, NULL, 995, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-22' AS Date), N'JU260', N'ASL', N'YU-APB', 213, NULL, 755, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-22' AS Date), N'JU422', N'ASL', N'YU-APH', 194.5, NULL, 940, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-22' AS Date), N'JU426', N'ASL', N'YU-APH', 192, NULL, 970, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-22' AS Date), N'JU988', N'ASL', N'YU-ARC', 796, NULL, 1430, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-22' AS Date), N'TK1082', N'THY', N'TC-JPH', 224, NULL, 1000, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-22' AS Date), N'TK1084', N'THY', N'TC-JPH', 225, NULL, 1010, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-22' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 110, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-23' AS Date), N'JU426', N'ASL', N'YU-APB', 188.99, NULL, 960.78, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-23' AS Date), N'CZ668', N'CSN', N'B-1168', 794, 1013, 1453.99, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- 2 x 32kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-23' AS Date), N'PC374', N'PGT', N'TC-RBB', 194, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-23' AS Date), N'TK1084', N'THY', N'TC-JYB', 217.59, NULL, 997, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-24' AS Date), N'JU260', N'ASL', N'YU-APH', 215, NULL, 749.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-24' AS Date), N'JU426', N'ASL', N'YU-APB', 199.99, NULL, 960.39, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-24' AS Date), N'TK1080', N'THY', N'TC-JPH', 230, NULL, 1000, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-24' AS Date), N'TK1082', N'THY', N'TC-LPA', 225, NULL, 990.5, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-24' AS Date), N'TK1084', N'THY', N'TC-LPA', 215.99, NULL, 995, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-24' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 108.99, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-25' AS Date), N'JU422', N'ASL', N'YU-APH', 197, NULL, 941, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-25' AS Date), N'JU426', N'ASL', N'YU-APH', 200, NULL, 944.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-25' AS Date), N'JU988', N'ASL', N'YU-ARC', 785, NULL, 1442.99, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-25' AS Date), N'TK1084', N'THY', N'TC-JPH', 227, NULL, 1000, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-26' AS Date), N'JU426', N'ASL', N'YU-APB', 194.95, NULL, 955, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
GO
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-26' AS Date), N'CZ668', N'CSN', N'B-1168', 800, 1022, 1449, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- 2 x 32kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-26' AS Date), N'TK1082', N'THY', N'TC-JPH', 220, NULL, 999.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-26' AS Date), N'TK1084', N'THY', N'TC-JYB', 221.55, NULL, 980, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-26' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 106, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-27' AS Date), N'JU426', N'ASL', N'YU-APH', 193.79, NULL, 977.77, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-28' AS Date), N'JU988', N'ASL', N'YU-ARC', 799, NULL, 1400, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-28' AS Date), N'TK1082', N'THY', N'TC-JPH', 227.99, NULL, 996.55, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-28' AS Date), N'TK1084', N'THY', N'TC-JPH', 222, NULL, 1007.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-09-28' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 112, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-01' AS Date), N'CZ668', N'CSN', N'B-1168', 793.99, 1009.49, 1460, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- 2 x 32kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-01' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 111, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-02' AS Date), N'JU988', N'ASL', N'YU-ARC', 791, NULL, 1415, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-02' AS Date), N'TK1082', N'THY', N'TC-JPH', 226, NULL, 991.55, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-03' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 110, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-04' AS Date), N'CZ668', N'CSN', N'B-1168', 797.49, 1015, 1455, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- 2 x 32kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-04' AS Date), N'TK1082', N'THY', N'TC-JYB', 230, NULL, 997.99, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-05' AS Date), N'JU988', N'ASL', N'YU-ARC', 783, NULL, 1417, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-06' AS Date), N'TK1082', N'THY', N'TC-JYB', 227.99, NULL, 999, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-08' AS Date), N'TK1082', N'THY', N'TC-JYB', 221.99, NULL, 980, N'- Prijava za let na aerodromu\r\n- Rucni prtljag\r\n- Grickalice\r\n- Prijava za let putem interneta', N'', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg\r\n- Rucni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Prioritetna prijava za let\r\n- Refundacija\r\n- Prijava za let putem interneta ')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2025-10-09' AS Date), N'W64031', N'WZZ', N'9H-WBT ', 114, NULL, NULL, N'- 1 licni predmet\r\n- Staje ispod sedišta ispred vas', N'', N'')
INSERT [dbo].[Instanca_Leta] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [Registracija], [Cena_Ekonomija], [Cena_Premium_Ekonomija], [Cena_Biznis], [Benefiti_Ekonomija], [Benefiti_Premium_Ekonomija], [Benefiti_Biznis]) VALUES (CAST(N'2026-09-16' AS Date), N'JU988', N'ASL', N'YU-ARC', 780, NULL, 1400, N'- Prijava za let na aerodromu\r\n- 1 x 23kg\r\n- Ručni prtljag\r\n- Obrok\r\n- Milje\r\n- Prijava za let putem interneta\r\n', N' ', N'- Prijava za let na aerodromu\r\n- Prioritetni prolaz na pasoškoj kontroli\r\n- 2 x 32kg *\r\n- Ručni prtljag\r\n- Pristup salonu\r\n- Obrok\r\n- Milje\r\n- Prioritetni prtljag\r\n- Prioritetno ukrcavanje\r\n- Rezervacija sedišta unapred\r\n- Prijava za let putem interneta\r\n')
GO
SET IDENTITY_INSERT [dbo].[Korisnik] ON 

INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (1, N'AleksaK', N'aleksa56522@its.edu.rs', N'945420DE3C2E227BAFB4C43EFFA96F7D', N'4E77E86C654D8B636760E4F27C12BA2C', N'Aleksa', N'Karamarkovic', N'Adresa 123', 0, NULL, CAST(N'2025-03-29T14:12:05.510' AS DateTime))
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (2, N'KorisnikNovi', N'NoviKorisnik@gmail.com', N'1B5086D35F90DF42547926B257C9110E', NULL, N'Novi', N'Korisnik', N'Nova Adresa 31', 0, NULL, NULL)
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (3, N'PeraPeric', N'Pera@gmail.com', N'A574B8A46E52199C13F74C1F2634E0B7', NULL, N'Pera', N'Peric', N'Perina Kuca', 0, NULL, NULL)
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (4, N'Mikic_Mika', N'mikinemail@yahoo.com', N'0A91EC7E30A4631FAA6EAEF865F4B5D3', NULL, N'Mika', N'Mikic', N'Mikin penthaus 123', 0, NULL, NULL)
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (5, N'Ana_Anic', N'anaanic@gmail.com', N'C1E400C8E38FD4275DDE59F5661030E7', NULL, N'Ana', N'Anic', N'PrimerAdrese 123', 0, NULL, NULL)
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (6, N'Administrator1', N'admin@onlinerezervacijaletova.com', N'DDD3D46DBA5F3A98AC938BE79EA569D8', NULL, N'Administrator', N'Administratorovic', N'Admin Adresa 123', 1, NULL, NULL)
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (10, N'UgaseniNalog', N'ugasennalog@gmail.com', N'EB2E4486E845244F11CB44B0DBDBDB7F', NULL, N'Ugasen', N'Nalog', N'Ugasena Adresa 123', 0, 1, NULL)
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (13, N'AdminomDodeljenNalog', N'dodeljenemail@yahoo.com', N'C8B20865C1767287F30F5E0E0F7BFEC5', NULL, N'Adminom', N'Dodeljen', N'Nalog 123', 0, NULL, NULL)
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (14, N'Administrator2', N'admin2@onlinerezervacijaletova.com', N'7F86A6EB8A8C5C0E5D3E635B02E5EB62', NULL, N'Admin2', N'Admin2', N'Admin2', 1, NULL, NULL)
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (16, N'PrimerKorisnik', N'primer@gmail.com', N'0A5CB4B5FCA7C63A257E99C91D82F781', N'A05006A02029C3886E8CF9231BA513B2', N'Primer', N'Korisnik', N'Primer Adresa 123', 0, 1, CAST(N'2025-01-26T17:36:51.707' AS DateTime))
INSERT [dbo].[Korisnik] ([ID_Korisnika], [Korisnicko_Ime], [Email], [Sifra], [Password_Reset_Token], [Ime], [Prezime], [Adresa], [Administrator], [Is_Deleted], [Password_Reset_Timestamp]) VALUES (17, N'Administrator3', N'admin3@gmail.com', N'0A5CB4B5FCA7C63A257E99C91D82F781', NULL, N'Admin', N'Admin', N'Admin adresa', 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Korisnik] OFF
GO
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'JU210', N'ASL', N'LYBE', N'EGLL', CAST(N'12:20:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'JU260', N'ASL', N'LYBE', N'EHAM', CAST(N'09:15:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'JU400', N'ASL', N'LYBE', N'LIRF', CAST(N'08:15:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'JU404', N'ASL', N'LYBE', N'LIRF', CAST(N'19:35:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'JU422', N'ASL', N'LYBE', N'LTFM', CAST(N'16:05:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'JU426', N'ASL', N'LYBE', N'LTFM', CAST(N'04:25:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'JU988', N'ASL', N'LYBE', N'ZGGG', CAST(N'18:55:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'CZ668', N'CSN', N'LYBE', N'ZGGG', CAST(N'05:00:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'KL1982', N'KLM', N'LYBE', N'EHAM', CAST(N'08:35:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'KL1984', N'KLM', N'LYBE', N'EHAM', CAST(N'15:15:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'PC374', N'PGT', N'LYBE', N'LTFJ ', CAST(N'15:00:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'TK1080', N'THY', N'LYBE', N'LTFM', CAST(N'19:05:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'TK1082', N'THY', N'LYBE', N'LTFM', CAST(N'12:50:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'TK1084', N'THY', N'LYBE', N'LTFM', CAST(N'00:05:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'W64031', N'WZZ', N'LYBE', N'LIRF', CAST(N'18:00:00' AS Time))
INSERT [dbo].[Let] ([Br_Leta], [ICAO_Kod], [Polazni_Aerodrom], [Dolazni_Aerodrom], [Vreme_Polaska]) VALUES (N'W94001', N'WZZ', N'LYBE', N'EGGW', CAST(N'01:35:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[Nalog] ON 

INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (1, CAST(N'2025-09-15' AS Date), N'ASL', N'JU400', 1, 276)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (2, CAST(N'2025-09-20' AS Date), N'WZZ', N'W64031', 1, 110)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (3, CAST(N'2025-09-18' AS Date), N'ASL', N'JU422', 2, 1904)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (4, CAST(N'2025-07-25' AS Date), N'ASL', N'JU400', 1, 260)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (5, CAST(N'2025-09-15' AS Date), N'ASL', N'JU400', 3, 414)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (6, CAST(N'2025-09-17' AS Date), N'THY', N'TK1080', 5, 470)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (7, CAST(N'2025-09-24' AS Date), N'WZZ', N'W64031', 5, 366.97)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (8, CAST(N'2025-09-16' AS Date), N'PGT', N'PC374', 4, 421.8)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (9, CAST(N'2025-09-14' AS Date), N'ASL', N'JU404', 2, 1466.66)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (10, CAST(N'2025-09-17' AS Date), N'THY', N'TK1080', 2, 5050)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (12, CAST(N'2025-09-15' AS Date), N'PGT', N'PC374', 1, 416)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (13, CAST(N'2025-09-21' AS Date), N'THY', N'TK1080', 2, 1782)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (14, CAST(N'2025-09-24' AS Date), N'WZZ', N'W64031', 10, 216.182)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (15, CAST(N'2025-09-17' AS Date), N'PGT', N'PC374', 10, 193)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (16, CAST(N'2025-09-24' AS Date), N'WZZ', N'W64031', 1, 216.182)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (17, CAST(N'2025-09-19' AS Date), N'ASL', N'JU422', 2, 176.4)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (18, CAST(N'2025-09-24' AS Date), N'THY', N'TK1080', 2, 900)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (19, CAST(N'2025-09-20' AS Date), N'ASL', N'JU422', 10, 375.78200000000004)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (23, CAST(N'2025-09-20' AS Date), N'THY', N'TK1080', 3, 412)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (24, CAST(N'2025-08-30' AS Date), N'KLM', N'KL1984', 1, 450)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (25, CAST(N'2025-08-21' AS Date), N'KLM', N'KL1984', 3, 220)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (29, CAST(N'2025-09-11' AS Date), N'ASL', N'JU210', 3, 497)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (30, CAST(N'2025-09-20' AS Date), N'CSN', N'CZ668', 3, 2054)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (31, CAST(N'2025-09-25' AS Date), N'ASL', N'JU988', 5, 800)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (32, CAST(N'2025-10-01' AS Date), N'CSN', N'CZ668', 5, 2048.98)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (33, CAST(N'2025-09-16' AS Date), N'KLM', N'KL1982', 5, 216.99)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (34, CAST(N'2025-09-16' AS Date), N'KLM', N'KL1982', 3, 404.58200000000005)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (35, CAST(N'2025-09-17' AS Date), N'KLM', N'KL1982', 3, 197.1)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (36, CAST(N'2025-09-08' AS Date), N'WZZ', N'W94001', 3, 622)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (37, CAST(N'2025-09-18' AS Date), N'ASL', N'JU404', 16, 273.8)
INSERT [dbo].[Nalog] ([ID_Naloga], [Datum_Polaska], [ICAO_Kod], [Br_Leta], [ID_Korisnika], [Iznos]) VALUES (38, CAST(N'2025-09-19' AS Date), N'KLM', N'KL1982', 16, 200.16)
SET IDENTITY_INSERT [dbo].[Nalog] OFF
GO
SET IDENTITY_INSERT [dbo].[Promocija] ON 

INSERT [dbo].[Promocija] ([ID], [Destinacija], [Tekst], [Aktivan_Slot]) VALUES (1, N'Rim', N'Pogledajte naše ponude letova za srce Italije.', 2)
INSERT [dbo].[Promocija] ([ID], [Destinacija], [Tekst], [Aktivan_Slot]) VALUES (2, N'Istanbul', N'Pogledajte naše ponude letova za most izmedju Evrope i Azije.', 3)
INSERT [dbo].[Promocija] ([ID], [Destinacija], [Tekst], [Aktivan_Slot]) VALUES (3, N'London', N'Pogledajte naše ponude letova za London.', NULL)
INSERT [dbo].[Promocija] ([ID], [Destinacija], [Tekst], [Aktivan_Slot]) VALUES (4, N'Amsterdam', N'Pogledajte naše ponude letova za kanale Amsterdama.', 1)
INSERT [dbo].[Promocija] ([ID], [Destinacija], [Tekst], [Aktivan_Slot]) VALUES (6, N'Guangdžo', N'Pogledajte naše ponude letova za Guangdžou', NULL)
SET IDENTITY_INSERT [dbo].[Promocija] OFF
GO
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-07-25' AS Date), N'JU400', N'ASL', 1, 2, N'Ekonomija', N'Aleksa', N'Karamarkovic', NULL, N'Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-08-21' AS Date), N'KL1984', N'KLM', 3, 1, N'Ekonomija', N'Pera', N'Peric', NULL, N'Perina Perina Kuca')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-08-30' AS Date), N'KL1984', N'KLM', 1, 2, N'Ekonomija', N'Aleksa', N'Karamarkovic', NULL, N'Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-08' AS Date), N'W94001', N'WZZ', 3, 2, N'Ekonomija', N'Pera', N'Peric', 1, N'Perina Kuca')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-11' AS Date), N'JU210', N'ASL', 3, 1, N'Ekonomija', N'Pera', N'Peric', NULL, N'Perina Kuca')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-14' AS Date), N'JU404', N'ASL', 2, 2, N'Biznis', N'Novi', N'Korisnik', NULL, N'Nova Adresa 37')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-15' AS Date), N'JU400', N'ASL', 1, 2, N'Ekonomija', N'Aleksa', N'Karamarkovic', 0, N'Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-15' AS Date), N'JU400', N'ASL', 3, 3, N'Ekonomija', N'Pera', N'Peric', 1, N'Perina Kuca')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-15' AS Date), N'PC374', N'PGT', 1, 2, N'Ekonomija', N'Aleksa', N'Karamarkovic', NULL, N'Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-16' AS Date), N'KL1982', N'KLM', 3, 2, N'Ekonomija', N'Pera', N'NijePeric', NULL, N'Perina Kuca')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-16' AS Date), N'KL1982', N'KLM', 5, 1, N'Ekonomija', N'Ana', N'Anic', 1, N'PrimerAdrese 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-16' AS Date), N'PC374', N'PGT', 4, 2, N'Ekonomija', N'Mika', N'Mikic', NULL, N'Mikin penthaus 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-17' AS Date), N'KL1982', N'KLM', 3, 1, N'Ekonomija', N'Pera', N'Peric', 1, N'Perina Kuca')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-17' AS Date), N'PC374', N'PGT', 10, 1, N'Ekonomija', N'Ugasen', N'Nalog', 1, N'Ugasena Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-17' AS Date), N'TK1080', N'THY', 2, 5, N'Biznis', N'Novi', N'Korisnik', NULL, N'Nova Adresa 37')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-17' AS Date), N'TK1080', N'THY', 5, 2, N'Ekonomija', N'Ana', N'Anic', NULL, N'PrimerAdrese 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-18' AS Date), N'JU404', N'ASL', 16, 2, N'Ekonomija', N'Primer', N'Korisnik', 1, N'Primer Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-18' AS Date), N'JU422', N'ASL', 2, 2, N'Biznis', N'Novi', N'Korisnik', 1, N'Druga Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-19' AS Date), N'JU422', N'ASL', 2, 1, N'Ekonomija', N'Novi', N'Korisnik', 1, N'Nova Adresa 37')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-19' AS Date), N'KL1982', N'KLM', 16, 1, N'Ekonomija', N'Primer', N'Korisnik', 1, N'Primer Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-20' AS Date), N'CZ668', N'CSN', 3, 2, N'Premium_Ekonomija', N'Pera', N'Peric', NULL, N'Perina Kuca')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-20' AS Date), N'JU422', N'ASL', 10, 2, N'Ekonomija', N'Ugasen', N'Nalog', 1, N'Ugasena Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-20' AS Date), N'TK1080', N'THY', 3, 2, N'Ekonomija', N'Pera', N'Peric', 1, N'Perina Kuca')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-20' AS Date), N'W64031', N'WZZ', 1, 1, N'Ekonomija', N'Aleksa', N'Karamarkovic', 1, N'Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-21' AS Date), N'TK1080', N'THY', 2, 2, N'Biznis', N'Trece', N'Lice', NULL, N'Rezervacije 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-24' AS Date), N'TK1080', N'THY', 2, 1, N'Biznis', N'Novi', N'Korisnik', 1, N'Nova Adresa 37')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-24' AS Date), N'W64031', N'WZZ', 1, 2, N'Ekonomija', N'Aleksa', N'Karamarkovic', 1, N'Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-24' AS Date), N'W64031', N'WZZ', 5, 3, N'Ekonomija', N'Anin', N'Drugar', NULL, N'PrimerAdrese 231')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-24' AS Date), N'W64031', N'WZZ', 10, 2, N'Ekonomija', N'Ugasen', N'Nalog', 1, N'Ugasena Adresa 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-09-25' AS Date), N'JU988', N'ASL', 5, 1, N'Ekonomija', N'Ana', N'Anic', NULL, N'PrimerAdrese 123')
INSERT [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Karata], [Klasa], [Ime], [Prezime], [Otkazana], [Adresa]) VALUES (CAST(N'2025-10-01' AS Date), N'CZ668', N'CSN', 5, 2, N'Premium_Ekonomija', N'Ana', N'Anic', NULL, N'PrimerAdrese 123')
GO
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-08-30' AS Date), N'KL1984', N'KLM', 1, N'A11', N'PH-NXA')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-08-30' AS Date), N'KL1984', N'KLM', 1, N'C11', N'PH-NXA')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-11' AS Date), N'JU210', N'ASL', 3, N'A15', N'YU-APH')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-14' AS Date), N'JU404', N'ASL', 2, N'D1', N'YU-APH')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-14' AS Date), N'JU404', N'ASL', 2, N'F1', N'YU-APH')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-15' AS Date), N'JU400', N'ASL', 1, N'A15', N'YU-APH')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-15' AS Date), N'JU400', N'ASL', 1, N'B15', N'YU-APH')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-15' AS Date), N'PC374', N'PGT', 1, N'A15', N'TC-RBB')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-15' AS Date), N'PC374', N'PGT', 1, N'B15', N'TC-RBB')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-16' AS Date), N'KL1982', N'KLM', 3, N'A11', N'PH-NXA')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-16' AS Date), N'KL1982', N'KLM', 3, N'C11', N'PH-NXA')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-16' AS Date), N'PC374', N'PGT', 4, N'A16', N'TC-RBB')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-16' AS Date), N'PC374', N'PGT', 4, N'B16', N'TC-RBB')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-17' AS Date), N'TK1080', N'THY', 5, N'A19', N'TC-LPA')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-17' AS Date), N'TK1080', N'THY', 5, N'B19', N'TC-LPA')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-20' AS Date), N'CZ668', N'CSN', 3, N'A26', N'B-1168')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-20' AS Date), N'CZ668', N'CSN', 3, N'C26', N'B-1168')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-24' AS Date), N'W64031', N'WZZ', 5, N'D13', N'9H-WBT')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-24' AS Date), N'W64031', N'WZZ', 5, N'E13', N'9H-WBT')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-09-25' AS Date), N'JU988', N'ASL', 5, N'H20', N'YU-ARC')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-10-01' AS Date), N'CZ668', N'CSN', 5, N'A26', N'B-1168')
INSERT [dbo].[Rezervisana_Sedista] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika], [Br_Sedista], [Registracija]) VALUES (CAST(N'2025-10-01' AS Date), N'CZ668', N'CSN', 5, N'C26', N'B-1168')
GO
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A1', N'PH-NXA', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A11', N'PH-NXA', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A15', N'PH-NXA', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A15', N'TC-RBB', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A15', N'YU-APH', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A16', N'TC-RBB', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A19', N'TC-LPA', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A2', N'TC-JYB', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A2', N'YU-ARC', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A25', N'9H-WBT ', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A26', N'B-1168', N'Premium_Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A5', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A50', N'B-1168', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A6', N'B-1168', N'Biznis', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A8', N'9H-WBT ', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A8', N'TC-JPH', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'A8', N'TC-JYB', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B15', N'TC-RBB', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B15', N'YU-APH', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B16', N'TC-RBB', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B19', N'TC-LPA', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B2', N'TC-JYB', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B25', N'9H-WBT ', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B27', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B5', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B50', N'B-1168', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B8', N'9H-WBT ', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B8', N'TC-JPH', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'B8', N'TC-JYB', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C1', N'PH-NXA', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C11', N'PH-NXA', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C15', N'PH-NXA', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C15', N'YU-APH', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C16', N'TC-RBB', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C19', N'TC-LPA', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C20', N'9H-WBT ', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C26', N'B-1168', N'Premium_Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C5', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C50', N'B-1168', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C8', N'9H-WBT ', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C8', N'TC-JPH', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'C8', N'TC-JYB', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D1', N'YU-APB', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D1', N'YU-APH', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D11', N'PH-NXA', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D13', N'9H-WBT ', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D14', N'YU-ARC', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D2', N'TC-JPH', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D2', N'YU-ARC', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D21', N'TC-JPH', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D21', N'TC-JYB', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D23', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D24', N'TC-LPA', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D3', N'TC-LPA', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D33', N'B-1168', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D34', N'TC-RBB', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D5', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'D8', N'YU-APB', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E10', N'B-1168', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E10', N'TC-LPA', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E13', N'9H-WBT ', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E14', N'YU-ARC', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E19', N'YU-APH', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E21', N'TC-JPH', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E21', N'TC-JYB', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E23', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E24', N'TC-LPA', N'Ekonomija', 20)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E28', N'B-1168', N'Premium_Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E33', N'B-1168', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E5', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E8', N'YU-APB', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'E9', N'YU-APH', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F1', N'YU-APB', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F1', N'YU-APH', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F10', N'TC-LPA', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F11', N'PH-NXA', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F14', N'YU-ARC', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F15', N'TC-JPH', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F15', N'TC-JYB', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F19', N'YU-APH', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F2', N'TC-JPH', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F20', N'9H-WBT ', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F23', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F3', N'TC-LPA', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F31', N'TC-LPA', N'Ekonomija', 8)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F4', N'9H-WBT ', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F5', N'TC-RBB', N'Ekonomija', 10)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'F8', N'YU-APB', N'Ekonomija', 7)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'G10', N'B-1168', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'G14', N'YU-ARC', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'G33', N'B-1168', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'H20', N'YU-ARC', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'K2', N'YU-ARC', N'Biznis', 0)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'K20', N'YU-ARC', N'Ekonomija', 15)
INSERT [dbo].[Sediste] ([Br_Sedista], [Registracija], [Klasa], [Doplata]) VALUES (N'K38', N'B-1168', N'Ekonomija', 15)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Korisnik_Email_uindex]    Script Date: 29.5.2025. 14:07:20 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Korisnik_Email_uindex] ON [dbo].[Korisnik]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Korisnik_Korisnicko_Ime_uindex]    Script Date: 29.5.2025. 14:07:20 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Korisnik_Korisnicko_Ime_uindex] ON [dbo].[Korisnik]
(
	[Korisnicko_Ime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Avion]  WITH CHECK ADD  CONSTRAINT [Avion_Avio_kompanija_ICAO_Kod_fk] FOREIGN KEY([ICAO_Kod])
REFERENCES [dbo].[Avio_kompanija] ([ICAO_Kod])
GO
ALTER TABLE [dbo].[Avion] CHECK CONSTRAINT [Avion_Avio_kompanija_ICAO_Kod_fk]
GO
ALTER TABLE [dbo].[Instanca_Leta]  WITH CHECK ADD  CONSTRAINT [Instanca_Leta_Avion_Registracija_fk] FOREIGN KEY([Registracija])
REFERENCES [dbo].[Avion] ([Registracija])
GO
ALTER TABLE [dbo].[Instanca_Leta] CHECK CONSTRAINT [Instanca_Leta_Avion_Registracija_fk]
GO
ALTER TABLE [dbo].[Instanca_Leta]  WITH CHECK ADD  CONSTRAINT [Instanca_Leta_Let_ICAO_Kod_Br_Leta_fk] FOREIGN KEY([ICAO_Kod], [Br_Leta])
REFERENCES [dbo].[Let] ([ICAO_Kod], [Br_Leta])
GO
ALTER TABLE [dbo].[Instanca_Leta] CHECK CONSTRAINT [Instanca_Leta_Let_ICAO_Kod_Br_Leta_fk]
GO
ALTER TABLE [dbo].[Let]  WITH CHECK ADD  CONSTRAINT [Let_Aerodrom_ICAO_Kod_Aerodroma_fk] FOREIGN KEY([Polazni_Aerodrom])
REFERENCES [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma])
GO
ALTER TABLE [dbo].[Let] CHECK CONSTRAINT [Let_Aerodrom_ICAO_Kod_Aerodroma_fk]
GO
ALTER TABLE [dbo].[Let]  WITH CHECK ADD  CONSTRAINT [Let_Aerodrom_ICAO_Kod_Aerodroma_fk_2] FOREIGN KEY([Dolazni_Aerodrom])
REFERENCES [dbo].[Aerodrom] ([ICAO_Kod_Aerodroma])
GO
ALTER TABLE [dbo].[Let] CHECK CONSTRAINT [Let_Aerodrom_ICAO_Kod_Aerodroma_fk_2]
GO
ALTER TABLE [dbo].[Let]  WITH CHECK ADD  CONSTRAINT [Let_Avio_kompanija_ICAO_Kod_fk] FOREIGN KEY([ICAO_Kod])
REFERENCES [dbo].[Avio_kompanija] ([ICAO_Kod])
GO
ALTER TABLE [dbo].[Let] CHECK CONSTRAINT [Let_Avio_kompanija_ICAO_Kod_fk]
GO
ALTER TABLE [dbo].[Nalog]  WITH CHECK ADD  CONSTRAINT [Nalog_Rezervacija_Datum_Polaska_Br_Leta_ICAO_Kod_ID_Korisnika_fk] FOREIGN KEY([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika])
REFERENCES [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Nalog] CHECK CONSTRAINT [Nalog_Rezervacija_Datum_Polaska_Br_Leta_ICAO_Kod_ID_Korisnika_fk]
GO
ALTER TABLE [dbo].[Rezervacija]  WITH CHECK ADD  CONSTRAINT [Rezervacija_Instanca_Leta_Datum_Polaska_ICAO_Kod_Br_Leta_fk] FOREIGN KEY([Datum_Polaska], [ICAO_Kod], [Br_Leta])
REFERENCES [dbo].[Instanca_Leta] ([Datum_Polaska], [ICAO_Kod], [Br_Leta])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Rezervacija] CHECK CONSTRAINT [Rezervacija_Instanca_Leta_Datum_Polaska_ICAO_Kod_Br_Leta_fk]
GO
ALTER TABLE [dbo].[Rezervacija]  WITH CHECK ADD  CONSTRAINT [Rezervacija_Korisnik_ID_Korisnika_fk] FOREIGN KEY([ID_Korisnika])
REFERENCES [dbo].[Korisnik] ([ID_Korisnika])
GO
ALTER TABLE [dbo].[Rezervacija] CHECK CONSTRAINT [Rezervacija_Korisnik_ID_Korisnika_fk]
GO
ALTER TABLE [dbo].[Rezervisana_Sedista]  WITH CHECK ADD  CONSTRAINT [Rezervisana_Sedista_Rezervacija_Datum_Polaska_Br_Leta_ICAO_Kod_ID_Korisnika_fk] FOREIGN KEY([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika])
REFERENCES [dbo].[Rezervacija] ([Datum_Polaska], [Br_Leta], [ICAO_Kod], [ID_Korisnika])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rezervisana_Sedista] CHECK CONSTRAINT [Rezervisana_Sedista_Rezervacija_Datum_Polaska_Br_Leta_ICAO_Kod_ID_Korisnika_fk]
GO
ALTER TABLE [dbo].[Rezervisana_Sedista]  WITH CHECK ADD  CONSTRAINT [Rezervisana_Sedista_Sediste_Br_Sedista_Registracija_fk] FOREIGN KEY([Br_Sedista], [Registracija])
REFERENCES [dbo].[Sediste] ([Br_Sedista], [Registracija])
GO
ALTER TABLE [dbo].[Rezervisana_Sedista] CHECK CONSTRAINT [Rezervisana_Sedista_Sediste_Br_Sedista_Registracija_fk]
GO
ALTER TABLE [dbo].[Sediste]  WITH CHECK ADD  CONSTRAINT [Sediste_Avion_Registracija_fk] FOREIGN KEY([Registracija])
REFERENCES [dbo].[Avion] ([Registracija])
GO
ALTER TABLE [dbo].[Sediste] CHECK CONSTRAINT [Sediste_Avion_Registracija_fk]
GO
USE [master]
GO
ALTER DATABASE [online_rezervacija_karata] SET  READ_WRITE 
GO
