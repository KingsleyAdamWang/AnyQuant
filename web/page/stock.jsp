<%--suppress JSUnresolvedVariable --%>
<%--
  Created by IntelliJ IDEA.
  User: song
  Date: 16-5-23
  Time: 下午1:08
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="bl.ManageSelfSelectStock" %>
<%@ page import="bl.ShowCurrentData" %>
<%@ page import="bl.util.Convert" %>
<%@ page import="util.Cast" %>
<%@ page import="vo.CurrentStockVO" %>
<%@ page import="vo.StockNewsVO" %>
<%@ page import="vo.StockVO" %>
<%@ page import="vo.TheIndexVO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="zh-CN">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%
    String userID = (String) session.getAttribute("UserId");

    String stockID = (String) request.getAttribute("stockID");
    String iconPath = "../images/icons/" + stockID + ".png";
    StockVO stockVO = (StockVO) session.getAttribute("stockVO_" + stockID);
    List<StockNewsVO> newsList = Cast.cast(session.getAttribute("newsList_" + stockID));

    TheIndexVO stockIndexVO = (TheIndexVO) session.getAttribute("stockIndex_" + stockID);
    pageContext.setAttribute("stockIndex", stockIndexVO);

    double bias = stockIndexVO.biasNorm();
    double ar = stockIndexVO.ARNorm();
    double br = stockIndexVO.BRNorm();
    double rsi = stockIndexVO.getRSI();
    double wm = stockIndexVO.getWM();

    String name = stockVO.getName();
    int dataNum = stockVO.getDate().length;
    String textColor;

    boolean followed = false;//标记是否在自选列表中

    if (userID != null) {
        ManageSelfSelectStock selfSelectStock = new ManageSelfSelectStock();
        List<String> stockList = selfSelectStock.getAllInterestedStock(userID);

        followed = stockList.contains(stockVO.getId());
    }
%>

<%--处理数据--%>
<script>
    var dataDate = [];
    var dataVolume = [];
    var dataHigh = [];
    var dataLow = [];
    var dataOpen = [];
    var dataClose = [];
    var dataDaily = [];

    <c:forEach items="${date}" var="dateShow" varStatus="loop">
    var dateShow = "${dateShow}"
    var dateK = "${dateDailyK[loop.count-1]}";
    var volumeShow = "${volume[loop.count-1]}";
    var highShow = "${high[loop.count-1]}";
    var lowShow = "${low[loop.count-1]}";
    var openShow = "${open[loop.count-1]}";
    var closeShow = "${close[loop.count-1]}";

    dataDate.push(dateShow);
    dataHigh.push(highShow);
    dataLow.push(lowShow);
    dataOpen.push(openShow);
    dataClose.push(closeShow);
    dataVolume.push(volumeShow);
    dataDaily.push([dateK, openShow * 1, closeShow * 1, lowShow * 1, highShow * 1]);//日期、开盘、收盘、最低、最高
    </c:forEach>
</script>
<%--周K数据--%>
<script>
    var dataDateWeekly = [];
    var dataWeekly = [];
    <c:forEach items="${dateWeeklyK}" var="dateShowWeekly" varStatus="loop">
    var dateWeeklyK = "${dateWeeklyK[loop.count-1]}"
    var highShowWeekly = "${highWeekly[loop.count-1]}"
    var lowShowWeekly = "${lowWeekly[loop.count-1]}"
    var openShowWeekly = "${openWeekly[loop.count-1]}"
    var closeShowWeekly = "${closeWeekly[loop.count-1]}"
    dataWeekly.push([dateWeeklyK, openShowWeekly * 1, closeShowWeekly * 1, lowShowWeekly * 1, highShowWeekly * 1])//开盘、收盘、最低、最高
    </c:forEach>
</script>

<%--月k数据--%>
<script>
    var dataDateMonthly = [];
    var dataMonthly = [];
    <c:forEach items="${dateMonthlyK}" var="dateShowMonthly" varStatus="loop">
    var dateMonthlyK = "${dateMonthlyK[loop.count-1]}"
    var highShowMonthly = "${highMonthly[loop.count-1]}";
    var lowShowMonthly = "${lowMonthly[loop.count-1]}";
    var openShowMonthly = "${openMonthly[loop.count-1]}";
    var closeShowMonthly = "${closeMonthly[loop.count-1]}";
    dataMonthly.push([dateMonthlyK, openShowMonthly * 1, closeShowMonthly * 1, lowShowMonthly * 1, highShowMonthly * 1]);//开盘、收盘、最低、最高
    </c:forEach>
