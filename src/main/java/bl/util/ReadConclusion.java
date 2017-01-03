package bl.util;

import java.io.*;
import java.util.ResourceBundle;

/**
 * Created by zcy on 2016/6/19.
 *
 */
public class ReadConclusion {
    public static String bias_intro = "";
    public static String[] bias_c = new String[5];
    public static String RSI_intro = "";
    public static String[] RSI_c = new String[9];
    public static String WM_intro = "";
    public static String[] WM_c = new String[3];
    public static String ARBR_intro = "";
    public static String[] ARBR_c = new String[6];


    public static void initConclusion() throws IOException {
        ResourceBundle resourceBundle = ResourceBundle.getBundle("stockindex-config");

        bias_intro = resourceBundle.getString("bias_intro");
        for(int i=0;i<bias_c.length;i++){
            bias_c[i] = resourceBundle.getString("bias_c"+(i+1));
        }
        RSI_intro = resourceBundle.getString("RSI_intro");
        for(int i=0;i<RSI_c.length;i++){
            RSI_c[i] = resourceBundle.getString("RSI_c"+(i+1));
        }
        WM_intro = resourceBundle.getString("WM_intro");
        for(int i=0;i<WM_c.length;i++){
            WM_c[i] = resourceBundle.getString("WM_c"+(i+1));
        }
        ARBR_intro = resourceBundle.getString("ARBR_intro");
        for(int i=0;i<ARBR_c.length;i++){
            ARBR_c[i] = resourceBundle.getString("ARBR_c"+(i+1));
        }
//        String encoding = "utf8";
//        String all = "";
//        String temp = "";
//
//        File file1 = new File("analysis/bias-config.txt");
//        File file2 = new File("analysis/RSI-config.txt");
//        File file3 = new File("analysis/WM-config.txt");
//        File file4 = new File("analysis/ARBR-config.txt");
//
//        InputStreamReader inputStreamReader = new InputStreamReader(new FileInputStream(file1),encoding);
//        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
//        while((temp = bufferedReader.readLine())!=null){
//            all += temp;
//        }
//        bias_intro = all.substring(0,167);
//        bias_c[0] = all.substring(167,206);
//        bias_c[1] = all.substring(206,238);
//        bias_c[2] = all.substring(238,265);
//        bias_c[3] = all.substring(265,293);
//        bias_c[4] = all.substring(293);
//        bufferedReader.close();
//
//        all = "";
//        inputStreamReader = new InputStreamReader(new FileInputStream(file2),encoding);
//        bufferedReader = new BufferedReader(inputStreamReader);
//        while((temp = bufferedReader.readLine())!=null){
//            all += temp;
//        }
//        RSI_intro = all.substring(0,81);
//        RSI_c[0] = all.substring(81,99);
//        RSI_c[1] = all.substring(99,117);
//        RSI_c[2] = all.substring(117,156);
//        RSI_c[3] = all.substring(156,195);
//        RSI_c[4] = all.substring(195,224);
//        RSI_c[5] = all.substring(224,251);
//        RSI_c[6] = all.substring(251,287);
//        RSI_c[7] = all.substring(287,325);
//        RSI_c[8] = all.substring(325);
//        bufferedReader.close();
//
//        all = "";
//        inputStreamReader = new InputStreamReader(new FileInputStream(file3),encoding);
//        bufferedReader = new BufferedReader(inputStreamReader);
//        while((temp = bufferedReader.readLine())!=null){
//            all += temp;
//        }
//        WM_intro = all.substring(0,111);
//        WM_c[0] = all.substring(111,139);
//        WM_c[1] = all.substring(139,167);
//        WM_c[2] = all.substring(167);
//        bufferedReader.close();
//
//        all = "";
//        inputStreamReader = new InputStreamReader(new FileInputStream(file4),encoding);
//        bufferedReader = new BufferedReader(inputStreamReader);
//        while((temp = bufferedReader.readLine())!=null){
//            all += temp;
//        }
//        ARBR_intro = all.substring(0,172);
//        ARBR_c[0] = all.substring(172,197);
//        ARBR_c[1] = all.substring(197,219);
//        ARBR_c[2] = all.substring(219,250);
//        ARBR_c[3] = all.substring(250,274);
//        ARBR_c[4] = all.substring(274,306);
//        ARBR_c[5] = all.substring(306);
//        bufferedReader.close();
    }
    public static void main(String[] args) throws IOException {
        ReadConclusion.initConclusion();
    }

}
