package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Service6;

/**
 * DAO xu ly truy xuat thong tin Dich vu (Modul 1: Tim kiem thong tin dich vu & phu tung)
 */
public class Service6DAO extends DAO {

    public Service6DAO() {
        super();
    }

    /**
     * Tim kiem danh sach dich vu co ten chua tu khoa
     * @param keyWord tu khoa nguoi dung nhap
     * @return danh sach cac dich vu phu hop
     */
    public List<Service6> searchService(String keyWord) {
        List<Service6> list = new ArrayList<>();
        initConnection();
        if (con == null) return list;

        String sql = "SELECT id, name, price, estDuration, `desc`, warrantyNote " +
                     "FROM tblService6 " +
                     "WHERE name LIKE ? " +
                     "ORDER BY id ASC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            String kw = "%" + (keyWord != null ? keyWord.trim() : "") + "%";
            ps.setString(1, kw);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service6 s = new Service6();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setPrice(rs.getFloat("price"));
                    s.setEstDuration(rs.getInt("estDuration"));
                    s.setDesc(rs.getString("desc"));
                    s.setWarrantyNote(rs.getString("warrantyNote"));
                    list.add(s);
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
     * Lay thong tin chi tiet cua mot dich vu theo id
     * @param serviceId ma id dich vu
     * @return doi tuong Service6 day du thong tin, hoac null neu khong tim thay
     */
    public Service6 getServiceDetail(int serviceId) {
        initConnection();
        if (con == null) return null;

        String sql = "SELECT id, name, price, estDuration, `desc`, warrantyNote " +
                     "FROM tblService6 WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Service6 s = new Service6();
                    s.setId(rs.getInt("id"));
                    s.setName(rs.getString("name"));
                    s.setPrice(rs.getFloat("price"));
                    s.setEstDuration(rs.getInt("estDuration"));
                    s.setDesc(rs.getString("desc"));
                    s.setWarrantyNote(rs.getString("warrantyNote"));
                    return s;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return null;
    }
}
