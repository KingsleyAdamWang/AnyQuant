package blservice;

import vo.StockIDNameVO;

import java.util.List;

/**
 * Created by zcy on 2016/5/23.
 *
 */
public interface ShowStockIDNameService {
    public StockIDNameVO getStockIdAndName(String id);
    public List<StockIDNameVO> getAllStockIdAndName();
}
