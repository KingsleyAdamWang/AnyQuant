$(function () {
    setColor();
    initNewsList();
    initStockList();
});

/*退出Start*/
$("#log-out").on('click', function () {
    jQuery.ajax({
        url: '/login',
        style: 'post',
        data: 'logout'
    });
});
/*退出End*/

/*新闻列表*/
function initNewsList() {
    $(".news-list").bootstrapNews({
        newsPerPage: 5,
        autoplay: true,
        pauseOnHover: true,
        direction: 'up',
        newsTickerInterval: 4000,
        onToDo: function () {
            //console.log(this);
        }
    });
}

/**
 * 初始化股票列表（颜色块）
 */
function initStockList() {
    $('#followed').children(':gt(0)').filter(function () {
        if ($(this).prev().prev().hasClass('btn-danger')) {
            $(this).attr('class', 'btn btn-warning');
        } else {
            $(this).attr('class', 'btn btn-danger');
        }
    });

    $('#un-followed').children(':gt(0)').filter(function () {
        if ($(this).prev().prev().hasClass('btn-danger')) {
            $(this).attr('class', 'btn btn-warning');
        } else {
            $(this).attr('class', 'btn btn-danger');
        }
    });
}

$('.modal-body button').on('click', function () {
    var followedNum = parseInt($('#followed-num').text());
    var unFollowedNum = parseInt($('#un-followed-num').text());

    $(this).hide();
    if ($(this).parent().is($('#followed'))) {
        $('#un-followed').append($(this));

        $('#followed-num').text(followedNum - 1);
        $('#un-followed-num').text(unFollowedNum + 1);
    } else {
        $('#followed').append($(this));

        $('#followed-num').text(followedNum + 1);
        $('#un-followed-num').text(unFollowedNum - 1);
    }

    initStockList();

    $(this).fadeIn('slow');
});

/**
 * 点击确定后的操作
 * @param userID 用户ID
 */
function apply(userID) {
    var portfolio = $('#followed').find('button');
    var stockName = '';

    for (var i = 0; i < portfolio.length; i++) {
        stockName += $(portfolio[i]).text() + ' ';
    }

    //隐藏模态框
    $('#myModal').modal('hide');
    //禁用滚动条
    $('body').css({overflow: "hidden"});
    //显示加载动画
    $('#main-content').waitMe({
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

    jQuery.ajax({
        url: '/portfolio',
        style: 'post',
        data: {id: userID, type: 'update', data: stockName},
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        success: function (data) {
            //更新列表
            update(data);
            //设置颜色
            setColor();
            //隐藏加载动画
            $('#main-content').waitMe('hide');
            //启用滚动条
            $('body').css({overflow: "auto"});
        }
    });
}

/**
 * 更新自选股列表
 * @param data
 */
function update(data) {
    var result = jQuery.parseJSON(data);

    updateStockData(result.data);
    updateStockNews(result.news);
}

/**
 * 更新股票数据
 * @param stockData 股票数据
 */
function updateStockData(stockData) {
    $('.stock-data').children().remove();

    for (var i = 0; i < stockData.length; i++) {
        $('.stock-data').append(addStockData(stockData[i]));
    }
}

/**
 * 更新股票新闻
 * @param stockNews 股票新闻
 */
function updateStockNews(stockNews) {
    $('.news-list').children().remove();

    for (var i = 0; i < stockNews.length; i++) {
        $('.news-list').append(addStockNews(stockNews[i]));
    }
}

/**
 * 向自选股列表中添加一个股票
 * @param data json类型，对应于stockVO
 */
function addStockData(data) {
    //noinspection JSUnresolvedVariable
    return '<tr>' +
        '<td>' + '<a target="_blank" href="stock.jsp?id=' + data.id + '">' + data.name + '</td>' +
        '<td>' + data.id + '</td>' +
        '<td>' + data.high + '</td>' +
        '<td>' + data.low + '</td>' +
        '<td>' + data.increase_num + '</td>' +
        '<td>' + data.increase_rate + '</td>' +
        '<td>' + data.open + '</td>' +
        '<td>' + data.close + '</td>' +
        '<td>' + data.volume + '</td>' +
        '<td>' + data.pe_ttm + '</td>' +
        '<td>' + data.pb + '</td>' +
        '</tr>';
}

function addStockNews(data) {
    return '<li class="news-item">' +
        '<table>' +
        '<tr>' +
        '<td>' + '<img class="img-circle icon" src="../images/icons/' + data.id + '.png"/>' + '</td>' +
        '<td>' + data.title + '</td>' +
        '<td>' + '<a target="_blank" ' +
        'href="stock.jsp?id=' + data.id + '#picture-prediction">' + '查看详情&gt;&gt;' + '</td>' +
        '</tr>' +
        '</table>' + '</li>';
}

/**
 * 设置表格中涨跌额/幅的颜色
 */
function setColor() {
    //涨跌额
    $('tbody tr td:nth-child(5)').filter(function () {
        return $(this).text() > 0;
    }).css({
        'color': 'red'
    }).end().filter(function () {
        return $(this).text() < 0;
    }).css({
        'color': 'green'
    });

    //涨跌幅
    $('tbody tr td:nth-child(6)').filter(function () {
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
}