package database;

import dataservice.UserInfoService;
import po.UserPO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zcy on 2016/5/9.
 *
 */
public class UserInfo implements UserInfoService{
    public UserPO getUserInfo(String id,String password){
        Connect co=new Connect();
        String sql="SELECT * FROM user where id = \'"+id+"\'"+" and password = \'"+password+"\'";
        ResultSet result = co.getResultSet(sql);

        UserPO userPO = new UserPO();
        List<String> stockList = new ArrayList<>();
        try {
            if(result.next()){
                userPO.setId(id);
                userPO.setPassword(password);

                //从selectstock表中找出该用户的所有自选股
                sql = "SELECT * FROM selectstock where userid = \'"+id+"\'";
                result = co.getResultSet(sql);
                while(result.next()){
                    stockList.add(result.getString(2));
                }
                userPO.setStockList(stockList);
            } //账号密码正确
            else{
                co.closeConnection();
                return null;
            } //账号或密码错误
        } catch (SQLException e) {
            e.printStackTrace();
        }
        co.closeConnection();
        return userPO;
    }

    public boolean register(String id,String password) throws SQLException {
        Connect co=new Connect();
        String sql="SELECT * FROM user where id = \'"+id+"\'";
        ResultSet result = co.getResultSet(sql);
        List<String> ids = new ArrayList<>();
        boolean exist = false;
        while (result.next()){
            ids.add(result.getString(1));
        }
        if(ids.contains(id)){
            exist = true;
        }
        co.closeConnection();

        if(!exist){
            co=new Connect();
            sql = "INSERT INTO user values (?,?)";
            PreparedStatement pstmt=co.getPreparedStatement(sql);

            pstmt.setString(1,id);
            pstmt.setString(2,password);
            pstmt.executeUpdate();

            co.closeConnection();
        }
        return !exist;
    }
}
