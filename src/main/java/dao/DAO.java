package dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Lop co so quan ly ket noi JDBC toi CSDL MySQL
 * Ho tro doc cau hinh tu file db.properties tren classpath, co fallback mac dinh.
 */
public class DAO {
    protected Connection con;

    private static String dbUrl = "jdbc:mysql://localhost:3306/db_garaman?useUnicode=true&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh";
    private static String dbUser = "root";
    private static String dbPassword = "root";
    private static String dbDriver = "com.mysql.cj.jdbc.Driver";

    static {
        try {
            Properties prop = new Properties();
            InputStream in = DAO.class.getClassLoader().getResourceAsStream("db.properties");
            if (in != null) {
                prop.load(in);
                if (prop.getProperty("db.url") != null) dbUrl = prop.getProperty("db.url");
                if (prop.getProperty("db.user") != null) dbUser = prop.getProperty("db.user");
                if (prop.getProperty("db.password") != null) dbPassword = prop.getProperty("db.password");
                if (prop.getProperty("db.driver") != null) dbDriver = prop.getProperty("db.driver");
                in.close();
            }
        } catch (Exception e) {
            System.err.println("DAO: Khong doc duoc file db.properties, dung cau hinh mac dinh.");
        }

        try {
            Class.forName(dbDriver);
        } catch (ClassNotFoundException e) {
            System.err.println("DAO: Khong tim thay Driver MySQL: " + e.getMessage());
        }
    }

    public DAO() {
        initConnection();
    }

    protected void initConnection() {
        try {
            if (con == null || con.isClosed()) {
                try {
                    con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                } catch (SQLException e) {
                    // Fallback thu voi mat khau rong neu "root" that bai
                    if ("root".equals(dbPassword)) {
                        try {
                            con = DriverManager.getConnection(dbUrl, dbUser, "");
                        } catch (SQLException e2) {
                            throw e;
                        }
                    } else {
                        throw e;
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("DAO: Loi ket noi CSDL: " + e.getMessage());
        }
    }

    public Connection getConnection() {
        initConnection();
        return con;
    }

    public void close() {
        if (con != null) {
            try {
                if (!con.isClosed()) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                con = null;
            }
        }
    }
}
