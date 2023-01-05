CREATE DATABASE QLCB;

USE QLCB;

CREATE TABLE CHUYENBAY
(
	MACB CHAR(5),
	GADI VARCHAR(50),
	GADEN VARCHAR(50),
	DODAI INT,
	GIODI TIME,
	GIODEN TIME,
	CHIPHI INT,
	MAMB INT,
	PRIMARY KEY(MACB) ,
	FOREIGN KEY(MAMB) REFERENCES MAYBAY(MAMB)

)
CREATE TABLE MAYBAY
(
	MAMB INT,
	LOAI VARCHAR(50),
	TAMBAY INT,
	PRIMARY KEY(MAMB)
)

CREATE  TABLE NHANVIEN
(
	MANV  CHAR(9),
	TEN NVARCHAR(50),
	LUONG INT,
	PRIMARY KEY(MANV)
)

CREATE TABLE CHUNGNHAN
(
	MANV CHAR(9),
	MAMB INT,
	PRIMARY KEY(MANV,MAMB)
)


--1)	Cho biết các chuyến bay đi Đà Lạt (DAD).
SELECT *
FROM CHUYENBAY
WHERE GADEN='DAD'  
--2)	Cho biết các loại máy bay có tầm bay lớn hơn 10,000km.
SELECT LOAI ,TAMBAY
FROM MAYBAY
WHERE TAMBAY>10000
--3)	Tìm các nhân viên có lương nhỏ hơn 10,000.
SELECT TEN,LUONG
FROM NHANVIEN
WHERE LUONG<10000
--4)	Cho biết các chuyến bay có độ dài đường bay nhỏ hơn 10.000km và lớn hơn 8.000km.
SELECT * 
FROM CHUYENBAY
WHERE DODAI<10000 AND DODAI>8000
--5)	Cho biết các chuyến bay xuất phát từ Sài Gòn (SGN) đi Ban Mê Thuộc (BMV).
SELECT *
FROM CHUYENBAY
WHERE GADI='SGN' AND GADEN='BMV'
--6)	Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN).
SELECT *
FROM CHUYENBAY
WHERE GADI='SGN'
--7)	Có bao nhiêu loại máy báy Boeing.
SELECT *
FROM MAYBAY
WHERE LOAI like '%Boeing%'
--8)	Cho biết tổng số lương phải trả cho các nhân viên.
SELECT  SUM(LUONG) AS [TONG LUONG]
FROM NHANVIEN


--9)	Cho biết mã số của các phi công lái máy báy Boeing.
SELECT DISTINCT NHANVIEN.MANV
FROM NHANVIEN,CHUNGNHAN
WHERE NHANVIEN.MANV = CHUNGNHAN.MANV AND CHUNGNHAN.MAMB IN 
	(
		SELECT MAMB
		FROM MAYBAY
		WHERE LOAI LIKE '%Boeing%'
	)
--10)	Cho biết các nhân viên có thể lái máy bay có mã số 747.
SELECT NHANVIEN.MANV,NHANVIEN.TEN , CHUNGNHAN.MAMB
FROM NHANVIEN,CHUNGNHAN
WHERE NHANVIEN.MANV=CHUNGNHAN.MANV AND CHUNGNHAN.MAMB IN
	(
		SELECT MAMB
		FROM MAYBAY
		WHERE LOAI LIKE '%747%'
	)
--11)	Cho biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái.
SELECT NHANVIEN.TEN, CHUNGNHAN.MAMB 
FROM NHANVIEN,CHUNGNHAN
WHERE NHANVIEN.MANV=CHUNGNHAN.MANV AND NHANVIEN.TEN LIKE '%Nguyễn%'

--12)	Cho biết mã số của các phi công vừa lái được Boeing vừa lái được Airbus.
SELECT NHANVIEN.MANV,MAYBAY.LOAI
FROM NHANVIEN,CHUNGNHAN,MAYBAY
WHERE NHANVIEN.MANV=CHUNGNHAN.MANV 
--13)	Cho biết các loại máy bay có thể thực hiện chuyến bay VN280.
SELECT LOAI
FROM MAYBAY 
WHERE MAYBAY.TAMBAY>(
	SELECT DODAI
	FROM CHUYENBAY
	WHERE CHUYENBAY.MACB='VN280'
)

