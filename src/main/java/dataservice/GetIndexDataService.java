package dataservice;

import po.CurrentIndexPO;
import po.IndexPO;

import java.io.IOException;

/**
 * Created by zcy on 2016/3/9.
 *
 */
public interface GetIndexDataService {
    /**
     * 得到最新的大盘数据
     *
     * @return IndexPO
     */
    IndexPO getLatestIndexData() throws IOException;
    /**
     * @param date1 开始日期
     * @param date2 结束日期
     * @return IndexPO
     * @throws IOException
     * date1和date2的格式是yyyyMMdd
     */
    public IndexPO getIndexDataBetween(String date1,String date2) throws IOException;
    /**
     * @return IndexPO
     * 得到最新一天的大盘数据
     */
    public CurrentIndexPO getCurrentIndexData();
}
