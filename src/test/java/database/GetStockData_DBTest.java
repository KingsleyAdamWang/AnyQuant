package database;

import data.GetStockData;
import org.junit.Test;
import po.StockPO;
import po.Stock_everyMinutePO;

import java.io.*;
import java.sql.SQLException;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by zcy on 2016/5/4.
 *
 */
public class GetStockData_DBTest {
    @Test
    public void getStockData_nameTest(){
        GetStockData_DB getStockData_db = new GetStockData_DB();
        StockPO stockPO = getStockData_db.getStockData_name("sh600016","2016-04-28","2016-04-28");
        assertEquals("sh600016",stockPO.getId());
        assertEquals("2016-04-28",stockPO.getDate()[0]);
        assertEquals(44022700,stockPO.getVolume()[0]);
        assertEquals(1.13,stockPO.getPb()[0],0.01);
        assertEquals(9.5,stockPO.getHigh()[0],0.01);
        assertEquals(7.41,stockPO.getPe_ttm()[0],0.01);
        assertEquals(9.37,stockPO.getAdj_price()[0],0.01);
        assertEquals(9.33,stockPO.getLow()[0],0.01);
        assertEquals(9.37,stockPO.getClose()[0],0.01);
        assertEquals(9.43,stockPO.getOpen()[0],0.01);
        assertEquals(0.15,stockPO.getTurnover()[0],0.01);
        assertEquals(-0.21,stockPO.getIncrease_decreaseRate()[0],0.01);
        assertEquals(-0.02,stockPO.getIncrease_decreaseNum()[0],0.01);

        stockPO = getStockData_db.getStockData_name("sh600016","20160428","20160428");
        assertEquals("2016-04-28",stockPO.getDate()[0]);

        stockPO = getStockData_db.getStockData_name("sh500016","20160428","20160428");
        assertNull(stockPO);
    }

    @Test
    public void getLatestStockTest() throws SQLException {
        GetStockData_DB getStockData_db = new GetStockData_DB();
        List<StockPO> list = getStockData_db.getLatestStock();
        assertEquals("sh600015",list.get(1).getId());
    }

    @Test
    public void getTimeSeriesDataTest() throws SQLException {
        GetStockData_DB getStockData_db = new GetStockData_DB();
        Stock_everyMinutePO stock_everyMinutePO = getStockData_db.getTimeSeriesData("sh600015");
        assertEquals("15:00",stock_everyMinutePO.getTime()[239]);
    }


}