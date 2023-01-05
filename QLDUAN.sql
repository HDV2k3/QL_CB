CREATE DATABASE QLDUAN;

USE QLDUAN;

CREATE TABLE NCC
(
	MaNCC char(5),
	Ten	nvarchar(40),
	Heso int,
	PRIMARY KEY(MaNCC)
)


CREATE TABLE VATTU
(
	MaVT char(5),
	Ten nvarchar(40),
	Mau nvarchar(15),
	TrLuong float,
	ThPho nvarchar(20),
	primary key(MaVT)
)

CREATE TABLE DUAN
(
	MaDA CHAR(5),
	Ten NVARCHAR(40),
	ThPho NVARCHAR(20),
	PRIMARY KEY (MaDA)
)

CREATE TABLE CC
(
	MaNCC CHAR(5),
	MaVT CHAR(5),
	MaDA CHAR (5),
	SLuong INT,
	PRIMARY KEY (MaNCC,MaVT,MaDA),
	FOREIGN KEY (MaNCC) REFERENCES NCC(MaNCC),
	FOREIGN KEY (MaVT) REFERENCES  VATTU(MaVT),
	FOREIGN KEY (MaDA) REFERENCES DUAN(MaDA)
)

--1)	Cho biết quy cách màu và thành phố của các vật tư không được trữ tại Hà Nội có trọng lượng lớn hơn 10.
SELECT V.Mau,V.ThPho
from VATTU V
where ThPho != N'Hà Nội' and V.TrLuong >10
--2)	Cho biết thông tin chi tiết của tất cả các dự án.
SELECT *
FROM DUAN
--3)	Cho biết thông tin chi tiết của tất cả các dự án ở TP.HCM.

--4)	Cho biết tên nhà cung cấp cung cấp vật tư cho dự án J1.
--5)	Cho biết tên nhà cung cấp, tên vật tư và tên dự án mà số lượng vật tư được cung cấp cho dự án bởi nhà cung cấp lớn hơn 300 và nhỏ hơn 750.
--6)	Cho biết thông tin chi tiết của các vật tư được cung cấp bởi các nhà cung cấp ở TP.HCM.
--7)	Cho biết mã số các vật tư được cung cấp cho các dự án tại TP.HCM bởi các nhà cung cấp ở TP.HCM.
--8)	Liệt kê các cặp tên thành phố mà nhà cung cấp ở thành phố thứ nhất cung cấp vật tư được trữ tại thành phố thứ hai.
--9)	Liệt kê các cặp tên thành phố mà nhà cung cấp ở thành phố thứ nhất cung cấp vật tư cho dự án tại thành phố thứ hai.
--10)	Liệt kê các cặp mã số nhà cung cấp ở cùng một thành phố.
--11)	Cho biết mã số và tên các vật tư được cung cấp cho dự án cùng thành phố với nhà cung cấp.
--12)	Cho biết mã số và tên các dự án được cung cấp vật tư bởi ít nhất một nhà cung cấp không cùng thành phố.
--13)	Cho biết mã số nhà cung cấp và cặp mã số vật tư được cung cấp bởi nhà cung cấp này.
--14)	Cho biết mã số các vật tư được cung cấp bởi nhiều hơn một nhà cung cấp.
--15)	Với mỗi vật tư cho biết mã số và tổng số lượng được cung cấp cho các dự án.
--16)	Cho biết tổng số các dự án được cung cấp vật tư bởi nhà cung cấp S1.
--17)	Cho biết tổng số lượng vật tư P1 được cung bởi nhà cung cấp S1.
--18)	Với mỗi vật tư được cung cấp cho một dự án, cho biết mã số, tên vật tư, tên dự án và tổng số lượng vật tư tương ứng.
--19)	Cho biết mã số, tên các vật tư và tên dự án có số lượng vật tư trung bình cung cấp cho dự án lớn hơn 350.
--20)	Cho biết tên các dự án được cung cấp vật tư bởi nhà cung cấp S1.
--21)	Cho biết quy cách màu của các vật tư được cung cấp bởi nhà cung cấp S1.
--22)	Cho biết mã số và tên các vật tư được cung cấp cho một dự án bất kỳ ở TP.HCM.
--23)	Cho biết mã số và tên các dự án sử dụng vật tư có thể được cung cấp bởi nhà cung cấp S1.
--24)	Cho biết mã số và tên nhà cung cấp có cung cấp vật tư có quy cách màu đỏ.
--25)	Cho biết tên các nhà cung cấp có chỉ số xếp hạng nhỏ hơn chỉ số lớn nhất.
--26)	Cho biết tên các nhà cung cấp không cung cấp vật tư P2.
--27)	Cho biết mã số và tên các nhà cung cấp đang cung cấp vật tư được cung cấp bởi nhà cung cấp có cung cấp vật tư với quy cách màu đỏ.
--28)	Cho biết mã số và tên các nhà cung cấp có chỉ số xếp hạng cao hơn nhà cung cấp S1.
--29)	Cho biết mã số và tên các dự án được cung cấp vật tư P1 với số lượng vật tư trung bình lớn hơn tất cả các số lượng vật tư được cung cấp cho dự án J1.
--30)	Cho biết mã số và tên các nhà cung cấp cung cấp vật tư P1 cho một dự án nào đó với số lượng lớn hơn số lượng trung bình của vật tư P1 được cung cấp cho dự án đó.
--31)	Cho biết mã số và tên các dự án không được cung cấp vật tư nào có quy cách màu đỏ bởi một nhà cung cấp bất kỳ ở TP.HCM.
--32)	Cho biết mã số và tên các dự án được cung cấp toàn bộ vật tư bởi nhà cung cấp S1.
--33)	Cho biết tên các nhà cung cấp cung cấp tất cả các vật tư.
--34)	Cho biết mã số và tên các vật tư được cung cấp cho tất cả các dự án tại TP.HCM.
--35)	Cho biết mã số và tên các nhà cung cấp cung cấp cùng một vật tư cho tất cả các dự án.
--36)	Cho biết mã số và tên các dự án được cung cấp tất cả các vật tư có thể được cung cấp bởi nhà cung cấp S1.
--37)	Cho biết tất cả các thành phố mà nơi đó có ít nhất một nhà cung cấp, trữ ít nhất một vật tư hoặc có ít nhất một dự án.
--38)	Cho biết mã số các vật tư hoặc được cung cấp bởi một nhà cung cấp ở TP.HCM hoặc cung cấp cho một dự án tại TP.HCM.
--39)	Liệt kê các cặp (mã số nhà cung cấp, mã số vật tư) mà nhà cung cấp không cấp vật tư.
--40)	Liệt kê các cặp mã số nhà cung cấp có thể cung cấp cùng tất cả các loại vật tư.
--41)	Cho biết tên các thành phố trữ nhiều hơn 5 vật tư có quy cách màu đỏ.



