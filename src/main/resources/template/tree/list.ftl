<#include "../list.ftl">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="${level}common/common_list.jsp" %>
    <link rel="stylesheet" href="${"$"}{basePath}static/assets/libs/jquery-treetable/css/jquery.treeTable.css"/>
    <link rel="stylesheet" href="${"$"}{basePath}static/assets/libs/jquery-treetable/css/jquery.treetable.theme.default.css"/>
</head>
<body class="bg-color">
<div class="wrapper">
    <section class="content">
        <!-- 列表数据区 -->
        <div class="box-krt">
            <!-- /.box-header -->
            <div class="box-body" id="boxbody">
                <div class="table-responsive" id="table-body">
                    <div class="table-button">
                        <shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:insert">
                            <button title="添加" type="button" id="insertBtn" data-placement="left" data-toggle="tooltip" class="btn btn-success btn-sm">
                                <i class="fa fa-plus"></i> 添加
                            </button>
                        </shiro:hasPermission>
                        <#if genTable.excelOut=='0'>
                            <shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:excelOut">
                                <button type="button" id="excelOutBtn" class="btn bg-orange btn-sm">
                                    <i class="fa fa-cloud-upload fa-btn"></i>导出
                                </button>
                            </shiro:hasPermission>
                        </#if>
                        <#if genTable.excelIn=='0'>
                            <shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:excelIn">
                                <input type="button" id="excelIn" value="导入">
                                <button type="button" id="excelInBtn" class="btn bg-purple btn-sm">
                                    <i class="fa fa-cloud-download fa-btn"></i>导入
                                </button>
                            </shiro:hasPermission>
                        </#if>
                    </div>
                    <table id="tree_table" class="table table-striped table-bordered table-hover table-krt">

                    </table>
                </div>
            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->
        <!-- /.row -->
    </section>
    <!-- /.content -->
</div>
<!-- ./wrapper -->
<!-- 通用js -->
<script type="text/javascript" src="${"$"}{basePath}static/assets/js/browser.js"></script>
<script type="text/javascript" src="${"$"}{basePath}static/assets/libs/jquery-treetable/javascripts/jquery.treeTable.js"></script>
<@excelJS genTable namespace></@excelJS>
<script language="javascript" type="text/javascript">

    //新增
    $("#insertBtn").click(function () {
        openDialog("新增表单", "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/insert", "800px", "500px");
    });

    //修改
    $(document).on("click", ".updateBtn", function () {
        var id = $(this).attr("rid");
        openDialog("修改表单", "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/update?id=" + id, "800px", "500px");
    });

    //添加子资源
    $(document).on("click", ".addBtn", function () {
        var id = $(this).attr("rid");
        openDialog("新增表单", "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/insert?id=" + id, "800px", "500px");
    });

    //删除
    $(document).on("click", ".deleteBtn", function () {
        var id = $(this).attr("rid");
        var fun = function () {
            $.ajax({
                type: "POST",
                url: "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/delete?id=" + id,
                data: $('#krtForm').serialize(),// 要提交的表单
                beforeSend: function () {
                    return loading();
                },
                success: function (rb) {
                    closeloading();
                    if (rb.code == 0) {
                        top.layer.msg(rb.msg);
                        initTable(0);
                    } else {
                        top.layer.msg(rb.msg);
                    }
                },
                error: function () {
                    closeloading();
                }
            });
        }
        confirmx("你确定删除此记录及下级记录吗？", fun);
    });
