package bl;

import blservice.ManageSelfSelectStockService;
import database.GetStockData_DB;
import database.SelfSelectStockManage;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zcy on 2016/5/16.
 * 对用户自选股进行管理
 */
public class ManageSelfSelectStock implements ManageSelfSelectStockService {
    /**
     * @param userID 用户账号
     * @return List<String>
     * 得到该用户的所有自选股
     */
    public List<String> getAllInterestedStock(String userID) {
        SelfSelectStockManage selfSelectStockManage = new SelfSelectStockManage();
        List<String> stocks = selfSelectStockManage.getAllInterestedStock(userID);
        return stocks;
    }

    /**
     * @param userID  用户账号
     * @param stockID 股票代号
     *                添加自选股
     */
    public boolean addSelfSelectStock(String userID, String stockID) {
        SelfSelectStockManage selfSelectStockManage = new SelfSelectStockManage();
        if (hasTheStock(userID, stockID)) {
            return false;
        }
        return selfSelectStockManage.addSelfSelectStock(userID, stockID);
    }

    /**
     * @param userID  用户账号
     * @param stockID 股票代号
     *                删除自选股
     */
    public boolean removeSelfSelectStock(String userID, String stockID) {
        SelfSelectStockManage selfSelectStockManage = new SelfSelectStockManage();
        return selfSelectStockManage.removeSelfSelectStock(userID, stockID);
    }

    /**
     * @return List<String>
     * 得到所有股票ID供用户选择添加自选
     */
    public List<String> getAllStockID() {
        List<String> list = new ArrayList<>();
        for (int i = 0; i < GetStockData_DB.stock_id.length; i++) {
            list.add(GetStockData_DB.stock_id[i]);
        }
        return list;
    }

    /**
     * @param userID   用户账号
     * @param stockIDs 所有被选中的股票id
     * @throws SQLException 根据用户选中的股票替换掉原来该用户的自选股
     */
    public boolean replaceSelfSelectStock(String userID, List<String> stockIDs) throws SQLException {
        SelfSelectStockManage selfSelectStockManage = new SelfSelectStockManage();
        return selfSelectStockManage.replaceSelfSelectStock(userID, stockIDs);
    }

    /**
     * @param userID  用户账号
     * @param stockID 股票代号
     * @return boolean
     * 判断该用户是否已经将该股票添加进自选
     */
    public boolean hasTheStock(String userID, String stockID) {
        SelfSelectStockManage selfSelectStockManage = new SelfSelectStockManage();
        return selfSelectStockManage.hasTheStock(userID, stockID);
    }
}
