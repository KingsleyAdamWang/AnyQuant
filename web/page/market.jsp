<%@ page import="vo.CurrentIndexVO" %>
<%@ page import="vo.IndexVO" %>
<%@ page import="bl.util.Convert" %>
<%@ page import="vo.BusinessNewsVO" %>
<%@ page import="java.util.List" %>
<%@ page import="util.Cast" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <meta charset="UTF-8">
    <title>AnyQuant--大盘指数</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <link href="../images/icon.png" rel="icon"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="../reference/date/css/daterangepicker.css" rel="stylesheet"/>
    <link href="../reference/loading/css/waitMe.css" rel="stylesheet"/>
    <link href="style/docs.min.css" rel="stylesheet"/>
    <link href="style/marketStyle.css" rel="stylesheet"/>
</head>

<%
    String userID = (String) session.getAttribute("UserId");
    CurrentIndexVO currentIndexVO = (CurrentIndexVO) session.getAttribute("currentIndexVO");
    IndexVO indexVO = (IndexVO) session.getAttribute("indexVO");
    List<BusinessNewsVO> businessNews = Cast.cast(session.getAttribute("businessNews"));

    int dataNum = indexVO.getDate().length;
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
                    <li class="active">
                        <a href="javascript: void(0)">
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

<%--周k线数据Start--%>
<script>
    var dataDateWeekly = [];
    var dataWeekly = [];
    <c:forEach items="${dateWeekly}" var="dateShowWeekly" varStatus="loop">
    var dateShowWeekly = "${dateShowWeekly}"
    var dateWeeklyK = "${dateWeeklyK[loop.count-1]}"
    var highShowWeekly = "${highWeekly[loop.count-1]}"
    var lowShowWeekly = "${lowWeekly[loop.count-1]}"
    var openShowWeekly = "${openWeekly[loop.count-1]}"
    var closeShowWeekly = "${closeWeekly[loop.count-1]}"
    dataWeekly.push([dateWeeklyK, openShowWeekly * 1, closeShowWeekly * 1, lowShowWeekly * 1, highShowWeekly * 1])//开盘、收盘、最低、最高
    </c:forEach>

</script>
<%--周k线数据End--%>

<%--月k线数据Start--%>
<script>
    var dataDateMonthly = [];
    var dataMonthly = [];
    <c:forEach items="${dateMonthly}" var="dateShowMonthly" varStatus="loop">
    var dateShowMonthly = "${dateShowMonthly}";
    var dateMonthlyK = "${dateMonthlyK[loop.count-1]}"
    var highShowMonthly = "${highMonthly[loop.count-1]}";
    var lowShowMonthly = "${lowMonthly[loop.count-1]}";
    var openShowMonthly = "${openMonthly[loop.count-1]}";
    var closeShowMonthly = "${closeMonthly[loop.count-1]}";
    dataMonthly.push([dateMonthlyK, openShowMonthly * 1, closeShowMonthly * 1, lowShowMonthly * 1, highShowMonthly * 1]);//开盘、收盘、最低、最高
    </c:forEach>
</script>
<%--月k线数据End--%>

