package database;

import org.junit.Test;
import po.UserPO;

import static org.junit.Assert.*;

/**
 * Created by zcy on 2016/5/9.
 *
 */
public class UserInfoTest {
    @Test
    public void getUserInfoTest(){
        UserInfo userInfo = new UserInfo();
        UserPO userPO = userInfo.getUserInfo("123456789@126.com","123456");
        assertEquals("sh601009",userPO.getStockList().get(0));
    }
}