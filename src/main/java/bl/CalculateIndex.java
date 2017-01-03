package bl;

import bl.util.ReadConclusion;
import blservice.CalculateIndexService;
import vo.IndexVO;
import vo.StockVO;
import vo.TheIndexVO;

import java.io.IOException;

/**
 * Created by zcy on 2016/4/13.
 * 计算股票的各种指标
 */
public class CalculateIndex implements CalculateIndexService{
    static {
        try {
            ReadConclusion readConclusion = new ReadConclusion();
            ReadConclusion.initConclusion();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private TheIndexVO theIndexVO;

    public TheIndexVO getTheIndex(StockVO stockVO){
        theIndexVO = new TheIndexVO(stockVO.getId());
        theIndexVO.setBias(calculateBias(stockVO));
        theIndexVO.setRSI(calculateRSI(stockVO));
        theIndexVO.setWM(calculateWM(stockVO));
        theIndexVO.setAR(calculateAR(stockVO));
        theIndexVO.setBR(calculateBR(stockVO));
        theIndexVO.setVR(calculateVR(stockVO)); //useless
        theIndexVO.setRSIs(calculateRSI_M(stockVO));
        theIndexVO.setARs(calculateAR_M(stockVO));
        theIndexVO.setBRs(calculateBR_M(stockVO));
        return theIndexVO;
    }

    public TheIndexVO getTheIndex(IndexVO indexVO){
        theIndexVO = new TheIndexVO();
        theIndexVO.setBias(calculateBias(indexVO));
        theIndexVO.setRSI(calculateRSI(indexVO));
        theIndexVO.setWM(calculateWM(indexVO));
        theIndexVO.setAR(calculateAR(indexVO));
        theIndexVO.setBR(calculateBR(indexVO));
        theIndexVO.setVR(calculateVR(indexVO));
        return theIndexVO;
    }

    private double calculateBias(StockVO stockVO){
        int length = stockVO.getDate().length;
        double[] closes = new double[5];
        for(int i=length-1;i>=length-5;i--){
            closes[length-1-i] = stockVO.getClose()[i];
        }
        return calBias(closes);
    }

    private double calculateBias(IndexVO indexVO){
        int length = indexVO.getDate().length;
        double[] closes = new double[5];
        for(int i=length-1;i>=length-5;i--){
            closes[length-1-i] = indexVO.getClose()[i];
        }
        return calBias(closes);
    }

    private double calculateRSI(StockVO stockVO){
        int length = stockVO.getDate().length;
        double[] closes = new double[15]; //[0]是最近的收盘价
        for(int i=length-1;i>=length-15;i--){
            closes[length-1-i] = stockVO.getClose()[i];
        }
        return calRSI(closes);
    }

    private double[] calculateRSI_M(StockVO stockVO){
        double[] RSIs = new double[5];
        int length = stockVO.getDate().length;
        for(int t=0;t<5;t++){
            double[] closes = new double[15]; //[0]是最近的收盘价
            for(int i=length-1-15*t;i>=length-15-15*t;i--){
                closes[length-1-15*t-i] = stockVO.getClose()[i];
            }
            RSIs[t] = calRSI(closes);
        }
        return RSIs;
    }

    private double calculateRSI(IndexVO indexVO){
        int length = indexVO.getDate().length;
        double[] closes = new double[15]; //[0]是最近的收盘价
        for(int i=length-1;i>=length-15;i--){
            closes[length-1-i] = indexVO.getClose()[i];
        }
        return calRSI(closes);
    }

    private double calculateWM(StockVO stockVO){
        int length = stockVO.getDate().length;
        double close = stockVO.getClose()[length-1];
        double[] high = new double[22];
        double[] low = new double[22];
        for(int i=length-1;i>=length-22;i--){
            high[length-1-i] = stockVO.getHigh()[i];
            low[length-1-i]  =stockVO.getLow()[i];
        }
        return calWM(high,low,close);
    }

    private double calculateWM(IndexVO indexVO){
        int length = indexVO.getDate().length;
        double[] high = new double[22];
        double[] low = new double[22];
        double close = indexVO.getClose()[length-1];
        for(int i=length-1;i>=length-22;i--){
            high[length-1-i] = indexVO.getHigh()[i];
            low[length-1-i]  = indexVO.getLow()[i];
        }
        return calWM(high,low,close);
    }

    private double calculateAR(StockVO stockVO){
        int length = stockVO.getDate().length;
        double[] opens = new double[20];
        double[] highs = new double[20];
        double[] lows = new double[20];
        for(int i=length-1;i>=length-20;i--){
            opens[length-1-i] = stockVO.getOpen()[i];
        }
        for(int i=length-1;i>=length-20;i--){
            highs[length-1-i] = stockVO.getHigh()[i];
        }
        for(int i=length-1;i>=length-20;i--){
            lows[length-1-i] = stockVO.getLow()[i];
        }
       return calAR(highs,lows,opens);
    }

    private double[] calculateAR_M(StockVO stockVO){
        double[] ARs = new double[5];
        int length = stockVO.getDate().length;
        for(int t=0;t<5;t++){
            double[] opens = new double[20];
            double[] highs = new double[20];
            double[] lows = new double[20];
            for(int i=length-1-20*t;i>=length-20-20*t;i--){
                opens[length-1-20*t-i] = stockVO.getOpen()[i];
            }
            for(int i=length-1-20*t;i>=length-20-20*t;i--){
                highs[length-1-20*t-i] = stockVO.getHigh()[i];
            }
            for(int i=length-1-20*t;i>=length-20-20*t;i--){
                lows[length-1-20*t-i] = stockVO.getLow()[i];
            }
            ARs[t] = calAR(highs,lows,opens);
        }
        return ARs;
    }

    private double calculateAR(IndexVO indexVO){
        int length = indexVO.getDate().length;
        double[] opens = new double[20];
        double[] highs = new double[20];
        double[] lows = new double[20];
        for(int i=length-1;i>=length-20;i--){
            opens[length-1-i] = indexVO.getOpen()[i];
        }
        for(int i=length-1;i>=length-20;i--){
            lows[length-1-i] = indexVO.getLow()[i];
        }
        for(int i=length-1;i>=length-20;i--){
            highs[length-1-i] = indexVO.getHigh()[i];
        }

       return calAR(highs,lows,opens);
    }

    private double calculateBR(StockVO stockVO){
        int length = stockVO.getDate().length;
        double[] closes = new double[20];
        double[] highs = new double[20];
        double[] lows = new double[20];
        for(int i=length-1;i>=length-20;i--){
            lows[length-1-i] = stockVO.getLow()[i];
        }
        for(int i=length-2;i>=length-21;i--){
            closes[length-2-i] = stockVO.getClose()[i];
        }
        for(int i=length-1;i>=length-20;i--){
            highs[length-1-i] = stockVO.getHigh()[i];
        }

        return calBR(closes,highs,lows);
    }

    private double[] calculateBR_M(StockVO stockVO){
        double[] BRs = new double[5];
        int length = stockVO.getDate().length;
        for(int t=0;t<5;t++){
            double[] closes = new double[20];
            double[] highs = new double[20];
            double[] lows = new double[20];
            for(int i=length-1-20*t;i>=length-20-20*t;i--){
                lows[length-1-20*t-i] = stockVO.getLow()[i];
            }
            for(int i=length-2-20*t;i>=length-21-20*t;i--){
                closes[length-2-20*t-i] = stockVO.getClose()[i];
            }
            for(int i=length-1-20*t;i>=length-20-20*t;i--){
                highs[length-1-20*t-i] = stockVO.getHigh()[i];
            }
            BRs[t] = calBR(closes,highs,lows);
        }
        return BRs;
    }

    private double calculateBR(IndexVO indexVO){
        int length = indexVO.getDate().length;
        double[] closes = new double[20];
        double[] highs = new double[20];
        double[] lows = new double[20];
        for(int i=length-2;i>=length-21;i--){
            closes[length-2-i] = indexVO.getClose()[i];
        }
        for(int i=length-1;i>=length-20;i--){
            highs[length-1-i] = indexVO.getHigh()[i];
        }
        for(int i=length-1;i>=length-20;i--){
            lows[length-1-i] = indexVO.getLow()[i];
        }
        return calBR(closes,highs,lows);

    }

    private double calculateVR(IndexVO indexVO){
        int length = indexVO.getDate().length;
        double[] closes = new double[20];
        double[] opens = new double[20];
        double[] volume = new double[20];
        for(int i=length-2;i>=length-21;i--){
            closes[length-2-i] = indexVO.getClose()[i];
            opens[length-2-i] = indexVO.getOpen()[i];
            volume[length-2-i] = indexVO.getVolume()[i];
        }
        return calVR(closes,opens,volume);
    }

    private double calculateVR(StockVO stockVO){
        int length = stockVO.getDate().length;
        double[] closes = new double[20];
        double[] opens = new double[20];
        double[] volume = new double[20];
        for(int i=length-2;i>=length-21;i--){
            volume[length-2-i] = stockVO.getVolume()[i];
            closes[length-2-i] = stockVO.getClose()[i];
            opens[length-2-i] = stockVO.getOpen()[i];
        }
        return calVR(closes,opens,volume);
    }

    private double calBias(double[] closes){
        double close = closes[0];
        double sum = 0;
        for(int i = 0;i<5;i++){
            sum+=closes[i];
        }
        double avg = sum/5.0;
        double result = (close-avg)/avg*100;
        return ((double)Math.round(result*10000))/10000;
    }

    private double calRSI(double[] closes){
        double sum1 = 0; //上涨总幅度
        for(int i=0;i<14;i++){
            if(closes[i]>closes[i+1]){
                sum1+=(closes[i]-closes[i+1]);
            }
        }
        double avg1 = sum1/14;
        double sum2 = 0; //下跌总幅度
        for(int i=0;i<14;i++){
            if(closes[i]<closes[i+1])
            sum2+=Math.abs(closes[i]-closes[i+1]);
        }
        double avg2 = sum2/14;
        double RS = avg1/avg2;
        double result = RS/(1+RS)*100;
        return ((double)Math.round(result*100))/100;
    }

    private double calWM(double[] high,double[] low,double close){
        int k = 0;
        for(int i=0;i<high.length;i++){
            if(high[i]>high[k]){
                k = i;
            }
        }
        double h = high[k]; //30天内的最高价

        k = 0;
        for(int i=0;i<low.length;i++){
            if(low[i]<low[k]){
                k = i;
            }
        }
        double l = low[k]; //30天内的最低价
        double result = (h-close)/(h-l)*100;
        return ((double)Math.round(result*100))/100;
    }

    private double calAR(double[] highs,double[] lows,double[] opens){
        double sum1 = 0;
        for(int i=0;i<opens.length;i++){
            sum1+=(highs[i]-opens[i]);
        }
        double sum2 = 0;
        for(int i=0;i<opens.length;i++){
            sum2+=(opens[i]-lows[i]);
        }
        double result = sum1/sum2*100;
        return ((double)Math.round(result*100))/100;
    }

    private double calBR(double[] closes,double[] highs,double[] lows){
        double sum1 = 0;
        double sum2 = 0;
        for(int i=0;i<closes.length;i++){
            sum1+=(highs[i]-closes[i]);
        }

        for(int i=0;i<closes.length;i++){
            sum2+=(closes[i]-lows[i]);
        }
        double result = sum1/sum2*100;
        return ((double)Math.round(result*100))/100;
    }

    private double calVR(double[] closes,double[] opens,double[] volume){
        int AVS,BVS,CVS;
        AVS=0;
        BVS=0;
        CVS=0;
        double VR;
        for(int i = 0;i<opens.length;i++){
            if(closes[i]-opens[i]>0){
                AVS+=volume[i];
            }else if(closes[i]-opens[i]<0){
                BVS+=volume[i];
            }else{
                CVS+=volume[i];
            }
        }
        VR = ((AVS+CVS*0.5)/(BVS+CVS*0.5));
        return ((double)Math.round(VR*100))/100;
    }
}
