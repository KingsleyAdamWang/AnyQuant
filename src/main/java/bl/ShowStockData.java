package bl;

import bl.util.MyDate;
import database.GetStockData_DB;
import dataservice.ShowStockDataService;
import po.StockPO;
import po.Stock_everyMinutePO;
import vo.StockVO;
import vo.Stock_everyMinuteVO;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by zcy on 2016/3/8.
 *
 */
public class ShowStockData implements ShowStockDataService{

    /**
     * todo 刚开始默认加载最近一个月的数据
     * todo 然后每次选择日期后，给我一个方法，根据两个时间点返回数据，最好只返回多出的那部分数据
     */

    public StockVO getLatestStockData(String id) throws SQLException, IOException {
        GetStockData_DB getStockData_db = new GetStockData_DB();
        StockPO stockPO = getStockData_db.getLatestStock(id);
        return new StockVO(stockPO);
    }

    /**
     * @param id 股票代号
     * @return StockVO
     * @throws IOException 得到指定股票的历史数据（默认为最近一个月）
     */
    public StockVO getStockData(String id) throws IOException {
        GetStockData_DB getStockData = new GetStockData_DB();
        StockPO a = getStockData.getStockData_name(id, MyDate.getDate_NDaysAgo(38), MyDate.getDate_Today());
        return new StockVO(a);
    }

    /**
     * @param id 股票代号
     * @param d1 开始日期
     * @param d2 结束日期
     * @return StockVO
     * @throws IOException
     * 得到指定时间段内的股票数据
     */
    public StockVO getStockData(String id,String d1,String d2) throws IOException {
        GetStockData_DB getStockData = new GetStockData_DB();
        StockPO stockPO;
//        if(MyDate.compareDate(d2,MyDate.getDate_OneMonthAgo())==1){
//            stockPO = getStockData.getStockData_name(id,d1,MyDate.getDate_NDaysAgo(31));
//        } //如果结束日期超过30天前的日期，只返回多出的
//        else{
//            stockPO = getStockData.getStockData_name(id,d1,d2);
//        }
        stockPO = getStockData.getStockData_name(id,d1,d2);
        return new StockVO(stockPO);
    }

    public StockVO getStockDataForKDaily(String id) throws IOException {
        GetStockData_DB getStockData_db = new GetStockData_DB();
        StockPO stockPO = getStockData_db.getStockData_name(id,MyDate.getDate_NDaysAgo(100),MyDate.getDate_Today());
        return new StockVO(stockPO);
    }

    /**
     * @param id 股票代号
     * @return StockVO
     * @throws IOException
     * 给周K线提供数据
     */
    public StockVO getStockDataForKWeekly(String id) throws IOException {
        GetStockData_DB getStockData_db = new GetStockData_DB();
        StockPO stockPO = getStockData_db.getStockData_withInterval(id,5);
        return  new StockVO(stockPO);
    }

    /**
     * @param id 股票代号
     * @return StockVO
     * @throws IOException
     * 给月K线提供数据
     */
    public StockVO getStockDataForKMonthly(String id) throws IOException {
        GetStockData_DB getStockData_db = new GetStockData_DB();
        StockPO stockPO = getStockData_db.getStockData_withInterval(id,22);
        return  new StockVO(stockPO);
    }

    /**
     * @param id 股票代号
     * @return Stock_everyMinuteVO
     */
    public Stock_everyMinuteVO showTimeSeriesData(String id) throws SQLException {
        GetStockData_DB getStockData_db = new GetStockData_DB();
        Stock_everyMinutePO stock_everyMinutePO = getStockData_db.getTimeSeriesData(id);
        return new Stock_everyMinuteVO(stock_everyMinutePO);
    }
}
