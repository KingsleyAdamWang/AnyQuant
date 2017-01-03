<%@ page import="util.Cast" %>
<%@ page import="vo.StockIDNameVO" %>
<%@ page import="vo.StockVO" %>
<%@ page import="java.util.List" %>
<%@ page import="vo.ReducedStockNewsVO" %>
<!DOCTYPE html>
<html lang="zh-CN">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <title>AnyQuant--自选</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link href="../images/icon.png" rel="icon"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style/docs.min.css" rel="stylesheet"/>
    <link href="../reference/news/css/bootstrap-theme.min.css" rel="stylesheet"/>
    <link href="../reference/news/css/normalize.css" rel="stylesheet"/>
    <link href="../reference/news/css/default.css" rel="stylesheet"/>
    <link href="../reference/news/css/site.css" rel="stylesheet"/>
    <link href="../reference/loading/css/waitMe.css" rel="stylesheet"/>
    <link href="style/portfolioStyle.css" rel="stylesheet"/>
</head>
<body>
<%
    String userID = (String) session.getAttribute("UserId");

    //关注股票列表
    List<StockVO> portfolioList = Cast.cast(session.getAttribute("portfolioList"));
    //关注股票ID
    List<String> portfolioIDList = Cast.cast(session.getAttribute("portfolioIDList"));
    //所有股票名称ID列表
    List<StockIDNameVO> stockIDNameList = Cast.cast(session.getAttribute("stockIDNameList"));
    //所有新闻标题
    List<ReducedStockNewsVO> newsList = Cast.cast(session.getAttribute("newsList_" + userID));

    String url;
%>
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
                    <li class="active">
                        <a href="javascript: void(0)">
                            <span class="glyphicon glyphicon-heart"></span> 自选
                        </a>
                    </li>
                    <li>
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
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="../index.jsp" id="log-out">
                            <span class="glyphicon glyphicon-user">退出</span>
                        </a>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </div>
</nav>
<%--导航栏End--%>

