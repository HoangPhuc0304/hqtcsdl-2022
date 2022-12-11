USE DB_UDBH
GO

--Fix dirty read--
--T1--
CREATE PROC sp_HuyDonHang_KhachHang
	@ID_KhachHang CHAR(10),
	@ID_DonHang CHAR(10)
AS
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
IF NOT EXISTS(SELECT * FROM DON_HANG WHERE ID_DonHang = @ID_DonHang)
BEGIN
	PRINT(N'Không tồn tại đơn hàng với ID là ' + @ID_DonHang)
	ROLLBACK TRAN
	RETURN
END
IF NOT EXISTS(SELECT * FROM DON_HANG WHERE ID_DonHang = @ID_DonHang AND ID_KhachHang = @ID_KhachHang)
BEGIN
	PRINT(N'Đơn hàng không thuộc về khách hàng có ID ' + @ID_KhachHang)
	ROLLBACK TRAN
	RETURN
END
DECLARE @TrangThai NVARCHAR(20)
SET @TrangThai = (SELECT TinhTrangDonHang FROM DON_HANG WHERE ID_DonHang = @ID_DonHang)

UPDATE DON_HANG
SET TinhTrangDonHang = N'Đã hủy'
WHERE ID_DonHang = @ID_DonHang

WAITFOR DELAY '00:00:05'

IF(@TrangThai != N'Chờ nhận')
BEGIN
	RAISERROR(N'Khách hàng không được hủy đơn nếu tình trạng đơn hàng đang là “đã tiếp nhận”.',16,1)
	ROLLBACK TRAN
	RETURN
END
PRINT(N'Hủy đơn hàng thành công')
COMMIT TRAN
RETURN
GO

--EXEC--
EXEC sp_HuyDonHang_KhachHang 'KH03','DH03'
