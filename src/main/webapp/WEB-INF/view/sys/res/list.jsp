<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common.jsp" %>
    <link rel="stylesheet" href="${basePath}static/assets/libs/ztree/zTreeStyle/zTreeStyle.css" type="text/css"/>
    <link rel="stylesheet" href="${basePath}static/assets/libs/jquery-treetable/css/jquery.treeTable.css"/>
    <link rel="stylesheet" href="${basePath}static/assets/libs/jquery-treetable/css/jquery.treetable.theme.default.css"/>
</head>
<body class="bg-color">
<div class="wrapper">
    <section class="content">
        <div class="row">
            <div class="col-md-2 col-md-12">
                <div class="box-krt">
                    <div class="box-header">
                        <h5>项目资源树</h5>
                        <div class="box-tools">
                            <button class="btn btn-box-tool" data-widget="collapse" id="refBtn">
                                <i class="fa fa-refresh"></i>
                            </button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div id="resTree" class="ztree"></div>
                        <!-- 参数 -->
                        <input type="hidden" id="pid" value="">
                    </div>
                </div>
            </div>
            <div class="col-md-10 col-md-12">
                <div class="box-krt">
                    <div class="box-header">
                        <h5>资源管理</h5>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body" id="boxbody">
                        <div class="table-responsive" id="table-body">
                            <div class="table-button">
                                <shiro:hasPermission name="sys:res:insert">
                                    <button title="添加" id="insertBtn" data-placement="left" data-toggle="tooltip" class="btn btn-success btn-sm">
                                        <i class="fa fa-plus"></i> 添加
                                    </button>
                                </shiro:hasPermission>
                            </div>
                            <table id="tree_table" class="table table-striped table-bordered table-hover table-krt">
                                <thead>
                                <tr>
                                    <th>名称</th>
                                    <th>连接</th>
                                    <th>类型</th>
                                    <th>权限标志</th>
                                    <th>排序</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col-xs-10 -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</div>
<!-- ./wrapper -->
<!-- 通用js -->
<script type="text/javascript" src="${basePath}static/assets/js/browser.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/jquery-treetable/javascripts/jquery.treeTable.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/ztree/jquery.ztree.excheck-3.5.js"></script>
<script language="javascript" type="text/javascript">

    $("#refBtn").click(function () {
        setCheck();
    });

    //新增
    $("#insertBtn").click(function () {
        var pid = $("#pid").val();
        openDialog("新增表单", "${basePath}sys/res/insert?id=" + pid, "800px", "500px");
    });
    
    //查看
    $(document).on("click", ".seeBtn", function () {
        var id = $(this).attr("rid");
        openDialogView("查看表单", "${basePath}sys/res/see?id=" + id, "800px", "500px");
    })
    
    //修改
    $(document).on("click", ".updateBtn", function () {
        var id = $(this).attr("rid");
        openDialog("修改表单", "${basePath}sys/res/update?id=" + id, "800px", "500px");
    });
    
    //添加子资源
    $(document).on("click", ".addBtn", function () {
        var id = $(this).attr("rid");
        openDialog("新增表单", "${basePath}sys/res/insert?id=" + id, "800px", "500px");
    });
    
    //删除
    $(document).on("click", ".deleteBtn", function () {
        var id = $(this).attr("rid");
        var fun = function () {
            $.ajax({
                type: "POST",
                url: "${basePath}sys/res/delete?id=" + id,
                data: $('#krtForm').serialize(),// 要提交的表单
                beforeSend: function () {
                    return loading();
                },
                success: function (rb) {
                    closeloading();
                    if (rb.code == 0) {
                        top.layer.msg(rb.msg);
                        var pid = $("#pid").val();
                        initTable(pid);
                        setCheck();
                    } else {
                        top.layer.msg(rb.msg);
                    }
                },
                error: function () {
                    closeloading();
                }
            });
        }
        confirmx("你确定删除此模块及下级模块吗？", fun);
    });
