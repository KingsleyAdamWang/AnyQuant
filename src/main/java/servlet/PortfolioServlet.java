package servlet;

import bl.ShowStockData;
import bl.ShowStockIDName;
import bl.ShowStockNews;
import database.SelfSelectStockManage;
import vo.ReducedStockNewsVO;
import vo.StockVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

/**
 * Created by song on 16-5-11.
 * <p>
 * 关注列表管理
 */
public class PortfolioServlet extends HttpServlet {

    /**
     * 要发送的消息
     */
    private StringBuilder result;

    private SelfSelectStockManage portfolioManage;

    public PortfolioServlet() {
        portfolioManage = new SelfSelectStockManage();
    }

    /**
     * 接收portfolio.jsp中更新后的关注列表，并将结果储存到数据库中
     *
     * @param req  request对象，包含操作信息
     *             操作信息包括：用户ID、操作类型、操作数据
     *             操作类型分为：add、delete、update
     * @param resp response对象
     *             add、delete操作：若存储成功，发送success，否则发送failure
     *             update操作：发送更新后的最新数据
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //用户ID
        String userID = req.getParameter("id");
        //操作类型
        String type = req.getParameter("type");
        //操作数据
        String data = req.getParameter("data");

        result = new StringBuilder();

        switch (type) {
            case "add":
                addPortfolio(userID, data);
                break;
            case "delete":
                deletePortfolio(userID, data);
                break;
            case "update":
                updatePortfolio(userID, data, resp);
                break;
            default:
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    /**
     * 向自选列表中添加某只股票
     *
     * @param userID  用户ID
     * @param stockID 股票代码
     * @return 若更新成功，返回true，否则返回false
     */
    private boolean addPortfolio(String userID, String stockID) {
        return portfolioManage.addSelfSelectStock(userID, stockID);
    }

    /**
     * 从自选列表中删除某只股票
     *
     * @param userID  用户ID
     * @param stockID 股票代码
     * @return 若删除成功，返回true，否则返回false
     */
    private boolean deletePortfolio(String userID, String stockID) {
        return portfolioManage.removeSelfSelectStock(userID, stockID);
    }

    /**
     * 更新自选列表
     *
     * @param userID     用户ID
     * @param stockNames 自选股名称，以空格隔开
     * @param response   response 发送更新后的最新数据
     */
    private void updatePortfolio(String userID, String stockNames, HttpServletResponse response) throws IOException {
        StringTokenizer tokenizer = new StringTokenizer(stockNames);
        ShowStockIDName showStockIDName = new ShowStockIDName();

        List<String> stockIDList = new ArrayList<>();

        while (tokenizer.hasMoreElements()) {
            //根据名称获取ID
            stockIDList.add(showStockIDName.getStockIdAndName(tokenizer.nextToken()).getId());
        }

        if (portfolioManage.replaceSelfSelectStock(userID, stockIDList)) {
            List<ReducedStockNewsVO> newsVOList = new ShowStockNews().showReducedStockNews(userID);
            sendPortfolio(stockIDList, newsVOList, response);
        }
    }

    /**
     * 发送更新后的自选股数据
     *
     * @param stockIDList 自选股ID列表
     * @param newsVOList  新闻标题列表
     * @param response    response对象，发送数据
     * @throws IOException
     */
    private void sendPortfolio(List<String> stockIDList, List<ReducedStockNewsVO> newsVOList, HttpServletResponse response) throws IOException {
        result.append("{");
        addData(stockIDList);
        addNews(newsVOList);
        result.append("}");

        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.println(result.toString());

        out.close();
    }

    /**
     * 添加股票数据
     *
     * @param stockIDList 自选股ID列表
     * @throws IOException
     */
    private void addData(List<String> stockIDList) throws IOException {
        ShowStockData stockData = new ShowStockData();
        result.append("\"data\":[");

        StockVO temp;
        for (String stockID : stockIDList) {
            try {
                temp = stockData.getLatestStockData(stockID);
                addStock(result, temp);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        result.deleteCharAt(result.length() - 1);//去掉最后的','
        result.append("],");
    }

    /**
     * 向返回结果中添加一只股票
     *
     * @param result  返回结果
     * @param stockVO 股票
     */
    private void addStock(StringBuilder result, StockVO stockVO) {
        result.append("{");
        result.append("\"name\":\"").append(stockVO.getName()).append("\",");
        result.append("\"id\":\"").append(stockVO.getId()).append("\",");
        result.append("\"high\":").append(stockVO.getHigh()[0]).append(",");
        result.append("\"low\":").append(stockVO.getLow()[0]).append(",");
        result.append("\"increase_num\":").append(stockVO.getIncrease_decreaseNum()[0]).append(",");
        result.append("\"increase_rate\":\"").
                append(stockVO.getIncrease_decreaseRate()[0]).append("\",");
        result.append("\"open\":").append(stockVO.getOpen()[0]).append(",");
        result.append("\"close\":").append(stockVO.getClose()[0]).append(",");
        result.append("\"volume\":\"").
                append(stockVO.volumeToString(stockVO.getVolume()[0])).append("\",");
        result.append("\"pe_ttm\":").append(stockVO.getPe_ttm()[0]).append(",");
        result.append("\"pb\":").append(stockVO.getPb()[0]);
        result.append("},");
    }

    /**
     * 添加新闻标题列表
     *
     * @param newsVOList 新闻列表
     */
    private void addNews(List<ReducedStockNewsVO> newsVOList) {
        result.append("\"news\":[");
        for (ReducedStockNewsVO newsVO : newsVOList) {
            result.append("{");
            result.append("\"id\":\"").append(newsVO.getId()).append("\",");
            result.append("\"title\":\"").append(newsVO.getTitle()).append("\"");
            result.append("},");
        }
        result.deleteCharAt(result.length() - 1);//去掉最后的','
        result.append("]");
    }
}
