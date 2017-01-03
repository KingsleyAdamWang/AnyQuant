<%@ page import="vo.TheIndexVO" %>
<%@ page import="vo.StockIDNameVO" %>
<%@ page import="java.util.List" %>
<%@ page import="util.Cast" %>
<%@ page import="vo.StockVO" %>
<%--
  Created by IntelliJ IDEA.
  User: song
  Date: 16-5-23
  Time: 下午11:47
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%
    String userID = (String) session.getAttribute("UserId");
    List<StockIDNameVO> stockIDNameList = Cast.cast(session.getAttribute("stockIDNameList"));

    String id_1 = (String) session.getAttribute("stockID_1");
    String stockName_1 = (String) session.getAttribute("name_" + id_1);
    TheIndexVO stockIndex_1 = (TheIndexVO) session.getAttribute("stockIndex_" + id_1);

    String id_2 = (String) session.getAttribute("stockID_2");
    String stockName_2 = null;
    TheIndexVO stockIndex_2 = null;
    if (id_2 != null) {
        stockName_2 = (String) session.getAttribute("name_" + id_2);

        stockIndex_2 = (TheIndexVO) session.getAttribute("stockIndex_" + id_2);
    }

    pageContext.setAttribute("stockName_1", stockName_1);
    pageContext.setAttribute("stockName_2", stockName_2);
    pageContext.setAttribute("stockIndex_1", stockIndex_1);
    pageContext.setAttribute("stockIndex_2", stockIndex_2);
%>

<head>
    <title>${stockName_1} VS ${stockName_2}</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link href="../images/icon.png" rel="icon"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style/docs.min.css" rel="stylesheet"/>
    <link href="../reference/slide/dist/powerange.css" rel="stylesheet"/>
    <link href="../reference/loading/css/waitMe.css" rel="stylesheet"/>
    <link href="style/stockContrastStyle.css" rel="stylesheet"/>
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

<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div id="main-content">
                <div class="panel">
                    <div class="well chart">
                        <div id="radarChart"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <span class="name">
                <span class="name_1">
                    <a data-toggle="modal" onclick="showModal(1)"
                       title="点击更换股票"><%=stockName_1%></a>
                </span>
                <span class="name_2">
                    <%
                        if (stockIndex_2 != null) {
                    %>
                    <a data-toggle="modal" onclick="showModal(2)"
                       title="点击更换股票">${stockName_2}</a>
                    <%
                    } else {
                    %>
                    <a data-toggle="modal" onclick="showModal(2)"
                       title="选择股票">选择股票</a>
                    <%
                        }
                    %>
                </span>
            </span>
            <%--滑块展现数据对比--%>
            <div class="slider-contract">
                <div class="well">
                    <div class="row">
                        <div class="col-md-3">
                            <h3><span class="label label-info">乖离率</span></h3>
                        </div>
                        <div class="col-md-1">
                            <span title="乖离率" class="pull-right">${stockIndex_1.biasNorm()}</span>
                        </div>
                        <div class="col-md-7 slider">
                            <input type="text" class="index_bias" title="乖离率">
                        </div>
                        <div class="col-md-1">
                            <span title="乖离率">${stockIndex_2.biasNorm()}</span>
                        </div>
                    </div>
                </div>
                <div class="well">
                    <div class="row">
                        <div class="col-md-3">
                            <h3><span class="label label-info">相对强弱指标</span></h3>
                        </div>
                        <div class="col-md-1">
                            <span title="相对强弱指标" class="pull-right">${stockIndex_1.RSI}</span>
                        </div>
                        <div class="col-md-7 slider">
                            <input type="text" class="index_RSI" title="相对强弱指标">
                        </div>
                        <div class="col-md-1">
                            <span title="相对强弱指标">${stockIndex_2.RSI}</span>
                        </div>
                    </div>
                </div>
                <div class="well">
                    <div class="row">
                        <div class="col-md-3">
                            <h3><span class="label label-info">威廉指标</span></h3>
                        </div>
                        <div class="col-md-1">
                            <span title="相对强弱指标" class="pull-right">${stockIndex_1.WM}</span>
                        </div>
                        <div class="col-md-7 slider">
                            <input type="text" class="index_WM" title="威廉指标">
                        </div>
                        <div class="col-md-1">
                            <span title="相对强弱指标">${stockIndex_2.WM}</span>
                        </div>
                    </div>
                </div>
                <div class="well">
                    <div class="row">
                        <div class="col-md-3">
                            <h3><span class="label label-info">人气指标</span></h3>
                        </div>
                        <div class="col-md-1">
                            <span title="相对强弱指标" class="pull-right">${stockIndex_1.ARNorm()}</span>
                        </div>
                        <div class="col-md-7 slider">
                            <input type="text" class="index_AR" title="人气指标">
                        </div>
                        <div class="col-md-1">
                            <span title="相对强弱指标">${stockIndex_2.ARNorm()}</span>
                        </div>
                    </div>
                </div>
                <div class="well">
                    <div class="row">
                        <div class="col-md-3">
                            <h3><span class="label label-info">意愿指标</span></h3>
                        </div>
                        <div class="col-md-1">
                            <span title="相对强弱指标" class="pull-right">${stockIndex_1.BRNorm()}</span>
                        </div>
                        <div class="col-md-7 slider">
                            <input type="text" class="index_BR" title="意愿指标">
                        </div>
                        <div class="col-md-1">
                            <span title="相对强弱指标">${stockIndex_2.BRNorm()}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--模态框，展现股票列表--%>
