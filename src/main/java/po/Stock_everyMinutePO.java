package po;

/**
 * Created by zcy on 2016/5/24.
 * 股票分时图的数据
 */
public class Stock_everyMinutePO {
    /**
     * 股票代号
     */
    private String id;
    /**
     * 当前价格
     */
    private String[] price;
    /**
     * 当前成交量
     */
    private String[] volume;
    /**
     * 当前均价
     */
    private String[] price_mean;
    /**
     * 当前涨跌额
     */
    private String[] increase_decreaseNum;
    /**
     * 当前涨跌幅
     */
    private String[] increase_decreaseRate;
    /**
     * 当前时间
     */
    private String[] time;

    public Stock_everyMinutePO() {
        price = new String[240];
        volume = new String[240];
        price_mean = new String[240];
        increase_decreaseNum = new String[240];
        increase_decreaseRate = new String[240];
        time = new String[240];
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String[] getPrice() {
        return price;
    }

    public void setPrice(String[] price) {
        this.price = price;
    }

    public String[] getVolume() {
        return volume;
    }

    public void setVolume(String[] volume) {
        this.volume = volume;
    }

    public String[] getPrice_mean() {
        return price_mean;
    }

    public void setPrice_mean(String[] price_mean) {
        this.price_mean = price_mean;
    }

    public String[] getIncrease_decreaseNum() {
        return increase_decreaseNum;
    }

    public void setIncrease_decreaseNum(String[] increase_decreaseNum) {
        this.increase_decreaseNum = increase_decreaseNum;
    }

    public String[] getIncrease_decreaseRate() {
        return increase_decreaseRate;
    }

    public void setIncrease_decreaseRate(String[] increase_decreaseRate) {
        this.increase_decreaseRate = increase_decreaseRate;
    }

    public String[] getTime() {
        return time;
    }

    public void setTime(String[] time) {
        this.time = time;
    }
}
