<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="krt" uri="/WEB-INF/tlds/krt.tld" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<c:set var="basePath" value="<%=basePath%>"/>
<c:set var="filePath" value="<%=filePath%>"/>
<meta charset="utf-8">
<meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
<meta content=always name=referrer>
<title>科睿特通用管理后台</title>
<link rel="shortcut icon" href="${basePath}static/favicon.ico">
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="${basePath}static/assets/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${basePath}static/assets/css/font-awesome.min.css"
<!-- select2 -->
<link rel="stylesheet" href="${basePath}static/assets/libs/select2/select2.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${basePath}static/assets/css/AdminLTE.min.css">
<!-- krtadmin -->
<link rel="stylesheet" href="${basePath}static/assets/css/krtadmin.css">
<!-- ./wrapper -->
<script src="${basePath}static/assets/libs/jquery/jquery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="${basePath}static/assets/libs/bootstrap/bootstrap.min.js"></script>
<!-- pace -->
<script src="${basePath}static/assets/libs/pace/pace.min.js"></script>
<!-- layer -->
<script src="${basePath}static/assets/libs/layer/layer.js"></script>
<!-- iCheck -->
<script src="${basePath}static/assets/libs/iCheck/icheck.min.js"></script>
<script src="${basePath}static/assets/js/icheck.js"></script>
<!-- wDate -->
<script src="${basePath}static/assets/libs/My97DatePicker/WdatePicker.js"></script>
<!-- 通用js -->
<script src="${basePath}static/assets/js/common.js"></script>
<!-- select2 -->
<script src="${basePath}static/assets/libs/select2/select2.full.min.js"></script>
<!--[if lt IE 9]>
<script language="javascript" type="text/javascript">
     top.location.href='${basePath}static/assets/html/browser.html';
</script>
<![endif]-->

