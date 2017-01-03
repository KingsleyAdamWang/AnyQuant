// <%--固定侧边栏Start--%>
var jWindow = $(window);

jWindow.scroll(function () {
    var scrollHeight = jWindow.scrollTop();

    $("#sidebar").css({
        position: "relative",
        top: scrollHeight + "px"
    });
});
// <%--固定侧边栏End--%>

// <%--侧边栏导航Start--%>
function click_scroll(target) {
    var scroll_offset = $("#" + target).offset();  //得到pos这个div层的offset，包含两个值，top和left
    $('body, html').animate({
        scrollTop: scroll_offset.top - 100  //让body的scrollTop等于pos的top，就实现了滚动
    }, 0);
}
// <%--侧边栏导航End--%>

/*激活提示框Start*/
$('.badge').tooltip({
    placement: 'left',
    hide: 100
});
$('#increase_collapse, #decrease_collapse, #volume_collapse').tooltip({
    placement: 'right',
    hide: 100
});
/*激活提示框End*/


/*表格排序Start*/
$(function () {
    for (var i = 0; i < 3; i++) {
        $('#basic-sort-' + i + ' table').stickySort({sortable: true});
    }
});
/*表格排序End*/

/*退出操作*/
$('#log-in').on('click', function (e) {
    if ($('#log-out').html() == '退出') {
        e.preventDefault();
        jQuery.ajax({
            url: '/login',
            style: 'post',
            data: 'logout',
            success: function () {
                $('#portfolio-item').hide();
                $('#portfolio-panel').hide();
                $('#log-out').text('登录');
            }
        });
    }
});

/*搜索股票*/
{

    function searchToggle(obj, evt) {
        var container = $(obj).closest('.search-wrapper');

        if (!container.hasClass('active')) {
            container.addClass('active');
            container.find('.search-input').focus();
            evt.preventDefault();
        } else if (container.hasClass('active') && $(obj).closest('.input-holder').length == 0) {
            recover();
            container.removeClass('active');
            // clear input
            container.find('.search-input').val('');
            // clear and hide result container when we press close
            container.find('.result-container').fadeOut(100, function () {
                $(this).empty();
            });
        }
    }

    function submitFn(obj, evt) {
        var value = $(obj).find('.search-input').val().trim();

        if (value.length) {
            handleSearch(handleInput(value));
        }

        evt.preventDefault();
    }

    /**
     * 处理输入内容，便于搜索
     * @param input
     */
    function handleInput(input) {
        var value = input;

        var bank = {// 银行简称
            '中行': '中国银行',
            '农行': '农业银行',
            '招行': '招商银行',
            '建行': '建设银行',
            '交行': '交通银行',
            '工行': '工商银行'
        };
        
        if (input.length == 2) { // 支持搜索银行简称
            if (input.indexOf('行') < 0) {
                value += '银行';
            } else if (bank[input] != '') {
                value = bank[input];
            }
        } else if (input.length == 6 && input.substr(0, 2) == '中国') {
            value = value.substr(2);
        }

        return value;
    }

    /**
     * 搜索股票
     * @param value 股票名称或ID
     */
    function handleSearch(value) {
        // 恢复到上次搜索前的状态
        recover();

        var result;//搜索结果
        if (value.length == 4) {
            result = search(1, value);
        } else {
            result = search(2, value);
        }

        if (result.parent().is($('#picture').find('tbody'))) {
            display(result);
        } else {
            alert('没有搜到任何股票。。。。');
        }
    }

    /**
     * 显示搜索结果
     * @param stock 搜索结果
     */
    function display(stock) {
        $('#portfolio-panel').fadeOut('slow');

        $(stock).siblings().fadeOut('slow');

        $('html, body').animate({scrollTop: '0px'}, 800);
    }

    /**
     * 恢复到搜索前的状态
     */
    function recover() {
        $('#portfolio-panel').fadeIn('slow');

        $('#picture').find('tbody').find('tr').fadeIn('slow');
    }

    /**
     * 搜索股票
     * @param column 列号，对应股票名称（1）或ID（2）
     * @param value 搜索内容
     * @return 搜索结果（股票对象）
     */
    function search(column, value) {
        return $('#picture').find('tbody').find('tr').children(':nth-child(' + column + ')')
            .filter(function () {
                return $(this).text().trim() == value;
            }).parent();
    }
}
