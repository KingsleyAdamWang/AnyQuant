package bl;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by zcy on 2016/6/1.
 *
 */
public class RegressionAnalysisTest {
    @Test
    public void close_estimateTest(){
        RegressionAnalysis regressionAnalysis = new RegressionAnalysis("sh600015");
        double result = regressionAnalysis.close_estimate(10.18,10.23,10.12,10.2,18090000,184000000,10.18);
        assertEquals(10.16,result,0.001);
    }

    @Test
    public void getLevelOfSignificanceTest(){
        RegressionAnalysis regressionAnalysis = new RegressionAnalysis("sh600015");
        assertEquals("可信度高",regressionAnalysis.getLevelOfSignificance());
    }

}