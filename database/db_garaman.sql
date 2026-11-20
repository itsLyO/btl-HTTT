-- ==============================================================================
-- DATABASE SCHEMA & SAMPLE DATA CHO HE THONG QUAN LY GARA O TO (GARAMAN)
-- Bám sát 100% tài liệu final.docx (Mục 2 Thiết kế CSDL 19 bảng & Mục 3 Kịch bản chi tiết)
-- Các mã định danh id được gán trực tiếp khớp 100% với mã hiển thị trên giao diện:
-- DV001..DV008, PT005..PT045, KH001..KH008, PNX102..PNX305, HD102..HD305
-- ==============================================================================

DROP DATABASE IF EXISTS `db_garaman`;
CREATE DATABASE `db_garaman` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `db_garaman`;

-- 1. Bảng Địa chỉ
DROP TABLE IF EXISTS `tblAddress6`;
CREATE TABLE `tblAddress6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `houseNumber` VARCHAR(50),
    `street` VARCHAR(100),
    `ward` VARCHAR(100),
    `district` VARCHAR(100),
    `city` VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Bảng Thành viên (gộp các thuộc tính họ tên firstName, midName, lastName)
DROP TABLE IF EXISTS `tblMember6`;
CREATE TABLE `tblMember6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `firstName` VARCHAR(50) NOT NULL,
    `midName` VARCHAR(50),
    `lastName` VARCHAR(50) NOT NULL,
    `dob` DATE,
    `email` VARCHAR(100),
    `tel` VARCHAR(20),
    `role` VARCHAR(50),
    `note` VARCHAR(255),
    `tblAddress6id` INT,
    CONSTRAINT `fk_member_address` FOREIGN KEY (`tblAddress6id`) REFERENCES `tblAddress6`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Bảng Nhân viên (kế thừa tblMember6)
