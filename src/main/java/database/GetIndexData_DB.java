package database;


import bl.util.MyDate;
import data.GetIndexData;
import dataservice.GetIndexData_DBService;
import po.CurrentIndexPO;
import po.IndexPO;
import po.StockPO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


/**
 * Created by zcy on 2016/5/4.
 *
 */
public class GetIndexData_DB implements GetIndexData_DBService{
    /**
     * @param date1 开始日期
     * @param date2 结束日期
     * @return IndexPO
     * 根据起止日期从数据库中读取大盘数据
     */
    public IndexPO getIndexDataBetween(String date1, String date2){
        if(date1.charAt(4)!='-'){
            date1 = date1.substring(0,4)+"-"+date1.substring(4,6)+"-"+date1.substring(6);//给date1加上-
            date2 = date2.substring(0,4)+"-"+date2.substring(4,6)+"-"+date2.substring(6);//给date2加上-
        }//如果日期格式是yyyyMMdd，加上-

        Connect co=new Connect();
        String sql="SELECT * FROM indexinfo ";
        ResultSet result=co.getResultSet(sql);

        int num=0; //记录符合要求的行数
        IndexPO indexPO = null;
        try {
            while(result.next()){
                if((MyDate.compareDate(date1,result.getString(6))==0)&&(MyDate.compareDate(result.getString(6),date2)==0)
                        &&(result.getLong(2)!=0)&&(result.getDouble(3)!=0)){
                    num++;
                }
            }
            result.beforeFirst();//游标回到起始处
            indexPO = new IndexPO(num);
            long[] volume = new long[num];
            double[] high = new double[num];
            double[] adj_price = new double[num];
            double[] low = new double[num];
            double[] close = new double[num];
            double[] open = new double[num];
            String[] date = new String[num];
            double[] increase_decreaseRate = new double[num];
            double[] increase_decreaseNum = new double[num];

            int k = 0;
            while(result.next()){
                if((MyDate.compareDate(date1,result.getString(6))==0)&&(MyDate.compareDate(result.getString(6),date2)==0)
                        &&(result.getLong(2)!=0)&&(result.getDouble(3)!=0)){
                    volume[k] = result.getLong(2);
                    high[k] = result.getDouble(3);
                    adj_price[k] = result.getDouble(4);
                    low[k] = result.getDouble(5);
                    date[k] = result.getString(6);
                    close[k] = result.getDouble(7);
                    open[k] = result.getDouble(8);
                    increase_decreaseRate[k] = result.getDouble(9);
                    increase_decreaseNum[k] = result.getDouble(10);
                    k++;
                }
                if(k==num){
                    break;
                }
            }
            indexPO.setVolume(volume);
            indexPO.setHigh(high);
            indexPO.setAdj_price(adj_price);
            indexPO.setLow(low);
            indexPO.setDate(date);
            indexPO.setClose(close);
            indexPO.setOpen(open);
            indexPO.setIncrease_decreaseRate(increase_decreaseRate);
            indexPO.setIncrease_decreaseNum(increase_decreaseNum);
            indexPO.setName("hs300");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        co.closeConnection();

        return indexPO;
    }

    /**
     * @return IndexPO
     * 得到最新的大盘数据（默认为2012-10-10至今）
     */
    public IndexPO getLatestIndexData(){
        return getIndexDataBetween("2012-10-10",MyDate.getDate_Today());
    }


    /**
     * @return IndexPO
     * 大盘数据日期不连续
     */
    public IndexPO getIndexData_withInterval(int interval){
        Connect co=new Connect();
        String sql="SELECT * FROM indexinfo ";
        ResultSet result=co.getResultSet(sql);

        IndexPO indexPO = null;
        try {
            int size = 0;
            while(result.next()){
                size++;
            }
            int num = size/interval-1; //数据个数
            if(num>200){
                num = 200;//如果数据个数太多了，固定为200个
            }
            indexPO = new IndexPO(num);
            result.beforeFirst();
            long[] volume = new long[num];
            double[] high = new double[num];
            double[] adj_price = new double[num];
            double[] low = new double[num];
            String[] date = new String[num];
            double[] close = new double[num];
            double[] open = new double[num];
            double[] increase_decreaseRate = new double[num];
            double[] increase_decreaseNum = new double[num];
            int k = 0;
            int n = 0;
            for(;k<size-interval*num+1;k++){
                result.next();
            }
            k = 0;
            while(result.next()){
                if(k%interval==0){
                    volume[n] = result.getLong(2);
                    high[n] = result.getDouble(3);
                    adj_price[n] = result.getDouble(4);
                    low[n] = result.getDouble(5);
                    date[n] = result.getString(6);
                    close[n] = result.getDouble(7);
                    open[n] = result.getDouble(8);
                    increase_decreaseRate[n] = result.getDouble(9);
                    increase_decreaseNum[n] = result.getDouble(10);
                    n++;
                }
                if(n==num){
                    break;
                }
                k++;
            }
            indexPO.setName("hs300");
            indexPO.setVolume(volume);
            indexPO.setHigh(high);
            indexPO.setAdj_price(adj_price);
            indexPO.setLow(low);
            indexPO.setDate(date);
            indexPO.setClose(close);
            indexPO.setOpen(open);
            indexPO.setIncrease_decreaseRate(increase_decreaseRate);
            indexPO.setIncrease_decreaseNum(increase_decreaseNum);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        co.closeConnection();

        return indexPO;
    }


}
