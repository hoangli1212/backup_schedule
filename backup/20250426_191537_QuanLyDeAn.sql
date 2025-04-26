﻿use master
go
if exists(select * from sys.databases where name = 'QLDeAn_MSSV')
	begin	
		ALTER DATABASE QLDeAn_MSSV SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		drop database QLDeAn_MSSV -- xóa CSDL
	end 		
go
create database QLDeAn_MSSV
go
use QLDeAn_MSSV
go 
create table PHONGBAN
(
		TENPHONG nvarchar(30),
		MAPHG int not null,
		TRPHG char(9),
		NGNHANCHUC datetime,
		constraint PK_PB primary key(MAPHG)
)
create table NHANVIEN 
(	
		HONV nvarchar(30),
		TENLOT nvarchar(30),
		TEN nvarchar(30),
		MANV char(9) not null,
		NGSINH datetime,
		DCHI nvarchar(50),
		PHAI nchar(6),
		LUONG float,
		PHG int,
		constraint PK_NV primary key(MANV)
)
CREATE TABLE DIADIEM_PHG
(
	MAPHG INT NOT NULL,
	DIADIEM NVARCHAR(30) NOT NULL,
	constraint PK_DD PRIMARY KEY (MAPHG, DIADIEM)
)

CREATE TABLE PHANCONG
(
	MADA INT NOT NULL,
	MA_NVIEN CHAR(9) NOT NULL,
	VITRI NVARCHAR(50),
	constraint PK_PC PRIMARY KEY ( MADA,MA_NVIEN)
)

CREATE TABLE THANNHAN
(
	MA_NVIEN CHAR(9) NOT NULL,
	TENTN NVARCHAR(30) NOT NULL,
	PHAI NCHAR(6),
	NGSINH DATETIME,
	QUANHE NVARCHAR(16),
	constraint PK_TN PRIMARY KEY (MA_NVIEN, TENTN)
)

CREATE TABLE DEAN
(
	TENDA NVARCHAR(30),
	MADA INT NOT NULL,
	DDIEM_DA NVARCHAR(30),
	NGAYBD DATETIME,
	NGAYKT DATETIME,
	constraint PK_DA PRIMARY KEY (MADA)
)
/*TAO KHOA NGOAI CHO CAC BANG*/
/*TRPHG - NHANVIEN(MANV)*/
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_PHONGBAN 
FOREIGN KEY (PHG) REFERENCES PHONGBAN(MAPHG) 

ALTER TABLE PHONGBAN ADD CONSTRAINT FK_PHONGBAN_NHANVIEN
FOREIGN KEY (TRPHG) REFERENCES NHANVIEN(MANV) 


ALTER TABLE DIADIEM_PHG ADD CONSTRAINT FK_DIADIEM_PHG_PHONGBAN
FOREIGN KEY (MAPHG) REFERENCES PHONGBAN(MAPHG)


ALTER TABLE THANNHAN ADD CONSTRAINT FK_THANNHAN_NHANVIEN
FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)


ALTER TABLE PHANCONG ADD CONSTRAINT FK_PHANCONG_NHANVIEN
FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)

ALTER TABLE PHANCONG ADD CONSTRAINT FK_PHANCONG_DEAN
FOREIGN KEY (MADA) REFERENCES DEAN(MADA)

---NHAP DU LIEU BANG PHONG BAN
INSERT INTO PHONGBAN (TENPHONG,MAPHG,TRPHG,NGNHANCHUC)
VALUES	(N'Phòng Triển Khai',5,NULL,'2010-05-20'),
		(N'Phòng Xây Dựng',4,NULL,'2011-01-01'),
		(N'Phòng Quản Lý',1,NULL,'2012-06-19')
		---NHAP DU LIEU BANG NHAN VIEN
