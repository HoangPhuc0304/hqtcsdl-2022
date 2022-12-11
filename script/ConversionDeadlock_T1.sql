USE DB_UDBH
GO

CREATE PROC sp_CapNhatTinhTrangCuaHang_T1
	@ID_CuaHang CHAR(10),
	@TinhTrangCuaHang NVARCHAR(20)
AS
BEGIN TRAN
SET TRAN ISOLATION LEVEL SERIALIZABLE
	IF NOT EXISTS (
		SELECT *
		FROM CUA_HANG
		WHERE ID_CuaHang = @ID_CuaHang
	)
	BEGIN
		PRINT(N'Cửa hàng không tồn tại với ID '+ @ID_CuaHang)
		ROLLBACK TRAN
		RETURN
	END

	WAITFOR DELAY '00:00:05'
	
	UPDATE CUA_HANG
	SET TinhTrangCuaHang = @TinhTrangCuaHang
	WHERE ID_CuaHang = @ID_CuaHang
COMMIT TRAN
RETURN
GO 

EXEC sp_CapNhatTinhTrangCuaHang_T1 'M001', N'Tạm nghỉ'
DROP PROC sp_CapNhatTinhTrangCuaHang_T1
