package filter;

import bl.ShowStockNews;
import webutil.PictureUtil;
import webutil.PortfolioUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by song on 16-5-17.
 * <p>
 * 加载各种榜单
 */
@WebFilter(filterName = "PictureFilter")
public class PictureFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();

        PictureUtil.loadPicture(session);

        if (session.getAttribute("UserId") != null) {
            PortfolioUtil.loadPortfolio(session);
        }

        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {
    }
}