INSERT INTO NHANVIEN(HONV,TENLOT,TEN,MANV,NGSINH,DCHI,PHAI,LUONG,PHG)
Values	(N'Đinh',N'Bá',N'Tiên','123456789','1970-01-09',N'TPHCM',N'Nam',30000,5),
		(N'Nguyễn',N'Thanh',N'Tùng','333445555','1975-12-08',N'TPHCM',N'Nam',40000,5),
		(N'Bùi',N'Thúy',N'Vũ','999887777','1980-07-19',N'Đà Nẵng',N'Nữ',25000,4),
		(N'Lê',N'Thị',N'Nhàn','987654321','1978-06-20',N'Huế',N'Nữ',43000,4),
		(N'Nguyễn',N'Mạnh',N'Hùng','666884444','1984-09-15',N'Quảng Nam',N'Nam',38000,5),
		(N'Trần',N'Thanh',N'Tâm','453453453','1988-07-31',N'Quảng Trị',N'Nam',25000,5),
		(N'Trần',N'Hồng',N'Quân','987987987','1990-03-29',N'Đà Nẵng',N'Nam',25000,4),
		(N'Vương',N'Ngọc',N'Quyền','888665555','1965-10-10',N'Quảng Ngãi',N'Nữ',55000,1)
Go
-----CẬP NHẬT DỮ LIỆU BẢNG PHÒNG BAN
UPDATE PHONGBAN
SET  TRPHG='333445555'
WHERE MAPHG=5
UPDATE PHONGBAN
SET  TRPHG='987987987'
WHERE MAPHG=4
UPDATE PHONGBAN
SET  TRPHG='888665555'
WHERE MAPHG=1
---NHAP DU LIEU BANG DIADIEM_PHG
INSERT INTO DIADIEM_PHG(MAPHG,DIADIEM)
VALUES	(1,N'Đà Nẵng'),
		(4,N'Đà Nẵng'),
		(5,N'Đà Nẵng'),
		(5,N'Hà Nội'),
		(5,N'Quảng Nam')
go
---NHAP DU LIEU BANG DIADIEM_PHG
INSERT INTO THANNHAN(MA_NVIEN,TENTN,PHAI,NGSINH,QUANHE)
values	('333445555',N'Quang',N'Nữ','2005-04-05',N'Con gai'),
		('333445555',N'Khang',N'Nam','2008-10-25',N'Con trai'),
		('333445555',N'Duong',N'Nữ','2078-05-03',N'Vo chong'),
		('987654321',N'Dang',N'Nam','2070-02-20',N'Vo chong'),
		('123456789',N'Duy',N'Nam','2000-01-01',N'Con trai'),
		('123456789',N'Chau',N'Nữ','2004-12-31',N'Con gai'),
		('123456789',N'Phuong',N'Nữ','2077-05-05',N'Vo chong')
Go
---NHAP DU LIEU BANG DEAN
INSERT INTO DEAN(TENDA,MADA,DDIEM_DA,NGAYBD,NGAYKT)
values	(N'Quản Lí Khách Sạn',100,N'Đà Nẵng','2012-01-01','2012-02-20'),
		(N'Quản Lí Bệnh Viện',200,N'Đà Nẵng','2013-03-15','2013-06-30'),
		(N'Quản Lí Bán Hàng',300,N'Hà Nội','2013-12-01','2014-02-01'),
		(N'Quản Lí Đào Tạo',400,N'Hà Nội','2014-03-15',null)
Go
---NHAP DU LIEU BANG PHAN CONG
INSERT INTO PHANCONG(MADA,MA_NVIEN,VITRI)
values	(100,'333445555',N'Trưởng Nhóm'),
		(100,'123456789',N'Thành Viên'),
		(100,'666884444',N'Thành Viên'),
		(200,'987987987',N'Trưởng Dự Án'),
		(200,'999887777',N'Trưởng Nhóm'),
		(200,'453453453',N'Thành Viên'),
		(200,'987654321',N'Thành Viên'),
		(300,'987987987',N'Trưởng Dự Án'),
		(300,'999887777',N'Trưởng Nhóm'),
		(300,'333445555',N'Trưởng Nhóm'),
		(300,'666884444',N'Thành Viên'),
		(300,'123456789',N'Thành Viên'),
		(400,'987987987',N'Trưởng Dự Án'),
		(400,'999887777',N'Trưởng Nhóm'),
		(400,'123456789',N'Thành Viên'),
		(400,'333445555',N'Thành Viên'),
		(400,'987654321',N'Thành Viên'),
		(400,'666884444',N'Thành Viên')
Go
--Viết các PROCEDURE sau: 
--a. Tạo thủ tục hiển thị nhân viên (họ tên) tham gia nhiều dự án nhất trong năm 2013 
	create procedure sp_hienThiNhanVienNhieuDuAnNhat2013
		as
			begin
			select nv.HONV + ' ' +  nv.TENLOT + ' ' + ' ' + nv.TEN as N'Họ và Tên'  , COUNT(pc.MADA) as N'Số dự án tham gia'  
			from NHANVIEN as nv
			inner join PHANCONG as pc on  nv.MANV = pc.MA_NVIEN
			inner join DEAN as da on pc.MADA = da.MADA
			where year(da.NGAYBD) = 2013
			group by nv.HONV, nv.TENLOT , nv.TEN
			order by count(pc.MADA) desc
			end
