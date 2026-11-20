package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.SparePart6;

/**
 * DAO xu ly truy xuat thong tin Phu tung (Modul 1: Tim kiem thong tin dich vu & phu tung)
 */
public class SparePart6DAO extends DAO {

    public SparePart6DAO() {
        super();
    }

    /**
     * Tim kiem danh sach phu tung co ten chua tu khoa
     * @param keyWord tu khoa nguoi dung nhap
     * @return danh sach cac phu tung phu hop
     */
    public List<SparePart6> searchSparePart(String keyWord) {
        List<SparePart6> list = new ArrayList<>();
        initConnection();
        if (con == null) return list;

        String sql = "SELECT id, name, manufacturer, unit, unitPrice, importPriceRef, stockQuantity, `desc` " +
                     "FROM tblSparePart6 " +
                     "WHERE name LIKE ? " +
                     "ORDER BY id ASC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            String kw = "%" + (keyWord != null ? keyWord.trim() : "") + "%";
            ps.setString(1, kw);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SparePart6 sp = new SparePart6();
                    sp.setId(rs.getInt("id"));
                    sp.setName(rs.getString("name"));
                    sp.setManufacturer(rs.getString("manufacturer"));
                    sp.setUnit(rs.getString("unit"));
                    sp.setUnitPrice(rs.getFloat("unitPrice"));
                    sp.setImportPriceRef(rs.getFloat("importPriceRef"));
                    sp.setStockQuantity(rs.getInt("stockQuantity"));
                    sp.setDesc(rs.getString("desc"));
                    list.add(sp);
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
     * Lay thong tin chi tiet cua mot phu tung theo id
     * @param sparePartId ma id phu tung
     * @return doi tuong SparePart6 day du thong tin, hoac null neu khong tim thay
     */
    public SparePart6 getSparePartDetail(int sparePartId) {
        initConnection();
        if (con == null) return null;

        String sql = "SELECT id, name, manufacturer, unit, unitPrice, importPriceRef, stockQuantity, `desc` " +
                     "FROM tblSparePart6 WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, sparePartId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    SparePart6 sp = new SparePart6();
                    sp.setId(rs.getInt("id"));
                    sp.setName(rs.getString("name"));
                    sp.setManufacturer(rs.getString("manufacturer"));
                    sp.setUnit(rs.getString("unit"));
                    sp.setUnitPrice(rs.getFloat("unitPrice"));
                    sp.setImportPriceRef(rs.getFloat("importPriceRef"));
                    sp.setStockQuantity(rs.getInt("stockQuantity"));
                    sp.setDesc(rs.getString("desc"));
                    return sp;
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
