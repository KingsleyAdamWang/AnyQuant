package webutil;

import bl.ShowStockIDName;
import bl.SortStock;
import blservice.SortStockService;
import vo.StockIDNameVO;
import vo.StockVO;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by song on 16-6-2.
 *
 * 行情工具类
 * 用于加载榜单（涨幅榜、跌幅榜、成交量榜）
 */
public class PictureUtil {

    private PictureUtil(){}

    /**
     * 加载各种榜单
     *
     * @param session session对象
     */
    public static void loadPicture(HttpSession session) throws IOException {
        //榜单同时加载，只需判断一个即可
        if (session.getAttribute("increase_rank") != null) {
            return;
        }

        SortStockService sortStock = null;
        try {
            sortStock = new SortStock();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        assert sortStock != null;
        List<StockVO> increase_rank = sortStock.increase_sort();
        List<StockVO> volume_rank = sortStock.volume_sort();

        session.setAttribute("increase_rank", increase_rank);
        session.setAttribute("volume_rank", volume_rank);
    }

    /**
     * 加载所有股票名称代码列表
     * 判断session中是否已存在stockIDNameList属性，若不存在，加载列表
     *
     * @param session session对象
     */
    public static void loadStockNameList(HttpSession session) {
        if (session.getAttribute("stockIDNameList") == null) {
            ShowStockIDName stockIDName = new ShowStockIDName();

            List<StockIDNameVO> stockIDNameList = stockIDName.getAllStockIdAndName();

            session.setAttribute("stockIDNameList", stockIDNameList);
        }
    }
}
