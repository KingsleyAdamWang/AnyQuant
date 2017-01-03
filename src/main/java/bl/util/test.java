package bl.util;

import java.util.Locale;
import java.util.ResourceBundle;

/**
 * Created by song on 16-6-20.
 *
 */
public class test {
    public static void main(String[] args) {
        System.out.println(testGet());
    }

    public static String testGet() {
        ResourceBundle resourceBundle = ResourceBundle.getBundle("test");
        return resourceBundle.getString("bias_intro");
    }
}
