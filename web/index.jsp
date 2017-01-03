<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userID = (String) session.getAttribute("UserId");
%>

<head>
    <meta charset="UTF-8">
    <title>AnyQuant</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="author" content="Ultraviolet"/>
    <link href="images/icon.png" rel="icon"/>
    <link href="page/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="page/style/docs.min.css" rel="stylesheet"/>
    <link href="page/style/jquery.fullPage.css" rel="stylesheet">
    <link href="page/style/homePage.css" rel="stylesheet"/>
    <link href="page/style/homeStyle.css" rel="stylesheet"/>
</head>

<body class="front_facing index">

<%--导航栏Start--%>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1" aria-expanded="true">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="javascript: void(0)">AnyQuant</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a href="javascript: void(0)">
                            <span class="glyphicon glyphicon-home"></span> 首页
                        </a>
                    </li>
                    <li>
                        <a href="page/portfolio.jsp">
                            <span class="glyphicon glyphicon-heart"></span> 自选
                        </a>
                    </li>
                    <li>
                        <a href="page/market.jsp">
                            <span class="glyphicon glyphicon-signal"></span> 大盘
                        </a>
                    </li>
                    <li>
                        <a href="page/picture.jsp">
                            <span class="glyphicon glyphicon-th-list"></span> 行情
                        </a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="page/login.jsp" id="log-in">
                            <%
                                if (userID == null) {
                            %>
                            <span class="glyphicon glyphicon-user" id="log-out">登录</span>
                            <%
                            } else {
                            %>
                            <span class="glyphicon glyphicon-user" id="log-out">退出</span>
                            <%
                                }
                            %>
                        </a>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </div>
</nav>
<%--导航栏End--%>

<div id="dowebok">
    <div class="section">
        <div class="layout-content front-facing index">
            <div class="hero">
                <div class="container">
                    <h1>
                        实时 高效 简约的银行股票<br>
                        <small>
                            <br>
                            在线股票分析平台&nbsp;&nbsp;提供 <span data-js-hook="type-to-container">数据查询</span>
                        </small>
                    </h1>

                    <div class="buttons-container">
                        <a href="page/picture.jsp"
                           class="wistia-popover[height=360,playerColor=7b796a,width=640] cpt-button style-outline size-large"
                           data-js-hook="play-video-button">
                            查询银行数据
                        </a>
                        <a href="page/market.jsp"
                           class="wistia-popover[height=360,playerColor=7b796a,width=640] cpt-button style-outline size-large"
                           data-js-hook="play-video-button">
                            关注大盘信息
                        </a>
                    </div>
                </div>
            </div>

            <div class="section acme-demo beige" data-js-hook="acme-demo">
                <h2>
                    用心改变 看得见<br>
                    <small>专业的股票助手</small>
                </h2>
                <div class="container bg-image" data-js-hook="inview">
                    <div class="explanations-container">
                        <img alt="Acme demo tip 1" class="explanation exp-1" data-js-hook="acme-demo-image"
                             src="images/point1.png"/>
                        <img alt="Acme demo tip 2" class="explanation exp-2" data-js-hook="acme-demo-image"
                             src="images/point2.png"/>
                        <img alt="Acme demo tip 3" class="explanation exp-3" data-js-hook="acme-demo-image"
                             src="images/point3.png"/>
                        <img alt="Acme demo tip 4" class="explanation exp-4" data-js-hook="acme-demo-image"
                             src="images/point4.png"/>
                        <img alt="Acme demo tip 5" class="explanation exp-5" data-js-hook="acme-demo-image"
                             src="images/point5.png"/>
                        <img alt="Acme demo tip 6" class="explanation exp-6" data-js-hook="acme-demo-image"
                             src="images/point6.png"/>
                    </div>
                    <div class="screenshot-mask">
                        <img alt="Acme demo page" class="content-image" data-js-hook="the-big-acme-image"
                             id="content-image" src="images/mainContent.png"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="section">
        <div class="bs-docs-featurette describe">
            <div class="container">
                <div class="row bs-docs-featured-sites">
                    <div class="col-xs-6 col-sm-3">
                        <div class="describe-box">
                            <p class="lead text-center">实时数据</p>
                            <div class="text-center">实时股票数据，更准确</div>
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-3">
                        <div class="describe-box">
                            <p class="lead text-center">多样图表</p>
                            <div class="text-center">多样统计图表，更直观</div>
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-3">
                        <div class="describe-box">
                            <p class="lead text-center">行情分析</p>
                            <div class="text-center">当前行情的透彻分析，把握先机</div>
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-3">
                        <div class="describe-box">
                            <p class="lead text-center">精准预测</p>
                            <div class="text-center">基于数据的精准预测，可靠保障</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--About Start--%>
<div>
    <div class="row">
        <div class="col-md-4 col-md-offset-1">
            <!-- 模态框（Modal） -->
            <div class="modal fade" id="about" tabindex="-1" role="dialog"
                 aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel">
                            Ultraviolet 团队
                        </h4>
                    </div>
                    <div class="modal-body">
                        宋益明 苏琰梓 章承尧 周梦佳
                    </div>
                </div><!-- /.modal-content -->
            </div>
        </div>
    </div>
</div>
<%--About End--%>

<footer class=bs-docs-footer role=contentinfo>
    <div class=container>
        <ul class=bs-docs-footer-links>
            <li>
                <a href="http://114.55.35.12/141250111_cseiii_AnyQuant/AnyQuant.git"
                   target="_blank">GitHub</a>
            </li>
            <li><a href="javascript: void(0)" data-toggle="modal" data-target="#about">About</a></li>
        </ul>
        <p>
            &copy;
            <a href="javascript: void(0)" data-toggle="modal"
               data-target="#about">Ultraviolet
            </a>
            团队开发 2016
        </p>
    </div>
</footer>

</body>

<script src="page/js/jquery.min.js"></script>
<script src="page/bootstrap/js/bootstrap.min.js"></script>
<script src="page/js/jquery.fullPage.min.js"></script>
<script src="page/js/homePage.js"></script>
<script src="page/js/index.js"></script>

<script>
//    $(function () {
//        $('#dowebok').fullpage({
//            sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', '#f90']
//        });
//    });
</script>

</html>