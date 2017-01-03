package dataservice;

import po.IndexPO;

/**
 * Created by zcy on 2016/5/30.
 *
 */
public interface GetIndexData_DBService {
    /**
     * @param date1 开始日期
     * @param date2 结束日期
     * @return IndexPO
     * 根据起止日期从数据库中读取大盘数据
     */
    public IndexPO getIndexDataBetween(String date1, String date2);
    /**
     * @return IndexPO
     * 得到最新的大盘数据（默认为2012-10-10至今）
     */
    public IndexPO getLatestIndexData();
    /**
     * @return IndexPO
     * 大盘数据日期不连续
     */
    public IndexPO getIndexData_withInterval(int interval);

}