<%--content Start--%>
<div class="container-fluid" id="main-content">
    <div class="row">
        <div class="col-md-2">
            <button class="btn btn-lg btn-primary" data-toggle="modal"
                    data-target="#myModal">自选股管理
            </button>
        </div>
        <div class="col-md-9">
            <%
                if (userID != null) {
            %>
            <div class="panel panel-info" id="portfolio-panel">
                <div class="panel-heading">
                    <h4 class="panel-title">自选股</h4>
                </div>
                <div id="portfolio">
                    <div class="panel-body">
                        <%
                            if (portfolioList != null) {
                        %>
                        <div class="table-responsive">
                            <div id="basic-sort">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th class="text-center">名称</th>
                                        <th class="text-center">代码</th>
                                        <th class="text-center">最高</th>
                                        <th class="text-center">最低</th>
                                        <th class="text-center">涨跌额</th>
                                        <th class="text-center">涨跌幅</th>
                                        <th class="text-center">开盘</th>
                                        <th class="text-center">收盘</th>
                                        <th class="text-center">成交量</th>
                                        <th class="text-center">市盈率</th>
                                        <th class="text-center">市净率</th>
                                    </tr>
                                    </thead>
                                    <tbody class="text-center stock-data">
                                    <%
                                        for (StockVO stock : portfolioList) {
                                            url = "stock.jsp?id=" + stock.getId();
                                    %>
                                    <tr>
                                        <td><a target="_blank" href=<%=url%>><%=stock.getName()%>
                                        </a></td>
                                        <td><%=stock.getId()%>
                                        </td>
                                        <td><%=stock.getHigh()[0]%>
                                        </td>
                                        <td><%=stock.getLow()[0]%>
                                        </td>
                                        <td><%=stock.getIncrease_decreaseNum()[0]%>
                                        </td>
                                        <td><%=stock.getIncrease_decreaseRate()[0]%>
                                        </td>
                                        <td><%=stock.getOpen()[0]%>
                                        </td>
                                        <td><%=stock.getClose()[0]%>
                                        </td>
                                        <td><%=stock.volumeToString(stock.getVolume()[0])%>
                                        </td>
                                        <td><%=stock.getPe_ttm()[0]%>
                                        </td>
                                        <td><%=stock.getPb()[0]%>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <%--股票列表End--%>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-list-alt"></span><b>News</b></div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <%
                                if (newsList != null) {
                            %>
                            <ul class="news-list">
                                <%
                                    for (ReducedStockNewsVO newsVO : newsList) {
                                        pageContext.setAttribute("title", newsVO.getTitle());
                                        pageContext.setAttribute("iconURL", "../images/icons/" + newsVO.getId() + ".png");
                                        pageContext.setAttribute("targetURL", "stock.jsp?id=" + newsVO.getId() + "#picture-prediction");
                                %>
                                <li class="news-item">
                                    <table>
                                        <tr>
                                            <td><img class="img-circle icon" src='${iconURL}'/></td>
                                            <td>
                                                ${title}
                                            </td>
                                            <td>
                                                <span class="details">
                                                    <a href='${targetURL}' target="_blank">查看详情&gt;&gt;</a>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <%--新闻列表End--%>
            <%
                }
            %>
        </div>
    </div>
</div>
<%--content End--%>

<%--自选股管理 模态框Start--%>
<div class="container-fluid">
    <div>
        <div class="row">
            <div class="col-md-4 col-md-offset-1">
                <!-- 模态框（Modal） -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                     aria-labelledby="portfolioLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close"
                                        data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title" id="portfolioLabel">
                                    自选股管理
                                </h4>
                            </div>
                            <div class="modal-body">
                                <%
                                    if (portfolioList != null) {
                                %>
                                <div class="row">
                                    <div class="col-md-6">
                                        <h4>
                                            <span class="label label-info">关注列表</span>
                                            <span class="badge" title="关注数量" id="followed-num">
                                                <%=portfolioIDList.size()%></span>
                                        </h4>
                                        <div class="well" id="followed">
                                            <%
                                                for (StockVO stockVO : portfolioList) {
                                            %>
                                            <button class="btn btn-warning"><%=stockVO.getName()%>
                                            </button>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h4>
                                            <span class="label label-info">股票列表</span>
                                            <span class="badge" title="未关注数量" id="un-followed-num">
                                                    <%=stockIDNameList.size() - portfolioIDList.size()%></span>
                                        </h4>
                                        <div class="well" id="un-followed">
                                            <%
                                                for (StockIDNameVO stockIDName : stockIDNameList) {
                                                    if (!portfolioIDList.contains(stockIDName.getId())) {
                                            %>
                                            <button class="btn btn-warning"><%=stockIDName.getName()%>
                                            </button>
                                            <%
                                                    }
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-sm btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button type="button" class="btn btn-sm btn-primary" onclick="apply('<%=userID%>')">
                                    确认
                                </button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>
            </div>
        </div>
    </div>
</div>
<%--自选股管理 模态框End--%>

<%--About Start--%>
<div class="about">
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="about" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
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
        </div><!-- /.modal -->
    </div>
</div>
<%--About End--%>

<footer class=bs-docs-footer role=contentinfo>
    <div class=container>
        <ul class=bs-docs-footer-links>
            <li><a href="http://114.55.35.12/141250111_cseiii_AnyQuant/AnyQuant.git"
                   target="_blank">GitHub</a></li>
            <li><a href="javascript: void(0)" data-toggle="modal" data-target="#about">About</a></li>
        </ul>
        <p>
            &copy;
            <a href="javascript: void(0)"
               data-toggle="modal" data-target="#about">
                Ultraviolet</a>
            团队开发 2016
        </p>
    </div>
</footer>

</body>

<script src="js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="../reference/news/js/jquery.bootstrap.newsbox.min.js"></script>
<script src="../reference/loading/js/waitMe.js"></script>
<script src="js/portfolio.js"></script>
</html>