--b. Tạo thủ tục hiển thị tên dự án, trưởng dự án và số nhân viên tham gia dự án đó.
go
	create procedure da_hienThiThongTinDuAnVaTruongDuAn
		as
			begin
				select da.TENDA, nv.HONV + ' ' + nv.TENLOT + ' ' + nv.TEN as N'Họ và  tên', count(pc.MA_NVIEN) as N' Số Nhân Viên Tham Gia ' 
				from DEAN as da
				inner join  PHANCONG as pc on da.MADA = pc.MADA
				inner join NHANVIEN as nv on pc.MA_NVIEN = nv.MANV
				group by  da.TENDA , nv.HONV, nv.TENLOT, nv.TEN
				order by da.TENDA
			end
--c. Tạo thủ tục truyền vào mã dự án, hiển thị tất cả các nhân viên tham gia dự án đó. 
go 
	create procedure da_hienThiNhanVienTheoDuAn
		@MaDuAn int 
		as
			begin
				select nv.HONV + ' ' + nv.TENLOT + ' ' + nv.TEN as N'Họ và tên nhân viên'
				from NHANVIEN as nv
				inner join PHANCONG as pc on nv.MANV = pc.MA_NVIEN
				where pc.MADA = @MaDuAn
			end
--d. Tạo thủ tục truyền vào mã phòng ban, hiển thị tên phòng ban, số lượng nhân viên và số lượng địa điểm của phòng ban đó. 
go
	create procedure sp_hienThiThongTinPhongBan
		@MaPhongBan int
		as
			begin
				select pb.TENPHONG , count(nv.Manv) as N'Số lượng nhân viên', count (distinct dd.DIADIEM) as N'Sô lượng địa điểm dự án'
				from PHONGBAN as pb
				left join NHANVIEN as nv on pb.TRPHG = nv.MANV
				left join DIADIEM_PHG as dd on pb.MAPHG = dd.MAPHG
				where pb.MAPHG = @MaPhongBan
				group by pb.TENPHONG
			end
--e. Tạo thủ tục truyền vào mã nhân viên (@manv) và vị trí (@vitri), hiển thị tên những dự án mà @manv tham gia với vị trí là @vitri. 
go
	create procedure sp_hienThiDanhSachDuAnTheoViTri
		@MaNv char(9),
		@ViTri Nvarchar(50)
		as
			begin
			select da.TENDA as N'Dự Án' 
			from DEAN as da
			inner join PHANCONG as pc on pc.MADA = da.MADA
			where pc.MA_NVIEN = @MaNv and pc.VITRI = @ViTri 
			end
--f. Tạo thủ tục: 
--không Tham số vào: @mapb 
--không Tham số ra: @luongcaonhat, @tennhanvien: lương cao nhất của phòng ban đó và họ tên nhân viên đạt lương cao nhất đó.
go
	create procedure sp_layLuongCaoNhatVaTenNhanVien
		as
			begin
				declare @MaPb int 
				declare @LuongCaoNhat float 
				declare @TenNhanVien nvarchar(100)

				select top 1 @MaPb = pb.MAPHG 
				from PHONGBAN as pb
				order by (select max(nv.LUONG) from NHANVIEN as nv where nv.PHG = pb.TRPHG) desc

				select top 1 @LuongCaoNhat = max(nv.LUONG), @TenNhanVien = nv.HONV + ' ' + nv.TENLOT + ' ' + nv.TEN  
				from NHANVIEN as nv
				where nv.PHG = @MaPb
				order by nv.LUONG desc

				select @LuongCaoNhat as N'Lương cao nhất' ,@TenNhanVien as N'Tên nhân viên'
			end
