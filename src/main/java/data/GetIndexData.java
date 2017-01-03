package data;

import bl.util.Convert;
import bl.util.MyDate;
import database.GetIndexData_DB;
import dataservice.GetIndexDataService;
import net.sf.json.JSONObject;
import po.CurrentIndexPO;
import po.IndexPO;

import java.io.IOException;

/**
 * Created by user on 2016/3/9.
 */
public class GetIndexData implements GetIndexDataService {

    /**
     * 得到最新的大盘数据
     *
     * @return IndexPO
     */
    public IndexPO getLatestIndexData() throws IOException {
        ReadData rdt = new ReadData();
        String url = "http://121.41.106.89:8010/api/benchmark/hs300?start=2012-11-01&end="+ MyDate.getDate_Today();
        String result = rdt.getData(url);
        String s1 = rdt.parseJSON(result, "data");
        String[] trading_info = rdt.parseJSON_array(s1, "trading_info");

        int num=0;
        for(int i=0;i<trading_info.length;i++){
            JSONObject jsonObject = JSONObject.fromObject(trading_info[i]);
            if(jsonObject.getString("volume").equals("0")){
                num++;
            }
        }//计算无用数据的个数
        long[] volume = new long[trading_info.length-num];
        double[] high = new double[trading_info.length-num];
        double[] adj_price = new double[trading_info.length-num];
        double[] low = new double[trading_info.length-num];
        double[] close = new double[trading_info.length-num];
        double[] open = new double[trading_info.length-num];
        String[] date = new String[trading_info.length-num];
        double[] increase_decreaseRate = new double[trading_info.length-num];
        double[] increase_decreaseNum = new double[trading_info.length-num];
        IndexPO indexPO = new IndexPO(trading_info.length-num);
        int k = 0;
        for (int i = 0; i < trading_info.length; i++) {

            JSONObject jsonObject = JSONObject.fromObject(trading_info[i]);

            if(jsonObject.getString("volume").equals("0")){
                continue;
            }

            volume[k] = Long.parseLong(jsonObject.getString("volume"));
            high[k] = Double.parseDouble(jsonObject.getString("high"));
            adj_price[k] = Double.parseDouble(jsonObject.getString("adj_price"));
            low[k] = Double.parseDouble(jsonObject.getString("low"));
            date[k] = jsonObject.getString("date");
            close[k] = Double.parseDouble(jsonObject.getString("close"));
            open[k] = Double.parseDouble(jsonObject.getString("open"));

            if(k>=1){
                increase_decreaseRate[k] = ((double) Math.round((close[k] - close[k - 1]) / close[k - 1] * 10000)) / 10000;
                increase_decreaseNum[k] = close[k]-close[k-1];
            }

            k++;
        }
        indexPO.setVolume(volume);
        indexPO.setHigh(high);
        indexPO.setAdj_price(adj_price);
        indexPO.setLow(low);
        indexPO.setDate(date);
        indexPO.setClose(close);
        indexPO.setOpen(open);
        indexPO.setIncrease_decreaseRate(increase_decreaseRate);
        indexPO.setIncrease_decreaseNum(increase_decreaseNum);
        JSONObject jsonObject1 = JSONObject.fromObject(s1);
        indexPO.setName(jsonObject1.getString("name"));

        return indexPO;
    }

