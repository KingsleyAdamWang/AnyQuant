<%@ page import="java.util.ResourceBundle" %>
<%@ page import="bl.util.test" %><%--
  Created by IntelliJ IDEA.
  User: song
  Date: 16-6-19
  Time: 下午11:59
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试配置文件</title>
    <meta name="description" content="AnyQuant是一个在线电话交易平台"/>
    <meta name="keyword" content="AnyQuant,股票,电话交易"/>
    <meta name="author" content="Ultraviolet"/>
    <link href="../images/icon.png" rel="icon"/>
    <%
        String path = request.getRealPath("/WEB-INFO/classes");
//        ResourceBundle res = ResourceBundle.getBundle("path/test.properties");
//        String test = res.getString("common.password.error.invalid");
        String test = new test().testGet();
    %>
</head>
<body>
<h1><%=path%></h1>
<h1><%=test%></h1>
</body>
</html>
