package bl.util;

import java.math.BigDecimal;

/**
 * Created by zcy on 2016/5/28.
 * 用来给成交量、成交额等数据进行单位转换
 */
public class Convert {
    /**
     * 将成交量进行数量级换算为万/千万/亿手后，以字符串形式返回
     *
     * @return 换算后的成交量
     */
    public static String getDealNum(long data) {
        StringBuilder temp = new StringBuilder(data + "");
        int length = temp.length();//一手等于100股

        if (length >= 11) {//11位数，数量级为亿,保留到百万位
            temp.delete(temp.length() - 8, temp.length());
            temp.insert(temp.length() - 2, '.');
            temp.append("亿手");
        } else if(length>=10){
            temp.delete(temp.length() - 7, temp.length());
            temp.insert(temp.length() - 2, '.');
            temp.append("千万手");
        }
        else if (length >= 7) {//7位数，数量级为万，保留到百位
            temp.delete(temp.length() - 4, temp.length());
            temp.insert(temp.length() - 2, '.');
            temp.append("万手");
        } else {
            temp.append("手");
        }

        return temp.toString();
    }

    /**
     * 将成交额进行数量级换算为万/亿后，以字符串形式返回
     *
     * @return 换算后的成交额
     */
    public static String getDealAmount(long volume,double high,double low) {
        BigDecimal bigDecimal = new BigDecimal(volume);
        double avgPrice = (high + low) / 2;
        if(avgPrice > 1000){
            avgPrice /= 300.0;
        }
        bigDecimal = bigDecimal.multiply(new BigDecimal(avgPrice));

        StringBuilder temp = new StringBuilder(bigDecimal.toString());
        int length = temp.length();

        if (temp.indexOf(".") != -1) {
            temp.delete(temp.indexOf("."), temp.length());
        }

        if (length >= 9) {//9位数，数量级为亿,保留到百万位
            temp.delete(temp.length() - 6, temp.length());
            temp.insert(temp.length() - 2, '.');
            temp.append("亿");
        } else if (length >= 5) {//5位数，数量级为万，保留到百位
            temp.delete(temp.length() - 2, temp.length());
            temp.insert(temp.length() - 2, '.');
            temp.append("万");
        }

        return temp.toString();
    }

    /**
     * @param s 一个浮点数
     * @return String
     * 将传过来的数据保留两位小数，以字符串形式返回
     */
    public static String remain2bit(String s){
        double a = Double.parseDouble(s);
        a = ((double)Math.round(a*100))/100;
        return (a+"");
    }
}
