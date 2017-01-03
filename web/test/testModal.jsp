<!DOCTYPE html>
<html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>Bootstrap 实例 - 模态框（Modal）插件</title>
    <link href="../page/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="../page/js/jquery.min.js"></script>
    <script src="../page/bootstrap/js/bootstrap.min.js"></script>
</head>
<style>
    button {
        margin: 15px;
    }
</style>
<body>

<h2>创建模态框（Modal）</h2>
<!-- 按钮触发模态框 -->
<button class="btn btn-primary btn-lg" data-toggle="modal"
        data-target="#myModal">
    开始演示模态框
</button>

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
                <h4 class="modal-title text-center" id="myModalLabel">
                    自选股管理
                </h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="well" id="followed">
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                            <button class="btn btn-primary test">南京银行</button>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="well" id="un-followed">

                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="change()">确认</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script>
    $('.test').on('click', function () {
        $(this).hide();
        if ($(this).parent().is($('#followed'))) {
            $('#un-followed').append($(this));
        } else {
            $('#followed').append($(this));
        }
        $(this).fadeIn('slow');
    });
//    var change = function () {
//        var stocks = document.getElementsByClassName('modal-body')[0].getElementsByTagName('input');
//
//
//        for (var i = 0; i < stocks.length; i++) {
//            console.log($(stocks[i]).val() + '-----' + stocks[i].checked);
//        }
//    };
//
//    $('#myModal').on('hide.bs.modal', function () {
//    })
</script>
</body>
</html>