package vo;

import po.ReducedStockNewsPO;

/**
 * Created by zcy on 2016/6/13.
 *
 */
public class ReducedStockNewsVO {
    /**
     * 股票代号
     */
    private String id;
    /**
     * 新闻标题
     */
    private String title;

    public ReducedStockNewsVO(){}

    public ReducedStockNewsVO(ReducedStockNewsPO reducedStockNewsPO){
        id = reducedStockNewsPO.getId();
        title = reducedStockNewsPO.getTitle();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
