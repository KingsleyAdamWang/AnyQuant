<%--suppress ALL --%>
<!DOCTYPE html>
<html>
<head>
    <title>Bootstrap 实例 - 默认的分页</title>
    <link href="../page/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="../page/js/jquery.min.js"></script>
    <script src="../page/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

<ul class="pagination" id="pagination">
    <li class="disabled"><a href="#">&laquo;</a></li>
    <li class="active"><a href="#">1</a></li>
    <li><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">5</a></li>
    <li><a href="#">&raquo;</a></li>
</ul>

<%--

if (stockVO.getIncrease_decreaseNum()[j] > 0) {
                                                textColor = "text-danger";
                                            } else if (stockVO.getIncrease_decreaseNum()[j] < 0) {
                                                textColor = "text-success";
                                            } else {
                                                textColor = "";
                                            }

--%>

<%--
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
                                <%
                                    if (dataNum > 15) {//数据少于15条时，不显示分页导航
                                %>
                                <ul class="pagination pull-right" id="pagination" style="display: none">
                                    <li onclick="changePage(0)" class="disabled">
                                        <a href="javascript: void(0)">&laquo;</a></li>
                                    <%
                                        for (int i = 1; i <= (dataNum - 1) / 15 + 1; i++) {
                                    %>
                                    <li onclick="changePage(<%=i%>)">
                                        <a href="javascript: void(0)"><%=i%></a>
                                    </li>
                                    <%
                                        }
                                    %>
                                    <li onclick="changePage(-1)">
                                        <a href="javascript: void(0)">&raquo;</a>
                                    </li>
                                </ul>
                                <%
                                    }
                                %>
                            </div>
                            <div class="table-responsive">
                            </div>
                            <%
                                //记录显示条目数
                                int index = dataNum;

                                //分页，每页数据数目为15
                                for (int i = 0; i < dataNum / 15 + 1; i++) {
                            %>
                            <div id="page-<%=i + 1%>">
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
                                        for (int j = 0; j < 20; j++) {
                                            if (index == 0) {
                                                break;
                                            }
                                            index--;
                                    %>
                                    <tr>
                                        <td><%=stockVO.getDate()[index]%>
                                        </td>
                                        <td><%=stockVO.getHigh()[index]%>
                                        </td>
                                        <td><%=stockVO.getLow()[index]%>
                                        </td>
                                        <td><%=stockVO.getIncrease_decreaseNum()[index]%></td>
                                        <td><%=stockVO.rateToString(stockVO.getIncrease_decreaseRate()[index])%></td>
                                        <td><%=stockVO.getOpen()[index]%></td>
                                        <td><%=stockVO.getClose()[index]%></td>
                                        <td><%=stockVO.volumeToString(stockVO.getVolume()[index])%></td>
                                        <td><%=stockVO.getPe_ttm()[index]%></td>
                                        <td><%=stockVO.getPb()[index]%></td>
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
                    </div>--%>

<div id="pagination-content">
    <div id="test-1" style="display: block;">
        test-1
    </div>
    <div id="test-2" style="display: none;">
        test-2
    </div>
    <div id="test-3" style="display: none;">
        test-3
    </div>
    <div id="test-4" style="display: none;">
        test-4
    </div>
    <div id="test-5" style="display: none;">
        test-5
    </div>
</div>

<script>
    var pages = $('#pagination li');

    var pageContents = $('#pagination-content div');

    function getSelected() {
        for (var i = 1; i < pages.length - 1; i++) {
            if (pages[i].className == 'active') {
                return i;
            }
        }
    }

    function changePage(pageNum) {
        var selected = getSelected();
        if (pageNum == 0) {
            if (selected != 1) {
                pages[selected].className = '';
                pages[selected - 1].className = 'active';

                $(pageContents[selected - 1]).hide();
                $(pageContents[selected - 2]).show();
            }
        } else if (pageNum == -1) {
            if (selected != pages.length - 2) {
                pages[selected].className = '';
                pages[selected + 1].className = 'active';

                $(pageContents[selected - 1]).hide();
                $(pageContents[selected]).show();
            }
        } else {
            pages[selected].className = '';
            pages[pageNum].className = 'active';

            $(pageContents[selected - 1]).hide();
            $(pageContents[pageNum - 1]).show();
        }

        if (getSelected() == 1) {
            pages[0].className = 'disabled';
        } else {
            pages[0].className = '';
        }
        if (getSelected() == pages.length - 2) {
            pages[pages.length - 1].className = 'disabled';
        } else {
            pages[pages.length - 1].className = '';
        }
    }
    ;

//    $(pages[1]).on('click', function () {
//        changePage(1);
//    });
//    $(pages[2]).on('click', function () {
//        changePage(2);
//    });
    for (var i = 0; i < pages.length - 1; i++) {
        $(pages[i]).on('click', function (e) {
//            e.preventDefault();
            changePage(i);
        });
    }
//    pages.last().on('click', changePage(-1));
</script>
</body>
</html>