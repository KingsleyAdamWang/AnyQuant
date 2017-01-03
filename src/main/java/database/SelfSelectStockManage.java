package database;

import dataservice.SelfSelectStockManageService;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zcy on 2016/5/14.
 *
 */
public class SelfSelectStockManage implements SelfSelectStockManageService {
    /**
     * @param userid 用户账号
     * @return List<String>
     * 得到这个用户所有自选股代号
     */
    public List<String> getAllInterestedStock(String userid) {
        List<String> stocks = new ArrayList<>();
        Connect co = new Connect();
        String sql = "SELECT * FROM selectstock where userid = \'" + userid + "\'";
        ResultSet result = co.getResultSet(sql);

        try {
            while (result.next()) {
                stocks.add(result.getString(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return stocks;
    }

    /**
     * @param userid  用户账号
     * @param stockid 向数据库中添加该用户的自选股
     */
    public boolean addSelfSelectStock(String userid, String stockid) {
        if (hasTheStock(userid, stockid)) {
            return false; //如果已经添加过了，直接返回
        }
        Connect co = new Connect();
        String sql = "insert into selectstock values (?,?)";
        PreparedStatement pstmt = co.getPreparedStatement(sql);
        try {
            pstmt.setString(1, userid);
            pstmt.setString(2, stockid);
            pstmt.executeUpdate();
            co.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * @param userid  用户账号
     * @param stockid 从数据库中删除该用户自选股
     */
    public boolean removeSelfSelectStock(String userid, String stockid) {
        Connect co = new Connect();
        String sql = "DELETE FROM selectstock WHERE userid = ? and stockid = ?";
        PreparedStatement pstmt = co.getPreparedStatement(sql);
        try {
            pstmt.setString(1, userid);
            pstmt.setString(2, stockid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        co.closeConnection();
        return true;
    }

    /**
     * @param userid   用户id
     * @param stockids 该用户选中的所有股票id
     *                 根据用户选中的那些股票替换掉原来的自选股
     */
    public boolean replaceSelfSelectStock(String userid, List<String> stockids) {
        Connect co = new Connect();
        String sql = "DELETE FROM selectstock WHERE userid = ? ";
        PreparedStatement pstmt = co.getPreparedStatement(sql);
        try {
            pstmt.setString(1, userid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        co.closeConnection();

        co = new Connect();
        sql = "insert into selectstock values (?,?)";
        pstmt = co.getPreparedStatement(sql);

        for (int i = 0; i < stockids.size(); i++) {
            try {
                pstmt.setString(1, userid);
                pstmt.setString(2, stockids.get(i));
                pstmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }

        }
        co.closeConnection();
        return true;
    }

    /**
     * @param userid  用户账号
     * @param stockid 股票代号
     * @return boolean
     * 判断该用户是否已经将该股票添加进自选
     */
    public boolean hasTheStock(String userid, String stockid) {
        Connect co = new Connect();
        String sql = "SELECT * FROM selectstock where userid = \'" + userid + "\'" + "and stockid = \'" + stockid + "\'";
        ResultSet result = co.getResultSet(sql);
        try {
            if (result.next()) {
                co.closeConnection();
                return true;
            } else {
                co.closeConnection();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        co.closeConnection();
        return false;
    }
}