--14)	Cho biết các chuyến bay có thể được thực hiện bởi máy bay Airbus A320.
SELECT MAYBAY.MAMB ,CHUYENBAY.MACB
FROM MAYBAY,CHUYENBAY
WHERE MAYBAY.MAMB= CHUYENBAY.MAMB AND TAMBAY>(
	SELECT CHUYENBAY.DODAI
	FROM CHUYENBAY,MAYBAY
	WHERE CHUYENBAY.MAMB=MAYBAY.MAMB AND MAYBAY.LOAI='Airbus A320'
)
--15)	Cho biết tên của các phi công lái máy bay Boeing.
SELECT DISTINCT NHANVIEN.TEN
FROM NHANVIEN,CHUNGNHAN
WHERE NHANVIEN.MANV=CHUNGNHAN.MANV AND CHUNGNHAN.MAMB  BETWEEN 727 AND 777
ORDER BY NHANVIEN.TEN
--16)	Với mỗi loại máy bay có phi công lái cho biết mã số, loại máy báy và tổng số phi công có thể lái loại máy bay đó.
SELECT MAYBAY.MAMB,MAYBAY.LOAI,COUNT(CHUNGNHAN.MANV) AS [SỐ PHI CÔNG CÓ THỂ LÁI MÁY BAY ĐÓ]
FROM MAYBAY,CHUNGNHAN
WHERE MAYBAY.MAMB=CHUNGNHAN.MAMB 
GROUP BY MAYBAY.MAMB,MAYBAY.LOAI
--17)	Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay trở về ga A. Cho biết các đường bay nào có thể đáp ứng yêu cầu này.
SELECT DISTINCT C1.MACB,C1.GIODI,C1.GIODEN,C1.GADI,C1.GADEN,C1.CHIPHI
FROM CHUYENBAY C1,CHUYENBAY C2
WHERE C1.GADI=C2.GADEN AND C1.GADEN=C2.GADI
ORDER BY C1.MACB
--Gom nhóm:
--18)	Với mỗi ga có chuyến bay xuất phát từ đó cho biết có bao nhiêu chuyến bay khởi hành từ ga đó.
SELECT CHUYENBAY.GADI, COUNT(CHUYENBAY.GADI) AS [TONG CHUYEN BAY XUAT PHAT TU GA DI]
FROM CHUYENBAY
GROUP BY GADI
--19)	Với mỗi ga có chuyến bay xuất phát từ đó cho biết tổng chi phí phải trả cho phi công lái các chuyến bay khởi hành từ ga đó.
SELECT CHUYENBAY.GADI  ,COUNT(CHUYENBAY.GADI) AS [TÔNG CHUYẾN BAY],SUM(CHUYENBAY.CHIPHI) AS [TONG CHI PHI]
FROM CHUYENBAY
GROUP BY CHUYENBAY.GADI
ORDER BY COUNT(CHUYENBAY.GADI) 
--20)	Với mỗi địa điểm xuất phát cho biết có bao nhiêu chuyến bay có thể khởi hành trước 12:00.
SELECT CHUYENBAY.GADI,COUNT(CHUYENBAY.MACB) AS [SO CHUYẾN BAY CÓ THỂ KHỞI HÀNH]
FROM CHUYENBAY
WHERE CHUYENBAY.GIODI < '12:00'
GROUP BY CHUYENBAY.GADI
ORDER BY [SO CHUYẾN BAY CÓ THỂ KHỞI HÀNH]
--21)	Cho biết mã số của các phi công chỉ lái được 3 loại máy bay.
SELECT CHUNGNHAN.MANV ,COUNT(CHUNGNHAN.MAMB) [SỐ LOẠI MÁY BAY CÓ THỂ LÁI]
FROM CHUNGNHAN
GROUP BY CHUNGNHAN.MANV
HAVING COUNT(CHUNGNHAN.MAMB) = 3
--22)	Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay, cho biết mã số phi công và tầm bay lớn nhất của các loại máy bay mà phi công đó có thể lái.
SELECT CHUNGNHAN.MANV,MAX(MAYBAY.TAMBAY) [TAM BAY LON NHAT]
FROM CHUNGNHAN,MAYBAY
WHERE CHUNGNHAN.MAMB=MAYBAY.MAMB
GROUP BY CHUNGNHAN.MANV
HAVING COUNT(CHUNGNHAN.MAMB) > 3

