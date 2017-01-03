package data;

import database.Connect;
import database.GetStockData_DB;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by zcy on 2016/5/14.
 * 根据股票ID得到中文名称
 */
public class StockId2Name {
    /**
     * @param id 股票代号
     * @return String
     * 根据股票ID从数据库中得到股票名称
     */
    public static String getStockName(String id){
        Connect co=new Connect();
        String sql="SELECT * FROM stockname where id = '"+id+"\'";
        ResultSet result=co.getResultSet(sql);
        String name = null;
        try {
            if(result.next()){
                name = result.getString(2);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        co.closeConnection();
        return name;
    }

    /**
     * @param name 股票名称
     * @return String
     * 根据股票名称从数据库中得到股票id
     */
    public static String getStockId(String name){
        Connect co=new Connect();
        String sql="SELECT * FROM stockname where name = '"+name+"\'";
        ResultSet result=co.getResultSet(sql);
        String id = null;
        try {
            if(result.next()){
                id = result.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        co.closeConnection();
        return id;
    }
}
