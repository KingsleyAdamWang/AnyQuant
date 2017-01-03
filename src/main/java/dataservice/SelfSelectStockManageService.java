package dataservice;

import java.util.List;

/**
 * Created by zcy on 2016/5/30.
 *
 */
public interface SelfSelectStockManageService {
    /**
     * @param userid 用户账号
     * @return List<String>
     * 得到这个用户所有自选股代号
     */
    public List<String> getAllInterestedStock(String userid);
    /**
     * @param userid 用户账号
     * @param stockid
     * 向数据库中添加该用户的自选股
     */
    public boolean addSelfSelectStock(String userid,String stockid);
    /**
     * @param userid 用户账号
     * @param stockid
     * 从数据库中删除该用户自选股
     */
    public boolean removeSelfSelectStock(String userid,String stockid);
    /**
     * @param userid 用户id
     * @param stockids 该用户选中的所有股票id
     * 根据用户选中的那些股票替换掉原来的自选股
     */
    public boolean replaceSelfSelectStock(String userid,List<String> stockids);
    /**
     * @param userid 用户账号
     * @param stockid 股票代号
     * @return boolean
     * 判断该用户是否已经将该股票添加进自选
     */
    public boolean hasTheStock(String userid,String stockid);
}