--23)	Với mỗi phi công cho biết mã số phi công và tổng số loại máy bay mà phi công đó có thể lái.
SELECT CHUNGNHAN.MANV, COUNT(CHUNGNHAN.MANV) AS [TỔNG SỐ LOẠI MÁY BAY CÓ THỂ LÁI]
FROM CHUNGNHAN
GROUP BY CHUNGNHAN.MANV

--24)	Cho biết mã số của các phi công có thể lái được nhiều loại máy bay nhất.
SELECT TOP 1 CHUNGNHAN.MANV
FROM CHUNGNHAN
GROUP BY MANV
ORDER BY  COUNT(MAMB) DESC

--25)	Cho biết mã số của các phi công có thể lái được ít loại máy bay nhất.
SELECT TOP 1 WITH TIES CHUNGNHAN.MANV, MIN(CHUNGNHAN.MANV) 
FROM CHUNGNHAN
GROUP BY MANV
ORDER BY COUNT(MAMB)    

--Truy vấn lồng:
--26)	Tìm các nhân viên không phải là phi công.
	
SELECT DISTINCT NHANVIEN.MANV,dbo.NHANVIEN.TEN
FROM dbo.NHANVIEN,dbo.CHUNGNHAN
WHERE dbo.NHANVIEN.MANV != ALL(SELECT DISTINCT dbo.CHUNGNHAN.MANV FROM dbo.CHUNGNHAN )
---CAC NHAN VIEN LA PHI CONG:
SELECT dbo.NHANVIEN.MANV,TEN,COUNT(dbo.NHANVIEN.MaNV)
FROM dbo.NHANVIEN,dbo.CHUNGNHAN
WHERE dbo.CHUNGNHAN.MANV = dbo.NHANVIEN.MANV 
GROUP BY dbo.NHANVIEN.MANV,TEN
--27)	Cho biết mã số của các nhân viên có lương cao nhất.
SELECT   NHANVIEN.LUONG , TEN
FROM NHANVIEN
WHERE LUONG=
(
	SELECT MAX(LUONG) 
	FROM NHANVIEN
)
--28)	Cho biết tổng số lương phải trả cho các phi công.
SELECT  SUM(NHANVIEN.LUONG) AS[TÔNG SỐ LƯƠNG PHẢI TRẢ]
FROM NHANVIEN
WHERE MANV IN(
	SELECT MANV
	FROM CHUNGNHAN
)
--29)	Tìm các chuyến bay có thể được thực hiện bởi tất cả các loại máy bay Boeing.
SELECT dbo.CHUYENBAY.MACB
FROM dbo.MAYBAY,dbo.CHUYENBAY
WHERE dbo.CHUYENBAY.MaMB=dbo.MAYBAY.MAMB AND dbo.MAYBAY.TAMBAY >= ALL(
SELECT	TAMBAY
FROM dbo.MAYBAY 
WHERE LOAI LIKE '%Boeing%'
)
--30)	Cho biết mã số của các máy bay có thể được sử dụng để thực hiện chuyến bay từ Sài Gòn (SGN) đến Huế (HUI).
SELECT dbo.MAYBAY.MAMB
FROM dbo.MAYBAY
WHERE TAMBAY>= (
SELECT TAMBAY
FROM dbo.MAYBAY,dbo.CHUYENBAY
WHERE dbo.MAYBAY.MAMB=dbo.CHUYENBAY.MAMB AND dbo.CHUYENBAY.GADI='SGN' AND dbo.CHUYENBAY.GADEN= 'HUI') 
--31)	Tìm các chuyến bay có thể được lái bởi các phi công có lương lớn hơn 100,000.
SELECT DISTINCT dbo.CHUYENBAY.MACB
FROM dbo.CHUYENBAY,dbo.CHUNGNHAN
WHERE dbo.CHUYENBAY.MAMB=dbo.CHUNGNHAN.MAMB AND dbo.CHUNGNHAN.MANV IN (
SELECT MANV
FROM dbo.NHANVIEN
WHERE LUONG > 100000)
--32)	Cho biết tên các phi công có lương nhỏ hơn chi phí thấp nhất của đường bay từ Sài Gòn (SGN) đến Buôn Mê Thuộc (BMV).
SELECT TOP 1 WITH TIES dbo.NHANVIEN.TEN,LUONG
FROM dbo.NHANVIEN,dbo.CHUNGNHAN
WHERE dbo.NHANVIEN.MANV=dbo.CHUNGNHAN.MANV AND 
--33)	Cho biết mã số của các nhân viên có lương cao thứ nhất.
 SELECT TOP 1 WITH TIES dbo.NHANVIEN.MANV