</script>

<%--分时图数据--%>
<script>
    var dataTime = [];
    var dataPrice = [];
    var dataPriceAvg = [];
    <c:forEach items="${time}" var="timeShow" varStatus="loop">
    var timeShow = "${timeShow}"
    var priceShow = "${price[loop.count-1]}";
    var priceAvgShow = "${priceAvg[loop.count-1]}";
    dataTime.push(timeShow);
    dataPrice.push(priceShow);
    dataPriceAvg.push(priceAvgShow);
    </c:forEach>
</script>


<head>
    <title>AnyQuant--<%=stockVO.getName()%>
    </title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link href="../images/icon.png" rel="icon"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style/docs.min.css" rel="stylesheet"/>
    <link href="../reference/date/css/daterangepicker.css" rel="stylesheet"/>
    <link href="../reference/loading/css/waitMe.css" rel="stylesheet"/>
    <link href="style/stockStyle.css" rel="stylesheet"/>
</head>
<body>

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
                    <li>
                        <a href="portfolio.jsp">
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
<%--导航栏End--%>

<%--content Start--%>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-6 col-md-2">
            <div id="sidebar">
                <span class="btn btn-danger" id="add-portfolio" data-toggle="button">
                    添加自选&nbsp;&nbsp;<span class="glyphicon glyphicon-plus"></span></span>
                <span class="btn btn-danger" id="delete-portfolio" data-toggle="button">
                    取消自选&nbsp;&nbsp;<span class="glyphicon glyphicon-minus"></span></span>
                <div class="list-group">
                    <ul class="menu" id="menu">
                        <li onclick="page_jump(this, 'latest-data')"
                            class="list-group-item text-center active">实时数据
                        </li>
                        <li onclick="page_jump(this, 'graphList')"
                            class="list-group-item text-center">
                            图&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;表
                        </li>
                        <li onclick="page_jump(this, 'history-data')"
                            class="list-group-item text-center">详细数据
                        </li>
                        <li onclick="page_jump(this, 'picture-prediction')"
                            class="list-group-item text-center">行情分析
                        </li>
                        <li onclick="page_jump(this, 'stock-news')"
                            class="list-group-item text-center">最新资讯
                        </li>
                        <li class="list-group-item text-center">
                            <a href="stockContrast.jsp?id=<%=stockID%>"
                               target="_blank" id="stock-contrast">股票对比</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-9">
            <div id="main-content">
                <div class="panel panel-default">
                    <div class="latest-data" id="latest-data"><!--最新数据-->
                        <div class="row">
                            <div class="col-md-3">
                                <div class="row">
                                    <div class="name-code">
                                        <div class="col-md-3">
                                            <img class="icon" src="<%=iconPath%>">
                                        </div>
                                        <div class="col-md-7">
                                            <div class="">
                                                <%--<div class="row"></div>--%>
                                                <P class="text-center name"><%=stockVO.getName()%>
                                                </P>
                                                <p class="text-center code">（<%=stockID%>）</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                ShowCurrentData currentData = new ShowCurrentData();
                                CurrentStockVO currentStockVO = currentData.showCurrentData(stockVO.getId());
                                if (currentStockVO.getIncrease_decreaseNum().charAt(0) == '-') {
                                    textColor = "text-success";
                                } else if (currentStockVO.getIncrease_decreaseNum().equals("0")) {
                                    textColor = "";
                                } else {
                                    textColor = "text-danger";
                                }
                            %>
                            <div class="col-md-3">
                                <div class="inc-dec">
                                    <p class="text-left <%=textColor%> price">
                                        <%=currentStockVO.getCurrentPrice()%>
                                        <small>
                                            <small>
                                                <small class="<%=textColor%>">
                                                    <%=currentStockVO.getIncrease_decreaseNum()%>
                                                    (<%=currentStockVO.getIncrease_decreaseRate()%>)
                                                </small>
                                            </small>
                                        </small>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="data">
                                    <div class="data-top"><%--顶部数据，包含今开、最高、成交量--%>
                                        <div class="col-md-3 col-md-offset-1">
                                            <p class="text-left">今开：<%=currentStockVO.getOpen()%>
                                            </p>
                                        </div>
                                        <div class="col-md-3">
                                            <p class="text-left">最高：<%=currentStockVO.getHigh()%>
                                            </p>
                                        </div>
                                        <div class="col-md-5">
                                            <P class="text-left">成交量：<%=currentStockVO.getVolume()%>
                                            </P>
                                        </div>
                                    </div>
                                    <div class="data-bottom"><%--底部数据，包含昨收、最低、成交额--%>
                                        <div class="col-md-3 col-md-offset-1">
                                            <p class="text-left">昨收：<%=currentStockVO.getClose()%>
                                            </p>
                                        </div>
                                        <div class="col-md-3">
                                            <p class="text-left">最低：<%=currentStockVO.getLow()%>
                                            </p>
                                        </div>
                                        <div class="col-md-5">
                                            <P class="text-left">成交额：<%=currentStockVO.getVolume_value()%>
                                            </P>
                                        </div>
                                    </div>
                                </div>
                                <%--data--%>
                            </div>
                        </div>
                    </div>
                    <%--最新数据End--%>
                    <div class="graphs" id="graphList">
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#分时图" data-toggle="tab">分时图</a>
                            </li>
                            <li class="dropdown">
                                <a href="#" id="tabDrop" class="dropdown-toggle"
                                   data-toggle="dropdown">折线图
                                    <b class="caret"></b>
                                </a>
                                <ul id="drop-menu" class="dropdown-menu" role="menu" aria-labelledby="tabDrop">
                                    <li>
                                        <a href="#折线图-0" tabindex="-1" data-toggle="tab">最高/最低</a>
                                    </li>
                                    <li>
                                        <a href="#折线图-1" tabindex="-1" data-toggle="tab">开盘/收盘</a>
                                    </li>
                                    <li>
                                        <a href="#折线图-2" tabindex="-1" data-toggle="tab">成交量</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#月K线" data-toggle="tab">月K线</a>
                            </li>
                            <li>
                                <a href="#周K线" data-toggle="tab">周K线</a>
                            </li>
                            <li>
                                <a href="#日K线" data-toggle="tab">日K线</a>
                            </li>
                        </ul>
                        <div id="graphs">
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="分时图">
                                    <div class="chart" id="timeSeriesChart"></div>
                                </div>
                                <div class="tab-pane fade" id="折线图-0">
                                    <div class="chart" id="lineChart-0"></div>
                                </div>
                                <div class="tab-pane fade" id="折线图-1">
                                    <div class="chart" id="lineChart-1"></div>
                                </div>
                                <div class="tab-pane fade" id="折线图-2">
                                    <div class="chart" id="lineChart-2"></div>
                                </div>
                                <div class="tab-pane fade" id="月K线">
                                    <div class="chart" id="monthlyKLine"></div>
                                </div>
                                <div class="tab-pane fade" id="周K线">
                                    <div class="chart" id="weeklyKLine"></div>
                                </div>
                                <div class="tab-pane fade" id="日K线">
                                    <div class="chart" id="dailyKLine"></div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <%--统计图End--%>
                    <div class="history-data" id="history-data">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                详细数据&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="badge" data-toggle="tooltip"
                                      id="data-num" title="数据数量"><%=dataNum%></span>
                            </div>
                            <div class="options">
                                <button type="button" class="btn btn-primary" id="show-date">日期范围</button>
                                <label id="date" style="display: none;">
                                    <%
                                        String endDate = stockVO.getDate()[dataNum - 1];
                                        String startDate = stockVO.getDate()[0];
                                    %>
                                    <input class="text-center" id="startDate" style="width: 100px;"
                                           value=<%=startDate%>> 至
                                    <input class="text-center" id="endDate" style="width: 100px;" readonly
                                           value="<%=endDate%>">
                                </label>
                                <ul class="pagination pagination-sm pull-right" id="pagination">
                                    <li onclick="changePage(0)" class="disabled">
                                        <a href="javascript: void(0)">&laquo;</a></li>
                                    <%
                                        if (dataNum > 15) {//数据少于15条时，不显示分页导航
                                            for (int i = 1; i <= (dataNum - 1) / 15 + 1; i++) {
                                    %>
                                    <li onclick="changePage(<%=i%>)">
                                        <a href="javascript: void(0)"><%=i%>
                                        </a>
                                    </li>
                                    <%
                                            }
                                        }
                                    %>
                                    <li onclick="changePage(-1)"><a href="javascript: void(0)">&raquo;</a></li>
                                </ul>
                            </div>
                            <div id="pagination-content">
                                <%
                                    //分页，每页15条数据
                                    //记录当前显示数据的指针，从最后逐个前进到开始位置
                                    int index = dataNum;
                                    for (int i = 0; i < (dataNum - 1) / 15 + 1; i++) {
                                %>
                                <div class="table-responsive" id="page-<%=i + 1%>" style="display: none">
                                    <table class="table table-striped text-center">
                                        <thead>
                                        <tr>
                                            <th class="text-center">日期</th>
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
                                        <tbody class="table-body">
                                        <%
                                            for (int j = 0; j < 15; j++) {
                                                index--;
                                                if (index < 0) {
                                                    break;
                                                }
                                        %>
                                        <tr>
                                            <td><%=stockVO.getDate()[index]%>
                                            </td>
                                            <td><%=stockVO.getHigh()[index]%>
                                            </td>
                                            <td><%=stockVO.getLow()[index]%>
                                            </td>
                                            <td><%=stockVO.getIncrease_decreaseNum()[index]%>
                                            </td>
                                            <td><%=stockVO.getIncrease_decreaseRate()[index]%>
                                            </td>
                                            <td><%=stockVO.getOpen()[index]%>
                                            </td>
                                            <td><%=stockVO.getClose()[index]%>
                                            </td>
                                            <td><%=Convert.getDealNum(stockVO.getVolume()[index])%>
                                            </td>
                                            <td><%=stockVO.getPe_ttm()[index]%>
                                            </td>
                                            <td><%=stockVO.getPb()[index]%>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <%--历史数据End--%>
                    <div id="picture-prediction">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                行情分析
                            </div>
                            <div class="panel-body">
                                <div class="chart" id="radarChart"></div>
                                <div class="analysis">
                                    <div class="well well-sm">
                                        <p>${stockIndex.conclusion1()}</p>
                                        <p>${stockIndex.conclusion2()}</p>
                                        <p>${stockIndex.conclusion3()}</p>
                                        <p>${stockIndex.conclusion4()}</p>
                                        <p>${stockIndex.conclusion5()}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--行情分析End--%>
                    <div id="stock-news">
                        <div class="accordion" id="accordion-102144">
                            <div class="accordion-group">
                                <%
                                    for (int i = 0; i < newsList.size(); i++) {
                                        String title = newsList.get(i).getTitle();
                                        String content = newsList.get(i).getContent();
                                %>

                                <h2>
                                    <a class="accordion-toggle collapsed" data-toggle="collapse"
                                       data-parent="#accordion-102144"
                                       href="#accordion-element-<%=i%>"><%=title%>
                                    </a>
                                </h2>
                                <div id="accordion-element-<%=i%>" class="accordion-body collapse in">
                                    <div class="accordion-inner well">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content%>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <%--实时资讯End--%>
                </div>
            </div>
        </div>
    </div>
</div>
<%--content End--%>

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

<script src="js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="../reference/date/js/moment.min.js"></script>
<script src="../reference/date/js/jquery.daterangepicker.js"></script>
<script src="../reference/loading/js/waitMe.js"></script>
<script src="js/stock.js"></script>

<!-- ECharts单文件引入 -->
<script src="//cdn.bootcss.com/echarts/3.1.10/echarts.js"></script>

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
                    $('#add-portfolio').show();
                    $('#delete-portfolio').hide();
                }
            });
        }
    });