</script>
<script type="text/javascript">
    //加载父表
    function initTable(pid) {
        $.ajax({
            type: "POST",
            url: "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/list",
            data: {
                "pid": pid,
    <#list genTable.genTableColumns as column>
        <#if column.isQuery=='0'>
            <#if column.showType=='checkbox'&& column.name !='pid'>
                "${column.javaField}": function () {
                var ${column.javaField}CheVal = "";
                $('input[name="${column.javaField}"]:checked').each(function(){
                    ${column.javaField}CheVal = ${"$"}(this).val() + ${column.javaField}CheVal + ",";
                });
                if(${column.javaField}CheVal.length>0){
                    ${column.javaField}CheVal = nameCheVal.substr(0,${column.javaField}CheVal.length-1);
                }
                return ${column.javaField}CheVal;
            };
            </#if>
            <#if column.showType!='checkbox' && column.name !='pid'>
                "${column.javaField}": ${"$"}("#${column.javaField}").val(),
            </#if>
        </#if>
    </#list>
            },
            async: true,
            beforeSend: function () {
                loading();
            },
            success: function (rb) {
                closeloading();
                if (rb.code == 0) {
                    var treeList = rb.data;
                    var tbody = '';
                    for (var i = 0; i < treeList.length; i++) {
                        var row = treeList[i];
                        var hasChild = "";
                        if (row.hasChild == 'true') {
                            hasChild = 'data-tt-branch="true"';
                        }
                        var tr = '<tr data-tt-id="' + row.id + '" ' + hasChild + '>'
                                <#list genTable.genTableColumns as column>
                                    <#if column.isList=='0'>
                                + "<td>" + isNull(row.${column.javaField}) + "</td>"
                                    </#if>
                                </#list>
                                + "<td>"
                                + '<shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:update"><button class="btn btn-xs btn-warning updateBtn" rid="' + row.id + '" pid="' + row.pid + '"><i class="fa fa-edit fa-btn"></i>修改</button></shiro:hasPermission>'
                                + '<shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:delete"><button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '"><i class="fa fa-trash fa-btn"></i>删除</button></shiro:hasPermission>'
                                + '<shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:insert"><button class="btn btn-xs btn-success addBtn" rid="' + row.id + '"><i class="fa fa-plus fa-btn"></i>添加子集</button></shiro:hasPermission>'
                                + "</td>"
                                + "</tr>";
                        tbody = tbody + tr;
                    }
                    $("#tree_table").remove();
                    var html = '<table id="tree_table" class="table table-striped table-bordered table-hover table-krt"><thead><tr><#list genTable.genTableColumns as column><#if column.isList=='0'><th>${column.comment}</th></#if></#list><th>操作</th></tr></thead><tbody id="tbody">' + tbody + '</tbody></table>';
                    $("#table-body").append(html);
                    initTreeTable();
                } else {
                    top.layer.msg(rb.msg);
                }
            },
            error: function () {
                closeloading();
                top.layer.msg("程序异常");
            }
        });
    }

    /**
     * 刷新table
     */
    function reloadTable() {
        initTable(0);
    }

    //初始化附表
    initTable(0);

    //搜索
    $("#searchBtn").on('click', function () {
        initTable("");
    });

    //初始化treeTable
    function initTreeTable() {
        $("#tree_table").treetable({
            expandable: true,
            onNodeExpand: nodeExpand,
            onNodeCollapse: nodeCollapse
        });
    }

    //展开事件
    function nodeExpand() {
        getNodeViaAjax(this.id);
    }
    //收缩事件
    function nodeCollapse() {

    }
    //加载子节点
    function getNodeViaAjax(pid) {
        $.ajax({
            type: 'POST',
            url: "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/list?pid=" + pid,
            dataType: 'json',
            async: true,
            beforeSend: function () {
                loading();
            },
            success: function (rb) {
                closeloading();
                if(rb.code==0) {
                    var childNodes = rb.data;
                    if (childNodes) {
                        var parentNode = $("#tree_table").treetable("node", pid);
                        for (var i = 0; i < childNodes.length; i++) {
                            var node = childNodes[i];
                            var nodeToAdd = $("#tree_table").treetable("node", node.id);
                            if (!nodeToAdd) {
                                var hasChild = "";
                                if (node.hasChild == 'true') {
                                    hasChild = 'data-tt-branch="true"';
                                }
                                var row = '<tr data-tt-id="' + node.id + '" ' + hasChild + ' data-tt-parent-id="' + pid + '">'
                                        <#list genTable.genTableColumns as column>
                                            <#if column.isList=='0'>
                                            + "<td>" + isNull(node.${column.javaField}) + "</td>"
                                            </#if>
                                        </#list>
                                        + "<td>"
                                        + '<shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:update"><button class="btn btn-xs btn-warning updateBtn" rid="' + node.id + '" pid="' + node.pid + '"><i class="fa fa-edit fa-btn"></i>修改</button></shiro:hasPermission>'
                                        + '<shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:delete"><button class="btn btn-xs btn-danger deleteBtn" rid="' + node.id + '"><i class="fa fa-trash fa-btn"></i>删除</button></shiro:hasPermission>'
                                        + '<shiro:hasPermission name="<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:insert"><button class="btn btn-xs btn-success addBtn" rid="' + node.id + '"><i class="fa fa-plus fa-btn"></i>添加子集</button></shiro:hasPermission>'
                                        + "</td>"
                                        + "</tr>";
                                $("#tree_table").treetable("loadBranch", parentNode, row);
                            }
                        }
                    }
                }else{
                    top.layer.msg(rb.msg);
                }
            },
            error: function () {
                closeloading();
                top.layer.msg("程序异常");
            }
        });
    }
</script>
</body>
</html>

