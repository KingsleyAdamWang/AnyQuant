package vo;

import bl.util.Convert;
import database.GetIndexData_DB;
import po.IndexPO;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by zcy on 2016/3/9.
 *
 */
public class IndexVO implements Serializable{
    private String name;
    private long[] volume;
    private double[] high;
    private double[] adj_price;
    private double[] low;
    private String[] date;
    private double[] close;
    private double[] open;
    /**
     * 大盘对应日期内的涨跌幅
     */
    private double[] increase_decreaseRate;
    /**
     * 大盘对应日期内的涨跌额
     */
    private double[] increase_decreaseNum;

    public IndexVO(IndexPO indexPO){
        volume = indexPO.getVolume();
        high = indexPO.getHigh();
        adj_price = indexPO.getAdj_price();
        low = indexPO.getLow();
        date = indexPO.getDate();
        close = indexPO.getClose();
        open = indexPO.getOpen();
        name = indexPO.getName();
        increase_decreaseRate = indexPO.getIncrease_decreaseRate();
        increase_decreaseNum = indexPO.getIncrease_decreaseNum();
    }

    public IndexVO(){

    }


    public long[] getVolume() {
        return volume;
    }


    public double[] getHigh() {
        return high;
    }


    public double[] getAdj_price() {
        return adj_price;
    }


    public double[] getLow() {
        return low;
    }


    public String[] getDate() {
        return date;
    }


    public double[] getClose() {
        return close;
    }


    public double[] getOpen() {
        return open;
    }


    public String getName() {
        return name;
    }

    public double[] getIncrease_decreaseRate() {
        return increase_decreaseRate;
    }

    public double[] getIncrease_decreaseNum() {
        return increase_decreaseNum;
    }

    /**
     * 将成交量进行数量级换算为万/千万/亿手后，以字符串形式返回
     *
     * @return 换算后的成交量
     */
    public String getDealNum(int n) {
        return Convert.getDealNum(volume[n]);
    }

    /**
     * @return String
     * 只转换最新的成交量数据
     */
    public String getDealNum(){
        return getDealNum(volume.length - 1);
    }

    /**
     * 将成交额进行数量级换算为万/亿后，以字符串形式返回
     *
     * @return 换算后的成交额
     */
    public String getDealAmount() {
        return Convert.getDealAmount(volume[volume.length - 1],high[high.length - 1],low[low.length - 1]);
    }

}

