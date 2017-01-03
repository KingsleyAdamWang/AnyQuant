package blservice;

import vo.UserVO;

import java.sql.SQLException;

/**
 * Created by zcy on 2016/5/23.
 *
 */
public interface UserLoginService {
    public UserVO login(String id, String password);
    public boolean register(String id,String password) throws SQLException;
}
