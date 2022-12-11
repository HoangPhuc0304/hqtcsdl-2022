USE DB_UDBH
GO

--Phantom--
--T2--
CREATE PROC sp_ThemMon
	@ID_CuaHang CHAR(10),
	@ID_Mon CHAR(10),
	@TenMon NVARCHAR(50),
	@MieuTa NVARCHAR(100),
	@GiaBan DECIMAL(18, 0),
	@TinhTrangMon NVARCHAR(20)
AS
BEGIN TRAN
BEGIN TRY
	/*Chỉ có đối tác mới có thể thêm món ăn*/
	IF NOT EXISTS (
		SELECT *
		FROM CUA_HANG
		WHERE ID_CuaHang = @ID_CuaHang
	)
	BEGIN
		PRINT(N'Không tồn tại cửa hàng với ID '+ @ID_CuaHang)
		ROLLBACK TRAN
		RETURN
	END

	/*Món phải ăn được thêm phải không tồn tại trong danh sách*/
	IF EXISTS (
		SELECT *
		FROM MON
		WHERE ID_Mon = @ID_Mon 
	)
	BEGIN
		PRINT(N'Đã tồn tại món ăn với ID '+ @ID_Mon)
		ROLLBACK TRAN
		RETURN
	END

	IF EXISTS (
		SELECT *
		FROM MON
		WHERE TenMon = @TenMon
	)
	BEGIN
		PRINT(N'Đã tồn tại món ăn với tên '+ @TenMon)
		ROLLBACK TRAN
		RETURN
	END

	/*Thêm món ăn vào danh sách món*/
	INSERT INTO MON(ID_Mon,TenMon,MieuTa,GiaBan,TinhTrangMon)
	VALUES(@ID_Mon,@TenMon,@MieuTa,@GiaBan,@TinhTrangMon)

	/*Cập nhật món ăn được thêm vào thực đơn*/
	INSERT INTO THUC_DON(ID_CuaHang,ID_Mon)
	VALUES(@ID_CuaHang,@ID_Mon)
END TRY
BEGIN CATCH
	RAISERROR(N'Thêm món không thành công',15,1)
	ROLLBACK TRAN
	RETURN
END CATCH
PRINT(N'Thêm món thành công')
COMMIT TRAN
RETURN
GO

--EXEC--
EXEC sp_ThemMon 'CH01','M010',N'Bún đậu mắm tôm','Mắm tôm nguyên chất',70000,'Có bán'