</script>
<%--退出操作End--%>

<%--分时图Start--%>
<script>
    var myChart = echarts.init(document.getElementById('timeSeriesChart'));
    var option = {
        title: {
            text: '<%=name%>分时图'
        },
        tooltip: {
            trigger: 'axis'
        },

        legend: {
            data: ['最新价格', '均价'],
            selectedMode: false
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: false},
                dataView: {show: false, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: false}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                boundaryGap: false,
                data: dataTime
            }
        ],
        yAxis: [
            {
                type: 'value',
                axisLine: {onZero: false},
                axisLabel: {
                    formatter: '{value}'
                },
                scale: true,
                splitArea: {
                    show: true
                }
            }
        ],
        series: [
            {
                name: '最新价格',
                type: 'line',
                data: dataPrice
            },
            {
                name: '均价',
                type: 'line',
                data: dataPriceAvg
            }
        ]
    };
    myChart.setOption(option);
</script>
<%--分时图End--%>

<%--折线图最高价、最低价Start--%>
<script>
    var myChart = echarts.init(document.getElementById('lineChart-0'));
    var option = {
        title: {
            text: '<%=name%>折线图'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['最高价', '最低价']
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: false},
                dataView: {show: false, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: false}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                boundaryGap: false,
                data: dataDate
            }
        ],
        yAxis: [
            {
                type: 'value',
                axisLine: {onZero: false},
                axisLabel: {
                    formatter: '{value}'
                },
                scale: true,
                splitArea: {
                    show: true
                }
            }
        ],
        dataZoom: [
            {
                type: 'inside',
                start: 50,
                end: 100
            },
            {
                show: true,
                type: 'slider',
                y: '90%',
                start: 50,
                end: 100
            }
        ],
        series: [
            {
                name: '最高价',
                type: 'line',
                data: dataHigh,
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            },
            {
                name: '最低价',
                type: 'line',
                data: dataLow,
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }
        ]
    };
    myChart.setOption(option);

