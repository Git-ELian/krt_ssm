<%--
  Created by IntelliJ IDEA.
  User: k
  Date: 2018/12/24
  Time: 19:11
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>新增论文</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
    <body>
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="page-header">
                        <h1>
                            新增日志
                        </h1>
                    </div>
                </div>
            </div>

            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="page-header">
                        <h1>
                            <small>新增日志</small>
                        </h1>
                    </div>
                </div>
            </div>
            <form action="" name="userForm">
                日志名称：<input type="text" name="logName"><br><br><br>
                日志数量：<input type="text" name="logNum"><br><br><br>
                日志描述：<input type="text" name="logDetail"><br><br><br>
                <input type="button" value="添加" onclick="addLog()">
            </form>

            <script type="text/javascript">
                function addLog() {
                    var form = document.forms[0];
                    form.action = "<%=basePath %>/sys/empLog/addLog";
                    form.method = "post";
                    form.submit();
                }
            </script>
        </div>
    </body>
</html>