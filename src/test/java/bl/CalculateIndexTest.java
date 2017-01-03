package bl;

import bl.util.MyDate;
import org.junit.Test;
import vo.TheIndexVO;

import java.io.IOException;

import static org.junit.Assert.*;

/**
 * Created by zcy on 2016/6/6.
 *
 */
public class CalculateIndexTest {
    @Test
    public void getTheIndexTest() throws IOException {
        CalculateIndex calculateIndex = new CalculateIndex();
        TheIndexVO theIndexVO = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601818", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        System.out.println(theIndexVO.biasNorm());
        TheIndexVO theIndexVO1 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh600015", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO2 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh600016", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO3 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh600036", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO4 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601009", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO5 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601166", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO6 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601169", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO7 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601288", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO8 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601328", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO9 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601398", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO10 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601939", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO11 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601988", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO12 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sh601998", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO13 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sz000001", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        TheIndexVO theIndexVO14 = calculateIndex.getTheIndex(new ShowStockData().getStockData("sz002142", MyDate.getDate_NDaysAgo(360),MyDate.getDate_Today()));
        System.out.println(theIndexVO1.biasNorm());
        System.out.println(theIndexVO2.biasNorm());
        System.out.println(theIndexVO3.biasNorm());
        System.out.println(theIndexVO4.biasNorm());
        System.out.println(theIndexVO5.biasNorm());
        System.out.println(theIndexVO6.biasNorm());
        System.out.println(theIndexVO7.biasNorm());
        System.out.println(theIndexVO8.biasNorm());
        System.out.println(theIndexVO9.biasNorm());
        System.out.println(theIndexVO10.biasNorm());
        System.out.println(theIndexVO11.biasNorm());
        System.out.println(theIndexVO12.biasNorm());
        System.out.println(theIndexVO13.biasNorm());
        System.out.println(theIndexVO14.biasNorm());
    }

}