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

$(function () {
    var companies = ['数据查询', '关注股票', '行情趋势', '大盘走势', '股票预测', '股票对比'], flag = 0;
    var typeToNext = function () {
        if (flag == companies.length) {
            flag = 0;
        }
        HRB.utils.djshook('type-to-container').typeTo(companies[flag]);
        flag++;
    };

    setInterval(function () {
        typeToNext()
    }, 4000);
});

$(function () {
    var screenHeight = window.innerHeight
        , headerHeight = $('.layout-header').outerHeight(true)
        , heroHeight = $('.hero').outerHeight(true)
        , difference = screenHeight - headerHeight - heroHeight;

    if (difference > 100) {
        var halfDifference = Math.min(((difference - 100) / 2), 100) + 'px';
        $('.hero').css({'padding-bottom': '+=' + halfDifference, 'padding-top': '+=' + halfDifference});
    }

});

$(function () {
    var imagePositions = [0, -50, -385, -930, -1260, -2550]
        , slideCounter = 0
        , $images = HRB.utils.djshook('acme-demo-image')
        , $bigImage = HRB.utils.djshook('the-big-acme-image');


    var nextSlide = function (num) {
        $images.removeClass('active');
        $images.eq(num).addClass('active');
        $bigImage.css('top', imagePositions[num]);

        slideCounter = num;

        setTimeout(function () {
            nextSlide(getNextSlideNum());
        }, 4500);
    };

    var getNextSlideNum = function () {
        return (slideCounter == imagePositions.length - 1) ? 0 : (slideCounter + 1);
    };

    $('.bg-image').one('inview', function () {
        nextSlide(0);
    });
});