</script>
<%--折线图End--%>

<%--折线图开盘价、收盘价Start--%>
<script>
    var myChart = echarts.init(document.getElementById('lineChart-1'));
    var option = {
        title: {
            text: '<%=name%>折线图'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['开盘价', '收盘价']
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: false},
                dataView: {show: false, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: false}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                boundaryGap: false,
                data: dataDate
            }
        ],
        yAxis: [
            {
                type: 'value',
                axisLine: {onZero: false},
                axisLabel: {
                    formatter: '{value}'
                },
                scale: true,
                splitArea: {
                    show: true
                }
            }
        ],
        dataZoom: [
            {
                type: 'inside',
                start: 50,
                end: 100
            },
            {
                show: true,
                type: 'slider',
                y: '90%',
                start: 50,
                end: 100
            }
        ],
        series: [
            {
                name: '开盘价',
                type: 'line',
                data: dataOpen,
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            },
            {
                name: '收盘价',
                type: 'line',
                data: dataClose,
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }
        ]
    };
    myChart.setOption(option);
</script>
<%--折线图End--%>

<%--折线图成交量Start--%>
<script>
    var myChart = echarts.init(document.getElementById('lineChart-2'));
    var option = {
        title: {
            text: '<%=name%>折线图'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['成交量']
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: false},
                dataView: {show: false, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: false}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                boundaryGap: false,
                data: dataDate
            }
        ],
        yAxis: [
            {
                type: 'value',
                axisLine: {onZero: false},
                axisLabel: {
                    formatter: '{value} 亿手'
                },
                scale: true,
                splitArea: {
                    show: true
                }
            }
        ],
        dataZoom: [
            {
                type: 'inside',
                start: 50,
                end: 100
            },
            {
                show: true,
                type: 'slider',
                y: '90%',
                start: 50,
                end: 100
            }
        ],
        series: [
            {
                name: '成交量',
                type: 'line',
                data: dataVolume,
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }
        ]
    };
    myChart.setOption(option);
