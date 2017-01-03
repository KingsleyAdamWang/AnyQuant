
$(function () {
   setSliders();
});

/*雷达图大小*/
{
    var width = $('#main-content').innerWidth();

    $('#radarChart').css({
        'width': width - 30 + 'px',//panel-body padding=15
        'height': '400px'
    });
}

/*登录/退出*/
{
    $('#log-in').on('click', function (e) {
        if ($('#log-out').text().trim() == '退出') {
            e.preventDefault();
            jQuery.ajax({
                url: '/login',
                style: 'post',
                data: 'logout',
                success: function () {
                    $('#log-out').text('登录');
                }
            });
        }
    });
}

/*动态添加股票*/
{
    var index_bias = $('.index_bias')[0];
    var index_RSI = $('.index_RSI')[0];
    var index_WM = $('.index_WM')[0];
    var index_AR = $('.index_AR')[0];
    var index_BR = $('.index_BR')[0];
    
    var stock_1 = $('#stock-1');
    var stock_2 = $('#stock-2');
    var stockList = $('#stockList');
    
    var index;

    /**
     * 显示模态框
     * @param index 标记第一/二只股票被点击
     */
    function showModal(index) {
        this.index = index;
        $('#myModal').modal('show');
    }

    /**
     * 为股票添加点击事件
     */
    $('.modal-body').find('button').on('click', function () {
        if ($(this).parent().is($(stock_1)) || $(this).parent().is($(stock_2))) {
            move($(this), $(stockList));
            $(this).attr('class', 'btn btn-warning');
        } else {
            if (!$(stock_1).children(':button').length) {
                move($(this), $(stock_1));
                $(this).attr('class', 'btn btn-primary');
            } else if (!$(stock_2).children(':button').length) {
                move($(this), $(stock_2));
                $(this).attr('class', 'btn btn-danger');
            }
        }
    });

    /**
     * 移动股票
     * @param stock 股票
     * @param target 目标位置
     */
    function move(stock, target) {
        $(stock).hide();
        $(target).append($(stock));
        $(stock).fadeIn('slow');
    }

    /**
     * 点击取消后的操作
     * @param stockName_1 原有第一只股票名称，用于恢复初始状态
     * @param stockName_2 原有第二只股票名称，用于恢复初始状态
     */
    function cancel(stockName_1, stockName_2) {
        // TODO 取消操作
        if ($(stock_1).children().first() != null &&
            $(stock_1).children().first().text().trim() != stockName_1) {
            move($(stock_1).children().first(), $(stockList));
        }
        if ($(stock_2).children().first() != null &&
            $(stock_2).children().first().text().trim() != stockName_2) {
            move($(stock_2).children().first(), $(stockList));
        }

        $(stock_1).html('<button class="btn btn-primary">' + stockName_1 + '</button>');
        if (stockName_2 != null) {
            $(stock_2).html('<button class="btn btn-danger">' + stockName_2 + '</button>');
        } else {
            $(stock_2).html('');
        }
    }

    /**
     * 点击确定后的操作
     * @param stockName_1
     * @param stockName_2
     */
    function apply(stockName_1, stockName_2) {
        if ($(stock_1).html().trim() == '' || $(stock_2).html().trim() == '') {
            alert('请选择要对比的股票！！！');
        } else {
            //隐藏模态框
            $('#myModal').modal('hide');

            //显示加载动画（雷达图）
            myChart.showLoading({
                text: '数据获取中',
                effect: 'whirling'
            });
            //显示加载动画（滑块）
            $('.slider-contract').waitMe({
                //none, rotateplane, stretch, orbit, roundBounce, win8,
                //win8_linear, ios, facebook, rotation, timer, pulse,
                //progressBar, bouncePulse or img
                effect: 'bounce',

                //place text under the effect (string).
                text: '',

                //background for container (string).
                bg: 'rgba(255,255,255,0.7)',

                //color for background animation and text (string).
                color: '#000',

                //change width for elem animation (string).
                sizeW: '',

                //change height for elem animation (string).
                sizeH: '',

                // url to image
                source: ''
            });

            var name_1 = $(stock_1).children().first().text().trim();
            var name_2 = $(stock_2).children().first().text().trim();
            if (name_1 != stockName_1) {
                addStock(1, name_1);
            }
            if (name_2 != stockName_2) {
                addStock(2, name_2);
            }
        }

        // 设置标题
        document.title = name_1 + 'VS' + name_2;
    }

    /**
     * 添加股票
     * @param index 添加第一/二只股票的数据
     * @param stockName 股票名称
     */
    function addStock(index, stockName) {
        jQuery.ajax({
            url: '/stockContrast',
            style: 'post',
            data: {index: index, stockName: stockName},
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (data) {
                var stockIndex = jQuery.parseJSON(data);

                // 更新股票名称
                $('.name_' + index).find('a').text(stockName);
                option.legend.data[index - 1] = stockName;
                // 更新雷达图
                updateChart(index, stockName, stockIndex);
                // 更新股票指数
                updateData(index, stockIndex);
                // 设置滑块
                setSliders();
                // 隐藏加载动画
                myChart.hideLoading();
                $('.slider-contract').waitMe('hide');

                myChart.setOption(option);
            }
        });
    }

    /**
     * 更新雷达图
     * @param index 标记第一/二只股票
     * @param stockName 股票名称
     * @param stockIndex 股票指数
     */
    function updateChart(index, stockName, stockIndex) {
        var data = option.series[0].data[index - 1];
        data.name = stockName;
        data.value = [stockIndex.bias, stockIndex.RSI, stockIndex.WM, stockIndex.AR, stockIndex.BR];
    }


    /**
     * 更新数据
     * @param index 标记第一/二只股票
     * @param stockIndex 股票指数
     */
    function updateData(index, stockIndex) {
        setStockIndex(index, index_bias, stockIndex.bias);
        setStockIndex(index, index_RSI, stockIndex.RSI);
        setStockIndex(index, index_WM, stockIndex.WM);
        setStockIndex(index, index_AR, stockIndex.AR);
        setStockIndex(index, index_BR, stockIndex.BR);
    }

    /**
     * 设置某项指标的值
     * @param index 标记第一/二只股票
     * @param element 元素
     * @param value 值
     */
    function setStockIndex(index, element, value) {
        if (index == 1) {//第一只股票
            $(element).parent().prev().text(value);
        } else {//第二只股票
            $(element).parent().next().text(value);
        }
    }

    /**
     * 设置所有滑块的值
     */
    function setSliders() {
        removeAllSliders();

        setSliderValue(index_bias);
        setSliderValue(index_RSI);
        setSliderValue(index_WM);
        setSliderValue(index_AR);
        setSliderValue(index_BR);
    }

    /**
     * 删除所有滑块
     */
    function removeAllSliders() {
        $('.range-bar').remove();
    }

    /**
     * 设置具体某个滑块的值
     * @param element 滑块元素
     */
    function setSliderValue(element) {
        var left_value = parseFloat($(element).parent().prev().text());
        var right_value = parseFloat($(element).parent().next().text());

        var value = left_value / (left_value + right_value);

        new Powerange(element, {
            disable: true,
            disableOpacity: 1,
            hideRange: true,
            min: 0,
            max: 1,
            start: value
        });
    }
}


