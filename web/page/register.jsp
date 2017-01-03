<%--
  Created by IntelliJ IDEA.
  User: lenovo2014
  Date: 2016/5/26
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>AnyQuant--注册</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,inital-scale=1">
    <script src="js/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="js/register.js"></script>
    <link href="../images/icon.png" rel="icon"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="style/loginStyle.css" rel="stylesheet"/>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1" aria-expanded="true">
                    <%--<span class="sr-only">Toggle navigation</span>--%>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="../index.jsp">AnyQuant</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a href="../index.jsp">
                            <span class="glyphicon glyphicon-home"></span> 首页
                        </a>
                    </li>
                    <li>
                        <a href="portfolio.jsp">
                            <span class="glyphicon glyphicon-heart"></span> 自选
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="market.jsp">
                            <span class="glyphicon glyphicon-signal"></span> 大盘
                        </a>
                    </li>
                    <li>
                        <a href="picture.jsp">
                            <span class="glyphicon glyphicon-th-list"></span> 行情
                        </a>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </div>
</nav>

<div class="container">
    <form id="loginForm" action="/register" method="post" class="form-horizontal">
        <fieldset>
            <legend><label><span class="glyphicon glyphicon-user"></span>&nbsp;用户注册</label></legend>
            <div class="form-group" id="new_midDiv">
                <label class="col-md-3 control-label" for="new_mid">账号</label>
                <div class="col-md-5">
                    <input type="text" id="new_mid" name="new_mid" class="form-control" placeholder="Email">
                </div>
                <div class="col-md-4" id="new_midSpan"></div>
            </div>
            <div class="form-group" id="new_passwordDiv">
                <label class="col-md-3 control-label" for="new_password">密码</label>
                <div class="col-md-5">
                    <input type="password" id="new_password" name="new_password" class="form-control"
                           placeholder="Password">
                </div>
                <div class="col-md-4" id="new_passwordSpan"></div>
            </div>
            <div class="form-group" id="againDiv">
                <label class="col-md-3 control-label" for="again">密码重复</label>
                <div class="col-md-5">
                    <input type="password" id="again" name="again" class="form-control" placeholder="Input again">
                </div>
                <div class="col-md-4" id="againSpan"></div>
            </div>
            <div class="form-group" id="butDiv">
                <div class="col-md-5 col-md-offset-3">
                    <button type="submit" id="submitBut" class="btn btn-primary pull-right">创建</button>
                    <%
                        String b = request.getHeader("referer");
                        System.out.println("b:"+b);
                    %>
                </div>
            </div>
        </fieldset>
    </form>
</div>
</body>
<script src="js/jquery.min.js" language="JavaScript"></script>
<script>
    $('#submitBut').on('click', function (e) {
        e.preventDefault();
        $.ajax({
            url: '/register',
            style: 'post',
            data: $('#loginForm').serialize(),
            success: function (data) {
                if(data) {
                    alert('注册成功！')
                    self.location = 'login.jsp';
                }else{
                    alert('该账号已存在，请重新注册！')
                }
            }

        });
    });
</script>
</html>
