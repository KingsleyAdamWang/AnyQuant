package bl;

import blservice.ShowStockNewsService;
import database.GetStockNews;
import database.SelfSelectStockManage;
import po.ReducedStockNewsPO;
import po.StockNewsPO;
import vo.ReducedStockNewsVO;
import vo.StockNewsVO;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zcy on 2016/5/16.
 *
 */
public class ShowStockNews implements ShowStockNewsService{
    /**
     * @param id 股票id
     * @return List<StockNewsVO>
     * 得到指定股票的新闻
     */
    public List<StockNewsVO> showStockNews(String id){
        GetStockNews getStockNews = new GetStockNews();
        List<StockNewsVO> list = new ArrayList<>();
        List<StockNewsPO> stockNewsPOs = getStockNews.getStockNews(id);
        for(int i=0;i<stockNewsPOs.size();i++){
            StockNewsVO stockNewsVO = new StockNewsVO();
            stockNewsVO.setId(stockNewsPOs.get(i).getId());
            stockNewsVO.setTitle(stockNewsPOs.get(i).getTitle());
            stockNewsVO.setContent(stockNewsPOs.get(i).getContent());
            stockNewsVO.setDate(stockNewsPOs.get(i).getDate());
            list.add(stockNewsVO);
        }
        return list;
    }

    /**
     * @param user 用户账号
     * @return List<ReducedStockNewsVO>
     * 根据用户账号得到该用户所有自选股的有关新闻
     */
    public List<ReducedStockNewsVO> showReducedStockNews(String user){
        SelfSelectStockManage selfSelectStockManage = new SelfSelectStockManage();
        List<ReducedStockNewsVO> reducedStockNewsVOList = new ArrayList<>();//存放最后结果
        List<List<ReducedStockNewsVO>> temp = new ArrayList<>();
        List<String> stocks = selfSelectStockManage.getAllInterestedStock(user);
        if(stocks.isEmpty()){
            return null; //这个用户没有关注任何股票
        }
        int[] sizes = new int[stocks.size()];
        for(int i=0;i<stocks.size();i++){
            List<ReducedStockNewsVO> reducedStockNewsVOs = showReducedStockNews_id(stocks.get(i));
            temp.add(reducedStockNewsVOs);
            sizes[i] = reducedStockNewsVOs.size();
        }

        //找出所有股票新闻个数的最大值
        int k = 0;
        for(int i=0;i<sizes.length;i++){
            if(sizes[i]>sizes[k]){
                k = i;
            }
        }
        int max = sizes[k];

        for(int i=0;i<max;i++){
            for(int j=0;j<temp.size();j++){
                if(!temp.get(j).isEmpty()){
                    reducedStockNewsVOList.add(temp.get(j).get(0));
                    temp.get(j).remove(0);
                }
            }
        }
        return reducedStockNewsVOList;
    }

    /**
     * @param id 股票代号
     * @return List<ReducedStockNewsVO>
     */
    private List<ReducedStockNewsVO> showReducedStockNews_id(String id){
        GetStockNews getStockNews = new GetStockNews();
        List<ReducedStockNewsVO> list = new ArrayList<>();
        List<ReducedStockNewsPO> stockNewsPOs = getStockNews.getReducedStockNews(id);
        for(int i=0;i<stockNewsPOs.size();i++){
            ReducedStockNewsVO reducedStockNewsVO = new ReducedStockNewsVO(stockNewsPOs.get(i));
            list.add(reducedStockNewsVO);
        }
        return list;
    }

    /**
     * 获取股票新闻标题
     * 用于显示新闻列表，不宜过多，返回前3条新闻的标题
     * @param id 股票id
     * @return 新闻标题列表
     */
    public List<String> showStockNewstTitles(String id) {
        List<String> titles = new ArrayList<>();

        List<StockNewsPO> stockNewsVOList = new GetStockNews().getStockNews(id);

        for (int i = 0; i < 3; i++) {
            titles.add(stockNewsVOList.get(i).getTitle());
        }

        return titles;
    }
}
