package database;

import data.ReadData;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by zcy on 2016/5/24.
 * 从网页上每隔一分钟读取一次当前数据
 */
public class ReadCurrentData {
    public static void main(String[] args){
        ReadCurrentData readCurrentData = new ReadCurrentData();
        readCurrentData.readData();
    }

    private void readData(){
        Thread thread = new Thread(new doRead());
        thread.start();
    }

    private class doRead implements Runnable{
        public void run() {
            Connect co = new Connect();
            String sql = "INSERT INTO currentdata values (?,?,?,?,?,?,?)";
            PreparedStatement preparedStatement = co.getPreparedStatement(sql);
            while(true){
                ReadData rdt = new ReadData();
                for(int i=0;i<GetStockData_DB.stock_id.length;i++){
                    String url = "http://hq.sinajs.cn/list=" + GetStockData_DB.stock_id[i];
                    String s1 = null;
                    try {
                        s1 = rdt.getData(url);
                        String[] strings = s1.split(",");
                        double incNum = remain2bit(Double.parseDouble(strings[3])-Double.parseDouble(strings[2]));
                        double incRate = remain2bit(incNum/Double.parseDouble(strings[2])*100);
                        preparedStatement.setString(1,GetStockData_DB.stock_id[i]);
                        preparedStatement.setString(2,strings[31].substring(0,5));
                        preparedStatement.setString(3,strings[3]);
                        preparedStatement.setString(4,strings[8]);
                        preparedStatement.setString(5,"?");
                        preparedStatement.setString(6,incNum+"");
                        preparedStatement.setString(7,incRate+"");
                        preparedStatement.executeUpdate();
                    } catch (IOException | SQLException e) {
                        e.printStackTrace();
                    }
                }
                try {
                    Thread.sleep(60000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    private static double remain2bit(double a){
        return ((double)Math.round(a*100))/100;
    }
}
