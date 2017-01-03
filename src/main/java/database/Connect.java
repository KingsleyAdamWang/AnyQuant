package database;

import java.sql.*;

/**
 * Created by zcy on 2016/5/3.
 *  172.26.27.105
 *  127.0.0.1
 *  114.212.43.242 172.28.130.120
 *  server 182.254.145.76
 */

public class Connect {
    private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://"+"127.0.0.1"+":3306/anyquant?useUnicode=true&characterEncoding=utf-8";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet result = null;

    public PreparedStatement getPreparedStatement(String sql) {

        try {
            Class.forName(Connect.DB_DRIVER);
            conn = DriverManager.getConnection(Connect.DB_URL, Connect.DB_USER, Connect.DB_PASS);
            pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return pstmt;
    }

    public ResultSet getResultSet(String sql) {

        try {
            pstmt = getPreparedStatement(sql);
            result = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public void closeConnection() {
        try {
            if (result != null) {
                result.close();
            }

            pstmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
