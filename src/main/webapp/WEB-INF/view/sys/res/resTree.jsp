<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common.jsp" %>
    <link rel="stylesheet" href="${basePath}static/assets/libs/ztree/zTreeStyle/zTreeStyle.css" type="text/css"/>
</head>
<body>
<div class="wrapper">
    <div id="resTree" class="ztree"></div>
</div><!-- ./wrapper -->
<script type="text/javascript" src="${basePath}static/assets/js/browser.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/ztree/jquery.ztree.excheck-3.5.js"></script>
<script language="javascript" type="text/javascript">
    var setting = {
        view: {selectedMulti: false, dblClickExpand: false},
        data: {simpleData: {enable: true}}
    };
    var zNodes = ${resTree};
    function setCheck() {
       $.fn.zTree.init($("#resTree"), setting, zNodes);
    }
    // 默认选择节点
    function selectCheckNode() {
        var id = '${param.id}';
        if (id != '') {
            var node = tree.getNodeByParam("id", id);
            tree.selectNode(node);
        }
    }
    //初始化
    setCheck();
    var tree = $.fn.zTree.getZTreeObj("resTree");
    selectCheckNode();
</script>
</body>
</html>
