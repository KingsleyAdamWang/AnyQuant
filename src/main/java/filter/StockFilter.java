package filter;

import bl.CalculateIndex;
import bl.ShowIndexData;
import bl.ShowStockData;
import bl.ShowStockNews;
import vo.StockNewsVO;
import vo.StockVO;
import vo.Stock_everyMinuteVO;
import vo.TheIndexVO;
import webutil.StockUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by song on 16-5-23.
 * <p>
 * 过滤stock.jsp，加载股票数据
 */
@WebFilter(filterName = "StockFilter")
public class StockFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    /**
     * 获取请求参数（ID），并加载股票数据
     *
     * @param req request对象，请求参数形如：“id=sh601009”
     * @throws ServletException
     * @throws IOException
     */
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();

        String query = request.getQueryString();
        String id = query.substring(3);

        StockVO stockVO = StockUtil.loadStockVO(id, request);
        StockUtil.loadStockIndex(id, request);
        StockUtil.loadStockNews(id, request);

        ShowStockData showStockData = new ShowStockData();
        StockVO stockDaily = showStockData.getStockDataForKDaily(stockVO.getId());
        StockVO stockWeekly = showStockData.getStockDataForKWeekly(stockVO.getId());
        StockVO stockMonthly = showStockData.getStockDataForKMonthly(stockVO.getId());

        long volumeOrigin[] = stockDaily.getVolume();
        double volume[] = new double[volumeOrigin.length];
        for (int i = 0; i < volumeOrigin.length; i++) {
            volume[i] = ((double) volumeOrigin[i] / 10000000000l);
        }

        session.setAttribute("name", stockDaily.getName());
        session.setAttribute("id", stockDaily.getId());
        session.setAttribute("high", stockDaily.getHigh());
        session.setAttribute("low", stockDaily.getLow());
        session.setAttribute("open", stockDaily.getOpen());
        session.setAttribute("close", stockDaily.getClose());
        session.setAttribute("volume", volume);
        session.setAttribute("date", stockDaily.getDate());

        String[] date = stockDaily.getDate();
        String[] dateWeekly = stockWeekly.getDate();
        String[] dateMonthly = stockMonthly.getDate();
        String[] dateDailyK = new String[date.length];
        String[] dateMonthlyK = new String[dateMonthly.length];
        String[] dateWeeklyK = new String[dateWeekly.length];

        changeDate(date, dateDailyK);
        changeDate(dateWeekly, dateWeeklyK);
        changeDate(dateMonthly, dateMonthlyK);

        session.setAttribute("dateDailyK", dateDailyK);
        session.setAttribute("dateMonthlyK", dateMonthlyK);
        session.setAttribute("dateWeeklyK", dateWeeklyK);


        session.setAttribute("highWeekly", stockWeekly.getHigh());
        session.setAttribute("lowWeekly", stockWeekly.getLow());
        session.setAttribute("openWeekly", stockWeekly.getOpen());
        session.setAttribute("closeWeekly", stockWeekly.getClose());

        session.setAttribute("highMonthly", stockMonthly.getHigh());
        session.setAttribute("lowMonthly", stockMonthly.getLow());
        session.setAttribute("openMonthly", stockMonthly.getOpen());
        session.setAttribute("closeMonthly", stockMonthly.getClose());

        //分时图数据
        Stock_everyMinuteVO stock_everyMinuteVO;
        try {
            stock_everyMinuteVO = showStockData.showTimeSeriesData(stockVO.getId());
            session.setAttribute("time", stock_everyMinuteVO.getTime());
            session.setAttribute("price", stock_everyMinuteVO.getPrice());
            session.setAttribute("priceAvg", stock_everyMinuteVO.getPrice_mean());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        chain.doFilter(req, resp);
    }

    public void changeDate(String[] dateOrigin, String[] date) {
        for (int i = 0; i < dateOrigin.length; i++) {
            if (dateOrigin[i].substring(5, 6).equals("0") && dateOrigin[i].substring(8, 9).equals("0")) {
                date[i] = dateOrigin[i].substring(0, 4) + "/" + dateOrigin[i].substring(6, 7) + "/" + dateOrigin[i].substring(9, 10);
            }
            if (dateOrigin[i].substring(5, 6).equals("0") && !dateOrigin[i].substring(8, 9).equals("0")) {
                date[i] = dateOrigin[i].substring(0, 4) + "/" + dateOrigin[i].substring(6, 7) + "/" + dateOrigin[i].substring(8, 10);
            }
            if (!dateOrigin[i].substring(5, 6).equals("0") && dateOrigin[i].substring(8, 9).equals("0")) {
                date[i] = dateOrigin[i].substring(0, 4) + "/" + dateOrigin[i].substring(5, 7) + "/" + dateOrigin[i].substring(9, 10);
            }
            if (!dateOrigin[i].substring(5, 6).equals("0") && !dateOrigin[i].substring(8, 9).equals("0")) {
                date[i] = dateOrigin[i].substring(0, 4) + "/" + dateOrigin[i].substring(5, 7) + "/" + dateOrigin[i].substring(8, 10);
            }
        }
    }

    /**
     * 加载indexVO
     * 判断stockVO日期区间是否大于30，
     * 若是，加载新的indexVO
     * 否则，忽略更新，保留原有indexVO
     *
     * @param stockVO 对应的stockVO对象
     */
    private TheIndexVO loadStockIndexVO(StockVO stockVO) {
        CalculateIndex calculateIndex = new CalculateIndex();
        TheIndexVO stockIndexVO = null;

//        if (stockVO.getDate().length >= 30) {
        stockIndexVO = calculateIndex.getTheIndex(stockVO);
//        }

        return stockIndexVO;
    }

    @Override
    public void destroy() {
        System.out.println("StockFilter.destroy");
    }
}