FROM dbo.NHANVIEN 
WHERE dbo.NHANVIEN.MANV IN (SELECT MANV FROM dbo.CHUNGNHAN)
ORDER BY LUONG DESC
--34)	Cho biết mã số của các nhân viên có lương cao thứ nhì.
 SELECT TOP 1 WITH TIES dbo.NHANVIEN.MANV
FROM dbo.NHANVIEN 
WHERE dbo.NHANVIEN.MANV IN (SELECT MANV FROM dbo.CHUNGNHAN) AND dbo.NHANVIEN.MANV NOT IN  (SELECT TOP 1 WITH TIES dbo.NHANVIEN.MANV
FROM dbo.NHANVIEN 
WHERE dbo.NHANVIEN.MANV IN (SELECT MANV FROM dbo.CHUNGNHAN)
ORDER BY LUONG DESC)
ORDER BY LUONG DESC

--35)	Cho biết mã số của các nhân viên có lương cao thứ nhất hoặc thứ nhì.
SELECT TOP 2 WITH TIES dbo.NHANVIEN.MANV
FROM dbo.NHANVIEN
WHERE dbo.NHANVIEN.MANV IN (SELECT MANV FROM dbo.CHUNGNHAN)
ORDER BY LUONG DESC

----36) Cho biết tên và lƣơng của các nhân viên không phải là phi công và có lƣơng lớn hơn lƣơng trung bình của tất cả các phi công.
SELECT N.TEN, N.LUONG
FROM NHANVIEN N
WHERE LUONG >= ALL( SELECT AVG(LUONG) FROM NHANVIEN N WHERE N.MANV IN
(SELECT MANV FROM CHUNGNHAN)) AND N.MANV NOT IN ( SELECT MANV FROM
CHUNGNHAN)
----37) Cho biết tên các phi công có thể lái các máy bay có tầm bay lớn hơn 4,800km nhƣng không có chứng nhận lái máy bay Boeing.
select distinct n.MANV,n.TEN
from MAYBAY m , CHUNGNHAN c,NHANVIEN n
where m.TAMBAY >4800 and c.MANV= n.MANV and c.MANV not in
( select c.MANV
from CHUNGNHAN
c,MAYBAY m
where m.MAMB =
c.MAMB and m.LOAI like 'Boeing%'
group by c.MANV)
----38) Cho biết tên các phi công lái ít nhất 3 loại máy bay có tầm bay xa hơn 3200km.
select n.MANV,n.TEN
from MAYBAY m,CHUNGNHAN c,NHANVIEN n
where c.MANV= n.MANV and c.MAMB=m.MAMB and c.MANV in
( select c.MANV
from CHUNGNHAN c,MAYBAY m
where c.MAMB=
m.MAMB and m.TAMBAY>3200
group by c.MANV
having
count(c.MAMB)>=3 )
group by n.TEN,n.MANV
----Kết ngoài:
----39) Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số loại máy bay mà nhân viên đó có thể lái.
select n.TEN,c.MANV, count(c.MAMB) as [Tổng số loại máy bay có thể
lái]
from NHANVIEN n inner join CHUNGNHAN c
on n.MANV= c.MANV
group by n.TEN,c.MANV
----40) Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số loại máy bay Boeing mà nhân viên đó có thể lái.
select n.TEN,c.MANV, count(c.MAMB) as [Số loại máy bay Boeing có thể
lái]
from NHANVIEN n inner join CHUNGNHAN c
on n.MANV= c.MANV inner join MAYBAY m
on m.LOAI like 'Boeing%' and m.MAMB=c.MAMB
group by n.TEN,c.MANV
----41) Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công có thể lái loại máy bay đó.
select m.LOAI, count(c.MANV) as [SỐ LƢỢNG PHI CÔNG CÓ THỂ LÁI]
from MAYBAY m inner join CHUNGNHAN c
on m.MAMB=c.MAMB
group by m.LOAI,c.MAMB
----42) Với mỗi loại máy bay cho biết loại máy bay và tổng số chuyến bay không thể thực hiện bởi loại máy bay đó.
select m.LOAI,count(m.MAMB) as [tổng số chuyến bay không thể thực hiện]
from CHUYENBAY c inner join MAYBAY m
on c.DODAI>m.TAMBAY and c.MAMB=m.MAMB
group by m.LOAI,m.MAMB
----43) Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công có lƣơng lớn hơn 100,000 có thể lái loại máy bay đó.
select m.LOAI, count(m.LOAI) as [SỐ PHI CÔNG LÁI ĐƢỢC]
from NHANVIEN n inner join CHUNGNHAN c
on n.LUONG>100000 and n.MANV=c.MANV inner join MAYBAY m on c.MAMB=m.MAMB
group by m.LOAI
----44) Với mỗi loại máy bay có tầm bay trên 3200km, cho biết tên của loại máy bay và lƣơng trung bình của các phi công có thể lái loại máy bay đó.
select m.LOAI, AVG(n.LUONG) as [Lƣơng Trung Bình]
from NHANVIEN n inner join CHUNGNHAN c
on n.MANV = c.MANV inner join MAYBAY m on m.TAMBAY>3200 and m.MAMB=c.MAMB
group by m.LOAI
----45) Với mỗi loại máy bay cho biết loại máy bay và tổng số nhân viên không thể lái loại máy bay đó.
select m.LOAI,NV.SLNV - PC.TPC as [Tổng số nhân viên không thể lái]
from (select count(n.MANV) as [SLNV] from NHANVIEN n)as NV ,MAYBAY m ,(
select m.MAMB,count(CN.MANV) as [TPC]
from MAYBAY m inner join CHUNGNHAN CN
on m.MAMB=CN.MAMB group by m.MAMB) as PC
where m.MAMB=PC.MAMB
group by m.LOAI, NV.SLNV - PC.TPC
----46) Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công không thể lái loại máy bay đó.
select m.LOAI, G.SLPC- PC.TPC as [Tổng số phi công không thể lái]
from MAYBAY m,( select m.MAMB,count(CN.MANV) as [TPC]
from MAYBAY m inner join CHUNGNHAN CN
on m.MAMB=CN.MAMB group by m.MAMB) as PC,
(select count(MANV) as [SLPC]
from ( select c.MANV from
CHUNGNHAN c,NHANVIEN n
where c.MANV=n.MANV group by
c.MANV)as T) as G
where m.MAMB=PC.MAMB
group by m.LOAI, G.SLPC- PC.TPC
----47) Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số chuyến bay xuất phát từ Sài Gòn mà nhân viên đó có thể lái.
select n.MANV, CB.SCB as [tổng số chuyến bay]
from NHANVIEN n,(select c.MANV,count(cb.MACB) as [SCB]
from CHUNGNHAN c inner join NHANVIEN n
on c.MANV=n.MANV inner join CHUYENBAY cb
on cb.GADI = 'SGN' and
cb.MAMB=c.MAMB group by c.MANV) as CB
where n.MANV=CB.MANV
----48) Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số chuyến bay xuất phát từ Sài Gòn mà nhân viên đó không thể lái.
select n.MANV,n.TEN, NV.TNV-CB.SCB as [Tổng số chuyến bay không thể lái]
from NHANVIEN n,(select count(n.MANV) as [TNV] from NHANVIEN n) as
NV,(select c.MANV,count(cb.MACB) as [SCB]
from CHUNGNHAN c inner join NHANVIEN n
on c.MANV=n.MANV inner join CHUYENBAY cb
on cb.GADI = 'SGN' and
cb.MAMB=c.MAMB group by c.MANV) as CB
where n.MANV= cb.MANV
group by n.MANV, NV.TNV-CB.SCB,n.TEN
----49) Với mỗi phi công cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà phi công đó có thể lái.
select n.MANV,n.TEN ,CB.SCB as [ tổng số chuyến bay xuất phát từ Sài
Gòn thực hiện đƣợc]
from NHANVIEN n,(select c.MANV,count(cb.MACB) as [SCB]
from CHUNGNHAN c inner join NHANVIEN n
on c.MANV=n.MANV inner join CHUYENBAY cb
on cb.GADI = 'SGN' and
cb.MAMB=c.MAMB group by c.MANV) as CB
where n.MANV =CB.MANV
group by n.MANV,cb.SCB,n.TEN
----50) Với mỗi phi công cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà phi công đó không thể lái.
select n.MANV,n.TEN, G.SLPC-CB.SCB as [TỔNG SỐ CHUYẾN BAY KHÔNG THỂ
LÁI]
from NHANVIEN n,(select c.MANV,count(cb.MACB) as [SCB]
from CHUNGNHAN c inner join NHANVIEN n
on c.MANV=n.MANV inner join CHUYENBAY cb
on cb.GADI = 'SGN' and
cb.MAMB=c.MAMB group by c.MANV) as CB,
(select count(MANV) as [SLPC]
from ( select c.MANV from CHUNGNHAN c,NHANVIEN n
where c.MANV=n.MANV group by c.MANV)as T) as G
where n.MANV=cb.MANV
group by n.MANV, G.SLPC-CB.SCB,n.TEN
----51) Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số loại máy bay không thể thực hiện chuyến bay đó.
select CBB.MACB,COUNT(CBB.MAMB) as [TỔNG SỐ MÁY BAY KHÔNG THỰC HIỆN ĐƢỢC]
from CHUYENBAY CBB,( select m.MAMB
from CHUYENBAY cb , MAYBAY m ,CHUNGNHAN
c
where c.MAMB=cb.MAMB and c.MAMB=m.MAMB
group by cb.MACB,m.MAMB) as TMB
where TMB.MAMB= CBB.MAMB and CBB.MAMB >= TMB.MAMB
group by CBB.MACB
----52) Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số loại máy bay có thể thực hiện chuyến bay đó.
SELECT CB.MACB,MB.[TỔNG MÁY BAY THỰC HIỆN ĐƢỢC]
FROM CHUYENBAY CB,(SELECT CB.MACB,count(MB.MAMB) AS [TỔNG MÁY BAY THỰC
HIỆN ĐƢỢC]
FROM CHUYENBAY CB,MAYBAY MB ,CHUNGNHAN C
WHERE CB.MAMB=MB.MAMB AND C.MAMB=cb.MAMB
GROUP BY CB.MACB,MB.MAMB) AS MB
WHERE CB.MACB=mb.MACB
----53) Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số nhân viên không thể lái chuyến bay đó.
select cb.MACB, NV.SLNV-PC.TPC as [TỔNG SỐ NHÂN VIÊN KHÔNG THỂ LÁI]
from CHUYENBAY cb,( select m.MAMB,count(CN.MANV) as [TPC]
from MAYBAY m inner join CHUNGNHAN CN
on m.MAMB=CN.MAMB group by m.MAMB) as PC,
(select count(n.MANV) as [SLNV] from NHANVIEN n)as NV
where cb.MAMB=PC.MAMB
----54) Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số phi công không thể lái chuyến bay đó.
select cb.MACB, G.SLPC- PC.TPC as [TỔNG SỐ PHI CÔNG KHÔNG THỂ LÁI]
from CHUYENBAY cb,(select count(MANV) as [SLPC]
from ( select c.MANV from CHUNGNHAN c,NHANVIEN n
where c.MANV=n.MANV group by c.MANV)as T) as G,( select
m.MAMB,count(CN.MANV) as [TPC]
from MAYBAY m inner join CHUNGNHAN CN
on m.MAMB=CN.MAMB group by m.MAMB) as PC
where cb.MAMB=PC.MAMB
----Exists và các dạng khác:
----55) Một hành khách muốn đi từ Hà Nội (HAN) đến Nha Trang (CXR) mà không phải đổi chuyến bay quá một lần. Cho biết mã chuyến bay và thời gian khởi hành từ Hà Nội nếu hành khách muốn đến Nha Trang trƣớc 16:00.
SELECT MACB , GIODI
FROM CHUYENBAY
WHERE GADI ='HAN' AND GADEN ='CXR' AND GIODEN<'16:00'
----56) Cho biết tên các loại máy bay mà tất cả các phi công có thể lái đều có lƣơng lớn hơn 200,000.
select m.LOAI
from MAYBAY m, (select mb.MAMB
from NHANVIEN nv,CHUNGNHAN c ,MAYBAY mb
where nv.MANV=c.MANV and nv.LUONG>200000 and
mb.MAMB=c.MAMB
group by mb.MAMB) as MB
where m.MAMB=MB.MAMB
----57) Cho biết thông tin của các đƣờng bay mà tất cả các phi công có thể bay trên đƣờng bay đó đều có lƣơng lớn hơn 100,000.
select cb.*
from (select cb.MACB
from CHUNGNHAN c,NHANVIEN nv ,CHUYENBAY cb,MAYBAY mb
where c.MANV=nv.MANV and nv.LUONG>100000 and cb.MAMB=mb.MAMB
and DODAI< TAMBAY
group by cb.MACB) as L,CHUYENBAY cb
where cb.MACB=L.MACB
----58) Cho biết tên các phi công chỉ lái các loại máy bay có tầm bay
xa hơn 3200km.
select n.MANV,n.TEN
from NHANVIEN n,(select c.MANV from CHUNGNHAN c where c.MANV not in(select
c.MANV from CHUNGNHAN c
inner join MAYBAY m
on c.MAMB=m.MAMB and m.TAMBAY<3200
group by c.MANV)
group by c.MANV)as TB
where n.MANV=TB.MANV
group by n.MANV,n.TEN
----59) Cho biết tên các phi công chỉ lái các loại máy bay có tầm bay xa hơn 3200km và một trong số đó là Boeing.
SELECT DISTINCT TEN N'CÁC PHI CÔNG LÁI MÁY BAY TRÊN 3200 VÀ CÓ LOẠI
BOEING'
FROM (SELECT MAMB FROM MAYBAY
WHERE TAMBAY >3200 AND LOAI LIKE 'Boeing%'GROUP BY MAMB)AS
TAMTB,
CHUNGNHAN CN , NHANVIEN NV
WHERE CN.MAMB=TAMTB.MAMB AND NV.MANV=CN.MANV
----60) Tìm các phi công có thể lái tất cả các loại máy bay.
select n.MANV,n.TEN,mb.SLMB as [SỐ LƢỢNG MÁY BAY CÓ THỂ LÁI]
from NHANVIEN n, (SELECT MANV , COUNT (MAMB) AS SL1PC
FROM CHUNGNHAN
GROUP BY MANV) as SMB, (SELECT COUNT (MAMB)
SLMB FROM MAYBAY where LOAI like 'Boeing%' ) as MB
where n.MANV=SMB.MANV and SMB.SL1PC=mb.SLMB
----61) Tìm các phi công có thể lái tất cả các loại máy bay Boeing.
select n.MANV,n.TEN, PC.SLMBCPC
from NHANVIEN n,(select count(m.MAMB) as [SLMB] from MAYBAY m where m.LOAI
like 'Boeing%' ) as MB,
(select c.MANV,count(c.MAMB) as [SLMBCPC]
from CHUNGNHAN c inner join MAYBAY m
on c.MAMB=m.MAMB and m.LOAI like
'Boeing%'
group by c.MANV) as PC
where n.MANV=PC.MANV and PC.SLMBCPC=MB.SLMB
group by n.MANV,n.TEN, PC.SLMBCPC