    /**
     * @param date1
     * @param date2
     * @return IndexPO
     * @throws IOException
     * date1和date2的格式是yyyyMMdd
     */
    public IndexPO getIndexDataBetween(String date1,String date2) throws IOException {
        ReadData rdt = new ReadData();
        String url;
        if(date1.charAt(4)!='-'){
            String d1 = date1.substring(0,4)+"-"+date1.substring(4,6)+"-"+date1.substring(6);//给date1加上-
            String d2 = date2.substring(0,4)+"-"+date2.substring(4,6)+"-"+date2.substring(6);//给date2加上-
            url = "http://121.41.106.89:8010/api/benchmark/hs300?start="+d1+"&end="+d2;
        }
        else{
            url = "http://121.41.106.89:8010/api/benchmark/hs300?start="+date1+"&end="+date2;
        }
        String result = rdt.getData(url);
        String s1 = rdt.parseJSON(result, "data");
        String[] trading_info = rdt.parseJSON_array(s1, "trading_info");

        int num=0;
        for(int i=0;i<trading_info.length;i++){
            JSONObject jsonObject = JSONObject.fromObject(trading_info[i]);
            if(jsonObject.getString("volume").equals("0")){
                num++;
            }
        }//计算无用数据的个数
        long[] volume = new long[trading_info.length-num];
        double[] high = new double[trading_info.length-num];
        double[] adj_price = new double[trading_info.length-num];
        double[] low = new double[trading_info.length-num];
        double[] close = new double[trading_info.length-num];
        double[] open = new double[trading_info.length-num];
        String[] date = new String[trading_info.length-num];
        double[] increase_decreaseRate = new double[trading_info.length-num];
        double[] increase_decreaseNum = new double[trading_info.length-num];
        IndexPO indexPO = new IndexPO(trading_info.length-num);
        int k = 0;
        for (int i = 0; i < trading_info.length; i++) {

            JSONObject jsonObject = JSONObject.fromObject(trading_info[i]);

            if(jsonObject.getString("volume").equals("0")){
                continue;
            }

            volume[k] = Long.parseLong(jsonObject.getString("volume"));
            high[k] = Double.parseDouble(jsonObject.getString("high"));
            adj_price[k] = Double.parseDouble(jsonObject.getString("adj_price"));
            low[k] = Double.parseDouble(jsonObject.getString("low"));
            date[k] = jsonObject.getString("date");
            close[k] = Double.parseDouble(jsonObject.getString("close"));
            open[k] = Double.parseDouble(jsonObject.getString("open"));

            if(k>=1){
                increase_decreaseRate[k] = ((double) Math.round((close[k] - close[k - 1]) / close[k - 1] * 10000)) / 10000;
                increase_decreaseNum[k] = close[k]-close[k-1];
            }

            k++;
        }
        indexPO.setVolume(volume);
        indexPO.setHigh(high);
        indexPO.setAdj_price(adj_price);
        indexPO.setLow(low);
        indexPO.setDate(date);
        indexPO.setClose(close);
        indexPO.setOpen(open);
        indexPO.setIncrease_decreaseRate(increase_decreaseRate);
        indexPO.setIncrease_decreaseNum(increase_decreaseNum);
        JSONObject jsonObject1 = JSONObject.fromObject(s1);
        indexPO.setName(jsonObject1.getString("name"));

        return indexPO;
    }

    /**
     * @return IndexPO
     * 得到最新一天的大盘数据
     */
    public CurrentIndexPO getCurrentIndexData(){
        GetIndexData_DB getIndexData_db = new GetIndexData_DB();
        IndexPO temp = getIndexData_db.getIndexDataBetween("2016-05-15",MyDate.getDate_Today());
        int length = temp.getDate().length;
        CurrentIndexPO currentIndexPO = new CurrentIndexPO();
        currentIndexPO.setCurrentPrice(temp.getClose()[length-1]+"");
        currentIndexPO.setIncrease_decreaseRate(temp.getIncrease_decreaseRate()[length-1]+"%");
        currentIndexPO.setIncrease_decreaseNum(temp.getIncrease_decreaseNum()[length-1]+"");
        currentIndexPO.setHigh(temp.getHigh()[length-1]+"");
        currentIndexPO.setLow(temp.getLow()[length-1]+"");
        currentIndexPO.setOpen(temp.getOpen()[length-1]+"");
        currentIndexPO.setClose(temp.getClose()[length-2]+"");
        currentIndexPO.setVolume(Convert.getDealNum(temp.getVolume()[length-1]));
        currentIndexPO.setVolume_value(Convert.getDealAmount(temp.getVolume()[length-1],temp.getHigh()[length-1],temp.getLow()[length-1]));
        return currentIndexPO;
    }


}
