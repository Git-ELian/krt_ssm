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
                        <h5>区域树</h5>
                        <div class="box-tools">
                            <button class="btn btn-box-tool" data-widget="collapse" id="refBtn">
                                <i class="fa fa-refresh"></i>
                            </button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div id="regionTree" class="ztree"></div>
                        <!-- 参数 -->
                        <input type="hidden" id="pid" value="">
                    </div>
                </div>
            </div>
            <div class="col-md-10 col-md-12">
                <!-- /.box-header -->
                <div class="box-krt">
                    <div class="box-body">
                        <div class="table-responsive">
                            <div class="table-button">
                                <shiro:hasPermission name="sys:region:insert">
                                    <button title="添加" id="insertBtn" data-placement="left"
                                            data-toggle="tooltip" class="btn btn-success btn-sm">
                                        <i class="fa fa-plus"></i> 添加
                                    </button>
                                </shiro:hasPermission>
                                <button title="刷新" data-placement="left"
                                        onclick="window.location.href = window.location.href"
                                        class="btn btn-primary btn-sm">
                                    <i class="fa fa-refresh"></i> 刷新
                                </button>
                            </div>
                            <div id="table-body">
                                <table id="tree_table" class="table table-striped table-bordered table-hover table-krt">
                                    <thead>
                                    <tr>
                                        <th width="40%">区域名称</th>
                                        <th width="20%">区域编码</th>
                                        <th width="20%">类型</th>
                                        <th width="20%">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>
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
            url: "${basePath}sys/region/regionTree",
            async: false,
            beforeSend: function () {
                loading();
            },
            success: function (data) {
                $.fn.zTree.init($("#regionTree"), setting, data);
                closeloading();

            },
            error: function () {
                closeloading();
            }
        });
    }

    // 默认选择节点
    function selectCheckNode() {
        initTable(0);
    }

    //初始化ztree
    setCheck();
    selectCheckNode();

    /*  ****************************** table事件 *********************************** */

    function isNull(str) {
        if (str == null || str == 'null') {
            return "";
        } else {
            return str;
        }
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

    //加载父表
    function initTable(pid) {
        $.ajax({
            type: "POST",
            url: "${basePath}sys/region/regionChild",
            data: {"pid": pid},
            async: true,
            beforeSend: function () {
                loading();
            },
            success: function (regList) {
                closeloading();
                var tbody = '';
                for (var i = 0; i < regList.length; i++) {
                    var node = regList[i];
                    var hasChild = "";
                    if (node.hasChild == 'true') {
                        hasChild = 'data-tt-branch="true"';
                    }
                    var row = "<tr data-tt-id=\"" + node.id + "\" data-tt-parent-id=\"" + node.pid + "\"" + hasChild + ">"
                        + "<td>" + isNull(node.name) + "</td>"
                        + "<td>" + isNull(node.code) + "</td>"
                        + "<td>" + isNull(node.typeName) + "</td>"
                        + "<td>"
                        + '<shiro:hasPermission name="sys:region:update"><button class="btn btn-xs btn-warning updateBtn" rid="' + node.id + '"><i class="fa fa-edit fa-btn"></i>修改</button></shiro:hasPermission>'
                        + '<shiro:hasPermission name="sys:region:delete"><button class="btn btn-xs btn-danger deleteBtn" rid="' + node.id + '"><i class="fa fa-trash fa-btn"></i>删除</button></shiro:hasPermission>'
                        + '<shiro:hasPermission name="sys:region:insert"><button class="btn btn-xs btn-success addBtn" rid="' + node.id + '"><i class="fa fa-plus fa-btn"></i>添加下级区域</button></shiro:hasPermission>'
                        + "</td>"
                        + "</tr>";
                    tbody = tbody + row;
                }
                $("#tree_table").remove();
                var html = ' <table id="tree_table" class="table table-striped table-bordered table-hover table-krt"> <thead><tr><th width="40%">区域名称</th><th width="20%">区域编码</th> <th width="20%">类型</th><th width="20%">操作</th></tr></thead><tbody>' + tbody + '</tbody></table>';
                console.log(html);
                $("#table-body").append(html);
                initTreeTable();
            },
            error: function (error) {
            },
            dataType: 'json'
        });
    }

    //加载子节点
    function getNodeViaAjax(pid) {
        $.ajax({
            type: "POST",
            url: "${basePath}sys/region/regionChild",
            data: {"pid": pid},
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

                            var row = "<tr data-tt-id=\"" + node.id + "\" data-tt-parent-id=\"" + node.pid + "\"" + hasChild + ">"
                                + "<td>" + isNull(node.name) + "</td>"
                                + "<td>" + isNull(node.code) + "</td>"
                                + "<td>" + isNull(node.typeName) + "</td>"
                                + "<td>"
                                + '<shiro:hasPermission name="sys:region:update"><button class="btn btn-xs btn-warning updateBtn" rid="' + node.id + '"><i class="fa fa-edit fa-btn"></i>修改</button></shiro:hasPermission>'
                                + '<shiro:hasPermission name="sys:region:delete"><button class="btn btn-xs btn-danger deleteBtn" rid="' + node.id + '"><i class="fa fa-trash fa-btn"></i>删除</button></shiro:hasPermission>'
                                + '<shiro:hasPermission name="sys:region:insert"><button class="btn btn-xs btn-success addBtn" rid="' + node.id + '"><i class="fa fa-plus fa-btn"></i>添加下级区域</button></shiro:hasPermission>'
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

    initTreeTable();

    //jequery
    $(function () {

        //pace监听ajax
        $(document).ajaxStart(function () {
            Pace.restart();
        });

        //新增
        $("#insertBtn").click(function () {
            var pid = $("#pid").val();
            openDialog("新增表单", "${basePath}sys/region/insert?id=" + pid, "800px", "300px", "");
        });
        //修改
        $(document).on("click", ".updateBtn", function () {
            var id = $(this).attr("rid");
            openDialog("修改表单", "${basePath}sys/region/update?id=" + id, "800px", "300px", "");
        });
        //添加下级区域
        $(document).on("click", ".addBtn", function () {
            var id = $(this).attr("rid");
            openDialog("新增表单", "${basePath}sys/region/insert?id=" + id, "800px", "300px", "");
        });
        //删除
        $(document).on("click", ".deleteBtn", function () {
            var id = $(this).attr("rid");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/region/delete",
                    data: {"id": id},
                    beforeSend: function () {
                        return loading();
                    },
                    success: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            top.layer.msg(rb.msg);
                            window.location.href = window.location.href;
                        } else {
                            top.layer.msg(rb.msg);
                        }
                    },
                    error: function () {
                        closeloading();
                    }
                });
            }
            confirmx("你确定删除该区域及它的下级区域吗？", fun);
        });
    });

</script>
</body>
</html>
