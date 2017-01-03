package vo;

import bl.RegressionAnalysis;
import bl.ShowStockData;
import bl.util.Convert;
import bl.util.ReadConclusion;
import database.GetStockData_DB;
import po.StockPO;

import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;

/**
 * Created by zcy on 2016/4/13.
 * 股票和大盘的各项指标
 */
public class TheIndexVO implements Serializable {
    /**
     * 股票代号
     */
    private String id;
    /**
     * 乖离率
     */
    private double bias;

    /**
     * 相对强弱指标
     * 变动范围0~100
     */
    private double RSI;

    /**
     * 威廉超买超卖指标
     * 变动范围0~100
     */
    private double WM;

    /**
     * 人气指标
     */
    private double AR;

    /**
     * 意愿指标
     */
    private double BR;

    /**
     * 成交量变异率
     */
    private double VR;

    //为了使得出的结论更准确，每个指标计算近5天的数据
    private double[] biases;
    private double[] RSIs; //need
    private double[] WMs;
    private double[] ARs; //need
    private double[] BRs; //need

    public TheIndexVO(String id){
        this.id = id;
        biases = new double[5];
        RSIs = new double[5];
        WMs = new double[5];
        ARs = new double[5];
        BRs = new double[5];
    }

    public TheIndexVO(){}


    public double getBias() {
        return bias;
    }

    public void setBias(double bias) {
        this.bias = bias;
    }

    public double getRSI() {
        return RSI;
    }

    public void setRSI(double RSI) {
        this.RSI = RSI;
    }

    public double getWM() {
        return WM;
    }

    public void setWM(double WM) {
        this.WM = WM;
    }

    public double getAR() {
        return AR;
    }

    public void setAR(double AR) {
        this.AR = AR;
    }

    public double getBR() {
        return BR;
    }

    public void setBR(double BR) {
        this.BR = BR;
    }

    public double getVR() {
        return VR;
    }

    public void setVR(double VR) {
        this.VR = VR;
    }

    public double biasNorm(){
        return Math.round(Math.abs(bias*50)*100)/100.0;
    }

    public double ARNorm() {
        if (AR >= 180) {
            return 100.00;
        }
        else{
            return ((double)Math.round((AR/180.0*100)*100))/100;
        }
    }

    public double BRNorm() {
        if(BR<0){
            return 0;
        }
        else if (BR >= 180) {
            return 100.00;
        }
        else{
            return ((double)Math.round((BR/180.0*100)*100))/100;
        }
    }

    public String conclusion1() throws SQLException {
        //对该指标的介绍
        String intro = "&nbsp;&nbsp;&nbsp;&nbsp;"+ ReadConclusion.bias_intro+"<br />";
        //对指标的分析结论
        String conclusion = "&nbsp;&nbsp;&nbsp;&nbsp;乖离率为"+((double)Math.round(bias*100))/100+"%,";
        if (bias >= 5) {
            conclusion += ReadConclusion.bias_c[0];
        } else if (bias <= -5) {
            conclusion += ReadConclusion.bias_c[1];
        } else {
            StockPO stockPO = new GetStockData_DB().getLatestStock(id);
            if(stockPO.getIncrease_decreaseRate()[0]>0 && bias<0){
                conclusion += ReadConclusion.bias_c[2];
            }
            else if(stockPO.getIncrease_decreaseRate()[0]<0 && bias>0){
                conclusion += ReadConclusion.bias_c[3];
            }
            else{
                conclusion += ReadConclusion.bias_c[4];
            }
        }
        return intro+conclusion;
    }

    public String conclusion2() {
        //对该指标的介绍
        String intro = "&nbsp;&nbsp;&nbsp;&nbsp;"+ReadConclusion.RSI_intro+"<br />";
        //对指标的分析结论
        String conclusion = "&nbsp;&nbsp;&nbsp;&nbsp;相对强弱指标为"+RSI+",";
        if(RSI > 50){
            conclusion += ReadConclusion.RSI_c[0];
        }
        else{
            conclusion += ReadConclusion.RSI_c[1];
        }
        if (RSI > 80) {
            conclusion += ReadConclusion.RSI_c[2];
        } else if (RSI < 20) {
            conclusion += ReadConclusion.RSI_c[3];
        } else if (RSI < 40) {
            conclusion += ReadConclusion.RSI_c[4];
        } else if(RSI > 60){
            conclusion += ReadConclusion.RSI_c[5];
        }
        else{
            if(RSIs[3]<50&&RSIs[4]>50){
                conclusion += ReadConclusion.RSI_c[6];
            }
            else if(RSIs[3]>50&&RSIs[4]<50){
                conclusion += ReadConclusion.RSI_c[7];
            }
            else{
                conclusion += ReadConclusion.RSI_c[8];
            }
        }
        return intro+conclusion;
    }

