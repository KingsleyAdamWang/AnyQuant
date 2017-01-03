package bl;

import bl.util.MyDate;
import blservice.ShowIndexDataService;
import data.GetIndexData;
import database.GetIndexData_DB;
import dataservice.GetIndexDataService;
import po.CurrentIndexPO;
import po.IndexPO;
import vo.CurrentIndexVO;
import vo.IndexVO;
import vo.StockVO;

import java.io.IOException;

/**
 * Created by zcy on 2016/3/9.
 *
 */
public class ShowIndexData implements ShowIndexDataService{

    /**
     * @return IndexVO
     * @throws IOException
     * 得到最新的大盘数据（默认为2012-10-10至今）
     */
    public IndexVO getLatestIndexData() throws IOException {
        GetIndexData_DB getIndexData = new GetIndexData_DB();
        IndexPO indexPO = getIndexData.getLatestIndexData();
        IndexVO indexVO = new IndexVO(indexPO);
        return indexVO;
    }

    /**
     * @return IndexVO
     * 得到近来一个月的大盘数据
     */
    public IndexVO getIndexData_aMonth(){
        return getIndexDataBetween(MyDate.getDate_OneMonthAgo(),MyDate.getDate_Today());
    }
    /**
     * @param date1 开始日期
     * @param date2 结束日期
     * @return indexVO
     * 得到指定时间段内的大盘数据
     */
    public IndexVO getIndexDataBetween(String date1,String date2){
        GetIndexData_DB getIndexData = new GetIndexData_DB();
        IndexPO indexPO = getIndexData.getIndexDataBetween(date1,date2);
        return new IndexVO(indexPO);
    }

    /**
     * @return IndexVO
     * 给周k线提供大盘数据
     */
    public IndexVO getIndexDataForKWeekly(){
        GetIndexData_DB getIndexData_db = new GetIndexData_DB();
        IndexPO indexPO = getIndexData_db.getIndexData_withInterval(5);
        return new IndexVO(indexPO);
    }

    /**
     * @return IndexVO
     * 给月k线提供大盘数据
     */
    public IndexVO getIndexDataForKMonthly(){
        GetIndexData_DB getIndexData_db = new GetIndexData_DB();
        IndexPO indexPO = getIndexData_db.getIndexData_withInterval(22);
        return new IndexVO(indexPO);
    }

    public CurrentIndexVO showCurrentIndexData(){
        GetIndexData getIndexData = new GetIndexData();
        CurrentIndexPO currentIndexPO = getIndexData.getCurrentIndexData();
        return new CurrentIndexVO(currentIndexPO);
    }

}
