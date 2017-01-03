package blservice;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

/**
 * Created by zcy on 2016/3/4.
 * <p>
 * 自选股票逻辑接口
 * 负责管理自选股票的添加与删除
 */
public interface ManageSelfSelectStockService {
    public List<String> getAllInterestedStock(String userid);
    public boolean addSelfSelectStock(String userid,String stockid);
    public boolean removeSelfSelectStock(String userid,String stockid);
    public List<String> getAllStockID();
    public boolean replaceSelfSelectStock(String userid,List<String> stockids) throws SQLException;
    public boolean hasTheStock(String userid,String stockid);

}