</script>
<%--折线图End--%>

<%--日K线Start--%>
<script>
    var myChart = echarts.init(document.getElementById('dailyKLine'));
    var data0 = splitData(dataDaily);

    function splitData(rawData) {
        var categoryData = [];
        var values = [];
        for (var i = 0; i < rawData.length; i++) {
            categoryData.push(rawData[i].splice(0, 1)[0]);
            values.push(rawData[i])
        }
        return {
            categoryData: categoryData,
            values: values
        };
    }

    function calculateMA(dayCount) {
        var result = [];
        for (var i = 0, len = data0.values.length; i < len; i++) {
            if (i < dayCount) {
                result.push('-');
                continue;
            }
            var sum = 0;
            for (var j = 0; j < dayCount; j++) {
                sum += data0.values[i - j][1];
            }
            var sd = sum / dayCount;
            result.push(sd.toFixed(2));
        }
        return result;
    }

    option = {
        title: {
            text: '<%=name%>日K线',
            left: 0
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'line'
            }
        },
        legend: {
            data: ['日K', 'MA5', 'MA10', 'MA20', 'MA30']
        },
        grid: {
            left: '10%',
            right: '10%',
            bottom: '15%'
        },
        xAxis: {
            type: 'category',
            data: data0.categoryData,
            scale: true,
            boundaryGap: false,
            axisLine: {onZero: false},
            splitLine: {show: false},
            splitNumber: 20,
            min: 'dataMin',
            max: 'dataMax'
        },
        yAxis: {
            scale: true,
            splitArea: {
                show: true
            }
        },
        dataZoom: [
            {
                type: 'inside',
                start: 50,
                end: 100
            },
            {
                show: true,
                type: 'slider',
                y: '90%',
                start: 50,
                end: 100
            }
        ],
        series: [
            {
                name: '日K',
                type: 'candlestick',
                data: data0.values,
                markPoint: {
                    label: {
                        normal: {
                            formatter: function (param) {
                                return param != null ? Math.round(param.value) : '';
                            }
                        }
                    },
                    data: [
                        {
                            name: 'highest value',
                            type: 'max',
                            valueDim: 'highest'
                        },
                        {
                            name: 'lowest value',
                            type: 'min',
                            valueDim: 'lowest'
                        },
                        {
                            name: 'average value on close',
                            type: 'average',
                            valueDim: 'close'
                        }
                    ],
                    tooltip: {
                        formatter: function (param) {
                            return param.name + '<br>' + (param.data.coord || '');
                        }
                    }
                },
                markLine: {
                    symbol: ['none', 'none'],
                    data: [
                        [
                            {
                                name: 'from lowest to highest',
                                type: 'min',
                                valueDim: 'lowest',
                                symbol: 'circle',
                                symbolSize: 10,
                                label: {
                                    normal: {show: false},
                                    emphasis: {show: false}
                                }
                            },
                            {
                                type: 'max',
                                valueDim: 'highest',
                                symbol: 'circle',
                                symbolSize: 10,
                                label: {
                                    normal: {show: false},
                                    emphasis: {show: false}
                                }
                            }
                        ],
                        {
                            name: 'min line on close',
                            type: 'min',
                            valueDim: 'close'
                        },
                        {
                            name: 'max line on close',
                            type: 'max',
                            valueDim: 'close'
                        }
                    ]
                }
            },
            {
                name: 'MA5',
                type: 'line',
                data: calculateMA(5),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA10',
                type: 'line',
                data: calculateMA(10),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA20',
                type: 'line',
                data: calculateMA(20),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA30',
                type: 'line',
                data: calculateMA(30),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            }
        ]
    };
    myChart.setOption(option);

