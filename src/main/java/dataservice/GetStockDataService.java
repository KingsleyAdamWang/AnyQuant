package dataservice;

import po.StockPO;

import java.io.IOException;
import java.util.List;

/**
 * Created by zcy on 2016/3/8.
 *
 */
public interface GetStockDataService {
    /**
     * 根据股票的名称得到这支股票的数据（默认为近一个月的）
     *
     * @param name
     * @return StockPO
     */
    public StockPO getStockData_name(String name) throws IOException;
    /**
     * 得到指定日期的指定名称的股票数据(*)
     *
     * @param name
     * @param dates
     * @return StockPO
     */
    public StockPO getStockData_name(String name, String dates) throws IOException;
    /**
     * 得到指定时间段内的指定名称的股票
     *
     * @param name
     * @param date1
     * @param date2
     * @return StockPO
     */
    public StockPO getStockData_name(String name, String date1, String date2) throws IOException;
    /**
     * 得到所有我们感兴趣的股票数据（默认为近一个月的）
     *
     * @return List<StockPO>
     */
    public List<StockPO> getAllInterestedStock() throws IOException;
    /**
     * 得到指定日期的我们感兴趣的所有股票数据
     *
     * @param dates
     * @return List<StockPO>
     */
    public List<StockPO> getAllInterestedStock(String dates) throws IOException;
    /**
     * 得到指定时间段内的我们感兴趣的所有股票数据
     *
     * @param date1 开始日期
     * @param date2 结束日期
     * @return List<StockPO>
     */
    public List<StockPO> getAllInterestedStock(String date1, String date2) throws IOException;
}
