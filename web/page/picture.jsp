<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="vo.StockVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.Cast" %>
<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <title>AnyQuant--行情</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <link href="../images/icon.png" rel="icon"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style/docs.min.css" rel="stylesheet"/>
    <link href="../reference/table/css/normalize.css" rel="stylesheet"/>
    <link href="../reference/table/css/default.css" rel="stylesheet"/>
    <link href="../reference/table/css/styles.css" media="all" rel="stylesheet"/>
    <link href="../reference/table/css/stickysort.css" media="all" rel="stylesheet"/>
    <link href="../reference/search/css/normalize.css" rel="stylesheet"/>
    <link href="../reference/search/css/default.css" rel="stylesheet">
    <link href="../reference/search/css/search-form.css" rel="stylesheet">
    <link href="style/pictureStyle.css" rel="stylesheet"/>
</head>

<%
    List<StockVO> increase_rank = Cast.cast(session.getAttribute("increase_rank"));
    List<StockVO> volume_rank = Cast.cast(session.getAttribute("volume_rank"));

    String userID = (String) session.getAttribute("UserId");
    List<StockVO> portfolioList = new ArrayList<>();//自选股列表
    if (userID != null) {
        portfolioList = Cast.cast(session.getAttribute("portfolioList"));
    }

    int stock_num = increase_rank.size();//股票数目
    int increase_num = 0;//涨幅大于0的股票数目

    String textColor;//以不同颜色区分涨/跌股票
    String url;//跳转地址

    //计算涨幅大于0的股票数目
    if (increase_rank.get(0).getIncrease_decreaseNum()[0] > 0) {
        for (int i = 0; i < increase_rank.size(); i++) {
            if (increase_rank.get(i).getIncrease_decreaseNum()[0] <= 0) {
                increase_num = i;
                break;
            }
        }
    }
%>

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
                    <li class="active">
                        <a href="javascript: void(0)">
                            <span class="glyphicon glyphicon-th-list"></span> 行情
                        </a>
                    </li>
                    <li>
                        <div class="search">
                            <section class="htmleaf-container">
                                <form onsubmit="submitFn(this, event);">
                                    <div class="search-wrapper">
                                        <div class="input-holder">
                                            <input type="text" class="search-input"
                                                   placeholder="搜索股票或代码"/>
                                            <button class="search-icon"
                                                    onclick="searchToggle(this, event);"><span></span>
                                            </button>
                                        </div>
                                        <span class="close" onclick="searchToggle(this, event);"></span>
                                        <div class="result-container">
                                        </div>
                                    </div>
                                </form>
                            </section>
                        </div>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="login.jsp" id="log-in">
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

