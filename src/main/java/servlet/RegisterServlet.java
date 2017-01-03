package servlet;

import database.UserInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Created by lenovo2014 on 2016/5/29.
 */
@WebServlet(name = "RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserInfo ui = new UserInfo();
        String new_mid = request.getParameter("new_mid");
        String new_password = request.getParameter("new_password");
        boolean r = false;
        try {
            r = ui.register(new_mid, new_password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("Register",r);
        PrintWriter out = response.getWriter();
        out.println(r);
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
