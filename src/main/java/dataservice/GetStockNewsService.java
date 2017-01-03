package dataservice;

import po.StockNewsPO;

import java.util.List;

/**
 * Created by zcy on 2016/5/30.
 *
 */
public interface GetStockNewsService {
    /**
     * @param stockID 股票代号
     * @return List<StockNewsPO>
     */
    public List<StockNewsPO> getStockNews(String stockID);
    /**
     * @param stockID 股票代号
     * @return List<String>
     * 根据股票ID从数据库中得到新闻标题
     */
    public List<String> getNewsTitle(String stockID);
    /**
     * @param stockID 股票代号
     * @return List<String>
     * 根据股票ID从数据库中得到新闻正文
     */
    public List<String> getNewsContent(String stockID);
    public List<String> getNewsDate(String stockID);

}