<%--content Start--%>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-6 col-md-2">
            <div id="sidebar">
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
                        <li onclick="page_jump(this, 'index-news')"
                            class="list-group-item text-center">最新资讯
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
                            <div class="col-md-2">
                                <div class="name-code">
                                    <P class="text-center name"> 沪深300
                                    </P>
                                    <p class="text-center code">（1B40003）</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="inc-dec">
                                    <p class="text-left price">
                                        <%=currentIndexVO.getCurrentPrice()%>
                                        <small>
                                            <small>
                                                <%
                                                    String textColor;
                                                    if (currentIndexVO.getIncrease_decreaseNum().charAt(0) == '-') {
                                                        textColor = "text-success";
                                                    } else if (currentIndexVO.getIncrease_decreaseNum().equals("0")) {
                                                        textColor = "";
                                                    } else {
                                                        textColor = "text-danger";
                                                    }
                                                %>
                                                <small class="<%=textColor%>">
                                                    <%=currentIndexVO.getIncrease_decreaseNum()%>
                                                    (<%=currentIndexVO.getIncrease_decreaseRate()%>)
                                                </small>
                                            </small>
                                        </small>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <%--<div class="data">--%>
                                <table class="data">
                                    <tr class="data-top">
                                        <td>
                                            今开：<%=currentIndexVO.getOpen()%>
                                        </td>
                                        <td>
                                            最高：<%=currentIndexVO.getHigh()%>
                                        </td>
                                        <td>
                                            成交量：<%=currentIndexVO.getVolume()%>
                                        </td>
                                    </tr>
                                    <tr class="data-bottom">
                                        <td>
                                            昨收：<%=currentIndexVO.getClose()%>
                                        </td>
                                        <td>
                                            最低：<%=currentIndexVO.getLow()%>
                                        </td>
                                        <td>
                                            成交额：<%=currentIndexVO.getVolume_value()%>
                                        </td>
                                    </tr>
                                </table>
                                <%--</div>--%>
                                <%--data--%>
                            </div>
                        </div>
                    </div>
                    <%--最新数据End--%>
                    <div class="graphs" id="graphList">
                        <ul class="nav nav-tabs">
                            <li class="dropdown active">
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
                                <div class="tab-pane fade in active" id="折线图-0">
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
                                        String endDate = indexVO.getDate()[dataNum - 1];
                                        String startDate = indexVO.getDate()[0];
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
                                    <li onclick="changePage(-1)">
                                        <a href="javascript: void(0)">&raquo;</a></li>
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
                                            <td><%=indexVO.getDate()[index]%>
                                            </td>
                                            <td><%=indexVO.getHigh()[index]%>
                                            </td>
                                            <td><%=indexVO.getLow()[index]%>
                                            </td>
                                            <td><%=indexVO.getIncrease_decreaseNum()[index]%>
                                            </td>
                                            <td><%=indexVO.getIncrease_decreaseRate()[index]%>
                                            </td>
                                            <td><%=indexVO.getOpen()[index]%>
                                            </td>
                                            <td><%=indexVO.getClose()[index]%>
                                            </td>
                                            <td><%=Convert.getDealNum(indexVO.getVolume()[index])%>
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
                    <div id="index-news">
                        <div class="panel panel-default" id="accordion-102">
                            <div class="panel-heading">
                                <span class="glyphicon glyphicon-list-alt"></span>
                                <b>&nbsp;&nbsp;最新咨询</b>
                            </div>
                            <div class="panel">
                                <%
                                    for (int i = 0; i < businessNews.size(); i++) {
                                        String title = businessNews.get(i).getTitle();
                                        String content = businessNews.get(i).getContent();
                                %>
                                <div class="panel-heading">
                                    <h1 class="panel-title">
                                        <a href="#element-<%=i%>" data-toggle="collapse"
                                           data-parent="#accordion-102"><%=title%>
                                        </a>
                                    </h1>
                                </div>
                                <div id="element-<%=i%>" class="panel-collapse collapse">
                                    <div class="panel-body well">
                                        <blockquote>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=content%>
                                        </blockquote>
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

</body>

<script src="js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="../reference/date/js/moment.min.js"></script>
<script src="../reference/date/js/jquery.daterangepicker.js"></script>
<%--echarts引包--%>
<script src="//cdn.bootcss.com/echarts/3.1.10/echarts.js"></script>
<script src="../reference/loading/js/waitMe.js"></script>
<script src="js/market.js"></script>

<%--折线图最高价、最低价Start--%>
<script>
    var myChart = echarts.init(document.getElementById('lineChart-0'));
    var option = {
        title: {
            text: '沪深300折线图'
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
            text: '沪深300折线图'
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
            text: '沪深300折线图'
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
            text: '沪深300日K线',
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
            text: '沪深300周K线',
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
            text: '沪深300月K线',
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

<%--分页Start--%>
<script>
    $(function () {
        //默认显示第一页
        $('#page-1').show();
        $('#pagination').children(':nth-child(2)').addClass('active');

        //设置’涨跌额/幅‘颜色
        setColor();
    });

    <%
    if (dataNum <= 15){//若数据少于15，隐藏分页导航
    %>
    $('#pagination').hide();
    <%
    }
    %>

    /**
     * 初始化分页
     *  若页数仅为1页，隐藏分页导航
     *  否则，默认显示第一页
     */
    var initPage = function (pageNum) {
        if (pageNum == 1) {
            $('#pagination').hide();
        } else {
            $('#pagination').show();
        }

        $('#pagination').children(':nth-child(2)').addClass('active').siblings().removeClass('active');
        $('#pagination-content').children(':first').slideDown();
    };

    //切换分页
    var changePage = function (page) {
        //所有分页
        var pagination = $('#pagination').find('li');
        //当前分页
        var paginationSelected = getPaginationSelected();
        //当前页
        var pageSelected = getPageSelected();

        if (page == 0) {//向前翻页
            if (!$(pagination).first().hasClass('disabled')) {//当前页不为第一页，向前翻页可点击
                $(pageSelected).fadeOut().prev().fadeIn();
                $(paginationSelected).removeClass().prev().addClass('active');
            }
        } else if (page == -1) {//向后翻页
            if (!$(pagination).last().hasClass('disabled')) {//当前页不为最后，向后翻页可点击
                $(paginationSelected).removeClass().next().addClass('active');
                $(pageSelected).fadeOut().next().fadeIn();
            }
        } else {
            $('#page-' + page).fadeIn().siblings().fadeOut();
            $(pagination).find('a:contains(' + page + ')')
                    .parent().addClass('active')
                    .siblings().removeClass();
        }
        //更新当前页
        paginationSelected = getPaginationSelected();
        if ($(paginationSelected).is($(pagination).eq(1))) {//若当前为第一页，向前翻页不可点击
            $(pagination).first().addClass('disabled');
            $(pagination).last().removeClass();
        } else if ($(paginationSelected).is($(pagination).last().prev())) {//若当前为最后一页，向后翻页不可点击
            $(pagination).last().addClass('disabled');
            $(pagination).first().removeClass();
        } else {
            $(pagination).first().removeClass();
            $(pagination).last().removeClass();
        }
    };

    /**
     * 设置表格中‘涨跌额’和‘涨跌幅’颜色
     */
    var setColor = function () {
        $('.table-body tr td:nth-child(4)').filter(function () {
            return $(this).text() > 0;
        }).css({
            'color': 'red'
        }).end().filter(function () {
            return $(this).text() < 0;
        }).css({
            'color': 'green'
        });
        $('.table-body tr td:nth-child(5)').filter(function () {
            return $(this).text() > 0;
        }).css({
            'color': 'red'
        }).end().filter(function () {
            return $(this).text() < 0;
        }).css({
            'color': 'green'
        }).end().text(function (i, text) {
            return text != 0 ? (text + '%') : text;
        });
    };

    /**
     * 获得当前分页导航
     */
    var getPaginationSelected = function () {
        return $('#pagination').children().filter('.active');
    };

    /**
     * 获得当前分页
     */
    var getPageSelected = function () {
        return $('#pagination-content').children().filter(':visible');
    };
</script>
<%--分页End--%>

</html>


