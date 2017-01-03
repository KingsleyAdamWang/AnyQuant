<%--
  Created by IntelliJ IDEA.
  User: song
  Date: 16-5-12
  Time: 上午9:58
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>AnyQuant</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <link href="../images/icon.png" rel="icon"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="style/docs.min.css" rel="stylesheet"/>
</head>
<body>

<%--About Start--%>
<div>
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

<%--<footer class=bs-docs-footer role=contentinfo>--%>
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
<%--</footer>--%>
</body>

<script src="js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>

</html>
