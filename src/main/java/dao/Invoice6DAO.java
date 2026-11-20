package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Car6;
import model.Customer6;
import model.FullName6;
import model.Invoice6;
import model.ReceptionSlip6;
import model.SalesStaff6;
import model.Service6;
import model.ServiceAssignment6;
import model.SparePart6;
import model.Technician6;
import model.UsedSparePart6;

/**
 * DAO xu ly truy xuat Chi tiet hoa don thanh toan (Modul 2)
 */
public class Invoice6DAO extends DAO {

    public Invoice6DAO() {
        super();
    }

    /**
     * Lay chi tiet hoa don thanh toan gan voi phieu tiep nhan slipId
     * Bao gom:
     * - Thong tin hoa don (ma, ngay thanh toan, hinh thuc, nhan vien ban hang lap)
     * - Thong tin khach hang va xe
     * - Danh sach cac hang muc dich vu (ServiceAssignment6) kem ky thuat vien
     * - Danh sach cac phu tung thay the (UsedSparePart6) kem so luong, don gia
     * @param slipId ma id phieu tiep nhan
     * @return doi tuong Invoice6 day du thong tin chi tiet, hoac null neu chua co hoa don
     */
    public Invoice6 getInvoiceDetail(int slipId) {
        initConnection();
        if (con == null) return null;

        Invoice6 invoice = null;

        try {
            // 1. Lay thong tin hoa don + phieu tiep nhan + khach hang + xe + nhan vien ban hang
            String sqlInv = "SELECT " +
                            "    inv.id AS inv_id, inv.paymentDate, inv.paymentMethod, inv.note AS inv_note, " +
                            "    rs.id AS slip_id, rs.receiveDate, rs.currentKm, rs.carStatus, rs.status AS slip_status, " +
                            "    cust_m.id AS cust_id, cust_m.firstName AS cust_fn, cust_m.midName AS cust_mn, cust_m.lastName AS cust_ln, cust_m.tel AS cust_tel, " +
                            "    car.id AS car_id, car.plateNumber, car.brand, car.model, car.year, " +
                            "    staff_m.id AS staff_id, staff_m.firstName AS staff_fn, staff_m.midName AS staff_mn, staff_m.lastName AS staff_ln " +
                            "FROM tblInvoice6 inv " +
                            "JOIN tblReceptionSlip6 rs ON inv.tblReceptionSlip6id = rs.id " +
                            "LEFT JOIN tblCustomer6 cust ON rs.tblCustomer6id = cust.tblMember6id " +
                            "LEFT JOIN tblMember6 cust_m ON cust.tblMember6id = cust_m.id " +
                            "LEFT JOIN tblCar6 car ON rs.tblCar6id = car.id " +
                            "LEFT JOIN tblSalesStaff6 staff ON inv.tblSalesStaff6id = staff.tblEmployee6id " +
                            "LEFT JOIN tblEmployee6 emp ON staff.tblEmployee6id = emp.tblMember6id " +
                            "LEFT JOIN tblMember6 staff_m ON emp.tblMember6id = staff_m.id " +
                            "WHERE rs.id = ?";

            try (PreparedStatement ps = con.prepareStatement(sqlInv)) {
                ps.setInt(1, slipId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        invoice = new Invoice6();
                        invoice.setId(rs.getInt("inv_id"));
                        invoice.setPaymentDate(rs.getTimestamp("paymentDate"));
                        invoice.setPaymentMethod(rs.getString("paymentMethod"));
                        invoice.setNote(rs.getString("inv_note"));

                        // SalesStaff
                        int staffId = rs.getInt("staff_id");
                        if (staffId > 0) {
                            SalesStaff6 staff = new SalesStaff6();
                            staff.setId(staffId);
                            FullName6 staffFn = new FullName6(
                                staffId,
                                rs.getString("staff_fn"),
                                rs.getString("staff_mn"),
                                rs.getString("staff_ln")
                            );
                            staff.setFullName(staffFn);
                            invoice.setSalesStaff(staff);
                        }

                        // ReceptionSlip
                        ReceptionSlip6 slip = new ReceptionSlip6();
                        slip.setId(rs.getInt("slip_id"));
                        slip.setReceiveDate(rs.getTimestamp("receiveDate"));
                        slip.setCurrentKm(rs.getInt("currentKm"));
                        slip.setCarStatus(rs.getString("carStatus"));
                        slip.setStatus(rs.getString("slip_status"));

                        // Customer
                        int custId = rs.getInt("cust_id");
                        if (custId > 0) {
                            Customer6 cust = new Customer6();
                            cust.setId(custId);
                            cust.setTel(rs.getString("cust_tel"));
                            FullName6 custFn = new FullName6(
                                custId,
                                rs.getString("cust_fn"),
                                rs.getString("cust_mn"),
                                rs.getString("cust_ln")
                            );
                            cust.setFullName(custFn);
                            slip.setCustomer(cust);
                        }

                        // Car
                        int carId = rs.getInt("car_id");
                        if (carId > 0) {
                            Car6 car = new Car6();
                            car.setId(carId);
                            car.setPlateNumber(rs.getString("plateNumber"));
                            car.setBrand(rs.getString("brand"));
                            car.setModel(rs.getString("model"));
                            car.setYear(rs.getInt("year"));
                            slip.setCar(car);
                        }

                        invoice.setReceptionSlip(slip);
                    }
                }
            }

            if (invoice == null || invoice.getReceptionSlip() == null) {
                return null;
            }

            int actualSlipId = invoice.getReceptionSlip().getId();

            // 2. Lay danh sach chi tiet dich vu (ServiceAssignment6)
            String sqlSa = "SELECT " +
                           "    sa.id AS sa_id, sa.actualPrice, sa.status AS sa_status, sa.note AS sa_note, " +
                           "    svc.id AS svc_id, svc.name AS svc_name, svc.price AS svc_price, svc.estDuration, " +
                           "    tech_m.id AS tech_id, tech_m.firstName AS tech_fn, tech_m.midName AS tech_mn, tech_m.lastName AS tech_ln " +
                           "FROM tblServiceAssignment6 sa " +
                           "JOIN tblService6 svc ON sa.tblService6id = svc.id " +
                           "LEFT JOIN tblTechnician6 tech ON sa.tblTechnician6id = tech.tblEmployee6id " +
                           "LEFT JOIN tblEmployee6 emp ON tech.tblEmployee6id = emp.tblMember6id " +
                           "LEFT JOIN tblMember6 tech_m ON emp.tblMember6id = tech_m.id " +
                           "WHERE sa.tblReceptionSlip6id = ? " +
                           "ORDER BY sa.id ASC";

            List<ServiceAssignment6> saList = new ArrayList<>();
            try (PreparedStatement ps = con.prepareStatement(sqlSa)) {
                ps.setInt(1, actualSlipId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        ServiceAssignment6 sa = new ServiceAssignment6();
                        sa.setId(rs.getInt("sa_id"));
                        sa.setActualPrice(rs.getFloat("actualPrice"));
                        sa.setStatus(rs.getString("sa_status"));
                        sa.setNote(rs.getString("sa_note"));

                        Service6 s = new Service6();
                        s.setId(rs.getInt("svc_id"));
                        s.setName(rs.getString("svc_name"));
                        s.setPrice(rs.getFloat("svc_price"));
                        s.setEstDuration(rs.getInt("estDuration"));
                        sa.setService(s);

                        int techId = rs.getInt("tech_id");
                        if (techId > 0) {
                            Technician6 tech = new Technician6();
                            tech.setId(techId);
                            FullName6 techFn = new FullName6(
                                techId,
                                rs.getString("tech_fn"),
                                rs.getString("tech_mn"),
                                rs.getString("tech_ln")
                            );
                            tech.setFullName(techFn);
                            sa.setTechnician(tech);
                        }

                        saList.add(sa);
                    }
                }
            }
            invoice.getReceptionSlip().setServiceAssignments(saList);

