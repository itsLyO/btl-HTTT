package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import model.CustomerStats6;
import model.FullName6;

/**
 * DAO xu ly Thong ke khach hang theo doanh thu (Modul 2)
 */
public class CustomerStats6DAO extends DAO {

    public CustomerStats6DAO() {
        super();
    }

    /**
     * Lay danh sach thong ke khach hang theo doanh thu trong khoang thoi gian startDate den endDate
     * Doanh thu tinh bang tong tien cac dich vu va phu tung cua cac phieu tiep nhan da hoan thanh.
     * Sap xep giam dan theo tong doanh thu.
     * @param startDate ngay bat dau
     * @param endDate ngay ket thuc
     * @return danh sach doi tuong CustomerStats6
     */
    public List<CustomerStats6> getCustomerStats(Date startDate, Date endDate) {
        List<CustomerStats6> list = new ArrayList<>();
        initConnection();
        if (con == null) return list;

        String sql = "SELECT " +
                     "    m.id AS member_id, m.username, m.email, m.tel, c.type, " +
                     "    m.firstName, m.midName, m.lastName, " +
                     "    COUNT(DISTINCT rs.id) AS totalVisits, " +
                     "    (COALESCE(SUM(sa_sum.total_sa), 0) + COALESCE(SUM(sp_sum.total_sp), 0)) AS totalRevenue " +
                     "FROM tblCustomer6 c " +
                     "JOIN tblMember6 m ON c.tblMember6id = m.id " +
                     "JOIN tblReceptionSlip6 rs ON rs.tblCustomer6id = c.tblMember6id " +
                     "    AND rs.receiveDate >= ? AND rs.receiveDate <= ? " +
                     "    AND rs.status = 'Đã hoàn thành' " +
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
                     "GROUP BY m.id, m.username, m.email, m.tel, c.type, m.firstName, m.midName, m.lastName " +
                     "ORDER BY totalRevenue DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            Timestamp tsStart = new Timestamp(startDate.getTime());

            Calendar cal = Calendar.getInstance();
            cal.setTime(endDate);
            if (cal.get(Calendar.HOUR_OF_DAY) == 0 && cal.get(Calendar.MINUTE) == 0) {
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                cal.set(Calendar.MILLISECOND, 999);
            }
            Timestamp tsEnd = new Timestamp(cal.getTimeInMillis());

            ps.setTimestamp(1, tsStart);
            ps.setTimestamp(2, tsEnd);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CustomerStats6 cs = new CustomerStats6();
                    cs.setId(rs.getInt("member_id"));
                    cs.setUsername(rs.getString("username"));
                    cs.setEmail(rs.getString("email"));
                    cs.setTel(rs.getString("tel"));
                    cs.setType(rs.getString("type"));

                    FullName6 fn = new FullName6();
                    fn.setId(rs.getInt("member_id"));
                    fn.setFirstName(rs.getString("firstName"));
                    fn.setMidName(rs.getString("midName"));
                    fn.setLastName(rs.getString("lastName"));
                    cs.setFullName(fn);

                    cs.setTotalVisits(rs.getInt("totalVisits"));
                    cs.setTotalRevenue(rs.getFloat("totalRevenue"));

                    list.add(cs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }
}
