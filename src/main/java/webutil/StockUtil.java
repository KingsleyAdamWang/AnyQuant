package webutil;

import bl.CalculateIndex;
import bl.ShowStockData;
import bl.ShowStockIDName;
import bl.ShowStockNews;
import bl.util.MyDate;
import vo.StockIDNameVO;
import vo.StockNewsVO;
import vo.StockVO;
import vo.TheIndexVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Created by song on 16-6-2.
 * <p>
 * 股票数据加载工具类
 * 负责加载股票数据
 */
public class StockUtil {
    private StockUtil() {
    }

    /**
     * 加载股票历史数据
     * 可选择日期区间
     *
     * @param stockID 股票ID
     * @param request request对象,加载股票ID
     * @return 股票历史数据
     */
    public static StockVO loadStockVO(String stockID, HttpServletRequest request) throws IOException {
        ShowStockData stockData = new ShowStockData();
        StockVO stockVO;
        HttpSession session = request.getSession();

        request.setAttribute("stockID", stockID);

        if (session.getAttribute("startDate" + stockID) == null) {
            stockVO = stockData.getStockData(stockID);
        } else {
            stockVO = stockData.getStockData(stockID,
                    (String) session.getAttribute("startDate" + stockID),
                    (String) session.getAttribute("endDate" + stockID));
        }

        session.setAttribute("stockVO_" + stockID, stockVO);

        return stockVO;
    }

    /**
     * 加载股票指标及股票名称
     *
     * @param stockID 股票ID
     * @param request request对象
     * @return 返回加载结果（TheIndexVO）
     * @throws IOException
     */
    public static TheIndexVO loadStockIndex(String stockID, HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("name_" + stockID) != null) {
            return null;
        }

        TheIndexVO theIndexVO = new CalculateIndex()
                .getTheIndex(new ShowStockData().getStockData(stockID, MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));

        StockIDNameVO stockName = new ShowStockIDName().getStockIdAndName(stockID);

        session.setAttribute("name_" + stockID, stockName.getName());
        session.setAttribute("stockIndex_" + stockID, theIndexVO);

        return theIndexVO;
    }

    /**
     * 加载股票新闻
     *
     * @param stockID 股票id
     * @param request request对象
     * @return 返回加载结果
     */
    public static List<StockNewsVO> loadStockNews(String stockID, HttpServletRequest request) {
        HttpSession session = request.getSession();

        List<StockNewsVO> newsList = new ShowStockNews().showStockNews(stockID);
        session.setAttribute("newsList_" + stockID, newsList);

        return newsList;
    }
}
