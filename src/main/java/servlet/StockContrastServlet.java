package servlet;

import bl.ShowStockIDName;
import vo.StockIDNameVO;
import vo.TheIndexVO;
import webutil.StockUtil;

import javax.json.Json;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by song on 16-6-1.
 * <p>
 * 接受stockContrast.jsp发送的请求（股票ID），返回请求结果（各项指标）
 */
@WebServlet(name = "StockContrastServlet")
public class StockContrastServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * 接收请求，发送请求结果
     * 请求格式形如：
     *
     * @param request  request对象，包含请求内容
     * @param response response对象，发送请求结果
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String index = request.getParameter("index");
        String stockName = request.getParameter("stockName");

        StockIDNameVO stockIDName = new ShowStockIDName().getStockIdAndName(stockName);

        String stockID = stockIDName.getId();

        HttpSession session = request.getSession();
        session.setAttribute("stockID_" + index, stockID);

        TheIndexVO stockIndex = StockUtil.loadStockIndex(stockID, request);
        System.out.println(stockName);
        sendData(stockIndex, response);
    }

    /**
     * 发送数据
     */
    private void sendData(TheIndexVO stockIndex, HttpServletResponse response) throws IOException {
        String result = "{" +
                "\"bias\":" + stockIndex.biasNorm() + "," +
                "\"RSI\":" + stockIndex.getRSI() + "," +
                "\"WM\":" + stockIndex.getWM() + "," +
                "\"AR\":" + stockIndex.ARNorm() + "," +
                "\"BR\":" + stockIndex.BRNorm() +
                "}";
        System.out.println(result);
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.println(result);
    }
}
