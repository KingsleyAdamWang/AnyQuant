package filter;

import bl.ShowStockIDName;
import bl.ShowStockNews;
import vo.ReducedStockNewsVO;
import webutil.PictureUtil;
import webutil.PortfolioUtil;
import vo.StockIDNameVO;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Created by song on 16-5-14.
 * <p>
 * 加载自选股票列表及所有股票名称代码
 */
@WebFilter(filterName = "PortfolioFilter")
public class PortfolioFilter implements Filter {

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();

        String id = (String) session.getAttribute("UserId");
        if (id !=null){
            PictureUtil.loadStockNameList(session);
            PortfolioUtil.loadPortfolio(session);

            List<ReducedStockNewsVO> newsList = new ShowStockNews().
                    showReducedStockNews(id);
            session.setAttribute("newsList_" + id, newsList);
        }

        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {
    }
}
