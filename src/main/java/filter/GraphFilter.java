package filter;

import bl.ShowIndexData;
import bl.util.MyDate;
import database.GetIndexData_DB;
import po.IndexPO;
import vo.IndexVO;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by zmj on 2016/5/14.
 */
@WebFilter(filterName = "GraphFilter")
public class GraphFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();
        ShowIndexData showIndexData=new ShowIndexData();

        IndexVO indexVO = showIndexData.getIndexDataBetween(MyDate.getDate_NDaysAgo(90),MyDate.getDate_Today());
        IndexVO indexVOWeekly=showIndexData.getIndexDataForKWeekly();
        IndexVO indexVOMonthly=showIndexData.getIndexDataForKMonthly();
       //连续的大盘指数数据
        long volumeOrigin[]=indexVO.getVolume();
        double volume[]=new double[volumeOrigin.length];
        for(int i=0;i<volumeOrigin.length;i++){
            volume[i]= ((double)volumeOrigin[i]/10000000000l);
        }
        double[] high =indexVO.getHigh();
        double[] low = indexVO.getLow();
        double[] close =indexVO.getClose();
        double[] open = indexVO.getOpen();
        String date[]=indexVO.getDate();
        session.setAttribute("volume",volume);
        session.setAttribute("date",date);
        session.setAttribute("high",high);
        session.setAttribute("low",low);
        session.setAttribute("close",close);
        session.setAttribute("open",open);

        //给周k提供数据
        String[] dateWeekly=indexVOWeekly.getDate();
        double[] highWeekly=indexVOWeekly.getHigh();
        double[] lowWeekly=indexVOWeekly.getLow();
        double[] openWeekly=indexVOWeekly.getOpen();
        double[] closeWeekly=indexVOWeekly.getClose();
        session.setAttribute("dateWeekly",dateWeekly);
        session.setAttribute("highWeekly",highWeekly);
        session.setAttribute("lowWeekly",lowWeekly);
        session.setAttribute("openWeekly",openWeekly);
        session.setAttribute("closeWeekly",closeWeekly);
        //给月k提供数据
        String[] dateMonthly=indexVOMonthly.getDate();
        double[] highMonthly=indexVOMonthly.getHigh();
        double[] lowMonthly=indexVOMonthly.getLow();
        double[] openMonthly=indexVOMonthly.getOpen();
        double[] closeMonthly=indexVOMonthly.getClose();
        session.setAttribute("dateMonthly",dateMonthly);
        session.setAttribute("highMonthly",highMonthly);
        session.setAttribute("lowMonthly",lowMonthly);
        session.setAttribute("openMonthly",openMonthly);
        session.setAttribute("closeMonthly",closeMonthly);

        String[] dateDailyK=new String[date.length];
        String[] dateMonthlyK=new String[dateMonthly.length];
        String[] dateWeeklyK=new String[dateWeekly.length];

        StockFilter stockFilter=new StockFilter();
        stockFilter.changeDate(date,dateDailyK);
        stockFilter.changeDate(dateWeekly,dateWeeklyK);
        stockFilter.changeDate(dateMonthly,dateMonthlyK);

        session.setAttribute("dateDailyK",dateDailyK);
        session.setAttribute("dateMonthlyK",dateMonthlyK);
        session.setAttribute("dateWeeklyK",dateWeeklyK);
        chain.doFilter(req, resp);
    }

    @Override
    public void destroy() {

    }
}
