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

/**
 * DAO xu ly truy xuat Lich su sua xe (Phieu tiep nhan) cua khach hang (Modul 2)
 */
public class ReceptionSlip6DAO extends DAO {

    public ReceptionSlip6DAO() {
        super();
    }

    /**
     * Lay danh sach cac phieu tiep nhan sua xe cua khach hang theo customerId
     * Kem thong tin xe, hoa don va tong tien tung lan den sua.
     * @param customerId id cua khach hang (id thanh vien)
     * @return danh sach cac ReceptionSlip6
     */
    public List<ReceptionSlip6> getCustomerHistory(int customerId) {
        List<ReceptionSlip6> list = new ArrayList<>();
        initConnection();
        if (con == null) return list;

        String sql = "SELECT " +
                     "    rs.id AS slip_id, rs.receiveDate, rs.currentKm, rs.carStatus, rs.status AS slip_status, " +
                     "    car.id AS car_id, car.plateNumber, car.brand, car.model, car.year, car.color, " +
                     "    inv.id AS inv_id, inv.paymentDate, inv.paymentMethod, inv.note AS inv_note, " +
                     "    (COALESCE(sa_sum.total_sa, 0) + COALESCE(sp_sum.total_sp, 0)) AS totalAmount " +
                     "FROM tblReceptionSlip6 rs " +
                     "LEFT JOIN tblCar6 car ON rs.tblCar6id = car.id " +
                     "LEFT JOIN tblInvoice6 inv ON inv.tblReceptionSlip6id = rs.id " +
                     "LEFT JOIN ( " +
                     "    SELECT tblReceptionSlip6id, SUM(actualPrice) AS total_sa " +
                     "    FROM tblServiceAssignment6 " +
                     "    GROUP BY tblReceptionSlip6id " +
                     ") sa_sum ON sa_sum.tblReceptionSlip6id = rs.id " +
                     "LEFT JOIN ( " +
                     "    SELECT tblReceptionSlip6id, SUM(quantity * actualPrice) AS total_sp " +
                     "    FROM tblUsedSparePart6 " +
                     "    GROUP BY tblReceptionSlip6id " +
                     ") sp_sum ON sp_sum.tblReceptionSlip6id = rs.id " +
                     "WHERE rs.tblCustomer6id = ? " +
                     "ORDER BY rs.receiveDate ASC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReceptionSlip6 slip = new ReceptionSlip6();
                    slip.setId(rs.getInt("slip_id"));
                    slip.setReceiveDate(rs.getTimestamp("receiveDate"));
                    slip.setCurrentKm(rs.getInt("currentKm"));
                    slip.setCarStatus(rs.getString("carStatus"));
                    slip.setStatus(rs.getString("slip_status"));

                    Car6 car = new Car6();
                    car.setId(rs.getInt("car_id"));
                    car.setPlateNumber(rs.getString("plateNumber"));
                    car.setBrand(rs.getString("brand"));
                    car.setModel(rs.getString("model"));
                    car.setYear(rs.getInt("year"));
                    car.setColor(rs.getString("color"));
                    slip.setCar(car);

                    float totalAmt = rs.getFloat("totalAmount");
                    slip.setCalculatedTotal(totalAmt);

                    int invId = rs.getInt("inv_id");
                    if (invId > 0) {
                        Invoice6 inv = new Invoice6();
                        inv.setId(invId);
                        inv.setPaymentDate(rs.getTimestamp("paymentDate"));
                        inv.setPaymentMethod(rs.getString("paymentMethod"));
                        inv.setNote(rs.getString("inv_note"));
                        inv.setTotalAmount(totalAmt);
                        slip.setInvoice(inv);
                    }

                    list.add(slip);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    /**
     * Lay thong tin Khach hang kem danh sach Xe so huu theo id (de hien thi tren tieu de trang HistoryUI6)
     */
    public Customer6 getCustomerInfo(int customerId) {
        initConnection();
        if (con == null) return null;

        Customer6 cust = null;
        try {
            String sql = "SELECT m.id, m.username, m.email, m.tel, c.type, " +
                         "       m.firstName, m.midName, m.lastName " +
                         "FROM tblCustomer6 c " +
                         "JOIN tblMember6 m ON c.tblMember6id = m.id " +
                         "WHERE m.id = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, customerId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cust = new Customer6();
                        cust.setId(rs.getInt("id"));
                        cust.setUsername(rs.getString("username"));
                        cust.setEmail(rs.getString("email"));
                        cust.setTel(rs.getString("tel"));
                        cust.setType(rs.getString("type"));

                        FullName6 fn = new FullName6();
                        fn.setId(rs.getInt("id"));
                        fn.setFirstName(rs.getString("firstName"));
                        fn.setMidName(rs.getString("midName"));
                        fn.setLastName(rs.getString("lastName"));
                        cust.setFullName(fn);
                    }
                }
            }

            if (cust != null) {
                String sqlCars = "SELECT id, plateNumber, brand, model, year, color, frameNumber, engineNumber, `desc` " +
                                 "FROM tblCar6 WHERE tblCustomer6id = ? ORDER BY id ASC";
                List<Car6> cars = new ArrayList<>();
                try (PreparedStatement psCars = con.prepareStatement(sqlCars)) {
                    psCars.setInt(1, customerId);
                    try (ResultSet rsCars = psCars.executeQuery()) {
                        while (rsCars.next()) {
                            Car6 car = new Car6();
                            car.setId(rsCars.getInt("id"));
                            car.setPlateNumber(rsCars.getString("plateNumber"));
                            car.setBrand(rsCars.getString("brand"));
                            car.setModel(rsCars.getString("model"));
                            car.setYear(rsCars.getInt("year"));
                            car.setColor(rsCars.getString("color"));
                            car.setFrameNumber(rsCars.getString("frameNumber"));
                            car.setEngineNumber(rsCars.getString("engineNumber"));
                            car.setDesc(rsCars.getString("desc"));
                            car.setCustomer(cust);
                            cars.add(car);
                        }
                    }
                }
                cust.setCars(cars);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return cust;
    }
}
