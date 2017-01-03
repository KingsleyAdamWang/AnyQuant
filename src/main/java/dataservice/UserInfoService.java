package dataservice;

import po.UserPO;

import java.sql.SQLException;

/**
 * Created by zcy on 2016/5/30.
 *
 */
public interface UserInfoService {
    public UserPO getUserInfo(String id, String password);
    public boolean register(String id,String password) throws SQLException;
}
