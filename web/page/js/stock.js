$(function () {
    // 默认显示第一页
    $('#page-1').show();
    $('#pagination').children(':nth-child(2)').addClass('active');
    // 设置涨跌额/幅颜色
    setColor();
    // 激活ToolTip
    $("[data-toggle='tooltip']").tooltip();
});


// <%--固定侧边栏Start--%>
{
    var jWindow = $(window);

    var menuList = $('#menu').children();//侧边栏菜单列表
    var content = $('#main-content').children().first().children();

    jWindow.scroll(function () {
        var scrollHeight = jWindow.scrollTop();

        for (var i = 0; i < content.length; i++) {
            if (scrollHeight + 100 > $(content[i]).offset().top) {
                clearAll();
                $(menuList[i]).addClass('active');
            }
        }

        $("#sidebar").css({
            position: "relative",
            top: scrollHeight + "px"
        });

        function clearAll() {
            $(menuList).each(function () {
                $(this).removeClass('active')
            });
        }
    });
}
// <%--固定侧边栏End--%>

/*图表大小Start*/
var width = $('#main-content').innerWidth();
$('#graphs div').css({
    'width': width + 'px',
    'height': '400px'
});

$('#radarChart').css({
    'width': width - 30 + 'px',//panel-body padding=15
    'height': '400px'
});
/*图表大小End*/


//侧边栏导航栏Start
{
    var menu = document.getElementById('menu');
    var items = menu.getElementsByTagName('li');

    function page_jump(item, target) {
        var selected = getSelected();

        items[selected].className = 'list-group-item text-center';
        item.className = 'list-group-item text-center active';

        scroll(target);
    }

    function getSelected() {
        for (var i = 0; i < items.length; i++) {
            if (items[i].className == 'list-group-item text-center active') {
                return i;
            }
        }
    }

    function scroll(target) {
        var scroll_offset = $("#" + target).offset();  //得到pos这个div层的offset，包含两个值，top和left
        $('body, html').animate({
            scrollTop: scroll_offset.top - 60  //让body的scrollTop等于pos的top，就实现了滚动
        }, 0);
    }
}
//侧边栏导航End

