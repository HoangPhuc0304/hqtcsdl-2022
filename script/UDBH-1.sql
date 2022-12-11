CREATE DATABASE [DB_UDBH]
GO
USE DB_UDBH
GO

/****** Object:  Table [dbo].[Cửa hàng]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE CUA_HANG(
	[ID_CuaHang] [char](10) NOT NULL,
	[ID_HopDong] [char](10) NULL,
	[TenCuaHang] [nvarchar](50) NULL,
	[TgDoiTen] [date] NULL,
	[TgHoatDong] [nvarchar](20) NULL,
	[TinhTrangCuaHang] [nvarchar](50) NULL,
CONSTRAINT [PK_Cửa hàng] PRIMARY KEY CLUSTERED 
(
	[ID_CuaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Đối tác]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE DOI_TAC(
	[ID_DoiTac] [char](10) NOT NULL,
	[Email] [char](100) NULL,
	[TenQuan] [nvarchar](50) NULL,
	[TenNguoiDaiDien] [nvarchar](30) NULL,
	[ThanhPho] [nvarchar](20) NULL,
	[Quan] [nvarchar](20) NOT NULL,
	[SoLuongChiNhanh] [int] NULL,
	[SoLuongDonMoiNgay] [int] NULL,
	[LoaiAmThuc] [nvarchar](50) NULL,
	[DiaChiKinhDoanh] [nvarchar](100) NULL,
	[SDT] [char](10) NULL,
CONSTRAINT [PK_Đối tác] PRIMARY KEY CLUSTERED 
(
	[ID_DoiTac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Đơn hàng]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE DON_HANG(
	[ID_DonHang] [char](10) NOT NULL,
	[ID_KhachHang] [char](10) NULL,
	[ID_TaiXe] [char](10) NULL,
	[Phi] [decimal](18, 0) NULL,
	[TgGiao] [nvarchar](50) NULL,
	[TinhTrangDonHang] [nvarchar](20) NULL,
CONSTRAINT [PK_Đơn hàng] PRIMARY KEY CLUSTERED 
(
	[ID_DonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hợp đồng]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE HOP_DONG(
	[ID_HopDong] [char](10) NOT NULL,
	[ID_DoiTac] [char](10) NULL,
	[MaSoThue] [char](10) NULL,
	[TenNguoiDaiDien] [nvarchar](30) NULL,
	[SoChiNhanhDK] [int] NULL,
	[NgayDK] [date] NULL,
	[NgayHetHan] [date] NULL,
	[DiaChiCacChiNhanh] [nvarchar](100) NULL,
	[SoTK] [char](10) NULL,
	[NganHang] [nchar](15) NULL,
	[ChiNhanh] [nchar](10) NULL,
CONSTRAINT [PK_Hợp đồng] PRIMARY KEY CLUSTERED 
(
	[ID_HopDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khách hàng]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE KHACH_HANG(
	[ID_KhachHang] [char](10) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[CMND] [char](9) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[Email] [char](100) NULL,
	[SDT] [char](10) NULL,
CONSTRAINT [PK_Khách hàng] PRIMARY KEY CLUSTERED 
(
	[ID_KhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Món]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE MON(
	[ID_Mon] [char](10) NOT NULL,
	[TenMon] [nvarchar](50) NULL,
	[MieuTa] [nvarchar](100) NULL,
	[GiaBan] [decimal](18, 0) NULL,
	[TinhTrangMon] [nvarchar](20) NULL,
CONSTRAINT [PK_Món] PRIMARY KEY CLUSTERED 
(
	[ID_Mon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--/****** Object:  Table [dbo].[CTDH]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE CHI_TIET_DON_HANG(
	[ID_DonHang] [char](10) NOT NULL,
	[ID_Mon] [char](10) NOT NULL,
	[SoLuong] [int] NULL,
	[TuyChon] [nvarchar](30) NULL,
	[HinhThucThanhToan] [nvarchar](50) NULL,
	[DiaChiGiaoHang] [nvarchar](100) NULL,
CONSTRAINT [PK_Chi tiết đơn hàng] PRIMARY KEY CLUSTERED 
(
	[ID_DonHang] ASC,
	[ID_Mon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tài xế]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TAI_XE(
	[ID_TaiXe] [char](10) NOT NULL,
	[HoTen] [nvarchar](30) NULL,
	[CMND] [char](9) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[BienSoXe] [char](10) NULL,
	[KhuVucHD] [nvarchar](100) NULL,
	[Email] [char](100) NULL,
	[SDT] [char](10) NULL,
	[SoTKNganHang] [char](13) NULL,
CONSTRAINT [PK_Tài xế] PRIMARY KEY CLUSTERED 
(
	[ID_TaiXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thực đơn]    Script Date: 12/10/2022 7:18:56 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE THUC_DON(
	[ID_CuaHang] [char](10) NOT NULL,
	[ID_Mon] [char](10) NOT NULL,
CONSTRAINT [PK_Thực đơn] PRIMARY KEY CLUSTERED 
(
	[ID_CuaHang] ASC,
	[ID_Mon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE CHI_TIET_DON_HANG WITH CHECK ADD  CONSTRAINT [FK_Chi tiết đơn hàng_Món] FOREIGN KEY([ID_Mon])
REFERENCES MON ([ID_Mon])
GO
ALTER TABLE CHI_TIET_DON_HANG CHECK CONSTRAINT [FK_Chi tiết đơn hàng_Món]
GO
ALTER TABLE DON_HANG  WITH CHECK ADD  CONSTRAINT [FK_Đơn hàng_Tài xế] FOREIGN KEY([ID_TaiXe])
REFERENCES TAI_XE ([ID_TaiXe])
GO
ALTER TABLE DON_HANG CHECK CONSTRAINT [FK_Đơn hàng_Tài xế]
GO
ALTER TABLE CUA_HANG  WITH CHECK ADD  CONSTRAINT [FK_Cửa hàng_Hợp đồng] FOREIGN KEY([ID_HopDong])
REFERENCES HOP_DONG ([ID_HopDong])
GO
ALTER TABLE CUA_HANG CHECK CONSTRAINT [FK_Cửa hàng_Hợp đồng]
GO
ALTER TABLE CHI_TIET_DON_HANG  WITH CHECK ADD  CONSTRAINT [FK_Chi tiết đơn hàng_Đơn hàng] FOREIGN KEY([ID_DonHang])
REFERENCES DON_HANG ([ID_DonHang])
GO
ALTER TABLE CHI_TIET_DON_HANG CHECK CONSTRAINT [FK_Chi tiết đơn hàng_Đơn hàng]
GO
ALTER TABLE DON_HANG  WITH CHECK ADD  CONSTRAINT [FK_Đơn hàng_Khách hàng] FOREIGN KEY([ID_KhachHang])
REFERENCES KHACH_HANG ([ID_KhachHang])
GO
ALTER TABLE DON_HANG CHECK CONSTRAINT [FK_Đơn hàng_Khách hàng]
GO
ALTER TABLE HOP_DONG  WITH CHECK ADD  CONSTRAINT [FK_Hợp đồng_Đối tác] FOREIGN KEY([ID_DoiTac])
REFERENCES DOI_TAC ([ID_DoiTac])
GO
ALTER TABLE HOP_DONG CHECK CONSTRAINT [FK_Hợp đồng_Đối tác]
GO
ALTER TABLE THUC_DON  WITH CHECK ADD  CONSTRAINT [FK_Thực đơn_Cửa hàng] FOREIGN KEY([ID_CuaHang])
REFERENCES CUA_HANG ([ID_CuaHang])
GO
ALTER TABLE THUC_DON CHECK CONSTRAINT [FK_Thực đơn_Cửa hàng]
GO
ALTER TABLE THUC_DON  WITH CHECK ADD  CONSTRAINT [FK_Thực đơn_Món] FOREIGN KEY([ID_Mon])
REFERENCES MON ([ID_Mon])
GO
ALTER TABLE THUC_DON CHECK CONSTRAINT [FK_Thực đơn_Món]
GO

--drop database DB_UDBH

--Nhập data
insert into DOI_TAC
values 
('DT01', 'CongTyA@gmail.com', N'Công ty Cơm tấm A', N'Nguyễn Văn A', N'Hà Nội', N'Đống Đa', 3, 50, N'Cơm tấm', N'Số 105, Đường Nguyễn Huệ, Phường Thanh Xuân, Quận Đống Đa, Hà Nội', '0232144561'),
('DT02', 'CongTyB@gmail.com', N'Công ty Mì Chay B', N'Nguyễn Thị B', N'Đà Nẵng', N'Thanh Khê', 2, 70, N'Mì chay', N'Số 93, Đường Phạm Văn Đồng, Phường An Khê, Quận Thanh Khê, Đà Nẵng', '0912312314'),
('DT03', 'CongTyC@gmail.com', N'Công ty Trà Sữa C', N'Nguyễn Tấn C', N'TPHCM', N'Bình Thạnh', 3, 100, N'Trà sữa', N'Số 17, Đường Lê Lợi, Phường 4, Quận Bình Thạnh, TPHCM', '0812635491')
go

insert into HOP_DONG
values 
('HD01', 'DT01', 'MST01', 'Nguyễn Văn A', 1, '2022/04/10', '2024/04/10', N'Số 238, Đường Nguyễn Huệ, Phường Thanh Xuân, Quận Đống Đa, Hà Nội', '1247743985', 'Vietcombank', N'Đống Đa'),
('HD02', 'DT01', 'MST02', 'Nguyễn Văn A', 1, '2022/04/10', '2024/04/10', N'Số 147, Đường Lê Lợi, Phường Việt Hưng, Quận Long Biên, Hà Nội', '1247823156', 'Vietcombank', N'Long Biên'),
('HD03', 'DT02', 'MST03', 'Nguyễn Thị B', 1, '2022/05/13', '2024/05/13', N'Số 143, Đường Ngô Quyền, Phường An Khê, Quận Thanh Khê, Đà Nẵng', '1239123842', 'Agribank', N'Thanh Khê'),
('HD04', 'DT03', 'MST04', 'Nguyễn Tấn C', 1, '2022/07/14', '2024/07/14', N'Số 205, Đường Phan Chu Trinh, Phường 10, Quận Bình Thạnh, TPHCM', '1237374732', 'Vietcombank', N'Bình Thạnh'),
('HD05', 'DT03', 'MST05', 'Nguyễn Tấn C', 1, '2022/07/14', '2024/07/14', N'Số 56, Đường số 3, Phường 16, Quận Gò Vấp, TPHCM', '1237356434', 'Agribank', N'Gò Vấp')
go

insert into CUA_HANG
values 
('CH01', 'HD01', N'Cửa hàng cơm tấm A1', '2022/07/25', '8h00-22h00', N'Bình thường'),
('CH02', 'HD02', N'Cửa hàng cơm tấm A2', '2022/11/22', '8h00-22h00', N'Đang bận'),
('CH03', 'HD03', N'Cửa hàng mì chay B1', '2022/10/14', '8h00-22h00', N'Bình thường'),
('CH04', 'HD04', N'Cửa hàng trà sữa C1', '2022/09/23', '8h00-22h00', N'Bình thường'),
('CH05', 'HD05', N'Cửa hàng trà sữa C2', '2022/08/30', '8h00-22h00', N'Tạm nghỉ')
go

insert into MON
values 
('M001', N'Cơm sườn', N'Cơm sườn nướng', 35000, N'Tạm ngưng'),
('M002', N'Cơm gà', N'Cơm đùi gà', 35000, N'Có bán'),
('M003', N'Mì thịt bò chay', N'Mì chay', 30000, N'Có bán'),
('M004', N'Bún xào chay', N'Bún chay', 30000, N'Có bán'),
('M005', N'Trà sữa trân châu đường đen', N'Trà sữa basic', 25000, N'Có bán'),
('M006', N'Trà sữa chocolate', N'Trà sữa hương socola', 30000, N'Hết hàng hôm nay')
go

insert into KHACH_HANG
values 
('KH01', N'Huỳnh Trung T', '212924653', N'Khánh Hòa', 'HTT@gmail.com', '0932459783'),
('KH02', N'Nguyễn Thị Thanh T', '213098624', N'Bình Định', 'NTTT@gmail.com', '0935659587'),
('KH03', N'Lê Văn B', '213432445', N'TPHCM', 'LVB@gmail.com', '0934623843'),
('KH04', N'Bùi Công H', '213398665', N'Ninh Bình', 'BCH@gmail.com', '0932756499')
go

insert into TAI_XE
values 
('TX01', N'Huỳnh Trọng K', '212937445', N'Quảng Ngãi', '76D-24183', 'Hà Nội', 'HTK@gmail.com', '0914152842', '1210032312'),
('TX02', N'Nguyễn Hoàng D', '212938123', N'Phú Yên', '78F-32251', 'Đà Nẵng', 'NHD@gmail.com', '0923674843', '1204345752'),
('TX03', N'Trương Văn L', '212938643', N'Cần Thơ', '65K-41246', 'TPHCM', 'TVL@gmail.com', '0983245631', '1248573476')
go

insert into DON_HANG
values 
('DH01', 'KH01', 'TX01', null, '2022/08/17', N'Chờ nhận'),
('DH02', 'KH02', 'TX02', null, '2022/11/23', N'Chờ nhận'),
('DH03', 'KH03', 'TX03', null, '2022/10/12', N'Đã tiếp nhận')
go

insert into CHI_TIET_DON_HANG
values
('DH01', 'M001', 2, N'Không hành', N'Chuyển khoản', N'Hà Nội'),
('DH02', 'M004', 1, N'Thêm nước tương', N'COD', N'Đà Nẵng'),
('DH03', 'M005', 1, N'Ít đá', N'Chuyển khoản', N'TPHCM')
go

insert into THUC_DON
values 
('CH01', 'M001'),
('CH01', 'M002'),
('CH02', 'M001'),
('CH02', 'M002'),
('CH03', 'M003'),
('CH03', 'M004'),
('CH04', 'M005'),
('CH04', 'M006'),
('CH05', 'M005'),
('CH05', 'M006')
go

--RBTV: Số lượng chi nhánh, số lượng đơn hàng mỗi ngày không âm.
CREATE TRIGGER trgChiNhanh_DOITAC
ON DOI_TAC
FOR INSERT, UPDATE
AS 
IF UPDATE(SoLuongChiNhanh)
BEGIN
	IF EXISTS (
		SELECT *
		FROM inserted
		WHERE SoLuongChiNhanh < 0
	)
	BEGIN
		RAISERROR(N'Số lượng chi nhánh không được âm.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgDonHang_DOITAC
ON DOI_TAC
FOR INSERT, UPDATE
AS 
IF UPDATE(SoLuongDonMoiNgay)
BEGIN
	IF EXISTS (
		SELECT *
		FROM inserted
		WHERE SoLuongDonMoiNgay < 0
	)
	BEGIN
		RAISERROR(N'Số lượng đơn hàng mỗi ngày không được âm.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Email là duy nhất
CREATE TRIGGER trgEmail_DOITAC
ON DOI_TAC
FOR INSERT, UPDATE
AS 
IF UPDATE(Email)
BEGIN
	IF EXISTS (
		SELECT *
		FROM DOI_TAC DT, inserted I
		WHERE DT.Email = I.Email
		GROUP BY DT.Email
		HAVING COUNT(*) > 1
	)
	BEGIN
		RAISERROR(N'Email là duy nhất.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgEmail_KHACHHANG
ON KHACH_HANG
FOR INSERT, UPDATE
AS 
IF UPDATE(Email)
BEGIN
	IF EXISTS (
		SELECT *
		FROM KHACH_HANG KH, inserted I
		WHERE KH.Email = I.Email
		GROUP BY KH.Email
		HAVING COUNT(*) > 1
	)
	BEGIN
		RAISERROR(N'Email là duy nhất.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgEmail_TAIXE
ON TAI_XE
FOR INSERT, UPDATE
AS 
IF UPDATE(Email)
BEGIN
	IF EXISTS (
		SELECT *
		FROM TAI_XE TX, inserted I
		WHERE TX.Email = I.Email
		GROUP BY TX.Email
		HAVING COUNT(*) > 1
	)
	BEGIN
		RAISERROR(N'Email là duy nhất.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Mã số thuế là duy nhất
CREATE TRIGGER trgMaSoThue_HOPDONG
ON HOP_DONG
FOR INSERT, UPDATE
AS 
IF UPDATE(MaSoThue)
BEGIN
	IF EXISTS (
		SELECT *
		FROM HOP_DONG HD, inserted I
		WHERE HD.MaSoThue = I.MaSoThue
		GROUP BY HD.MaSoThue
		HAVING COUNT(*) > 1
	)
	BEGIN
		RAISERROR(N'Mã số thuế là duy nhất.',16,1)
		ROLLBACK
	END
END
go

--RBTV: CMND là duy nhất
CREATE TRIGGER trgCMND_KHACHHANG
ON KHACH_HANG
FOR INSERT, UPDATE
AS 
IF UPDATE(CMND)
BEGIN
	IF EXISTS (
		SELECT *
		FROM KHACH_HANG KH, inserted I
		WHERE KH.CMND = I.CMND
		GROUP BY KH.CMND
		HAVING COUNT(*) > 1
	)
	BEGIN
		RAISERROR(N'CMND là duy nhất.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgCMND_TAIXE
ON TAI_XE
FOR INSERT, UPDATE
AS 
IF UPDATE(CMND)
BEGIN
	IF EXISTS (
		SELECT *
		FROM TAI_XE TX, inserted I
		WHERE TX.CMND = I.CMND
		GROUP BY TX.CMND
		HAVING COUNT(*) > 1
	)
	BEGIN
		RAISERROR(N'CMND là duy nhất.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Tên món không trùng nhau
CREATE TRIGGER trgTenMon_MON
ON MON
FOR INSERT, UPDATE
AS 
IF UPDATE(TenMon)
BEGIN
	IF EXISTS (
		SELECT *
		FROM MON M, inserted I
		WHERE M.TenMon = I.TenMon
		GROUP BY M.TenMon
		HAVING COUNT(*) > 1
	)
	BEGIN
		RAISERROR(N'Tên món không trùng nhau.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Ngày hết hạn phải lớn hơn ngày đăng ký
CREATE TRIGGER trgNgayHetHan_NgayDK_HOPDONG
ON HOP_DONG
FOR INSERT, UPDATE
AS 
IF UPDATE(NgayDK) OR UPDATE(NgayHetHan)
BEGIN
	IF EXISTS (
		SELECT *
		FROM inserted
		WHERE NgayDK > NgayHetHan
	)
	BEGIN
		RAISERROR(N'Ngày hết hạn phải lớn hơn ngày đăng ký.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Thời gian cập nhật tên cửa hàng phải sau 30 ngày kể từ ngày đăng kí/ngày cập nhật gần nhất
CREATE TRIGGER trgTgDoiTen_CUAHANG
ON CUA_HANG
FOR UPDATE
AS 
IF UPDATE(TenCuaHang)
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM inserted I
		WHERE DATEDIFF(day, I.TgDoiTen, GETDATE()) >= 30
	)
	BEGIN
		RAISERROR(N'Thời gian cập nhật tên cửa hàng phải sau 30 ngày kể từ ngày đăng kí/ngày cập nhật gần nhất.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Khách hàng không được hủy đơn nếu tình trạng đơn hàng đang là “đã tiếp nhận”.
--CREATE TRIGGER trgTinhTrangDonHang_DONHANG
--ON DON_HANG
--FOR UPDATE
--AS 
--IF UPDATE(TinhTrangDonHang)
--BEGIN
--	IF EXISTS (
--		SELECT *
--		FROM inserted I, deleted D
--		WHERE I.ID_DonHang = D.ID_DonHang 
--		AND D.TinhTrangDonHang = N'Đã tiếp nhận'
--		AND I.TinhTrangDonHang = N'Đã hủy'
--	)
--	BEGIN
--		RAISERROR(N'Khách hàng không được hủy đơn nếu tình trạng đơn hàng đang là “đã tiếp nhận”.',16,1)
--		ROLLBACK
--	END
--END
--go

--RBTV: Người đăng kí hợp đồng phải là một đối tác
CREATE TRIGGER trgID_DoiTac_HOPDONG
ON HOP_DONG
FOR INSERT, UPDATE
AS 
IF UPDATE(ID_DoiTac)
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM DOI_TAC DT, inserted I
		WHERE I.ID_DoiTac = DT.ID_DoiTac
	)
	BEGIN
		RAISERROR(N'Người đăng kí hợp đồng phải là một đối tác.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgID_DoiTac_DOITAC
ON DOI_TAC
FOR DELETE, UPDATE
AS 
IF UPDATE(ID_DoiTac)
BEGIN
	IF EXISTS (
		SELECT *
		FROM HOP_DONG HD, deleted D
		WHERE HD.ID_DoiTac = D.ID_DoiTac
	)
	BEGIN
		RAISERROR(N'Người đăng kí hợp đồng phải là một đối tác.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Mỗi cửa hàng phải có hợp đồng
CREATE TRIGGER trgID_HopDong_CUAHANG
ON CUA_HANG
FOR INSERT, UPDATE
AS 
IF UPDATE(ID_HopDong)
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM HOP_DONG HD, inserted I
		WHERE I.ID_HopDong = HD.ID_HopDong
	)
	BEGIN
		RAISERROR(N'Mỗi cửa hàng phải có hợp đồng.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgID_HopDong_HOPDONG
ON HOP_DONG
FOR DELETE, UPDATE
AS 
IF UPDATE(ID_HopDong)
BEGIN
	IF EXISTS (
		SELECT *
		FROM CUA_HANG CH, deleted D
		WHERE CH.ID_HopDong = D.ID_HopDong
	)
	BEGIN
		RAISERROR(N'Mỗi cửa hàng phải có hợp đồng.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Thực đơn được tạo và sửa bởi các cửa hàng
CREATE TRIGGER trgID_CuaHang_THUCDON
ON THUC_DON
FOR INSERT, UPDATE
AS 
IF UPDATE(ID_CuaHang)
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM CUA_HANG CH, inserted I
		WHERE I.ID_CuaHang = CH.ID_CuaHang
	)
	BEGIN
		RAISERROR(N'Thực đơn được tạo và sửa bởi các cửa hàng.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgID_CuaHang_CUAHANG
ON CUA_HANG
FOR DELETE, UPDATE
AS 
IF UPDATE(ID_CuaHang)
BEGIN
	IF EXISTS (
		SELECT *
		FROM THUC_DON TD, deleted D
		WHERE TD.ID_CuaHang = D.ID_CuaHang
	)
	BEGIN
		RAISERROR(N'Thực đơn được tạo và sửa bởi các cửa hàng.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Thực đơn phải chứa thông tin của các món ăn
CREATE TRIGGER trgID_Mon_THUCDON
ON THUC_DON
FOR INSERT, UPDATE
AS 
IF UPDATE(ID_Mon)
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM MON M, inserted I
		WHERE I.ID_Mon = M.ID_Mon
	)
	BEGIN
		RAISERROR(N'Thực đơn phải chứa thông tin của các món ăn.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgID_Mon_MON
ON MON
FOR DELETE, UPDATE
AS 
IF UPDATE(ID_Mon)
BEGIN
	IF EXISTS (
		SELECT *
		FROM THUC_DON TD, deleted D
		WHERE TD.ID_Mon = D.ID_Mon
	)
	BEGIN
		RAISERROR(N'Thực đơn phải chứa thông tin của các món ăn.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Đơn hàng phải chứa thông tin khách hàng
CREATE TRIGGER trgID_KhachHang_DONHANG
ON DON_HANG
FOR INSERT, UPDATE
AS 
IF UPDATE(ID_KhachHang)
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM KHACH_HANG KH, inserted I
		WHERE I.ID_KhachHang = KH.ID_KhachHang
	)
	BEGIN
		RAISERROR(N'Đơn hàng phải chứa thông tin khách hàng.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgID_KhachHang_KHACHHANG
ON KHACH_HANG
FOR DELETE, UPDATE
AS 
IF UPDATE(ID_KhachHang)
BEGIN
	IF EXISTS (
		SELECT *
		FROM DON_HANG DH, deleted D
		WHERE DH.ID_KhachHang = D.ID_KhachHang
	)
	BEGIN
		RAISERROR(N'Đơn hàng phải chứa thông tin khách hàng.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Đơn hàng phải chứa thông tin tài xế
CREATE TRIGGER trgID_TaiXe_DONHANG
ON DON_HANG
FOR INSERT, UPDATE
AS 
IF UPDATE(ID_TaiXe)
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM TAI_XE TX, inserted I
		WHERE I.ID_TaiXe = TX.ID_TaiXe
	)
	BEGIN
		RAISERROR(N'Đơn hàng phải chứa thông tin tài xế.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgID_TaiXe_TAIXE
ON TAI_XE
FOR DELETE, UPDATE
AS 
IF UPDATE(ID_TaiXe)
BEGIN
	IF EXISTS (
		SELECT *
		FROM DON_HANG DH, deleted D
		WHERE DH.ID_TaiXe = D.ID_TaiXe
	)
	BEGIN
		RAISERROR(N'Đơn hàng phải chứa thông tin tài xế.',16,1)
		ROLLBACK
	END
END
go

--RBTV: Chi tiết đơn hàng phải chứa thông mã đơn hàng.
CREATE TRIGGER trgID_DonHang_CTDONHANG
ON CHI_TIET_DON_HANG
FOR INSERT, UPDATE
AS 
IF UPDATE(ID_DonHang)
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM DON_HANG DH, inserted I
		WHERE I.ID_DonHang = DH.ID_DonHang
	)
	BEGIN
		RAISERROR(N'Chi tiết đơn hàng phải chứa thông mã đơn hàng.',16,1)
		ROLLBACK
	END
END
go

CREATE TRIGGER trgID_DonHang_DONHANG
ON DON_HANG
FOR DELETE, UPDATE
AS 
IF UPDATE(ID_DonHang)
BEGIN
	IF EXISTS (
		SELECT *
		FROM CHI_TIET_DON_HANG CTDH, deleted D
		WHERE CTDH.ID_DonHang = D.ID_DonHang
	)
	BEGIN
		RAISERROR(N'Chi tiết đơn hàng phải chứa thông mã đơn hàng.',16,1)
		ROLLBACK
	END
END
go

--Phân quyền
--Tạo role DOITAC và cấp quyền 
exec sp_addrole 'DOITAC'
grant select on dbo.HOP_DONG to DOITAC
grant select on dbo.CHI_TIET_DON_HANG to DOITAC
grant select on dbo.DON_HANG to DOITAC
grant update on dbo.DON_HANG(TinhTrangDonHang) to DOITAC
grant select, delete, update on dbo.CUA_HANG to DOITAC
grant select, delete, update on dbo.THUC_DON to DOITAC
grant select, delete, update on dbo.MON to DOITAC
GRANT EXECUTE TO DOITAC

--Tạo role KHACHHANG và cấp quyền 
exec sp_addrole 'KHACHHANG'
grant select on dbo.DOI_TAC to KHACHHANG
grant select on dbo.CHI_TIET_DON_HANG to KHACHHANG
grant select on dbo.DON_HANG to KHACHHANG
grant select on dbo.MON to KHACHHANG
grant select on dbo.THUC_DON to KHACHHANG
grant select on dbo.CUA_HANG(ID_CuaHang,TenCuaHang,TgHoatDong,TinhTrangCuaHang) to KHACHHANG
GRANT EXECUTE TO KHACHHANG

--Tạo role TAIXE và cấp quyền 
exec sp_addrole 'TAIXE'
grant select on dbo.CHI_TIET_DON_HANG to TAIXE
grant select on dbo.DON_HANG to TAIXE
grant update on dbo.DON_HANG(TinhTrangDonHang) to TAIXE
GRANT EXECUTE TO TAIXE

--Tạo role NHANVIEN và cấp quyền 
exec sp_addrole 'NHANVIEN'
grant select on dbo.DOI_TAC to NHANVIEN
grant select on dbo.HOP_DONG to NHANVIEN

--Tạo login
create login LG_DoiTac
with password = '123'
go

create login LG_KhachHang
with password = '123'
go

create login LG_NhanVien
with password = '123'
go

create login LG_TaiXe
with password = '123'
go

create login LG_Admin
with password = '123'
go

--Tạo user 
create user userDT for login LG_DoiTac
create user userKH for login LG_KhachHang
create user userNV for login LG_NhanVien
create user userTX for login LG_TaiXe

--Thêm user vào role
exec sp_addrolemember  'DOITAC','userDT'
exec sp_addrolemember  'KHACHHANG','userKH'
exec sp_addrolemember  'NHANVIEN','userNV'
exec sp_addrolemember  'TAIXE','userTX'

--Tạo login ADMIN chính là data_system
exec sp_addsrvrolemember 'LG_Admin', 'sysadmin'


--
