package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Customer6;
import model.FullName6;
import model.InventoryStaff6;
import model.Manager6;
import model.Member6;
import model.SalesStaff6;
import model.Technician6;

/**
 * DAO xu ly truy xuat va xac thuc thanh vien (Member6)
 * Ho tro dang nhap phan quyen theo role: Customer (Modul 1), Manager (Modul 2)
 */
public class Member6DAO extends DAO {

    public Member6DAO() {
        super();
    }

    /**
     * Kiem tra thong tin dang nhap cua thanh vien
     * @param username ten dang nhap
     * @param password mat khau
     * @return doi tuong Member6 dung lop con theo vai tro neu dung, null neu sai
     */
    public Member6 checkLogin(String username, String password) {
        if (username == null || password == null) {
            close();
            return null;
        }
        initConnection();
        if (con == null) return null;

        String sql = "SELECT m.id, m.username, m.password, m.firstName, m.midName, m.lastName, " +
                     "       m.dob, m.email, m.tel, m.role, m.note " +
                     "FROM tblMember6 m " +
                     "WHERE m.username = ? AND m.password = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username.trim());
            ps.setString(2, password.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String role = rs.getString("role");
                    Member6 member;
                    if ("Manager".equalsIgnoreCase(role)) {
                        member = new Manager6();
                    } else if ("SalesStaff".equalsIgnoreCase(role)) {
                        member = new SalesStaff6();
                    } else if ("InventoryStaff".equalsIgnoreCase(role)) {
                        member = new InventoryStaff6();
                    } else if ("Technician".equalsIgnoreCase(role)) {
                        member = new Technician6();
                    } else {
                        member = new Customer6();
                    }
                    member.setId(rs.getInt("id"));
                    member.setUsername(rs.getString("username"));
                    member.setPassword(rs.getString("password"));
                    member.setDob(rs.getDate("dob"));
                    member.setEmail(rs.getString("email"));
                    member.setTel(rs.getString("tel"));
                    member.setRole(role);
                    member.setNote(rs.getString("note"));

                    FullName6 fn = new FullName6(
                        rs.getInt("id"),
                        rs.getString("firstName"),
                        rs.getString("midName"),
                        rs.getString("lastName")
                    );
                    member.setFullName(fn);

                    return member;
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