</script>
<%--日K线End--%>

<%--周K线Start--%>
<script>
    var myChart = echarts.init(document.getElementById('weeklyKLine'));
    var data0 = splitData(dataWeekly);

    function splitData(rawData) {
        var categoryData = [];
        var values = [];
        for (var i = 0; i < rawData.length; i++) {
            categoryData.push(rawData[i].splice(0, 1)[0]);
            values.push(rawData[i])
        }
        return {
            categoryData: categoryData,
            values: values
        };
    }

    function calculateMA(dayCount) {
        var result = [];
        for (var i = 0, len = data0.values.length; i < len; i++) {
            if (i < dayCount) {
                result.push('-');
                continue;
            }
            var sum = 0;
            for (var j = 0; j < dayCount; j++) {
                sum += data0.values[i - j][1];
            }
            var sd = sum / dayCount;
            result.push(sd.toFixed(2));
        }
        return result;
    }

    option = {
        title: {
            text: '<%=name%>周K线',
            left: 0
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'line'
            }
        },
        legend: {
            data: ['周K', 'MA5', 'MA10', 'MA20', 'MA30']
        },
        grid: {
            left: '10%',
            right: '10%',
            bottom: '15%'
        },
        xAxis: {
            type: 'category',
            data: data0.categoryData,
            scale: true,
            boundaryGap: false,
            axisLine: {onZero: false},
            splitLine: {show: false},
            splitNumber: 20,
            min: 'dataMin',
            max: 'dataMax'
        },
        yAxis: {
            scale: true,
            splitArea: {
                show: true
            }
        },
        dataZoom: [
            {
                type: 'inside',
                start: 50,
                end: 100
            },
            {
                show: true,
                type: 'slider',
                y: '90%',
                start: 50,
                end: 100
            }
        ],
        series: [
            {
                name: '周K',
                type: 'candlestick',
                data: data0.values,
                markPoint: {
                    label: {
                        normal: {
                            formatter: function (param) {
                                return param != null ? Math.round(param.value) : '';
                            }
                        }
                    },
                    data: [
                        {
                            name: 'XX标点',
                            coord: ['2013/5/31', 2300],
                            value: 2300,
                            itemStyle: {
                                normal: {color: 'rgb(41,60,85)'}
                            }
                        },
                        {
                            name: 'highest value',
                            type: 'max',
                            valueDim: 'highest'
                        },
                        {
                            name: 'lowest value',
                            type: 'min',
                            valueDim: 'lowest'
                        },
                        {
                            name: 'average value on close',
                            type: 'average',
                            valueDim: 'close'
                        }
                    ],
                    tooltip: {
                        formatter: function (param) {
                            return param.name + '<br>' + (param.data.coord || '');
                        }
                    }
                },
                markLine: {
                    symbol: ['none', 'none'],
                    data: [
                        [
                            {
                                name: 'from lowest to highest',
                                type: 'min',
                                valueDim: 'lowest',
                                symbol: 'circle',
                                symbolSize: 10,
                                label: {
                                    normal: {show: false},
                                    emphasis: {show: false}
                                }
                            },
                            {
                                type: 'max',
                                valueDim: 'highest',
                                symbol: 'circle',
                                symbolSize: 10,
                                label: {
                                    normal: {show: false},
                                    emphasis: {show: false}
                                }
                            }
                        ],
                        {
                            name: 'min line on close',
                            type: 'min',
                            valueDim: 'close'
                        },
                        {
                            name: 'max line on close',
                            type: 'max',
                            valueDim: 'close'
                        }
                    ]
                }
            },
            {
                name: 'MA5',
                type: 'line',
                data: calculateMA(5),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA10',
                type: 'line',
                data: calculateMA(10),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA20',
                type: 'line',
                data: calculateMA(20),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA30',
                type: 'line',
                data: calculateMA(30),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            }
        ]
    };
    myChart.setOption(option);