</script>
<script type="text/javascript">
    //ztree点击事件
    function zTreeOnClick(event, treeId, treeNode) {
        var pid = treeNode.id;
        $("#pid").val(pid);
        initTable(pid);
    }
    ;
    //ztree设置
    var setting = {
        view: {
            selectedMulti: false,
            dblClickExpand: false
        },
        data: {
            simpleData: {enable: true}
        },
        callback: {
            onClick: zTreeOnClick
        }
    };

    function setCheck() {
        $.ajax({
            type: "POST",
            url: "${basePath}sys/res/resTree",
            async: false,
            beforeSend: function () {
                loading();
            },
            success: function (data) {
                $.fn.zTree.init($("#resTree"), setting, data);
                closeloading();

            },
            error: function () {
                closeloading();
            }
        });
    }

    // 默认选择节点
    function selectCheckNode() {
        var id = 0;
        var tree = $.fn.zTree.getZTreeObj("resTree");
        var node = tree.getNodeByParam("id", id);
        tree.selectNode(node);
        //初始化权限系统
        $("#pid").val(id);
        initTable(id);
    }

    //初始化ztree
    setCheck();
    selectCheckNode();

    function isNull(str) {
        if (str == null || str == 'null') {
            return "";
        } else {
            return str;
        }
    }
    //加载父表
    function initTable(pid) {
        $("#pid").val(pid);
        $.ajax({
            type: "POST",
            url: "${basePath}sys/res/list",
            data: {"pid": pid},
            async: true,
            beforeSend: function () {
                loading();
            },
            success: function (resList) {
                closeloading();
                var tbody = '';
                for (var i = 0; i < resList.length; i++) {
                    var row = resList[i];
                    var hasChild = "";
                    if (row.hasChild == 'true') {
                        hasChild = 'data-tt-branch="true"';
                    }
                    var type = row.type;
                    if (type == 'url') {
                        type = '<span class="badge bg-red">菜单</span>';
                    } else {
                        type = '<span class="badge bg-light-blue">按钮</span>';
                    }
                    var tr = '<tr data-tt-id="' + row.id + '" ' + hasChild + '>'
                        + "<td>" + isNull(row.name) + "</td>"
                        + "<td>" + isNull(row.url) + "</td>"
                        + "<td>" + type + "</td>"
                        + "<td>" + isNull(row.permission) + "</td>"
                        + "<td>" + isNull(row.sortNo) + "</td>"
                        + "<td>"
                        + '<shiro:hasPermission name="sys:res:see"><button class="btn btn-xs btn-info seeBtn" rid="' + row.id + '" pid="' + row.pid + '"><i class="fa fa-eye fa-btn"></i>查看</button></shiro:hasPermission>'
                        + '<shiro:hasPermission name="sys:res:update"><button class="btn btn-xs btn-warning updateBtn" rid="' + row.id + '" pid="' + row.pid + '"><i class="fa fa-edit fa-btn"></i>修改</button></shiro:hasPermission>'
                        + '<shiro:hasPermission name="sys:res:delete"><button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '"><i class="fa fa-trash fa-btn"></i>删除</button></shiro:hasPermission>'
                        + '<shiro:hasPermission name="sys:res:insert"><button class="btn btn-xs btn-success addBtn" rid="' + row.id + '"><i class="fa fa-plus fa-btn"></i>添加子资源</button></shiro:hasPermission>'
                        + "</td>"
                        + "</tr>";
                    tbody = tbody + tr;
                }

                $("#tree_table").remove();
                var html = '<table id="tree_table" class="table table-striped table-bordered table-hover table-krt"><thead><tr><th>名称</th><th>连接</th><th>类型</th><th>权限标志</th><th>排序</th><th>操作</th></tr></thead><tbody id="tbody">' + tbody + '</tbody></table>';
                $("#table-body").append(html);
                initTreeTable();
            },
            error: function () {
                closeloading();
            }
        });
    }

    /**
     * 刷新table
     */
    function reloadTable() {
        var pid = $("#pid").val();
        initTable(pid);
    }

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
            url: "${basePath}sys/res/list?pid=" + pid,
            async: true,
            beforeSend: function () {
                loading();
            },
            success: function (data) {
                closeloading();
                var childNodes = data;
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
                            var type = node.type;
                            if (type == 'url') {
                                type = '<span class="badge bg-red">菜单</span>';
                            } else {
                                type = '<span class="badge bg-light-blue">按钮</span>';
                            }
                            var row = '<tr data-tt-id="' + node.id + '" ' + hasChild + ' data-tt-parent-id="' + pid + '">'
                                + "<td>" + isNull(node.name) + "</td>"
                                + "<td>" + isNull(node.url) + "</td>"
                                + "<td>" + type + "</td>"
                                + "<td>" + isNull(node.permission) + "</td>"
                                + "<td>" + isNull(node.sortNo) + "</td>"
                                + "<td>"
                                + '<shiro:hasPermission name="sys:res:see"><button class="btn btn-xs btn-info seeBtn" rid="' + node.id + '" pid="' + node.pid + '"><i class="fa fa-eye fa-btn"></i>查看</button></shiro:hasPermission>'
                                + '<shiro:hasPermission name="sys:res:update"><button class="btn btn-xs btn-warning updateBtn" rid="' + node.id + '" pid="' + node.pid + '"><i class="fa fa-edit fa-btn"></i>修改</button></shiro:hasPermission>'
                                + '<shiro:hasPermission name="sys:res:delete"><button class="btn btn-xs btn-danger deleteBtn" rid="' + node.id + '"><i class="fa fa-trash fa-btn"></i>删除</button></shiro:hasPermission>'
                                + '<shiro:hasPermission name="sys:res:insert"><button class="btn btn-xs btn-success addBtn" rid="' + node.id + '"><i class="fa fa-plus fa-btn"></i>添加子资源</button></shiro:hasPermission>'
                                + "</td>"
                                + "</tr>";
                            $("#tree_table").treetable("loadBranch", parentNode, row);
                        }

                    }

                }

            },
            error: function (error) {
            },
            dataType: 'json'
        });
    }
</script>
</body>
</html>