<div class="container-fluid">
    <div>
        <div class="row">
            <div class="col-md-4 col-md-offset-1">
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
                                    股票对比
                                </h4>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-3 col-md-offset-2">
                                        <div class="well" id="stock-1">
                                            <button class="btn btn-primary">${stockName_1}
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <h1><i>VS</i></h1>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="well" id="stock-2">
                                            <%
                                                if (stockName_2 != null) {
                                            %>
                                            <button class="btn btn-danger"><%=stockName_2%>
                                            </button>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    <div class="col-md-10 col-md-offset-1">
                                        <div class="well" id="stockList">
                                            <%
                                                String stockName;
                                                for (StockIDNameVO stockIDName : stockIDNameList) {
                                                    stockName = stockIDName.getName();
                                                    if (!stockName.equals(stockName_1)
                                                            && !stockName.equals(stockName_2)) {
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
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal"
                                        onclick="cancel('<%=stockName_1%>', '<%=stockName_2%>')">关闭
                                </button>
                                <button type="button" class="btn btn-sm btn-primary"
                                        onclick="apply('<%=stockName_1%>', '<%=stockName_2%>')">
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

</body>

<script src="js/jquery.min.js"></script>
<script src="../page/bootstrap/js/bootstrap.min.js"></script>
<script src="../reference/slide/dist/powerange.min.js"></script>
<script src="../reference/loading/js/waitMe.js"></script>
<script src="js/stockContrast.js"></script>

<script src="//cdn.bootcss.com/echarts/2.2.7/echarts.js"></script>
<%--雷达图--%>
<script>
    var myChart, option;
    require.config({
        paths: {
            echarts: 'js/dist'
        }
    });
    require(
            [
                'echarts',
                'echarts/chart/radar'
            ],
            function (ec) {
                myChart = ec.init(document.getElementById('radarChart'));
                var ecConfig = require('echarts/config');

                option = {
                    title: {
                        text: '股票对比图',
                        subtext: '银行股指标分析'
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        itemGap: 100,
                        data: ['${stockName_1}', '${stockName_2 == null ? '选择股票' : stockName_2}']
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
                                    value: [${stockIndex_1.biasNorm()}, ${stockIndex_1.RSI}, ${stockIndex_1.WM},
                                        ${stockIndex_1.ARNorm()}, ${stockIndex_1.BRNorm()}],
                                    name: '${stockName_1}',
                                    label: {
                                        normal: {
                                            show: true,
                                            formatter: function (params) {
                                                return params.value;
                                            }
                                        }
                                    }
                                },
                                {
                                    value: [${stockIndex_2.biasNorm()}, ${stockIndex_2.RSI}, ${stockIndex_2.WM},
                                        ${stockIndex_2.ARNorm()}, ${stockIndex_2.BRNorm()}],
                                    name: '${stockName_2}',
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

                //鼠标监听事件
                myChart.on(ecConfig.EVENT.LEGEND_SELECTED, function (param) {
                    var legend = option.legend.data;
                    for (var i = 0; i < legend.length; i++) {
                        if (param.target == legend[i]) {
                            showModal(i + 1);
                        }
                    }
                });
            }
    );
</script>


</html>
