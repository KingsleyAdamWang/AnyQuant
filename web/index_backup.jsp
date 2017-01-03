<%--
  Created by IntelliJ IDEA.
  User: song
  Date: 16-4-28
  Time: 下午11:13
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>AnyQuant</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <link href="images/icon.png" rel="icon"/>
    <link href="page/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="page/style/homeStyle.css" rel="stylesheet"/>
    <link href="page/style/main.css" rel="stylesheet"/>
    <line href="page/style/jquery.slideBox.css" rel="stylesheet"/>
    <script>
        $(function () {
            $.scrollify({
                section: "section",
            });
        });
    </script>
</head>

<%
    String userID = (String) session.getAttribute("UserId");
%>

<body>

<%--导航栏Start--%>
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
                <a class="navbar-brand" href="javascript: void(0)">AnyQuant</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-left">
                    <li class="active">
                        <a href="javascript: void(0)">
                            <span class="glyphicon glyphicon-home"></span> 首页
                        </a>
                    </li>
                    <li>
                        <a href="page/portfolio.jsp">
                            <span class="glyphicon glyphicon-heart"></span> 自选
                        </a>
                    </li>
                    <li class="dropdown">
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


<%--第一部分图Start--%>
<section class="panel home" data-section-name="home">
    <div class="inner">
        <div id="firstIntroduction"></div>
        <script>
            document.getElementById("firstIntroduction").innerHTML = '<img src="../images/index.png"  />';
        </script>
    </div>
</section>
<%--第一部分图End--%>


<%--第二部分Start--%>
<section class="panel overview" data-section-name="overview">
    <div class="inner">
        <center>
            <h1>我们是什么网站</h1>
        </center>

        <div id="demo3" class="slideBox">
            <ul class="items">
                <li><img src="images/1.png"></li>
                <li><img src="images/2.png"></li>
                <li><img src="images/3.png"></li>
                <li><img src="images/4.png"></li>
                <li><img src="images/5.png"></li>
            </ul>
        </div>
    </div>
</section>


<%--第三部分Start--%>
<section class="panel configuration" data-section-name="configuration">
    <div class="inner">
        <center><h1>我们能帮您做什么</h1></center>
        <%--四个框start--%>
        <div class="bs-docs-featurette describe">
            <div class="container">
                <div class="row bs-docs-featured-sites">
                    <div class="col-xs-6 col-sm-3">
                        <div class="describe-box">
                            <p class="lead">实时数据</p>
                            &nbsp;&nbsp;实时股票数据，更准确的数据展示
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-3">
                        <div class="describe-box">
                            <p class="lead">多样图表</p>
                            &nbsp;&nbsp;多样统计图表，更直观的数据展示
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-3">
                        <div class="describe-box">
                            <p class="lead">行情分析</p>
                            &nbsp;&nbsp;当前行情的透彻分析，把握先机
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-3">
                        <div class="describe-box">
                            <p class="lead">精准预测</p>
                            &nbsp;&nbsp;基于数据的精准预测，可靠保障
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <%--四个框end--%>
    </div>
</section>


<%--最底下脚本start--%>
<footer class=bs-docs-footer role=contentinfo>
    <div class=container>
        <ul class=bs-docs-footer-links>
            <li><a href="http://114.55.35.12/141250111_cseiii_AnyQuant/AnyQuant.git">Gitlab</a></li>
            <li><a href="#" data-toggle="modal" data-target="#myModal">About</a></li>
            <li><a href="#" data-toggle="modal" data-target="#secondModal">Advice</a></li>
        </ul>
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
             aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel">
                            关于我们
                        </h4>
                    </div>
                    <div class="modal-body">
                        我们是南京大学软件学院大二的Ultraviolet工作组</br>
                        很高兴您能使用我们的研发产品</br>
                        如果有需要改进的地方，请一定要告诉我们哦~</br>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>

        <!-- 模态框（Modal） -->
        <div class="modal fade" id="secondModal" tabindex="-1" role="dialog"
             aria-labelledby="secondModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                                data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="secondModalLabel">
                            建议
                        </h4>
                    </div>
                    <div class="modal-body">
                        <textarea name="MSG" cols=70 rows=4>
不要大意的给我们建议吧！</textarea>
                        <%--<input type="text" style="width:500px;height:100px;">--%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="button" class="btn btn-primary">
                            提交
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <p>
            &copy; Ultraviolet 团队开发 2016
        </p>
    </div>
</footer>

</body>


<script src="page/js/jquery.min.js"></script>
<script src="page/js/bootstrap.min.js"></script>
<script src="page/js/jquery-1.7.1.js"></script>
<script src="page/js/jquery.easing.1.3.js"></script>
<script src="page/js/main.js"></script>
<script src="page/js/scrollify.min.js"></script>
<script src="page/js/html5shiv.min.js"></script>
<script src="page/js/jquery.slideBox.js"></script>
<script src="page/js/jquery.slideBox.min.js"></script>

<script>
    $.scrollify({
        section: "section",
        sectionName: "section-name",
        easing: "easeOutExpo",
        scrollSpeed: 1100,
        offset: 0,
        scrollbars: true,
        before: function () {
        },
        after: function () {
        }
    });
</script>
<%--退出操作Start--%>
<script>
    $('#log-in').on('click', function (e) {
        if ($('#log-out').html() == '退出') {
            e.preventDefault();
            $.ajax({
                url: '/login',
                style: 'post',
                data: 'logout',
                success: function () {
                    $('#log-out').html('登录');
                }
            });
        }
    });
</script>
<%--退出操作End--%>

<%--图片轮播--%>
<script>
    jQuery(function ($) {
        $('#demo3').slideBox({
            duration: 0.3,//滚动持续时间，单位：秒
            easing: 'linear',//swing,linear//滚动特效
            delay: 5,//滚动延迟时间，单位：秒
            hideClickBar: false,//不自动隐藏点选按键
            clickBarRadius: 10
        });
    });
</script>

</html>
