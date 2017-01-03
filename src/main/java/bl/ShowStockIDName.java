package bl;

import blservice.ShowStockIDNameService;
import data.StockId2Name;
import database.GetStockData_DB;
import vo.StockIDNameVO;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zcy on 2016/5/14.
 *
 */
public class ShowStockIDName implements ShowStockIDNameService{

    /**
     * @param s 股票代号或名称
     * @return StockIDNameVO
     * 根据股票id或者名称得到股票的IDNameVO
     */
    public StockIDNameVO getStockIdAndName(String s){
        StockIDNameVO stockIDNameVO = new StockIDNameVO();
        if(s.length()==4){
            //如果传的是股票名称
            stockIDNameVO.setName(s);
            stockIDNameVO.setId(StockId2Name.getStockId(s));
        }
        else{
            stockIDNameVO.setId(s);
            stockIDNameVO.setName(StockId2Name.getStockName(s));
        }
        return stockIDNameVO;
    }
    
    /**
     * @return List<StockIDNameVO>
     * 得到所有银行股的代号和名称
     */
    public List<StockIDNameVO> getAllStockIdAndName(){
        List<StockIDNameVO> stockIDNameVOList = new ArrayList<>();
        for(int i=0;i< GetStockData_DB.stock_id.length;i++){
            StockIDNameVO stockIDNameVO = getStockIdAndName(GetStockData_DB.stock_id[i]);
            stockIDNameVOList.add(stockIDNameVO);
        }
        return stockIDNameVOList;
    }
}
