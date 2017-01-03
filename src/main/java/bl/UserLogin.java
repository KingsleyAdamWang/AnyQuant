package bl;

import blservice.UserLoginService;
import database.UserInfo;
import po.UserPO;
import vo.UserVO;

import java.sql.SQLException;

/**
 * Created by zcy on 2016/5/12.
 *
 */
public class UserLogin implements UserLoginService{
    public UserVO login(String id,String password){
        UserInfo userInfo = new UserInfo();
        UserPO userPO = userInfo.getUserInfo(id,password);
        if(userPO==null){
            return null;
        }
        else{
            return new UserVO(userPO);
        }
    }

    public boolean register(String id,String password) throws SQLException {
        UserInfo userInfo = new UserInfo();
        return userInfo.register(id,password);
    }
}
