use DB_UDBH
go

create proc usp_kiemTraTinhTrangDonHang
(
	@IDDH char(10)
)
as
begin tran

set transaction isolation level repeatable read

if not exists (select dh.* from DON_HANG dh where dh.ID_DonHang = @IDDH )
begin	
	print N'Đơn hàng không tồn tại'
	return
end

declare @TTDH nvarchar(20), @TTDH2 nvarchar(20)


select dh.*
from DON_HANG dh
where dh.ID_DonHang = @IDDH 

waitfor delay '0:00:05'


select dh.*
from DON_HANG dh
where dh.ID_DonHang = @IDDH 

commit tran
go

exec usp_kiemTraTinhTrangDonHang 'DH01'