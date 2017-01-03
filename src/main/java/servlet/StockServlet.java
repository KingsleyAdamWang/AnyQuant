package servlet;

import bl.ShowStockData;
import bl.ShowStockNews;
import filter.StockFilter;
import vo.StockNewsVO;
import vo.StockVO;

import javax.json.Json;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.StringTokenizer;

/**
 * Created by song on 16-5-23.
 * <p>
 * 根据日期范围，加载股票数据
 */
public class StockServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * 获取ajax请求参数（日期范围），更新日期范围，加载对应的股票数据
     *
     * @param request  request对象，
     *                 请求参数形如：“id=sh600016&startDate=2016-01-04&endDate=2016-01-07”
     * @param response response对象，返回股票数据（json格式）
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String data = request.getQueryString();
        StringTokenizer tokenizer = new StringTokenizer(data, "&");
        String id = tokenizer.nextToken().substring(3);
        String startDate = tokenizer.nextToken().substring(10);
        String endDate = tokenizer.nextToken().substring(8);

        ShowStockData stockData = new ShowStockData();
        StockVO stockVO = stockData.getStockData(id, startDate, endDate);

        HttpSession session = request.getSession();
        session.setAttribute("stockVO", stockVO);
        session.setAttribute("startDate" + id, startDate);
        session.setAttribute("endDate" + id, endDate);

        loadData(response, stockVO);
    }


    /**
     * 加载数据，将stockVO封装为json格式并发送
     *
     * @throws IOException
     */
    private void loadData(HttpServletResponse response, StockVO stockVO) throws IOException {
        StringBuilder result = new StringBuilder();

        result.append("[");
        for (int i = 0; i < stockVO.getDate().length; i++) {
            result.append("{");
            result.append("\"date\":\"").append(stockVO.getDate()[i]).append("\",");
            result.append("\"high\":").append(stockVO.getHigh()[i]).append(",");
            result.append("\"low\":").append(stockVO.getLow()[i]).append(",");
            result.append("\"increase_num\":").append(stockVO.getIncrease_decreaseNum()[i]).append(",");
            result.append("\"increase_rate\":\"").
                    append(stockVO.getIncrease_decreaseRate()[i]).append("\",");
            result.append("\"open\":").append(stockVO.getOpen()[i]).append(",");
            result.append("\"close\":").append(stockVO.getClose()[i]).append(",");
            result.append("\"volume\":\"").
                    append(stockVO.volumeToString(stockVO.getVolume()[i])).append("\",");
            result.append("\"pe_ttm\":").append(stockVO.getPe_ttm()[i]).append(",");
            result.append("\"pb\":").append(stockVO.getPb()[i]);
            result.append("},");
        }
        result.deleteCharAt(result.length() - 1);//去掉最后的','
        result.append("]");

        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.println(result.toString());

        out.close();
    }
}