</script>
<%--周K线End--%>

<%--月K线Start--%>
<script>
    var myChart = echarts.init(document.getElementById('monthlyKLine'));
    var data0 = splitData(dataMonthly);

    function splitData(rawData) {
        var categoryData = [];
        var values = [];
        for (var i = 0; i < rawData.length; i++) {
            categoryData.push(rawData[i].splice(0, 1)[0]);
            values.push(rawData[i])
        }
        return {
            categoryData: categoryData,
            values: values
        };
    }

    function calculateMA(dayCount) {
        var result = [];
        for (var i = 0, len = data0.values.length; i < len; i++) {
            if (i < dayCount) {
                result.push('-');
                continue;
            }
            var sum = 0;
            for (var j = 0; j < dayCount; j++) {
                sum += data0.values[i - j][1];
            }
            var sd = sum / dayCount;
            result.push(sd.toFixed(2));
        }
        return result;
    }

    option = {
        title: {
            text: '<%=name%>月K线',
            left: 0
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'line'
            }
        },
        legend: {
            data: ['月K', 'MA5', 'MA10', 'MA20', 'MA30']
        },
        grid: {
            left: '10%',
            right: '10%',
            bottom: '15%'
        },
        xAxis: {
            type: 'category',
            data: data0.categoryData,
            scale: true,
            boundaryGap: false,
            axisLine: {onZero: false},
            splitLine: {show: false},
            splitNumber: 20,
            min: 'dataMin',
            max: 'dataMax'
        },
        yAxis: {
            scale: true,
            splitArea: {
                show: true
            }
        },
        dataZoom: [
            {
                type: 'inside',
                start: 50,
                end: 100
            },
            {
                show: true,
                type: 'slider',
                y: '90%',
                start: 50,
                end: 100
            }
        ],
        series: [
            {
                name: '月K',
                type: 'candlestick',
                data: data0.values,
                markPoint: {
                    label: {
                        normal: {
                            formatter: function (param) {
                                return param != null ? Math.round(param.value) : '';
                            }
                        }
                    },
                    data: [
                        {
                            name: 'XX标点',
                            coord: ['2013/5/31', 2300],
                            value: 2300,
                            itemStyle: {
                                normal: {color: 'rgb(41,60,85)'}
                            }
                        },
                        {
                            name: 'highest value',
                            type: 'max',
                            valueDim: 'highest'
                        },
                        {
                            name: 'lowest value',
                            type: 'min',
                            valueDim: 'lowest'
                        },
                        {
                            name: 'average value on close',
                            type: 'average',
                            valueDim: 'close'
                        }
                    ],
                    tooltip: {
                        formatter: function (param) {
                            return param.name + '<br>' + (param.data.coord || '');
                        }
                    }
                },
                markLine: {
                    symbol: ['none', 'none'],
                    data: [
                        [
                            {
                                name: 'from lowest to highest',
                                type: 'min',
                                valueDim: 'lowest',
                                symbol: 'circle',
                                symbolSize: 10,
                                label: {
                                    normal: {show: false},
                                    emphasis: {show: false}
                                }
                            },
                            {
                                type: 'max',
                                valueDim: 'highest',
                                symbol: 'circle',
                                symbolSize: 10,
                                label: {
                                    normal: {show: false},
                                    emphasis: {show: false}
                                }
                            }
                        ],
                        {
                            name: 'min line on close',
                            type: 'min',
                            valueDim: 'close'
                        },
                        {
                            name: 'max line on close',
                            type: 'max',
                            valueDim: 'close'
                        }
                    ]
                }
            },
            {
                name: 'MA5',
                type: 'line',
                data: calculateMA(5),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA10',
                type: 'line',
                data: calculateMA(10),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA20',
                type: 'line',
                data: calculateMA(20),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            },
            {
                name: 'MA30',
                type: 'line',
                data: calculateMA(30),
                smooth: true,
                lineStyle: {
                    normal: {opacity: 0.5}
                }
            }
        ]
    };
    myChart.setOption(option);

