<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: song
  Date: 16-5-22
  Time: 下午2:11
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TestAjax</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <%--<link href="../page/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>--%>
    <%--<script src="../page/bootstrap/js/bootstrap.min.js"></script>--%>
    <%--<link href="../images/icon.png" rel="icon"/>--%>
    <%--<script src="../page/js/jquery.js"></script>--%>
    <%--<script src="../page/js/jquery.min.js"></script>--%>
    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</head>
<body>

<ul id="myTab" class="nav nav-tabs">
    <li class="active">
        <a href="#home" data-toggle="tab">
            W3Cschool Home
        </a>
    </li>
    <li><a href="#ios" data-toggle="tab">iOS</a></li>
    <li class="dropdown">
        <a href="#" id="myTabDrop1" class="dropdown-toggle"
           data-toggle="dropdown">Java
            <b class="caret"></b>
        </a>
        <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
            <li><a href="#jmeter" tabindex="-1" data-toggle="tab">jmeter</a></li>
            <li><a href="#ejb" tabindex="-1" data-toggle="tab">ejb</a></li>
        </ul>
    </li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="home">
        <p>W3Cschoool菜鸟教程是一个提供最新的web技术站点，本站免费提供了建站相关的技术文档，帮助广大web技术爱好者快速入门并建立自己的网站。菜鸟先飞早入行——学的不仅是技术，更是梦想。</p>
    </div>
    <div class="tab-pane fade" id="ios">
        <p>iOS 是一个由苹果公司开发和发布的手机操作系统。最初是于 2007 年首次发布 iPhone、iPod Touch 和 Apple
            TV。iOS 派生自 OS X，它们共享 Darwin 基础。OS X 操作系统是用在苹果电脑上，iOS 是苹果的移动版本。</p>
    </div>
    <div class="tab-pane fade" id="jmeter">
        <p>jMeter 是一款开源的测试软件。它是 100% 纯 Java 应用程序，用于负载和性能测试。</p>
    </div>
    <div class="tab-pane fade" id="ejb">
        <p>Enterprise Java Beans（EJB）是一个创建高度可扩展性和强大企业级应用程序的开发架构，部署在兼容应用程序服务器（比如 JBOSS、Web Logic 等）的 J2EE 上。
        </p>
    </div>
</div>




<input type="button" value="test">

<%
    //    request.setAttribute("test", "test123");
    List<String> testList = new ArrayList<>();
    testList.add("str1");
    String string = (String) session.getAttribute("test");
%>

<div id="test">
    <%=string%>
</div>

<form id="form" method="post" action="/portfolio">
    <table>
        <tr>
            <td>用户名：</td>
            <td><input type="checkbox" name="name" id="name"></td>
        </tr>
        <tr>
            <td>密码</td>
            <td><input type="checkbox" name="password-text" id="password"></td>
        </tr>
    </table>
</form>


</body>
<script>
    $('input[type=button]').click(function () {

        var test = {
            'name': 'tom',
            'age': 30
        };

        $.ajax({
            url: '/portfolio?data=' + Math.random(),
            type: 'POST',
            data: 'test'+ $('#form').serialize(),
            success: function (data) {
                var temp = eval(data);
                alert(1);
//                $('#test').html(temp[0].name);
            }
        });
    });

    $(document).ajaxStop(function () {
        <%--alert('<%=string%>');--%>
    });

</script>
</html>
