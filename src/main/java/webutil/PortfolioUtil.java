package webutil;

import bl.ShowStockData;
import database.SelfSelectStockManage;
import filter.PictureFilter;
import filter.PortfolioFilter;
import vo.StockVO;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by song on 16-6-1.
 * <p>
 * 自选工具类，用于加载自选股票信息
 */
public class PortfolioUtil {
    private PortfolioUtil() {
    }

    /**
     * 加载自选股列表
     * 自选股可能发生变化，每次刷新均加载数据
     *
     * @param session session对象
     * @return 返回自选股ID列表
     * @throws IOException
     * @see PortfolioFilter
     * @see PictureFilter
     */
    public static List<String> loadPortfolio(HttpSession session) throws IOException {
        ShowStockData stockData = new ShowStockData();
        List<StockVO> portfolioList = new ArrayList<>();

        List<String> portfolioIDList = new SelfSelectStockManage().getAllInterestedStock(
                (String) session.getAttribute("UserId"));

        for (String temp : portfolioIDList) {
            try {
                portfolioList.add(stockData.getLatestStockData(temp));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        session.setAttribute("portfolioIDList", portfolioIDList);
        session.setAttribute("portfolioList", portfolioList);

        return portfolioIDList;
    }
}