DROP TABLE IF EXISTS `tblEmployee6`;
CREATE TABLE `tblEmployee6` (
    `tblMember6id` INT PRIMARY KEY,
    `position` VARCHAR(100),
    CONSTRAINT `fk_employee_member` FOREIGN KEY (`tblMember6id`) REFERENCES `tblMember6`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Bảng Nhân viên Quản lí (kế thừa tblEmployee6)
DROP TABLE IF EXISTS `tblManager6`;
CREATE TABLE `tblManager6` (
    `tblEmployee6id` INT PRIMARY KEY,
    CONSTRAINT `fk_manager_employee` FOREIGN KEY (`tblEmployee6id`) REFERENCES `tblEmployee6`(`tblMember6id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Bảng Nhân viên Bán hàng (kế thừa tblEmployee6)
DROP TABLE IF EXISTS `tblSalesStaff6`;
CREATE TABLE `tblSalesStaff6` (
    `tblEmployee6id` INT PRIMARY KEY,
    CONSTRAINT `fk_salesstaff_employee` FOREIGN KEY (`tblEmployee6id`) REFERENCES `tblEmployee6`(`tblMember6id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Bảng Nhân viên Kho (kế thừa tblEmployee6)
DROP TABLE IF EXISTS `tblInventoryStaff6`;
CREATE TABLE `tblInventoryStaff6` (
    `tblEmployee6id` INT PRIMARY KEY,
    CONSTRAINT `fk_inventorystaff_employee` FOREIGN KEY (`tblEmployee6id`) REFERENCES `tblEmployee6`(`tblMember6id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Bảng Nhân viên Kỹ thuật (kế thừa tblEmployee6)
DROP TABLE IF EXISTS `tblTechnician6`;
CREATE TABLE `tblTechnician6` (
    `tblEmployee6id` INT PRIMARY KEY,
    CONSTRAINT `fk_technician_employee` FOREIGN KEY (`tblEmployee6id`) REFERENCES `tblEmployee6`(`tblMember6id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Bảng Khách hàng (kế thừa tblMember6)
DROP TABLE IF EXISTS `tblCustomer6`;
CREATE TABLE `tblCustomer6` (
    `tblMember6id` INT PRIMARY KEY,
    `type` VARCHAR(50),
    CONSTRAINT `fk_customer_member` FOREIGN KEY (`tblMember6id`) REFERENCES `tblMember6`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Bảng Nhà cung cấp
DROP TABLE IF EXISTS `tblSupplier6`;
CREATE TABLE `tblSupplier6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    `taxCode` VARCHAR(50),
    `email` VARCHAR(100),
    `tel` VARCHAR(20),
    `desc` VARCHAR(255),
    `tblAddress6id` INT,
    CONSTRAINT `fk_supplier_address` FOREIGN KEY (`tblAddress6id`) REFERENCES `tblAddress6`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Bảng Xe ô tô
DROP TABLE IF EXISTS `tblCar6`;
CREATE TABLE `tblCar6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `plateNumber` VARCHAR(20) NOT NULL UNIQUE,
    `brand` VARCHAR(50),
    `model` VARCHAR(50),
    `year` INT,
    `color` VARCHAR(30),
    `frameNumber` VARCHAR(50),
    `engineNumber` VARCHAR(50),
    `desc` VARCHAR(255),
    `tblCustomer6id` INT,
    CONSTRAINT `fk_car_customer` FOREIGN KEY (`tblCustomer6id`) REFERENCES `tblCustomer6`(`tblMember6id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. Bảng Dịch vụ
DROP TABLE IF EXISTS `tblService6`;
CREATE TABLE `tblService6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    `price` FLOAT NOT NULL,
    `estDuration` INT,
    `desc` VARCHAR(255),
    `warrantyNote` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. Bảng Phụ tùng
DROP TABLE IF EXISTS `tblSparePart6`;
CREATE TABLE `tblSparePart6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    `manufacturer` VARCHAR(100),
    `unit` VARCHAR(50),
    `unitPrice` FLOAT NOT NULL,
    `importPriceRef` FLOAT,
    `stockQuantity` INT NOT NULL DEFAULT 0,
    `desc` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 13. Bảng Lịch hẹn
DROP TABLE IF EXISTS `tblAppointment6`;
CREATE TABLE `tblAppointment6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `appointDate` DATETIME NOT NULL,
    `note` VARCHAR(255),
    `status` VARCHAR(50),
    `tblCustomer6id` INT,
    `tblCar6id` INT,
    `tblService6id` INT,
    CONSTRAINT `fk_appoint_customer` FOREIGN KEY (`tblCustomer6id`) REFERENCES `tblCustomer6`(`tblMember6id`) ON DELETE SET NULL,
    CONSTRAINT `fk_appoint_car` FOREIGN KEY (`tblCar6id`) REFERENCES `tblCar6`(`id`) ON DELETE SET NULL,
    CONSTRAINT `fk_appoint_service` FOREIGN KEY (`tblService6id`) REFERENCES `tblService6`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14. Bảng Phiếu tiếp nhận
DROP TABLE IF EXISTS `tblReceptionSlip6`;
CREATE TABLE `tblReceptionSlip6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `receiveDate` DATETIME NOT NULL,
    `currentKm` INT,
    `carStatus` VARCHAR(255),
    `status` VARCHAR(50),
    `tblCustomer6id` INT,
    `tblSalesStaff6id` INT,
    `tblCar6id` INT,
    CONSTRAINT `fk_slip_customer` FOREIGN KEY (`tblCustomer6id`) REFERENCES `tblCustomer6`(`tblMember6id`) ON DELETE SET NULL,
    CONSTRAINT `fk_slip_salesstaff` FOREIGN KEY (`tblSalesStaff6id`) REFERENCES `tblSalesStaff6`(`tblEmployee6id`) ON DELETE SET NULL,
    CONSTRAINT `fk_slip_car` FOREIGN KEY (`tblCar6id`) REFERENCES `tblCar6`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 15. Bảng Chi tiết dịch vụ / Phân công dịch vụ (thuộc Phiếu tiếp nhận)
DROP TABLE IF EXISTS `tblServiceAssignment6`;
CREATE TABLE `tblServiceAssignment6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `actualPrice` FLOAT NOT NULL,
    `status` VARCHAR(50),
    `note` VARCHAR(255),
    `tblReceptionSlip6id` INT NOT NULL,
    `tblService6id` INT NOT NULL,
    `tblTechnician6id` INT,
    CONSTRAINT `fk_assign_slip` FOREIGN KEY (`tblReceptionSlip6id`) REFERENCES `tblReceptionSlip6`(`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_assign_service` FOREIGN KEY (`tblService6id`) REFERENCES `tblService6`(`id`) ON DELETE RESTRICT,
    CONSTRAINT `fk_assign_tech` FOREIGN KEY (`tblTechnician6id`) REFERENCES `tblTechnician6`(`tblEmployee6id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 16. Bảng Chi tiết phụ tùng sử dụng (thuộc Phiếu tiếp nhận)
DROP TABLE IF EXISTS `tblUsedSparePart6`;
CREATE TABLE `tblUsedSparePart6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `quantity` INT NOT NULL,
    `actualPrice` FLOAT NOT NULL,
    `tblReceptionSlip6id` INT NOT NULL,
    `tblSparePart6id` INT NOT NULL,
    CONSTRAINT `fk_usedsp_slip` FOREIGN KEY (`tblReceptionSlip6id`) REFERENCES `tblReceptionSlip6`(`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_usedsp_sparepart` FOREIGN KEY (`tblSparePart6id`) REFERENCES `tblSparePart6`(`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 17. Bảng Hóa đơn thanh toán (1 - 0..1 với tblReceptionSlip6)
DROP TABLE IF EXISTS `tblInvoice6`;
CREATE TABLE `tblInvoice6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `paymentDate` DATETIME NOT NULL,
    `paymentMethod` VARCHAR(50),
    `note` VARCHAR(255),
    `tblReceptionSlip6id` INT NOT NULL UNIQUE,
    `tblSalesStaff6id` INT,
    CONSTRAINT `fk_invoice_slip` FOREIGN KEY (`tblReceptionSlip6id`) REFERENCES `tblReceptionSlip6`(`id`) ON DELETE RESTRICT,
    CONSTRAINT `fk_invoice_salesstaff` FOREIGN KEY (`tblSalesStaff6id`) REFERENCES `tblSalesStaff6`(`tblEmployee6id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 18. Bảng Đơn nhập phụ tùng
DROP TABLE IF EXISTS `tblImportBill6`;
CREATE TABLE `tblImportBill6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `importDate` DATETIME NOT NULL,
    `note` VARCHAR(255),
    `tblSupplier6id` INT,
    `tblInventoryStaff6id` INT,
    CONSTRAINT `fk_importbill_supplier` FOREIGN KEY (`tblSupplier6id`) REFERENCES `tblSupplier6`(`id`) ON DELETE SET NULL,
    CONSTRAINT `fk_importbill_staff` FOREIGN KEY (`tblInventoryStaff6id`) REFERENCES `tblInventoryStaff6`(`tblEmployee6id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 19. Bảng Chi tiết nhập phụ tùng
DROP TABLE IF EXISTS `tblImportDetail6`;
CREATE TABLE `tblImportDetail6` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `quantity` INT NOT NULL,
    `importPrice` FLOAT NOT NULL,
    `tblImportBill6id` INT NOT NULL,
    `tblSparePart6id` INT NOT NULL,
    CONSTRAINT `fk_importdetail_bill` FOREIGN KEY (`tblImportBill6id`) REFERENCES `tblImportBill6`(`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_importdetail_sparepart` FOREIGN KEY (`tblSparePart6id`) REFERENCES `tblSparePart6`(`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ==============================================================================
-- DỮ LIỆU MẪU CHUẨN KHỚP 100% CÁC MÃ ĐỊNH DANH VÀ KỊCH BẢN FINAL.DOCX
-- ==============================================================================

-- 1. Địa chỉ
INSERT INTO `tblAddress6` (`id`, `houseNumber`, `street`, `ward`, `district`, `city`) VALUES
(1, '123', 'Nguyễn Trãi', 'Thanh Xuân Trung', 'Thanh Xuân', 'Hà Nội'),
(2, '45', 'Trần Phú', 'Văn Quán', 'Hà Đông', 'Hà Nội'),
(3, '78', 'Giải Phóng', 'Đồng Tâm', 'Hai Bà Trưng', 'Hà Nội'),
(4, '12', 'Cầu Giấy', 'Dịch Vọng', 'Cầu Giấy', 'Hà Nội'),
(5, 'Lô 35', 'KCN Quang Minh', 'Quang Minh', 'Mê Linh', 'Hà Nội'),
(6, 'Lô B2', 'KCN Thăng Long', 'Kim Chung', 'Đông Anh', 'Hà Nội');

-- 2. Thành viên (KH001 -> id=1, KH008 -> id=8)
INSERT INTO `tblMember6` (`id`, `username`, `password`, `firstName`, `midName`, `lastName`, `dob`, `email`, `tel`, `role`, `note`, `tblAddress6id`) VALUES
(1, 'kh001', '123456', 'A', 'Văn', 'Nguyễn', '1980-01-01', 'anguyen@gmail.com', '0901234567', 'Customer', 'Khách hàng thân thiết VIP', 1),
(2, 'sales1', '123456', 'C', 'Văn', 'Lê', '1992-08-20', 'salec@garaman.vn', '0987654321', 'SalesStaff', 'Nhân viên bán hàng & cố vấn dịch vụ', 3),
(3, 'tech1', '123456', 'D', 'Văn', 'Phạm', '1990-11-10', 'techd@garaman.vn', '0971234567', 'Technician', 'Nhân viên kỹ thuật cơ máy', 3),
(4, 'tech2', '123456', 'E', 'Văn', 'Trần', '1993-02-14', 'teche@garaman.vn', '0979876543', 'Technician', 'Nhân viên kỹ thuật điện - điện lạnh', 2),
(5, 'ware1', '123456', 'Kho', 'Văn', 'Hoàng', '1988-09-09', 'ware@garaman.vn', '0961122334', 'InventoryStaff', 'Nhân viên quản lý kho', 4),
(6, 'admin', '123456', 'Quản', 'Văn', 'Nguyễn', '1985-05-15', 'manager@garaman.vn', '0912345678', 'Manager', 'Nhân viên quản lí điều hành', 4),
(8, 'kh008', '123456', 'B', 'Thị', 'Trần', '1985-06-18', 'btran@gmail.com', '0988765432', 'Customer', 'Khách hàng cá nhân', 2);

-- 3. Nhân viên & phân quyền
INSERT INTO `tblEmployee6` (`tblMember6id`, `position`) VALUES
(2, 'Cố vấn dịch vụ / Bán hàng'),
(3, 'Kỹ thuật viên cơ gầm máy'),
(4, 'Kỹ thuật viên điện lạnh ô tô'),
(5, 'Thủ kho phụ tùng'),
(6, 'Giám đốc vận hành gara');

INSERT INTO `tblManager6` (`tblEmployee6id`) VALUES (6);
INSERT INTO `tblSalesStaff6` (`tblEmployee6id`) VALUES (2);
INSERT INTO `tblTechnician6` (`tblEmployee6id`) VALUES (3), (4);
INSERT INTO `tblInventoryStaff6` (`tblEmployee6id`) VALUES (5);

-- 4. Khách hàng
INSERT INTO `tblCustomer6` (`tblMember6id`, `type`) VALUES
(1, 'VIP'),
(8, 'Cá nhân');

-- 5. Nhà cung cấp
INSERT INTO `tblSupplier6` (`id`, `name`, `taxCode`, `email`, `tel`, `desc`, `tblAddress6id`) VALUES
(1, 'Công ty TNHH Dầu nhớt Castrol BP Petco', '0300823456', 'contact@castrol.vn', '02838234567', 'Nhà cung cấp dầu nhớt và chất lỏng bôi trơn chính hãng', 5),
(2, 'Tổng kho Phụ tùng Ô tô Toyota Hà Nội', '0101234567', 'parts@toyotavn.com', '02437654321', 'Nhà phân phối linh kiện phụ tùng Toyota & Denso chính hãng', 6);

-- 6. Xe ô tô
INSERT INTO `tblCar6` (`id`, `plateNumber`, `brand`, `model`, `year`, `color`, `frameNumber`, `engineNumber`, `desc`, `tblCustomer6id`) VALUES
(1, '30A-123.45', 'Toyota', 'Camry', 2022, 'Đen', 'RL456789012', '2AR-FE89012', 'Xe gia đình bảo dưỡng định kỳ chính hãng', 1),
(2, '30F-999.88', 'Mazda', 'CX-5', 2021, 'Trắng', 'JM345678901', 'PE-VPS78901', 'Xe đi lại hàng ngày', 8);

-- 7. Danh mục Dịch vụ (DV001, DV002, DV003, DV004, DV008)
INSERT INTO `tblService6` (`id`, `name`, `price`, `estDuration`, `desc`, `warrantyNote`) VALUES
(1, 'Thay dầu động cơ', 150000, 30, 'Xả nhớt cũ, kiểm tra lọc nhớt, châm dầu nhớt mới đạt chuẩn định mức', 'Kiểm tra lại miễn phí trong vòng 7 ngày'),
(2, 'Bảo dưỡng cấp lớn 40.000 km', 1200000, 180, 'Kiểm tra toàn diện động cơ, gầm, phanh, hệ thống lái và thay thế các dung dịch tiêu hao', 'Bảo hành 3 tháng hoặc 5.000 km'),
(3, 'Thay dầu hộp số tự động', 200000, 45, 'Tuần hoàn xả và thay dầu hộp số tự động chuyên dụng bằng máy chuyên dụng', 'Bảo hành 1 tháng'),
(4, 'Cân chỉnh độ chụm và góc đặt bánh xe', 350000, 40, 'Cân chỉnh điện tử 3D góc đặt bánh xe chống mòn lốp và lệch lái', 'Bảo hành 1 tháng'),
(8, 'Vệ sinh giàn lạnh', 1200000, 90, 'Nội soi vệ sinh giàn lạnh điều hòa bằng dung dịch sinh học chuyên dụng không tháo taplo', 'Bảo hành 6 tháng');

-- 8. Danh mục Phụ tùng (PT005, PT012, PT023, PT031, PT045, PT006)
INSERT INTO `tblSparePart6` (`id`, `name`, `manufacturer`, `unit`, `unitPrice`, `importPriceRef`, `stockQuantity`, `desc`) VALUES
(5, 'Dầu nhớt Castrol 4L', 'Castrol - Việt Nam', 'Can (4 lít)', 450000, 360000, 25, 'Độ nhớt 10W-40, chuẩn API SN/CF, công nghệ phân tử bảo vệ động cơ'),
(6, 'Dầu hộp số tự động ATF WS 4L', 'Toyota', 'Can (4 lít)', 650000, 500000, 18, 'Dầu hộp số chuyên dùng cho xe số tự động 6 cấp và CVT'),
(12, 'Lọc dầu động cơ Toyota', 'Toyota Genuine Parts', 'Chiếc', 180000, 130000, 40, 'Lõi lọc giấy vi sợi cao cấp lọc sạch cặn bẩn bôi trơn'),
(23, 'Bộ má phanh trước Brembo', 'Brembo - Italy', 'Bộ', 1600000, 1250000, 15, 'Má phanh gốm ceramic chống ồn chịu nhiệt cao'),
(31, 'Nước làm mát động cơ cao cấp 4L', 'Castrol Radicool', 'Can (4 lít)', 220000, 160000, 30, 'Nước làm mát pha sẵn chống đông và chống sôi tản nhiệt tối ưu'),
(45, 'Lọc gió điều hòa than hoạt tính', 'Denso - Nhật Bản', 'Chiếc', 300000, 210000, 20, 'Lọc bụi mịn PM2.5 khử mùi ẩm mốc và khí độc trong khoang lái');

-- 9. Phiếu tiếp nhận xe (PNX102 -> id=102, PNX218 -> id=218, PNX305 -> id=305)
INSERT INTO `tblReceptionSlip6` (`id`, `receiveDate`, `currentKm`, `carStatus`, `status`, `tblCustomer6id`, `tblSalesStaff6id`, `tblCar6id`) VALUES
(102, '2026-02-15 08:30:00', 40500, 'Xe bảo dưỡng định kỳ cấp lớn 40.000km và thay thế phụ tùng hao mòn', 'Đã hoàn thành', 1, 2, 1),
(218, '2026-05-20 09:15:00', 45200, 'Xe bảo dưỡng định kỳ và thay dầu hộp số tự động', 'Đã hoàn thành', 1, 2, 1),
(305, '2026-08-18 10:00:00', 49800, 'Thay dầu nhớt động cơ và kiểm tra hệ thống phanh', 'Đã hoàn thành', 1, 2, 1),
(401, '2026-04-10 14:00:00', 30000, 'Bảo dưỡng cấp trung và thay dầu', 'Đã hoàn thành', 8, 2, 2),
(450, '2026-07-22 08:45:00', 35000, 'Thay má phanh và bảo dưỡng phanh', 'Đã hoàn thành', 8, 2, 2);

-- 10. Chi tiết dịch vụ theo Phiếu tiếp nhận
-- Phiếu 102 (PNX102): Dịch vụ = 1,200,000 (DV002) + 350,000 (DV004) + 1,200,000 (DV008) = 2,750,000 VNĐ
INSERT INTO `tblServiceAssignment6` (`id`, `actualPrice`, `status`, `note`, `tblReceptionSlip6id`, `tblService6id`, `tblTechnician6id`) VALUES
(1, 1200000, 'Hoàn thành', 'Bảo dưỡng cấp lớn 40.000 km hoàn tất', 102, 2, 3),
(2, 350000, 'Hoàn thành', 'Cân chỉnh độ chụm góc đặt bánh xe chuẩn 0 độ', 102, 4, 3),
(3, 1200000, 'Hoàn thành', 'Vệ sinh giàn lạnh sạch mùi thơm mát', 102, 8, 4),
-- Phiếu 218 (PNX218): Dịch vụ = 150k + 200k + 250k = 600,000 VNĐ
(4, 150000, 'Hoàn thành', 'Thay dầu động cơ', 218, 1, 3),
(5, 200000, 'Hoàn thành', 'Thay dầu hộp số tự động', 218, 3, 3),
(6, 250000, 'Hoàn thành', 'Bảo dưỡng phanh', 218, 4, 4),
-- Phiếu 305 (PNX305): Dịch vụ = 150k + 250k = 400,000 VNĐ
(7, 150000, 'Hoàn thành', 'Thay dầu động cơ', 305, 1, 3),
(8, 250000, 'Hoàn thành', 'Cân chỉnh bánh xe', 305, 4, 3),
-- Phiếu 401 (PNX401): Dịch vụ = 1,800,000 VNĐ
(9, 1200000, 'Hoàn thành', 'Bảo dưỡng cấp lớn', 401, 2, 4),
(10, 600000, 'Hoàn thành', 'Cân chỉnh góc lái và phanh', 401, 4, 3),
-- Phiếu 450 (PNX450): Dịch vụ = 1,200,000 VNĐ
(11, 1200000, 'Hoàn thành', 'Vệ sinh giàn lạnh', 450, 8, 4);

-- 11. Chi tiết phụ tùng sử dụng theo Phiếu tiếp nhận
-- Phiếu 102 (PNX102): Phụ tùng = 450k (PT005) + 180k (PT012) + 1,600k (PT023) + 220k (PT031) + 300k (PT045) = 2,750,000 VNĐ
-- -> TỔNG PHIẾU PNX102 = 2,750,000 + 2,750,000 = 5,500,000 VNĐ (KHỚP 100%)
INSERT INTO `tblUsedSparePart6` (`id`, `quantity`, `actualPrice`, `tblReceptionSlip6id`, `tblSparePart6id`) VALUES
(1, 1, 450000, 102, 5),
(2, 1, 180000, 102, 12),
(3, 1, 1600000, 102, 23),
(4, 1, 220000, 102, 31),
(5, 1, 300000, 102, 45),
-- Phiếu 218 (PNX218): Phụ tùng = 3,600,000 VNĐ -> TỔNG = 4,200,000 VNĐ (KHỚP 100%)
(6, 2, 650000, 218, 6),
(7, 1, 450000, 218, 5),
(8, 1, 180000, 218, 12),
(9, 1, 1600000, 218, 23),
(10, 1, 70000, 218, 31),
-- Phiếu 305 (PNX305): Phụ tùng = 2,400,000 VNĐ -> TỔNG = 2,800,000 VNĐ (KHỚP 100%)
(11, 1, 450000, 305, 5),
(12, 1, 180000, 305, 12),
(13, 1, 1600000, 305, 23),
(14, 1, 170000, 305, 45),
-- Phiếu 401 (PNX401): Phụ tùng = 3,200,000 VNĐ -> TỔNG = 5,000,000 VNĐ
(15, 2, 1600000, 401, 23),
-- Phiếu 450 (PNX450): Phụ tùng = 2,000,000 VNĐ -> TỔNG = 3,200,000 VNĐ
(16, 1, 1600000, 450, 23),
(17, 1, 400000, 450, 5);

-- 12. Hóa đơn thanh toán (HD102 -> id=102, HD218 -> id=218, HD305 -> id=305)
-- NV lập hóa đơn: Lê Văn C (id member = 2)
INSERT INTO `tblInvoice6` (`id`, `paymentDate`, `paymentMethod`, `note`, `tblReceptionSlip6id`, `tblSalesStaff6id`) VALUES
(102, '2026-02-15 11:30:00', 'Chuyển khoản', 'Đã thanh toán đủ qua chuyển khoản ngân hàng Vietcombank', 102, 2),
(218, '2026-05-20 12:00:00', 'Chuyển khoản', 'Thanh toán thành công qua mã QR', 218, 2),
(305, '2026-08-18 11:45:00', 'Tiền mặt', 'Đã thu tiền mặt tại quầy', 305, 2),
(401, '2026-04-10 16:30:00', 'Chuyển khoản', 'Thanh toán VietinBank', 401, 2),
(450, '2026-07-22 10:30:00', 'Chuyển khoản', 'Thanh toán chuyển khoản', 450, 2);

-- 13. Đơn nhập phụ tùng & chi tiết nhập
INSERT INTO `tblImportBill6` (`id`, `importDate`, `note`, `tblSupplier6id`, `tblInventoryStaff6id`) VALUES
(1, '2026-01-10 09:00:00', 'Nhập dầu nhớt Castrol đầu quý I', 1, 5),
(2, '2026-01-15 10:00:00', 'Nhập linh kiện má phanh và lọc gió Toyota', 2, 5);

INSERT INTO `tblImportDetail6` (`id`, `quantity`, `importPrice`, `tblImportBill6id`, `tblSparePart6id`) VALUES
(1, 50, 360000, 1, 5),
(2, 30, 160000, 1, 31),
(3, 60, 130000, 2, 12),
(4, 25, 1250000, 2, 23);
