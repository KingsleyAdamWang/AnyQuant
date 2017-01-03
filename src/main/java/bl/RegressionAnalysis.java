package bl;

import Jama.Matrix;
import bl.util.Convert;
import bl.util.MyDate;
import database.GetIndexData_DB;
import database.GetStockData_DB;
import po.IndexPO;
import po.StockPO;

/**
 * Created by zcy on 2016/5/29.
 * 根据今日开盘价，最高价，最低价，收盘价，成交量，成交额，次日开盘价，
 * 对次日收盘价进行多元线性回归分析，给出次日收盘价的预测
 */
public class RegressionAnalysis {
    /**
     * 线性回归方程中的回归系数
     */
    private double[] beita;
    /**
     * 自变量历史数据构成的矩阵
     */
    private Matrix X;
    /**
     * 因变量历史数据构成的矩阵
     */
    private Matrix Y;

    public RegressionAnalysis(String id){
        beita = new double[8];
        cal_beita(id);
    }

    /**
     * @param open 今日开盘价
     * @param high 最高价
     * @param low 最低价
     * @param close 今日收盘价
     * @param volume 成交量
     * @param volume_value 成交额
     * @param open_tom 次日开盘价
     * @return double
     * 根据得到的多元线性回归方程计算明日收盘价
     */
    public double close_estimate(double open,double high,double low,double close,
                                 double volume,double volume_value,double open_tom){
        double result = beita[0]+beita[1]*open+beita[2]*high+beita[3]*low+beita[4]*close+
                beita[5]*volume+beita[6]*volume_value+beita[7]*open_tom;
        return Double.parseDouble(Convert.remain2bit(result+""));
    }

    /**
     * @return String
     * 根据决定系数得到显著性分析的定性结果
     */
    public String getLevelOfSignificance(){
        double r2 = levelOfSignificance();
        if(r2>=0.9){
            return "可信度高";
        }
        else if(r2>=0.6){
            return "可信度中";
        }
        else{
            return "可信度低";
        }
    }

    /**
     * @return double
     * 对线性回归预测结果进行显著性分析，计算出决定系数
     * r^2 = Sr/St,Sr为回归偏差平方和，St为总的偏差平方和
     */
    private double levelOfSignificance(){
        int n = X.getRowDimension();
        double[][] jm = new double[n][n];
        for(int i=0;i<n;i++){
            for(int j=0;j<n;j++){
                jm[i][j]=1;
            }
        }
        Matrix J = new Matrix(jm);
        Matrix b = (X.transpose().times(X)).inverse().times(X.transpose()).times(Y);
        double ST = Y.transpose().times(Y).getArray()[0][0] - 1.0/15*(Y.transpose().times(J).times(Y)).getArray()[0][0];
        double SE = Y.transpose().times(Y).getArray()[0][0] - b.transpose().times(X.transpose()).times(Y).getArray()[0][0];
        double SR = ST-SE;
        return SR/ST;
    }

    /**
     * @param id 股票代号
     * 计算回归方程中的回归系数
     */
    private void cal_beita(String id){
        double[][] x;
        double[][] y;

        if(id.equals("hs300")){
            GetIndexData_DB getIndexData_db = new GetIndexData_DB();
            IndexPO indexPO = getIndexData_db.getIndexDataBetween(MyDate.getDate_NDaysAgo(365),MyDate.getDate_Today());
            int n = indexPO.getDate().length-1;
            x = new double[n][8];
            y = new double[n][1];

            for(int i=0;i<n;i++){
                x[i][0] = 1;
                x[i][1] = indexPO.getOpen()[i];
                x[i][2] = indexPO.getHigh()[i];
                x[i][3] = indexPO.getLow()[i];
                x[i][4] = indexPO.getClose()[i];
                x[i][5] = indexPO.getVolume()[i];
                x[i][6] = indexPO.getVolume()[i]*(indexPO.getHigh()[i]+indexPO.getLow()[i])/2;
                x[i][7] = indexPO.getOpen()[i+1];
            }

            for(int i=0;i<n;i++){
                y[i][0] = indexPO.getClose()[i+1];
            }
        }
        else{
            GetStockData_DB getStockData_db = new GetStockData_DB();
            StockPO stockPO = getStockData_db.getStockData_name(id, MyDate.getDate_NDaysAgo(365),MyDate.getDate_Today());
            int n = stockPO.getDate().length-1; //n是历史数据个数
            x = new double[n][8];
            y = new double[n][1];

            for(int i=0;i<n;i++){
                x[i][0] = 1;
                x[i][1] = stockPO.getOpen()[i];
                x[i][2] = stockPO.getHigh()[i];
                x[i][3] = stockPO.getLow()[i];
                x[i][4] = stockPO.getClose()[i];
                x[i][5] = stockPO.getVolume()[i];
                x[i][6] = stockPO.getVolume()[i]*(stockPO.getHigh()[i]+stockPO.getLow()[i])/2;
                x[i][7] = stockPO.getOpen()[i+1];
            }

            for(int i=0;i<n;i++){
                y[i][0] = stockPO.getClose()[i+1];
            }
        }


        X = new Matrix(x);
        Y = new Matrix(y);

        Matrix result_m = (X.transpose().times(X)).inverse().times(X.transpose()).times(Y);
        double[][] result = result_m.getArray();
        for(int i=0;i<8;i++){
            beita[i] = result[i][0];
        }
    }

    public static void main(String[] args){
        double[][] x = {{1,274,2450},{1,180,3250},{1,375,3802},{1,205,2838},{1,86,2347},
                {1,265,3782},{1,98,3008},{1,330,2450},{1,195,2137},{1,53,2560},{1,430,4020},
                {1,372,4427},{1,236,2660},{1,157,2088},{1,370,2605}};
        Matrix X = new Matrix(x);
        double[][] y = {{162},{120},{223},{131},{67},{169},{81},{192},{116},{55},
                {252},{232},{144},{103},{212}};
        Matrix Y = new Matrix(y);
        Matrix beita = (X.transpose().times(X)).inverse().times(X.transpose()).times(Y);
        double[][] re = beita.getArray();
        int row = beita.getRowDimension();
        int column = beita.getColumnDimension();
        for(int i=0;i<row;i++){
            for(int j=0;j<column;j++){
                System.out.println(re[i][j]);
            }
        }

        double[][] jm = new double[15][15];
        for(int i=0;i<15;i++){
            for(int j=0;j<15;j++){
                jm[i][j]=1;
            }
        }
        Matrix J = new Matrix(jm);
        double ST = Y.transpose().times(Y).getArray()[0][0] - 1.0/15*(Y.transpose().times(J).times(Y)).getArray()[0][0];
        double SE = Y.transpose().times(Y).getArray()[0][0] - beita.transpose().times(X.transpose()).times(Y).getArray()[0][0];
        double SR = ST-SE;
        double r2 = SR/ST;
        System.out.println(column);
    }


}
