use DB_UDBH
go

create proc usp_capNhatGiaMon_T2
(
	@IDMon char(10),
	@ThayDoi decimal
)
as
begin tran
declare @GiaBan decimal

if not exists (select * from MON where ID_Mon = @IDMon)
begin
	print N'Món không tồn tại'
	return
end
select @GiaBan = m.GiaBan
from MON m 
where m.ID_Mon = @IDMon
waitfor delay '0:00:05'
set @GiaBan = @GiaBan + @ThayDoi

update MON
set GiaBan = @GiaBan
where ID_Mon = @IDMon
commit tran
go

exec usp_capNhatGiaMon_T2 'M001', 1000
DROP proc usp_capNhatGiaMon_T2
