package dataservice;

import po.BusinessNewsPO;

import java.util.List;

/**
 * Created by zcy on 2016/5/30.
 *
 */
public interface GetBusinessNewsService {
    /**
     * @return List<BusinessNewsPO>
     * 从数据库中得到行业新闻
     */
    public List<BusinessNewsPO> getBusinessNews();

}