<div class="container-fluid">
    <div class="row">
        <div class="col-xs-6 col-md-2">
            <div id="sidebar">
                <div class="list-group">
                    <ul class="menu">
                        <%
                            if (userID != null) {
                        %>
                        <li onclick="click_scroll('portfolio')" id="portfolio-item">
                            <a href="javascript: void(0)" class="list-group-item
                                    list-group-item-info text-left active">自选股
                                <span class="badge" title="关注数量"><%=portfolioList.size()%></span>
                            </a>
                        </li>
                        <%
                            }
                        %>
                        <li onclick="click_scroll('picture')">
                            <a href="javascript: void(0)" class="list-group-item
                                    list-group-item-warning text-left active">今日行情
                                <span class="badge" title="股票总数"><%=stock_num%></span>
                            </a>
                        </li>
                        <li onclick="click_scroll('increase_rank')">
                            <a href="javascript: void(0)" class="list-group-item
                        list-group-item-danger text-left active">涨幅榜
                                <span class="badge" title="上涨数量"><%=increase_num%></span></a>
                        </li>
                        <li onclick="click_scroll('decrease_rank')">
                            <a href="javascript: void(0)" class="list-group-item
                        list-group-item-success text-left active">
                                跌幅榜<span class="badge" title="下跌数量"><%=stock_num - increase_num%></span></a>
                        </li>
                        <li onclick="click_scroll('volume_rank')">
                            <a href="javascript: void(0)" class="list-group-item
                            text-left active">成交量榜</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-10">
            <div class="rank-list well">
                <div class="panel-group" id="accordion">
                    <%
                        if (userID != null) {
                    %>
                    <div class="panel panel-info" id="portfolio-panel">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#portfolio">自选股</a>
                            </h4>
                        </div>
                        <div id="portfolio" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <div id="basic-sort-1">
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
                                            <tbody>
                                            <%
                                                for (StockVO stock : portfolioList) {
                                                    url = "stock.jsp?id=" + stock.getId();
                                                    if (stock.getIncrease_decreaseNum()[0] > 0) {
                                                        textColor = "text-danger";
                                                    } else if (stock.getIncrease_decreaseNum()[0] < 0) {
                                                        textColor = "text-success";
                                                    } else {
                                                        textColor = "";
                                                    }
                                            %>
                                            <tr>
                                                <td class="text-center"><a target="_blank"
                                                                           href=<%=url%>><%=stock.getName()%>
                                                </a>
                                                </td>
                                                <td class="text-center"><%=stock.getId()%>
                                                </td>
                                                <td class="text-center"><%=stock.getHigh()[0]%>
                                                </td>
                                                <td class="text-center"><%=stock.getLow()[0]%>
                                                </td>
                                                <td class="text-center <%=textColor%>"><%=stock.getIncrease_decreaseNum()[0]%>
                                                </td>
                                                <td class="text-center <%=textColor%>"><%=stock.rateToString(stock.getIncrease_decreaseRate()[0])%>
                                                </td>
                                                <td class="text-center"><%=stock.getOpen()[0]%>
                                                </td>
                                                <td class="text-center"><%=stock.getClose()[0]%>
                                                </td>
                                                <td class="text-center"><%=stock.volumeToString(stock.getVolume()[0])%>
                                                </td>
                                                <td class="text-center"><%=stock.getPe_ttm()[0]%>
                                                </td>
                                                <td class="text-center"><%=stock.getPb()[0]%>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#picture">今日行情</a>
                            </h4>
                        </div>
                        <div id="picture" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <div id="basic-sort-0">
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
                                            <tbody>
                                            <%
                                                for (StockVO stock : increase_rank) {
                                                    url = "stock.jsp?id=" + stock.getId();
                                                    if (stock.getIncrease_decreaseNum()[0] > 0) {
                                                        textColor = "text-danger";
                                                    } else if (stock.getIncrease_decreaseNum()[0] < 0) {
                                                        textColor = "text-success";
                                                    } else {
                                                        textColor = "";
                                                    }
                                            %>
                                            <tr>
                                                <td class="text-center"><a target="_blank"
                                                                           href=<%=url%>><%=stock.getName()%>
                                                </a>
                                                </td>
                                                <td class="text-center"><%=stock.getId()%>
                                                </td>
                                                <td class="text-center"><%=stock.getHigh()[0]%>
                                                </td>
                                                <td class="text-center"><%=stock.getLow()[0]%>
                                                </td>
                                                <td class="text-center <%=textColor%>"><%=stock.getIncrease_decreaseNum()[0]%>
                                                </td>
                                                <td class="text-center <%=textColor%>"><%=stock.rateToString(stock.getIncrease_decreaseRate()[0])%>
                                                </td>
                                                <td class="text-center"><%=stock.getOpen()[0]%>
                                                </td>
                                                <td class="text-center"><%=stock.getClose()[0]%>
                                                </td>
                                                <td class="text-center"><%=stock.volumeToString(stock.getVolume()[0])%>
                                                </td>
                                                <td class="text-center"><%=stock.getPe_ttm()[0]%>
                                                </td>
                                                <td class="text-center"><%=stock.getPb()[0]%>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-danger">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#increase_rank">涨幅榜</a>
                            </h4>
                        </div>
                        <div id="increase_rank" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="table-responsive">
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
                                        <tbody>
                                        <%
                                            for (StockVO stock : increase_rank) {
                                                url = "stock.jsp?id=" + stock.getId();
                                                if (stock.getIncrease_decreaseNum()[0] > 0) {
                                                    textColor = "text-danger";
                                                } else if (stock.getIncrease_decreaseNum()[0] < 0) {
                                                    textColor = "text-success";
                                                } else {
                                                    textColor = "";
                                                }
                                        %>
                                        <tr>
                                            <td class="text-center"><a target="_blank"
                                                                       href=<%=url%>><%=stock.getName()%>
                                            </a>
                                            </td>
                                            <td class="text-center"><%=stock.getId()%>
                                            </td>
                                            <td class="text-center"><%=stock.getHigh()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getLow()[0]%>
                                            </td>
                                            <td class="text-center <%=textColor%>"><%=stock.getIncrease_decreaseNum()[0]%>
                                            </td>
                                            <td class="text-center <%=textColor%>"><%=stock.rateToString(stock.getIncrease_decreaseRate()[0])%>
                                            </td>
                                            <td class="text-center"><%=stock.getOpen()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getClose()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.volumeToString(stock.getVolume()[0])%>
                                            </td>
                                            <td class="text-center"><%=stock.getPe_ttm()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getPb()[0]%>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#decrease_rank">跌幅榜</a>
                            </h4>
                        </div>
                        <div id="decrease_rank" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="table-responsive">
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
                                        <tbody>
                                        <%
                                            for (int i = stock_num - 1; i >= 0; i--) {
                                                StockVO stock = increase_rank.get(i);
                                                url = "stock.jsp?id=" + stock.getId();
                                                if (stock.getIncrease_decreaseNum()[0] > 0) {
                                                    textColor = "text-danger";
                                                } else if (stock.getIncrease_decreaseNum()[0] < 0) {
                                                    textColor = "text-success";
                                                } else {
                                                    textColor = "";
                                                }
                                        %>
                                        <tr>
                                            <td class="text-center"><a target="_blank"
                                                                       href=<%=url%>><%=stock.getName()%>
                                            </a>
                                            </td>
                                            <td class="text-center"><%=stock.getId()%>
                                            </td>
                                            <td class="text-center"><%=stock.getHigh()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getLow()[0]%>
                                            </td>
                                            <td class="text-center <%=textColor%>"><%=stock.getIncrease_decreaseNum()[0]%>
                                            </td>
                                            <td class="text-center <%=textColor%>"><%=stock.rateToString(stock.getIncrease_decreaseRate()[0])%>
                                            </td>
                                            <td class="text-center"><%=stock.getOpen()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getClose()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.volumeToString(stock.getVolume()[0])%>
                                            </td>
                                            <td class="text-center"><%=stock.getPe_ttm()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getPb()[0]%>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-primary active">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#volume_rank">成交量榜</a>
                            </h4>
                        </div>
                        <div id="volume_rank" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="table-responsive">
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
                                        <tbody>
                                        <%
                                            for (StockVO stock : volume_rank) {
                                                url = "stock.jsp?id=" + stock.getId();
                                                if (stock.getIncrease_decreaseNum()[0] > 0) {
                                                    textColor = "text-danger";
                                                } else if (stock.getIncrease_decreaseNum()[0] < 0) {
                                                    textColor = "text-success";
                                                } else {
                                                    textColor = "";
                                                }
                                        %>
                                        <tr>
                                            <td class="text-center"><a target="_blank"
                                                                       href=<%=url%>><%=stock.getName()%>
                                            </a>
                                            </td>
                                            <td class="text-center"><%=stock.getId()%></td>
                                            <td class="text-center"><%=stock.getHigh()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getLow()[0]%>
                                            </td>
                                            <td class="text-center <%=textColor%>"><%=stock.getIncrease_decreaseNum()[0]%>
                                            </td>
                                            <td class="text-center <%=textColor%>"><%=stock.rateToString(stock.getIncrease_decreaseRate()[0])%>
                                            </td>
                                            <td class="text-center"><%=stock.getOpen()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getClose()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.volumeToString(stock.getVolume()[0])%>
                                            </td>
                                            <td class="text-center"><%=stock.getPe_ttm()[0]%>
                                            </td>
                                            <td class="text-center"><%=stock.getPb()[0]%>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--排行榜End--%>
        </div>
    </div>
</div>

<%--About Start--%>
<div class="about">
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="about" tabindex="-1" role="dialog"
         aria-labelledby="aboutLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="aboutLabel">
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

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/picture.js"></script>
<%--表格排序组件--%>
<script src="../reference/table/js/jquery.ba-throttle-debounce.min.js"></script>
<script src="../reference/table/js/jquery.stickysort.js"></script>

<script></script>

</body>
</html>