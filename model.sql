USE [learningDatabase]
GO
/****** Object:  Table [dbo].[t_Customer]    Script Date: 8/02/2019 5:27:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](40) NOT NULL,
	[City] [nvarchar](40) NULL,
	[Region] [nvarchar](40) NULL,
	[Country] [nvarchar](40) NULL,
	[Phone] [nvarchar](20) NULL,
 CONSTRAINT [PK_t_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_Order]    Script Date: 8/02/2019 5:27:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[OrderNumber] [nvarchar](10) NULL,
	[StatusCode] [nvarchar](10) NULL,
	[ShippedDate] [datetime] NOT NULL,
	[Amount] [decimal](12, 2) NOT NULL,
	[Currency] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_t_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_OrderDetails]    Script Date: 8/02/2019 5:27:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_OrderDetails](
	[OrderDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[PriceEach] [int] NOT NULL,
	[QuantityOrdered] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_t_OrderDetaile] PRIMARY KEY CLUSTERED 
(
	[OrderDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_Product]    Script Date: 8/02/2019 5:27:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductRetailerId] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductDescription] [nvarchar](100) NULL,
	[QuantityInStock] [int] NOT NULL,
	[BuyPrice] [decimal](12, 2) NOT NULL,
 CONSTRAINT [PK_t_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_Retailer]    Script Date: 8/02/2019 5:27:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Retailer](
	[RetailerId] [int] IDENTITY(1,1) NOT NULL,
	[RetailerName] [nvarchar](100) NOT NULL,
	[RetailerDescription] [nvarchar](100) NULL,
	[YearSince] [int] NOT NULL,
	[VendorRatingCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_t_Retailer] PRIMARY KEY CLUSTERED 
(
	[RetailerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_Order] ADD  CONSTRAINT [DF_t_Order_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[t_Order] ADD  CONSTRAINT [DF_t_Order_ShippedDate]  DEFAULT (getdate()) FOR [ShippedDate]
GO
ALTER TABLE [dbo].[t_Order] ADD  CONSTRAINT [DF_t_Order_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[t_Order] ADD  CONSTRAINT [DF_t_Order_Currency]  DEFAULT ('AUD') FOR [Currency]
GO
ALTER TABLE [dbo].[t_OrderDetails] ADD  CONSTRAINT [DF_t_OrderDetaile_QuantityOrdered]  DEFAULT ((1)) FOR [QuantityOrdered]
GO
ALTER TABLE [dbo].[t_Product] ADD  CONSTRAINT [DF_t_Product_QuantityInStock]  DEFAULT ((1)) FOR [QuantityInStock]
GO
ALTER TABLE [dbo].[t_Product] ADD  CONSTRAINT [DF_t_Product_BuyPrice]  DEFAULT ((0)) FOR [BuyPrice]
GO
ALTER TABLE [dbo].[t_Retailer] ADD  CONSTRAINT [DF_t_Retailer_YearSince]  DEFAULT ((1)) FOR [YearSince]
GO
ALTER TABLE [dbo].[t_Order]  WITH CHECK ADD  CONSTRAINT [FK_t_Order_t_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[t_Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[t_Order] CHECK CONSTRAINT [FK_t_Order_t_Customer]
GO
ALTER TABLE [dbo].[t_OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_t_OrderDetails_t_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[t_Order] ([OrderId])
GO
ALTER TABLE [dbo].[t_OrderDetails] CHECK CONSTRAINT [FK_t_OrderDetails_t_Order]
GO
ALTER TABLE [dbo].[t_OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_t_OrderDetails_t_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[t_Product] ([ProductId])
GO
ALTER TABLE [dbo].[t_OrderDetails] CHECK CONSTRAINT [FK_t_OrderDetails_t_Product]
GO
ALTER TABLE [dbo].[t_Product]  WITH CHECK ADD  CONSTRAINT [FK_t_Product_t_Retailer] FOREIGN KEY([ProductRetailerId])
REFERENCES [dbo].[t_Retailer] ([RetailerId])
GO
ALTER TABLE [dbo].[t_Product] CHECK CONSTRAINT [FK_t_Product_t_Retailer]
GO
