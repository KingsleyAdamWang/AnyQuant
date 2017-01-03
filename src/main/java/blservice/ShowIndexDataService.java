package blservice;

import vo.IndexVO;

import java.io.IOException;

/**
 * Created by zcy on 2016/3/19.
 *
 */
public interface ShowIndexDataService {
    public IndexVO getLatestIndexData() throws IOException;
    public IndexVO getIndexDataBetween(String date1,String date2);
    public IndexVO getIndexDataForKWeekly();
    public IndexVO getIndexDataForKMonthly();
}