//日期选择Start
{
    //开始日期、结束日期
    var startDate = $('#startDate');
    var endDate = $('#endDate');
    //记录开始/结束日期初始值
    var start_temp = $(startDate).val();
    var end_temp = $(endDate).val();

    $('#show-date').on('click', function () {//显示日期选择框
        $("#date").toggle();
    });

    $('#startDate, #endDate').dateRangePicker({
        format: 'YYYY-MM-DD',
        language: 'cn',
        startDate: '2016-01-01',
        endDate: getDate(),
        autoClose: true,

        getValue: function () {
            if ($(startDate).val() && $(endDate).val())
                return $(startDate).val() + ' to ' + $(endDate).val();
            else
                return '';
        },
        setValue: function (s, s1, s2) {
            $(startDate).val(s1);
            $(endDate).val(s2);
        }
    });

    function apply(id) {
        if (!legalDate($(startDate).val(), $(endDate).val())) {
            alert('所选区间无数据!');
            $(startDate).val(start_temp);
            $(endDate).val(end_temp);

            //延迟5秒后隐藏日期选择框
            $('#date').delay(5000).fadeOut('fast');

            return;
        }

        //显示加载动画
        $('#history-data').waitMe({
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
            url: '/stock',
            style: 'post',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            data: 'id=' + id + '&startDate=' + $(startDate).val() + '&endDate=' + $(endDate).val(),
            success: function (data) {
                //删除已有分页和数据（保留翻页选项）
                $('#pagination').children().not(':first').not(':last').remove();
                $('#pagination-content').children().remove();
                //更新数据
                updateData(data);
                //设置‘涨跌额/幅’颜色
                setColor();
                //隐藏加载动画
                $('#history-data').waitMe('hide');
            }
        });

        //更新记录
        start_temp = $(startDate).val();
        end_temp = $(endDate).val();

        //延迟5秒后隐藏日期选择框
        $('#date').delay(5000).fadeOut('fast');
    }

    //更新数据
    var updateData = function (data) {
        var result = jQuery.parseJSON(data);
        //记录当前显示数据的指针，从最后逐个前进到开始位置
        var index = result.length;
        //页数
        var pageNum = Math.floor((result.length - 1) / 15) + 1;
        for (var i = 1; i <= pageNum; i++) {
            createPage(i);
            for (var j = 0; j < 15 && index != 0; j++) {
                index--;
                insertData(i, result[index]);
            }
        }

        //去除无数据的日期
        $('#startDate').val(result[0].date);
        $('#endDate').val(result[result.length - 1].date);

        $('#data-num').text(result.length);
        //初始化分页
        initPage(pageNum);
    };

    /**
     * 创建分页，从1开始编号
     * @param page 页号
     */
    var createPage = function (page) {
        $('#pagination-content').append(
            '<div class="table-responsive" id="page-' + page + '" style="display: none"></div>');
        $('#page-' + page).append(
            '<table class="table table-striped text-center">' +
            '<thead><tr><th class="text-center">日期</th>' +
            '<th class="text-center">最高</th>' +
            '<th class="text-center">最低</th>' +
            '<th class="text-center">涨跌额</th>' +
            '<th class="text-center">涨跌幅</th>' +
            '<th class="text-center">开盘</th>' +
            '<th class="text-center">收盘</th>' +
            '<th class="text-center">成交量</th>' +
            '<th class="text-center">市盈率</th>' +
            '<th class="text-center">市净率</th>' +
            '</tr></thead><tbody class="table-body">' +
            '</tbody></table>'
        );

        createPagination(page);
    };

    /**
     * 创建分页导航
     * @param page 页号
     */
    var createPagination = function (page) {
        $('<li onclick="changePage(' + page + ')">' +
            '<a href="javascript: void(0)">' + page + '</a></li>'
        ).insertBefore($('#pagination').children().last());
    };

    /**
     * 插入数据
     * @param page 页号
     * @param data 数据
     */
    var insertData = function (page, data) {
        //noinspection JSUnresolvedVariable
        $('#page-' + page).find('.table-body').append(
            '<tr>' +
            '<td>' + data.date + '</td>' +
            '<td>' + data.high + '</td>' +
            '<td>' + data.low + '</td>' +
            '<td>' + data.increase_num + '</td>' +
            '<td>' + data.increase_rate + '</td>' +
            '<td>' + data.open + '</td>' +
            '<td>' + data.close + '</td>' +
            '<td>' + data.volume + '</td>' +
            '<td>' + data.pe_ttm + '</td>' +
            '<td>' + data.pb + '</td>' +
            '</tr>'
        );
    };

    $('#endDate').dateRangePicker().bind('datepicker-close', function () {
        if (!checkDate($('#startDate').val())) {//若日期非法，回复到修改前的值
            $('#startDate').val(start_temp);
        }
    });

    $('#startDate').on('click', function () {
        $(this).data('dateRangePicker').open();
    });

    /**
     * 获取当前日期
     */
    function getDate() {
        var date = new Date();
        var month = date.getMonth() + 1;
        var monthString = (month > 9) ? month : ('0' + month);
        return date.getFullYear() + '-' + monthString + '-' + date.getDate();
    }

    /**
     * 判断日期区间是否合法
     * 判定依据为二者均为周六/周日，且间隔不大于1
     * @param startDate
     * @param endDate
     */
    function legalDate(startDate, endDate) {
        var startTime = new Date(startDate).getTime();
        var endTime = new Date(endDate).getTime();

        if (isWeekend(startDate) && isWeekend(endDate)) {
            var dateInterval = Math.abs((startTime - endTime) / (1000 * 60 * 60 * 24));

            if (dateInterval <= 1) {
                return false;
            }
        }
        return true;
    }

    /**
     * 判断是否是周末
     * @param date 日期字符串
     */
    function isWeekend(date) {
        var day = new Date(date).getDay();
        return (day == 0) || (day == 6);
    }

    /**
     * 检验日期是否合法
     * @param date 日期
     * @returns {boolean}
     */
    function checkDate(date) {//检查日期是否合法，用于手动编辑日期选择框情况
        var result = date.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);

        if (result == null)
            return false;
        var d = new Date(result[1], result[3] - 1, result[4]);
        return (d.getFullYear() == result[1] && (d.getMonth() + 1) == result[3] && d.getDate() == result[4]);
    }
}
//日期选择End

//分页Start
{
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

    /**
     * 切换分页
     * @param page 页号，其中0代表向前翻页，-1代表向后翻页
     */
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
}
//分页End