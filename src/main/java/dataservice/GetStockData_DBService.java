package dataservice;

import po.StockPO;
import po.Stock_everyMinutePO;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by zcy on 2016/5/30.
 *
 */
public interface GetStockData_DBService {
    /**
     * @param name 股票名称
     * @param date1 开始日期
     * @param date2 结束日期
     * @return StockPO
     * 根据股票ID和起止日期从数据库中得到股票信息
     */
    public StockPO getStockData_name(String name, String date1, String date2);
    /**
     * @return List<StockPO>
     * 得到所有银行股数据（近一个月的）
     */
    public List<StockPO> getAllStock();
    /**
     * @return StockPO
     * 得到数据库中某支股票最新一天的股票数据
     */
    public StockPO getLatestStock(String id) throws SQLException;

    public List<StockPO> getLatestStock() throws SQLException;
    /**
     * @param id 股票代号
     * @return StockPO
     * 股票数据日期不连续
     */
    public StockPO getStockData_withInterval(String id,int interval);
    /**
     * @param id 股票代号
     * @return Stock_everyMinutePO
     * 得到指定股票分时图的数据
     */
    public Stock_everyMinutePO getTimeSeriesData(String id) throws SQLException;
}
