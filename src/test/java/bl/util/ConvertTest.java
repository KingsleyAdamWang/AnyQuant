package bl.util;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by zcy on 2016/6/2.
 *
 */
public class ConvertTest {
    @Test
    public void getDealNumTest(){
        assertEquals("1.10亿手",Convert.getDealNum(11000000000L));
        assertEquals("2.00千万手",Convert.getDealNum(2000000000));
        assertEquals("3.22万手",Convert.getDealNum(3220000));
    }

    @Test
    public void getDealAmountTest(){
        assertEquals(".95亿",Convert.getDealAmount(10000000,10,9));
    }

    @Test
    public void remain2bitTest(){
        assertEquals("3.22",Convert.remain2bit("3.22333"));
    }

}