package servlet;

import bl.ShowIndexData;
import bl.util.Convert;
import vo.IndexVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

/**
 * Created by song on 16-5-28.
 *
 * 根据日期范围，加载大盘数据
 */
@WebServlet(name = "MarketServlet")
public class MarketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * 获取ajax请求参数（日期范围），更新日期范围，加载对应的股票数据
     *
     * @param request  request对象，
     *                 请求参数形如：“startDate=2016-01-04&endDate=2016-01-07”
     * @param response response对象，返回股票数据（json格式）
     *                 若请求区间内无数据，不予响应
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String data = request.getQueryString();
        StringTokenizer tokenizer = new StringTokenizer(data, "&");
        String startDate = tokenizer.nextToken().substring(10);
        String endDate = tokenizer.nextToken().substring(8);

        ShowIndexData indexData = new ShowIndexData();
        IndexVO indexVO = indexData.getIndexDataBetween(startDate, endDate);

        if (indexVO != null) {
            HttpSession session = request.getSession();
            session.setAttribute("indexVO", indexVO);
            session.setAttribute("startDate_index", startDate);
            session.setAttribute("endDate_index", endDate);
            loadData(response, indexVO);
        }
    }

    /**
     * 加载数据，将indexVO封装为json格式并发送
     *
     * @throws IOException
     */
    private void loadData(HttpServletResponse response, IndexVO indexVO) throws IOException {
        StringBuilder result = new StringBuilder();

        result.append("[");
        for (int i = 0; i < indexVO.getDate().length; i++) {
            result.append("{");
            result.append("\"date\":\"").append(indexVO.getDate()[i]).append("\",");
            result.append("\"high\":").append(indexVO.getHigh()[i]).append(",");
            result.append("\"low\":").append(indexVO.getLow()[i]).append(",");
            result.append("\"increase_num\":").append(indexVO.getIncrease_decreaseNum()[i]).append(",");
            result.append("\"increase_rate\":\"").
                    append(indexVO.getIncrease_decreaseRate()[i]).append("\",");

            result.append("\"open\":").append(indexVO.getOpen()[i]).append(",");
            result.append("\"close\":").append(indexVO.getClose()[i]).append(",");
            result.append("\"volume\":\"").
                    append(Convert.getDealNum(indexVO.getVolume()[i])).append("\"");
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