--g. Tạo thủ tục: 
--không Tham số vào: @ngaybatdau, @ngayketthuc 
--không Tham số ra: @soduan: số lượng dự án bắt đầu và kết thúc trong khoảng thời gian trên (có nghĩa sau bắt đầu sau @ ngaybatdau và kết thúc trước @ngayketthuc) 
go 
	create procedure sp_tinhSoDuAnKhoangThoiGian
		as
			begin
				declare @NgayBatDau datetime
				declare @NgayKetThuc datetime
				declare @SoDuAn int 

				set @NgayBatDau = '01/12/2013'
				set @NgayKetThuc = '01/02/2014'

				select @SoDuAn = count (*)
				from DEAN as da
				where NGAYBD >= @NgayBatDau and NGAYKT <= @NgayKetThuc

				select @SoDuAn as N'Số dư án'
			end 
--h. Tạo thủ tục: 
--không Tham số vào: @mada 
--không Tham số ra: @sonu, @sonam: số nhân viên nữ và nhân viên nam tham gia dự án đó. 
go
	create procedure sp_tínhoNhanVienTheoGioiTinh
		as 
			begin
				declare @MaDeAn int
				declare @SoNam int
				declare @SoNu int

				set @MaDeAn = 100

				select 
					@SoNam = count(case when nv.PHAI = N'Nam' then 1 end),
					@SoNu = count(case when nv.PHAI = N'Nữ' then 1 end)
				from NHANVIEN as nv
				inner join PHANCONG as pc on  nv.MANV = pc.MA_NVIEN
				where pc.MADA = @MaDeAn 

				select @SoNu as N'Số Nữ' , @SoNam as N'Số Nam'
			end
--i. Tạo thủ tục thêm mới một phòng ban với các tham số vào: @mapb, @tenpb, @trphg, @ngnhanchuc. 
--Yêu cầu: 
--không Kiểm tra @mapb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục. 
--không Kiểm tra @tenpb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục. 
--không Kiểm tra @trphg có phải là nhân viên không, nếu không phải là nhân viên thì thông báo và kết thúc thủ tục. 
--không Nếu các điều kiện trên đều thỏa thì cho thêm mới phòng ban. 
go
	create procedure sp_themMoiPhongBan
	@MaPb int, 
	@TenPb nvarchar(50),
	@trPhg char(9),
	@NgayNhanChuc datetime
		as 
			begin
			declare @countMaPb int
			declare @countTenPb int
			declare @IsNhanVien bit

			select @countMaPb = count(*)
			from PHONGBAN as pb
			where pb.MAPHG = @MaPb

			if @countMaPb > 0
				begin
					print 'Mã phòng ban đã tồn tại'
					return 
				end

			if @countTenPb > 0
				begin
					print 'Tên phòng ban đã tồn tại'
					return 
				end

			select @IsNhanVien = case when exists (select 1 
			from NHANVIEN as nv
			where nv.MANV = @trPhg) then 1 else 0 end
			if @IsNhanVien = 0
				begin
					print 'Trưởng phòng không tồn tại trong danh sách nhân viên'
					return
				end
			insert into PHONGBAN (TENPHONG , MAPHG, TRPHG , NGNHANCHUC)
						values (@TenPb , @MaPb , @IsNhanVien, @NgayNhanChuc)
				print 'Thêm mới phòng ban thành công' 
			end

--j. Tạo thủ tục cập nhật ngày kết thúc của một dự án với tham số vào là @mada và @ngayketthuc. 
--Yêu cầu: 
--không Kiểm tra @mada có tồn tại không, nếu không thì thông báo và kết thúc thủ tục. 
--không Kiểm tra @ngayketthuc có sau ngày bắt đầu không, nếu không thì thông báo và kết thúc thủ tục 
--không Nếu các điều kiện trên đều thỏa thì cho cập nhật ngày kết thúc. 
go
	create procedure sp_capNhapKetThucDuAn
		@MaDa int, 
		@NgayKetThuc datetime
		as
			begin
				declare @CountMaDa int
				declare @NgayBatDau datetime

				select @CountMaDa = count(*) ,  @NgayBatDau = da.NGAYBD
				from DEAN as da	
				where da.MADA = @MaDa
				group by da.NGAYBD

				if @CountMaDa = 0
					begin
						print 'Mã dự án không tồn tại'
						return 
					end

				if @NgayKetThuc <= @NgayBatDau
					begin
						print 'Ngày kết thúc dự án phải sau ngày bắt đầu dự án'
						return
					end

					update DEAN 
					set NGAYKT = @NgayKetThuc
					where MADA = @MaDa
			end
		

