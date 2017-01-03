<!doctype html>
<html lang="zh">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>测试分页</title>
    <link href="../reference/pagination/dist/pagination.css" rel="stylesheet">
</head>
<body>
<div class="data-container"></div>
<div id="pagination-table"></div>

<script src="../page/js/jquery.min.js"></script>
<script src="../reference/pagination/dist/pagination.js"></script>
<script>
    $(function () {
        function createTable(name) {
            var container = $('#pagination-' + name);
            var sources = function () {
                var result = [][2];

                for (var i = 1; i < 40; i++) {
                    result[i][0] = i;
                    result[i][1] = i;
                }

                return result;
            }();

            var array = {
                data: ['1', '2', '3', '4']
            };

            var options = {
                dataSource: sources,
//                locator: 'data',
                className: 'paginationjs-theme-blue',
                pageSize: 30,
                callback: function (response, pagination) {
                    window.console && console.log(response, pagination);

                    var dataHtml = '<ul>';

                    $.each(response, function (index, item) {
                        dataHtml += '<li>' + item + '</li>';
                    });

                    dataHtml += '</ul>';

                    container.prev().html(dataHtml);
                }
            };

            container.pagination(options);

            return container;
        }

        createTable('table');
    });
</script>
</body>
</html>