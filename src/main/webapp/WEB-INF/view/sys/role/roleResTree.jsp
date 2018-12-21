<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common.jsp" %>
    <link rel="stylesheet" href="${basePath}static/assets/libs/ztree/zTreeStyle/zTreeStyle.css" type="text/css"/>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <div id="resTree" class="ztree"></div>
</div><!-- ./wrapper -->
<script type="text/javascript" src="${basePath}static/assets/js/browser.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/ztree/jquery.ztree.excheck-3.5.js"></script>
<script language="javascript" type="text/javascript">
    var setting = {
        check: {enable: true, chkStyle: "checkbox", radioType: "all"},
        data: {simpleData: {enable: true}}
    };
    var zNodes =${resTree};
    function setCheck() {
        $.fn.zTree.init($("#resTree"), setting, zNodes);
    }
    //初始化
    setCheck();
    var tree = $.fn.zTree.getZTreeObj("resTree");
</script>
</body>
</html>
