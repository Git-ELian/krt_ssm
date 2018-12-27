<%--
  Created by IntelliJ IDEA.
  User: k
  Date: 2018/12/24
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String appPath = request.getContextPath(); %>
<html>
<head>
    <title>Paper列表</title>
    <%@include file="../../common/common_list.jsp" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
    <body>
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="page-header">
                        <h1 style="text-align: center">
                            基于SSM框架的日志管理系统
                        </h1>
                    </div>
                </div>
            </div>

            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="page-header">
                        <h1>
                            <small>日志列表 —— 显示所有日志</small>
                        </h1>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 column">
                    <a class="btn btn-primary" href="${path}/sys/empLog/toAddLog">新增</a>
                </div>
            </div>
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-hover table-striped">
                        <thead>
                        <tr>
                            <th>日志编号</th>
                            <th>日志名字</th>
                            <th>日志数量</th>
                            <th>日志描述</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="log" items="${requestScope.get('logs')}" varStatus="status">
                            <tr>
                                <td>${log.logId}</td>
                                <td>${log.logName}</td>
                                <td>${log.logNum}</td>
                                <td>${log.logDetail}</td>
                                <td>
                                    <a href="${path}/sys/empLog/toUpdateLog?id=${log.logId}">更改</a> |
                                    <a href="<%=appPath%>/sys/empLog/del/${log.logId}">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
