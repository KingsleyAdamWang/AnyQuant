package blservice;

import vo.CurrentStockVO;

import java.io.IOException;

/**
 * Created by zcy on 2016/5/23.
 *
 */
public interface ShowCurrentDataService {
    public CurrentStockVO showCurrentData(String id) throws IOException;
}
