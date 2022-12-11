use DB_UDBH
go

create proc usp_capNhatTinhTrangDonHang
(
	@IDDH char(10), @TTDH nvarchar(20)
)
as
begin tran

if not exists (select dh.* from DON_HANG dh where dh.ID_DonHang = @IDDH )
begin	
	print N'Đơn hàng không tồn tại'
	return
end

update DON_HANG
set TinhTrangDonHang = @TTDH
where ID_DonHang = @IDDH

commit tran 
go

exec usp_capNhatTinhTrangDonHang 'DH01', N'Đang giao'
DROP PROC usp_capNhatTinhTrangDonHang
