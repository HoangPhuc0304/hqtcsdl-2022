use DB_UDBH
go

create proc usp_DongCH_T1
(
	@IDCH char(10)
)
as
begin tran
if not exists (select * from MON where ID_Mon IN (
	SELECT DISTINCT M.ID_Mon
	FROM THUC_DON TD, MON M
	WHERE TD.ID_CuaHang = @IDCH AND TD.ID_Mon = M.ID_Mon
))
begin
	print N'Món không tồn tại'
	return
end

update MON
set TinhTrangMon = N'Ngưng bán'
where ID_Mon IN (
	SELECT DISTINCT M.ID_Mon
	FROM THUC_DON TD, MON M
	WHERE TD.ID_CuaHang = @IDCH AND TD.ID_Mon = M.ID_Mon
)
waitfor delay '0:00:05'

if not exists (select ch.* from CUA_HANG ch where ch.ID_CuaHang = @IDCH )
begin	
	print N'Cửa hàng không tồn tại'
	return
end

update CUA_HANG
set TinhTrangCuaHang = N'Tạm nghỉ'
where ID_CuaHang = @IDCH
commit tran
go

exec usp_DongCH_T1 'CH01'
DROP PROC usp_DongCH_T1
