package blservice;

import vo.StockNewsVO;

import java.util.List;

/**
 * Created by zcy on 2016/5/23.
 *
 */
public interface ShowStockNewsService {
    public List<StockNewsVO> showStockNews(String id);

}