    public String conclusion3() {
        //对该指标的介绍
        String intro = "&nbsp;&nbsp;&nbsp;&nbsp;"+ReadConclusion.WM_intro+"<br />";
        //对指标的分析结论
        String conclusion = "&nbsp;&nbsp;&nbsp;&nbsp;威廉超买超卖指标为"+WM+",";
        if (WM > 80) {
            conclusion += ReadConclusion.WM_c[0];
        } else if (WM < 20) {
            conclusion += ReadConclusion.WM_c[1];
        } else {
            conclusion += ReadConclusion.WM_c[2];
        }
        return intro+conclusion;
    }

    public String conclusion4() {
        //对该指标的介绍
        String intro = "&nbsp;&nbsp;&nbsp;&nbsp;"+ReadConclusion.ARBR_intro+"<br />";
        //对指标的分析结论
        String conclusion = "&nbsp;&nbsp;&nbsp;&nbsp;人气指标为"+AR+",<br />&nbsp;&nbsp;&nbsp;&nbsp;意愿指标为"+BR+"。<br />&nbsp;&nbsp;&nbsp;&nbsp;";
        if (BR < AR && BR<100) {
            conclusion += ReadConclusion.ARBR_c[0];
        } else if (BR < AR && AR<50) {
            conclusion += ReadConclusion.ARBR_c[1];
        } else if(ARs[1]>ARs[0] && ARs[2]>ARs[1] && ARs[3]>ARs[2] && ARs[4]>ARs[3]
                && BRs[1]>BRs[0] && BRs[2]>BRs[1] && BRs[3]>BRs[2] && BRs[4]>BRs[3]){
            conclusion += ReadConclusion.ARBR_c[2];
        } else if(BRs[1]>BRs[0] && BRs[2]>BRs[1] && BRs[3]>BRs[2] && BRs[4]>BRs[3]){
            conclusion += ReadConclusion.ARBR_c[3];
        } else if(BRs[4] < BRs[3]/2.0){
            conclusion += ReadConclusion.ARBR_c[4];
        }
        else{
            conclusion += ReadConclusion.ARBR_c[5];
        }
        return intro+conclusion;
    }

    public String conclusion5() throws IOException, SQLException {
        RegressionAnalysis regressionAnalysis = new RegressionAnalysis(id);
        String conclusion = "&nbsp;&nbsp;&nbsp;&nbsp;【预测】 ";
        ShowStockData showStockData = new ShowStockData();
        StockVO stockVO = showStockData.getLatestStockData(id);
//        conclusion += stockVO.getOpen()[0];
//        conclusion += (" ,最高价: "+stockVO.getHigh()[0]);
//        conclusion += (" ,最低价: "+stockVO.getLow()[0]);
//        conclusion += (" ,收盘价: "+stockVO.getClose()[0]);
//        conclusion += (" ,成交量: "+stockVO.getVolume()[0]);
        double volumeValue = stockVO.getVolume()[0]*(stockVO.getHigh()[0]+stockVO.getLow()[0])/2;
//        conclusion += (" ,成交额: "+ Convert.getDealAmount(stockVO.getVolume()[0],stockVO.getHigh()[0],stockVO.getLow()[0]));
//        conclusion += (" ,当日开盘价:"+(stockVO.getClose()[0]+stockVO.getIncrease_decreaseNum()[0]));
        conclusion += (" <br />&nbsp;&nbsp;&nbsp;&nbsp;预测当日收盘价为: "+regressionAnalysis.close_estimate(stockVO.getOpen()[0],stockVO.getHigh()[0],stockVO.getLow()[0],stockVO.getClose()[0],stockVO.getVolume()[0],volumeValue,stockVO.getClose()[0]+stockVO.getIncrease_decreaseNum()[0]));
        conclusion += "。<br />&nbsp;&nbsp;&nbsp;&nbsp;预测可靠程度：";
        conclusion += (regressionAnalysis.getLevelOfSignificance()+"。");
        return conclusion;
    }

    public double[] getBiases() {
        return biases;
    }

    public void setBiases(double[] biases) {
        this.biases = biases;
    }

    public double[] getRSIs() {
        return RSIs;
    }

    public void setRSIs(double[] RSIs) {
        this.RSIs = RSIs;
    }

    public double[] getWMs() {
        return WMs;
    }

    public void setWMs(double[] WMs) {
        this.WMs = WMs;
    }

    public double[] getARs() {
        return ARs;
    }

    public void setARs(double[] ARs) {
        this.ARs = ARs;
    }

    public double[] getBRs() {
        return BRs;
    }

    public void setBRs(double[] BRs) {
        this.BRs = BRs;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
