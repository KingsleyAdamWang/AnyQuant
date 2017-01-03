package vo;

import po.CurrentIndexPO;
import po.CurrentStockPO;

import java.io.Serializable;

/**
 * Created by zcy on 2016/5/23.
 *
 */
public class CurrentIndexVO implements Serializable {
    /**
     * 当前价格
     */
    private String currentPrice;
    /**
     * 今日开盘价
     */
    private String open;
    /**
     * 昨日收盘价
     */
    private String close;
    /**
     * 最高价
     */
    private String high;
    /**
     * 最低价
     */
    private String low;
    /**
     * 成交量，单位是万手
     */
    private String volume;
    /**
     * 成交金额，单位是万元
     */
    private String volume_value;
    /**
     * 涨跌额
     */
    private String increase_decreaseNum;
    /**
     * 涨跌幅
     */
    private String increase_decreaseRate;

    public CurrentIndexVO(CurrentIndexPO currentIndexPO){
        currentPrice = currentIndexPO.getCurrentPrice();
        open = currentIndexPO.getOpen();
        close = currentIndexPO.getClose();
        high = currentIndexPO.getHigh();
        low = currentIndexPO.getLow();
        volume = currentIndexPO.getVolume();
        volume_value = currentIndexPO.getVolume_value();
        increase_decreaseNum = currentIndexPO.getIncrease_decreaseNum();
        increase_decreaseRate = currentIndexPO.getIncrease_decreaseRate();
    }

    public String getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(String currentPrice) {
        this.currentPrice = currentPrice;
    }

    public String getOpen() {
        return open;
    }

    public void setOpen(String open) {
        this.open = open;
    }

    public String getClose() {
        return close;
    }

    public void setClose(String close) {
        this.close = close;
    }

    public String getHigh() {
        return high;
    }

    public void setHigh(String high) {
        this.high = high;
    }

    public String getLow() {
        return low;
    }

    public void setLow(String low) {
        this.low = low;
    }

    public String getVolume() {
        return volume;
    }

    public void setVolume(String volume) {
        this.volume = volume;
    }

    public String getVolume_value() {
        return volume_value;
    }

    public void setVolume_value(String volume_value) {
        this.volume_value = volume_value;
    }

    public String getIncrease_decreaseNum() {
        return increase_decreaseNum;
    }

    public void setIncrease_decreaseNum(String increase_decreaseNum) {
        this.increase_decreaseNum = increase_decreaseNum;
    }

    public String getIncrease_decreaseRate() {
        return increase_decreaseRate;
    }

    public void setIncrease_decreaseRate(String increase_decreaseRate) {
        this.increase_decreaseRate = increase_decreaseRate;
    }

}
