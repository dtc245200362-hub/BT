-- ============================================================
-- CHUẨN BỊ: KHỞI TẠO CƠ SỞ DỮ LIỆU & DỮ LIỆU MẪU
-- ============================================================

-- 1. Tạo CSDL nếu chưa tồn tại
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;

-- 2. Chọn CSDL để làm việc (Bước 1)
USE QuanLySinhVien;

-- 3. Xóa bảng cũ nếu đã tồn tại (để tránh lỗi trùng lặp khi chạy lại)
DROP TABLE IF EXISTS Mark;
DROP TABLE IF EXISTS Student;

-- 4. Tạo bảng Student
CREATE TABLE Student (
    StudentId INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    Address VARCHAR(100)
);

-- 5. Tạo bảng Mark
CREATE TABLE Mark (
    MarkId INT AUTO_INCREMENT PRIMARY KEY,
    StudentId INT,
    Mark FLOAT,
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
);

-- 6. Chèn dữ liệu mẫu vào bảng Student
INSERT INTO Student (StudentName, Address) VALUES 
('Nguyen Van A', 'Ha Noi'),
('Tran Thi B', 'Da Nang'),
('Le Van C', 'Ha Noi'),
('Pham Van D', 'TPHCM'),
('Hoang Thi E', 'Da Nang');

-- 7. Chèn dữ liệu mẫu vào bảng Mark
INSERT INTO Mark (StudentId, Mark) VALUES 
(1, 18.0), (1, 16.0),
(2, 12.0), (2, 14.0),
(3, 19.0), (3, 20.0),
(4, 10.0), (4, 11.0);


-- ============================================================
-- THỰC HÀNH CÁC BƯỚC TRUY VẤN DỮ LIỆU
-- ============================================================

-- BƯỚC 1: Sử dụng cơ sở dữ liệu QuanLySinhVien
USE QuanLySinhVien;


-- BƯỚC 2: Hiển thị số lượng sinh viên ở từng nơi
SELECT Address, COUNT(StudentId) AS 'SoLuongHocVien'
FROM Student
GROUP BY Address;


-- BƯỚC 3: Tính điểm trung bình các môn học của mỗi học viên
SELECT S.StudentId, S.StudentName, AVG(Mark) AS 'DiemTrungBinh'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;


-- BƯỚC 4: Hiển thị những bạn học viên có điểm trung bình các môn học lớn hơn 15
SELECT S.StudentId, S.StudentName, AVG(Mark) AS 'DiemTrungBinh'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) > 15;


-- BƯỚC 5: Hiển thị thông tin các học viên có điểm trung bình lớn nhất (Thủ khoa)
SELECT S.StudentId, S.StudentName, AVG(Mark) AS 'DiemTrungBinh'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (
    SELECT AVG(Mark) 
    FROM Mark 
    GROUP BY StudentId
);