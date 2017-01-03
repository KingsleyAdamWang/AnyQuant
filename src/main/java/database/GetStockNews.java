package database;

import dataservice.GetStockNewsService;
import po.ReducedStockNewsPO;
import po.StockNewsPO;
import vo.StockNewsVO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zcy on 2016/5/6.
 *
 */
public class GetStockNews implements GetStockNewsService{
    /**
     * @param stockID 股票代号
     * @return List<StockNewsPO>
     */
    public List<StockNewsPO> getStockNews(String stockID){
        List<String> titles = getNewsTitle(stockID);
        List<String> contents = getNewsContent(stockID);
        List<String> dates = getNewsDate(stockID);
        int size = titles.size();
        List<StockNewsPO> news = new ArrayList<>();
        for(int i=0;i<size;i++){
            StockNewsPO stockNewsPO = new StockNewsPO();
            stockNewsPO.setId(stockID);
            stockNewsPO.setTitle(titles.get(i));
            stockNewsPO.setContent(contents.get(i));
            stockNewsPO.setDate(dates.get(i));
            news.add(stockNewsPO);
        }
        return news;
    }

    /**
     * @param stockID 股票代号
     * @return List<ReducedStockNewsPO>
     */
    public List<ReducedStockNewsPO> getReducedStockNews(String stockID){
        List<String> titles = getNewsTitle(stockID);
        List<ReducedStockNewsPO> news = new ArrayList<>();
        for(int i=0;i<titles.size();i++){
            ReducedStockNewsPO reducedStockNewsPO = new ReducedStockNewsPO();
            reducedStockNewsPO.setId(stockID);
            reducedStockNewsPO.setTitle(titles.get(i));
            news.add(reducedStockNewsPO);
        }
        return news;
    }

    /**
     * @param stockID 股票代号
     * @return List<String>
     * 根据股票ID从数据库中得到新闻标题
     */
    public List<String> getNewsTitle(String stockID){
        List<String> titles = getNews(stockID,2);
        return titles;
    }

    /**
     * @param stockID 股票代号
     * @return List<String>
     * 根据股票ID从数据库中得到新闻正文
     */
    public List<String> getNewsContent(String stockID){
        List<String> contents = getNews(stockID,3);
        return contents;
    }

    public List<String> getNewsDate(String stockID){
        List<String> dates = getNews(stockID,4);
        return dates;
    }

    private List<String> getNews(String stockID,int n){
        List<String> results = new ArrayList<>();
        Connect co=new Connect();
        String sql="SELECT * FROM companynews where id = \'"+stockID+"\'";
        ResultSet result=co.getResultSet(sql);

        try {
            while(result.next()){
                results.add(result.getString(n));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        co.closeConnection();
        return results;
    }

}
