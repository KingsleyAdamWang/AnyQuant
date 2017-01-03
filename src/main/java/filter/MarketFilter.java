package filter;

import bl.ShowBusinessNews;
import bl.ShowIndexData;
import vo.CurrentIndexVO;
import vo.IndexVO;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by song on 16-5-28.
 *
 * 过滤market.jsp，加载大盘数据
 */
@WebFilter(filterName = "MarketFilter")
public class MarketFilter implements Filter {

    private ShowIndexData indexData;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        indexData = new ShowIndexData();
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpSession session = ((HttpServletRequest) req).getSession();

        if (session.getAttribute("currentIndexVO") == null) {
            //第一次访问，加载currentIndexVO、indexVO和businessNews
            //以后每次刷新，无需再次加载
            CurrentIndexVO currentIndexVO = indexData.showCurrentIndexData();
            IndexVO indexVO = indexData.getIndexData_aMonth();
            ShowBusinessNews businessNews = new ShowBusinessNews();

            session.setAttribute("currentIndexVO", currentIndexVO);
            session.setAttribute("indexVO", indexVO);
            session.setAttribute("businessNews", businessNews.showBusinessNews());
        }

        chain.doFilter(req, resp);
    }

    @Override
    public void destroy() {

    }
}