            // 3. Lay danh sach chi tiet phu tung su dung (UsedSparePart6)
            String sqlSp = "SELECT " +
                           "    usp.id AS usp_id, usp.quantity, usp.actualPrice, " +
                           "    sp.id AS sp_id, sp.name AS sp_name, sp.manufacturer, sp.unit, sp.unitPrice " +
                           "FROM tblUsedSparePart6 usp " +
                           "JOIN tblSparePart6 sp ON usp.tblSparePart6id = sp.id " +
                           "WHERE usp.tblReceptionSlip6id = ? " +
                           "ORDER BY usp.id ASC";

            List<UsedSparePart6> uspList = new ArrayList<>();
            try (PreparedStatement ps = con.prepareStatement(sqlSp)) {
                ps.setInt(1, actualSlipId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        UsedSparePart6 usp = new UsedSparePart6();
                        usp.setId(rs.getInt("usp_id"));
                        usp.setQuantity(rs.getInt("quantity"));
                        usp.setActualPrice(rs.getFloat("actualPrice"));

                        SparePart6 sp = new SparePart6();
                        sp.setId(rs.getInt("sp_id"));
                        sp.setName(rs.getString("sp_name"));
                        sp.setManufacturer(rs.getString("manufacturer"));
                        sp.setUnit(rs.getString("unit"));
                        sp.setUnitPrice(rs.getFloat("unitPrice"));
                        usp.setSparePart(sp);

                        uspList.add(usp);
                    }
                }
            }
            invoice.getReceptionSlip().setUsedSpareParts(uspList);

            // Cap nhat tong tien hoa don
            invoice.setTotalAmount(invoice.getReceptionSlip().getTotalAmount());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return invoice;
    }
}
