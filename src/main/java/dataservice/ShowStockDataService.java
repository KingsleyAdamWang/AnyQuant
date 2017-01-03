package dataservice;

import vo.StockVO;
import vo.Stock_everyMinuteVO;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by zcy on 2016/6/1.
 *
 */
public interface ShowStockDataService {
    /**
     * @param id 股票代号
     * @return StockVO
     * @throws SQLException
     * @throws IOException
     * 得到最新一天的股票数据
     */
    public StockVO getLatestStockData(String id) throws SQLException, IOException;

    /**
     * @param id 股票代号
     * @return StockVO
     * @throws IOException 得到指定股票的历史数据（默认为最近一个月）
     */
    public StockVO getStockData(String id) throws IOException;

    /**
     * @param id 股票代号
     * @param d1 开始日期
     * @param d2 结束日期
     * @return StockVO
     * @throws IOException
     * 得到指定时间段内的股票数据
     */
    public StockVO getStockData(String id,String d1,String d2) throws IOException;

    /**
     * @param id 股票代号
     * @return StockVO
     * @throws IOException
     * 给日K线提供数据
     */
    public StockVO getStockDataForKDaily(String id) throws IOException;

    /**
     * @param id 股票代号
     * @return StockVO
     * @throws IOException
     * 给周K线提供数据
     */
    public StockVO getStockDataForKWeekly(String id) throws IOException;
    /**
     * @param id 股票代号
     * @return StockVO
     * @throws IOException
     * 给月K线提供数据
     */
    public StockVO getStockDataForKMonthly(String id) throws IOException;
    /**
     * @param id 股票代号
     * @return Stock_everyMinuteVO
     */
    public Stock_everyMinuteVO showTimeSeriesData(String id) throws SQLException;
}
