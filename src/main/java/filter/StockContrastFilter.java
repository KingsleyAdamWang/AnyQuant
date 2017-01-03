package filter;

import webutil.PictureUtil;
import webutil.PortfolioUtil;
import webutil.StockUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by song on 16-6-1.
 * <p>
 * 股票对比过滤器，负责加载第一只股票的数据（各项指数）
 */
@WebFilter(filterName = "StockContrastFilter")
public class StockContrastFilter implements Filter {
    public void destroy() {
    }

    /**
     * 获取请求参数（ID），并加载股票指标
     *
     * @param req request对象，请求参数形如：“id=sh601009”
     * @throws ServletException
     * @throws IOException
     */
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;

        String id = request.getQueryString().substring(3);

        request.getSession().setAttribute("stockID_1", id);
        // 加载股票指标
        StockUtil.loadStockIndex(id, request);
        //加载所有股票名称列表
        PictureUtil.loadStockNameList(request.getSession());

        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