</script>
<%--月K线End--%>

<%--添加/取消关注切换Start--%>
<script>
    $(function () {
        if (<%=followed%>) {
            $('#delete-portfolio').show();
        } else {
            $("#add-portfolio").show();
        }
    });

    $('#add-portfolio').on('click', function () {
                if (<%=userID == null%>) {//若未登录，跳转至登录界面
                    top.location = 'login.jsp';
                } else {//添加自选
                    $.ajax({
                        url: '/portfolio',
                        type: 'POST',
                        data: {id: '<%=userID%>', type: 'add', data: '<%=stockID%>'},
                        success: function () {
                            $('#add-portfolio').hide();
                            $('#delete-portfolio').show();
                        }
                    });
                }
            }
    );

    $('#delete-portfolio').on('click', function () {//取消自选
        $.ajax({
            url: '/portfolio',
            type: 'POST',
            data: {id: '<%=userID%>', type: 'delete', data: '<%=stockID%>'},
            success: function () {
                $('#delete-portfolio').hide();
                $('#add-portfolio').show();
            }
        });
    });
</script>
<%--添加/取消关注切换End--%>

<%--雷达图Start--%>
<script>
    var myChart = echarts.init(document.getElementById('radarChart'));

    var option = {
        title: {
            text: '<%=stockVO.getName()%>',
            subtext: '银行股指标分析'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            x: 'center',
            data: ['<%=stockVO.getName()%>']
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: false},
                dataView: {show: false, readOnly: false},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        polar: [
            {
                indicator: [
                    {text: '乖离率', max: 100},
                    {text: '相对强弱指标', max: 100},
                    {text: '威廉超买超卖指标', max: 100},
                    {text: '人气指标', max: 100},
                    {text: '意愿指标', max: 100}
                ],
                radius: 130
            }
        ],
        series: [
            {
                name: '银行股指标数据',
                type: 'radar',
                tooltip: {
                    trigger: 'item'
                },
                itemStyle: {
                    normal: {
                        areaStyle: {
                            type: 'default'
                        }
                    }
                },
                data: [
                    {
                        value: [<%=bias%>, <%=rsi%>, <%=wm%>, <%=ar%>, <%=br%>],
                        name: '<%=stockVO.getName()%>',
                        label: {
                            normal: {
                                show: true,
                                formatter: function (params) {
                                    return params.value;
                                }
                            }
                        }
                    }
                ]
            }
        ]
    };
    myChart.setOption(option);

</script>
<%--雷达图End--%>

<%--日期选择框Start--%>
<script>
    //日期改变后更新数据
    $(endDate).dateRangePicker().bind('datepicker-change', function () {
        apply('<%=stockID%>');
    });
</script>
<%--日期选择框End--%>

<%--分页Start--%>
<script>
    <%
    if (dataNum <= 15){//若数据少于15，隐藏分页导航
    %>
    $('#pagination').hide();
    <%
    }
    %>
</script>
<%--分页End--%>

</body>
</html>