package bl;

import org.junit.Test;
import vo.CurrentIndexVO;
import vo.StockVO;
import vo.Stock_everyMinuteVO;

import java.io.IOException;
import java.sql.SQLException;

import static org.junit.Assert.*;

/**
 * Created by zcy on 2016/5/16.
 *
 */
public class ShowStockDataTest {
    @Test
    public void getStockDataTest() throws IOException {
        ShowStockData showStockData = new ShowStockData();
        StockVO stockVO = showStockData.getStockData("sh600015","2005-10-14","2005-10-16");
        assertEquals("2005-10-14",stockVO.getDate()[0]);
        assertEquals(4.18001,stockVO.getHigh()[0],0.01);
        assertEquals(4.14001,stockVO.getOpen()[0],0.01);
        assertEquals(4.11999,stockVO.getLow()[0],0.01);
        assertEquals(4.13001,stockVO.getClose()[0],0.01);
    }
    @Test
    public void getStockDataForKWeeklyTest() throws IOException {
        ShowStockData showStockData = new ShowStockData();
        StockVO stockVO = showStockData.getStockDataForKWeekly("sh600015");
        assertNotNull(stockVO.getDate());
    }
    @Test
    public void getStockDataForKMonthlyTest() throws IOException {
        ShowStockData showStockData = new ShowStockData();
        StockVO stockVO = showStockData.getStockDataForKMonthly("sh600015");
        assertNotNull(stockVO.getDate());
    }

    @Test
    public void showTimeSeriesDataTest() throws SQLException {
        ShowStockData showStockData = new ShowStockData();
        Stock_everyMinuteVO stock_everyMinuteVO = showStockData.showTimeSeriesData("sh600015");
        assertEquals("15:00",stock_everyMinuteVO.getTime()[239]);
    }

}