--k. Tạo thủ tục phân công nhân viên vào dự án mới. Các tham số vào là: @mada, @manv, @vitri. 
--Yêu cầu: 
--không @vitri chỉ nhận một trong 3 giá trị: “Trưởng dự án”, “Trưởng nhóm” và “Thành viên”. Nếu không thỏa điều kiện này thì thông báo và kết thúc thủ tục. 
--không Nếu @vitri = “Trưởng dự án” thì kiểm tra dự án @duan đã có nhân viên làm “Trưởng dự án” chưa, nếu có rồi thì thông báo và kết thúc thủ tục. 
--không Nếu các điều kiện trên đều thỏa thì cho thêm mới phân công.
go 
create procedure sp_phanCongNhanVienVaoDuAnMoi
	@MaDa int,
	@MaNv char(9),
	@Vitri nvarchar (50)
	as
		begin
			declare @countViTri int
			declare @countViTriDuAn int

			if not exists(select 1 from (values (N'Trưởng Dự Án '), (N'Trưởng Nhóm'), (N'Thành Viên') ) as T(ViTri) where T.ViTri = @Vitri )
				begin
					print 'Vị trí phải là một trong ba giá trị : "Trưởng Dự Án" , "Trưởng Nhóm" , hoặc "Thành Viên"'
					return
				end

			if @Vitri = N'Trưởng Dự Án'
				begin
					select * 
					from PHANCONG as pc
					where pc.MADA = @MaDa and pc.VITRI = N'Trưởng Dự Án'

					if @countViTriDuAn > 0
						begin
							print 'Dự án đã có nhân viên làm trưởng dự án'
							return
						end
				end
			insert into PHANCONG (MADA , MA_NVIEN, VITRI)
						values(@MaDa, @MaNv,@Vitri)

				print 'Phân công nhân viên vào dự án mới thành công'
		end
go
--1. TRANSACTION
--a. Xóa một nhân viên bất kỳ và xóa thông tin trưởng phòng của nhân viên này (không xóa phòng ban, chỉ xóa dữ liệu trưởng phòng và 
--ngày nhận chức). Nếu bất kỳ hành động nào xảy ra lỗi thì hủy bỏ tất cả các hành động.
	begin transaction;
	begin try
		delete from NHANVIEN where MANV = '123456789';
		update PHONGBAN set TRPHG = null where TRPHG = '123456789';
		commit;
	end try
	begin catch
		rollback;
	end catch

--b. Xóa một phòng ban, xóa những địa điểm liên quan
--đến phòng ban, xóa thông tin phòng ban của nhân viên viên thuộc phòng ban này (không xóa nhân viên, chỉ xóa dữ liệu phòng trong nhân viên). Nếu bất kỳ hành động nào xảy ra lỗi thì hủy bỏ tất cả các hành động.
begin transaction;
begin try 
		delete from PHONGBAN where MAPHG = 5;
		update NHANVIEN set PHG = null where PHG = 5;
		commit;
	end try
	begin catch
		rollback;
	end catch
--2. FUNCTION	
--Viết hàm xác định một nhân viên có tham gia dự án nào đó với chức vụ là “Trưởng dự án” hay không
create function dbo.IsProjectManager(@MANV CHAR(9))
returns bit
as
begin
    declare @IsProjectManager bit;
    set @IsProjectManager = (select count(*) from PHANCONG where MA_NVIEN = @MANV and VITRI = 'Trưởng Dự Án');
    return @IsProjectManager;
end;
--3. TRIGGER
--Tạo trigger cho ràng buộc: Với mỗi dự án, số lượng “trưởng dự án” phải ít hơn số lượng “trưởng nhóm” và số lượng “trưởng nhóm” phải ít hơn số lượng “thành viên”.
create trigger CheckProjectRoles
on PHANCONG
after insert, update
as
begin
    if exists (select 1 from inserted where VITRI = 'Trưởng dự án')
    begin
        declare @ProjectCount int, @TeamLeadCount int;
        select @ProjectCount = count(*) from PHANCONG where MADA = (select MADA from inserted) and VITRI = 'Trưởng Dự Án'
        select @TeamLeadCount = count(*) from PHANCONG where MADA = (select MADA from inserted) AND VITRI = 'Trưởng nhóm'
        if @ProjectCount >= @TeamLeadCount
        begin
            throw 50001, 'Số lượng Trưởng dự án phải ít hơn số lượng Trưởng nhóm.', 1
        end
    end
end

