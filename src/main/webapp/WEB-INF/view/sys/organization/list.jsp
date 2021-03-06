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
                        <h5>组织机构树</h5>
                        <div class="box-tools">
                            <button class="btn btn-box-tool" data-widget="collapse" id="refBtn">
                                <i class="fa fa-refresh"></i>
                            </button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div id="organizationTree" class="ztree"></div>
                        <!-- 参数 -->
                        <input type="hidden" id="pid" value="">
                    </div>
                </div>
            </div>
            <div class="col-md-10 col-md-12">
                <div class="box-krt">
                    <div class="box-header">
                        <h5>组织机构管理</h5>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body" id="boxbody">
                        <div class="table-responsive" id="table-body">
                            <div class="table-button">
                                <shiro:hasPermission name="sys:organization:insert">
                                    <button title="添加" id="insertBtn" data-placement="left" data-toggle="tooltip" class="btn btn-success btn-sm">
                                        <i class="fa fa-plus"></i> 添加
                                    </button>
                                </shiro:hasPermission>
                            </div>
                            <table id="tree_table" class="table table-striped table-bordered table-hover table-krt">
                                <thead>
                                <tr>
                                    <th>机构名称</th>
                                    <th>机构代码</th>
                                    <th>机构类别</th>
                                    <th>结构类型</th>
                                    <th>备注</th>
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
<script type="text/javascript" src="${basePath}static/assets/js/browser.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/jquery-treetable/javascripts/jquery.treeTable.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${basePath}static/assets/libs/ztree/jquery.ztree.excheck-3.5.js"></script>
<!-- page script -->
<script language="javascript" type="text/javascript">

    $("#refBtn").click(function () {
        setCheck();
    });

    //新增
    $("#insertBtn").click(function () {
        var pid = $("#pid").val();
        openDialog("新增表单", "${basePath}sys/organization/insert?id="+pid, "800px", "620px", "");
    });

    //查看
    $(document).on("click", ".seeBtn", function () {
        var id = $(this).attr("rid");
        openDialogView("查看表单", "${basePath}sys/organization/see?id=" + id, "800px", "620px", "");
    });

    //添加子资源
    $(document).on("click", ".addBtn", function () {
        var id = $(this).attr("rid");
        openDialog("新增表单", "${basePath}sys/organization/insert?id=" + id, "800px", "620px", "");
    });

    //修改
    $(document).on("click", ".updateBtn", function () {
        var id = $(this).attr("rid");
        openDialog("修改表单", "${basePath}sys/organization/update?id=" + id, "800px", "620px", "");
    });

    //删除
    $(document).on("click", ".deleteBtn", function () {
        var id = $(this).attr("rid");
        var fun = function () {
            $.ajax({
                type: "POST",
                url: "${basePath}sys/organization/delete?id=" + id,
                beforeSend: function () {
                    return loading();
                },
                success: function (rb) {
                    closeloading();
                    if (rb.code==0) {
                        top.layer.msg(rb.msg);
                        var pid = $("#pid").val();
                        initTable(pid);
                        setCheck();
                    } else {
                        top.layer.msg(msg.data);
                    }
                },
                error: function () {
                    closeloading();
                }
            });
        };
        confirmx("你确定删除此机构及下级机构吗？", fun);
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

    //初始化加载tree
    function setCheck() {
        $.ajax({
            type: "POST",
            url: "${basePath}sys/organization/organizationTree",
            async: false,
            beforeSend: function () {
                loading();
            },
            success: function (data) {
                $.fn.zTree.init($("#organizationTree"), setting, data);
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
        var tree = $.fn.zTree.getZTreeObj("organizationTree");
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
            url: "${basePath}sys/organization/list",
            data:{"pid":pid},
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
                    var tr = '<tr data-tt-id="' + row.id + '" ' + hasChild + '>'
                            + "<td>" + isNull(row.name) + "</td>"
                            + "<td>" + isNull(row.code) + "</td>"
                            + "<td>" + isNull(row.typeName) + "</td>"
                            + "<td>" + isNull(row.gradeName) + "</td>"
                            + "<td>" + isNull(row.remark) + "</td>"
                            + "<td>"
                            + '<shiro:hasPermission name="sys:organization:see"><button class="btn btn-xs btn-info seeBtn" rid="' + row.id + '" pid="' + row.pid + '"><i class="fa fa-eye fa-btn"></i>查看</button></shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:organization:update"><button class="btn btn-xs btn-warning updateBtn" rid="' + row.id + '" pid="' + row.pid + '"><i class="fa fa-edit fa-btn"></i>修改</button></shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:organization:delete"><button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '"><i class="fa fa-trash fa-btn"></i>删除</button></shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:organization:insert"><button class="btn btn-xs btn-success addBtn" rid="' + row.id + '"><i class="fa fa-plus fa-btn"></i>添加下级机构</button></shiro:hasPermission>'
                            + "</td>"
                            + "</tr>";
                    tbody = tbody + tr;
                }
                $("#tree_table").remove();
                var html = '<table id="tree_table" class="table table-striped table-bordered table-hover table-krt"><thead><tr><th>机构名称</th><th>机构代码</th><th>机构类别</th><th>结构类型</th><th>备注</th><th>操作</th></tr></thead><tbody id="tbody">' + tbody + '</tbody></table>';
                console.log(html);
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
            url: "${basePath}sys/organization/list?pid=" + pid,
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
                            var row = '<tr data-tt-id="' + node.id + '" ' + hasChild + ' data-tt-parent-id="' + pid + '">'
                                    + "<td>" + isNull(node.name) + "</td>"
                                    + "<td>" + isNull(node.code) + "</td>"
                                    + "<td>" + isNull(node.typeName) + "</td>"
                                    + "<td>" + isNull(node.gradeName) + "</td>"
                                    + "<td>" + isNull(node.remark) + "</td>"
                                    + "<td>"
                                    + '<shiro:hasPermission name="sys:organization:see"><button class="btn btn-xs btn-info seeBtn" rid="' + node.id + '" pid="' + node.pid + '"><i class="fa fa-eye fa-btn"></i>查看</button></shiro:hasPermission>'
                                    + '<shiro:hasPermission name="sys:organization:update"><button class="btn btn-xs btn-warning updateBtn" rid="' + node.id + '" pid="' + node.pid + '"><i class="fa fa-edit fa-btn"></i>修改</button></shiro:hasPermission>'
                                    + '<shiro:hasPermission name="sys:organization:delete"><button class="btn btn-xs btn-danger deleteBtn" rid="' + node.id + '"><i class="fa fa-trash fa-btn"></i>删除</button></shiro:hasPermission>'
                                    + '<shiro:hasPermission name="sys:organization:insert"><button class="btn btn-xs btn-success addBtn" rid="' + node.id + '"><i class="fa fa-plus fa-btn"></i>添加下级机构</button></shiro:hasPermission>'
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

