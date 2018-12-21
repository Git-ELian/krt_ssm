<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common_list.jsp" %>
</head>
<body class="bg-color">
<div class="wrapper">
    <!-- Content Wrapper. Contains page content -->
    <section class="content">
        <div class="search" id="search">
            <div class="panel-body">
                <div class="col-sm-12">
                    <form class="form-inline" action="">
                        <div class="form-group" style="margin:5px">
                            <label for="username" class="control-label" style="padding:0 5px">用户账号</label>
                            <input type="text" class="form-control" placeholder="用户账号" id="username">
                        </div>
                        <div class="form-group" style="margin:5px">
                            <label for="name" class="control-label" style="padding:0 5px">用户姓名</label>
                            <input type="text" class="form-control" placeholder="用户姓名" id="name">
                        </div>
                        <div class="form-group" style="margin:5px">
                            <label for="roleCode" class="control-label" style="padding:0 5px">角色名</label>
                            <select class="form-control" id="roleCode">
                                <option value="">==请选择==</option>
                                <c:forEach items="${roleList}" var="role">
                                    <c:if test="${role.code!='admin'}">
                                        <option value="${role.code}">${role.name}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group" style="margin:5px">
                            <label for="organizationName" class="control-label" style="padding:0 5px">所属机构</label>
                            <div class="input-group width-px-200">
                                <input type="text" name="organizationName" id="organizationName"
                                       class="form-control" readonly="readonly">
                                <span class="input-group-btn">
                                        <button class="btn btn-primary btn-flat" id="organizationTreeBtn" type="button"><i
                                                class="fa fa-search"></i></button>
                                        <button class="btn btn-danger btn-flat" id="cancleOrganizationBtn"
                                                type="button"><i class="fa fa-times"></i></button>
                                    </span>
                                <input type="hidden" name="organizationCode" id="organizationCode">
                            </div>
                        </div>
                        <div class="form-group" style="margin:5px">
                            <label for="status" class="control-label" style="padding:0 5px">账号状态</label>
                            <select class="form-control" id="status">
                                <option value="">==全部==</option>
                                <option value="0">正常</option>
                                <option value="1">禁用</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <div class="text-center">
                                <button type="button" id="searchBtn" class="btn btn-primary btn-sm">
                                    <i class="fa fa-search fa-btn"></i>搜索
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="box-krt">
            <div class="box-body">
                <div class="table-responsive">
                    <div class="table-button">
                        <shiro:hasPermission name="sys:user:insert">
                            <button title="添加" type="button" id="insertBtn" data-placement="left"
                                    data-toggle="tooltip" class="btn btn-success btn-sm">
                                <i class="fa fa-plus"></i> 添加
                            </button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="sys:user:delete">
                            <button title="批量删除" class="btn btn-sm btn-danger" type="button" id="deleteBatchBtn">
                                <i class="fa fa-trash fa-btn"></i>批量删除
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" class="iCheck"></th>
                            <th>用户账号</th>
                            <th>用户姓名</th>
                            <th>角色名</th>
                            <th>所属机构</th>
                            <th>账号状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section> <!-- /.content -->
</div>
<!-- ./wrapper -->
<!-- page script -->
<script type="text/javascript">
    var datatable;
    function initDatatable() {
        datatable = $('#datatable').DataTable({
            "ajax": {
                "url": "${basePath}sys/user/list",
                "type": "post",
                "data": function (d) {
                    d.username = $('#username').val();
                    d.name = $('#name').val();
                    d.roleCode = $('#roleCode').val();
                    d.organizationCode = $('#organizationCode').val();
                    d.status = $('#status').val();
                }
            },
            "columns": [
                {
                    "data": "id",

                    render: function (data, type) {
                        return '<input type="checkbox" class="iCheck check" value="' + data + '">';
                    }
                },
                {"data": "username"},
                {"data": "name"},
                {"data": "roleName"},
                {"data": "organizationName"},
                {
                    "data": "status",
                    render: function (data) {
                        if (data == '0') {
                            return '<span class="badge bg-green">正常</span>';
                        } else {
                            return '<span class="badge bg-maroon">禁用</span>';
                        }
                    }
                },
                {
                    "data": "id",
                    render: function (data, type, row) {
                        var button = "";
                        if (row.status == '0') {
                            button = '<shiro:hasPermission  name="sys:user:status">'
                                + '<button class="btn btn-xs bg-maroon cancelBtn" rid="' + row.id + '" status="1">'
                                + '<i class="fa fa-close fa-btn"></i>禁用'
                                + '</button>'
                                + '</shiro:hasPermission>';
                        } else {
                            button = '<shiro:hasPermission  name="sys:user:status">'
                                + '<button class="btn btn-xs btn-success cancelBtn" rid="' + row.id + '" status="0">'
                                + '<i class="fa fa-check fa-btn"></i>启用'
                                + '</button>'
                                + '</shiro:hasPermission>';
                        }
                        if (row.username != 'admin') {
                            return '<shiro:hasPermission  name="sys:user:see">'
                                + '<button class="btn btn-xs btn-info seeBtn" rid="' + row.id + '">'
                                + '<i class="fa fa-eye fa-btn"></i>查看'
                                + '</button>'
                                + '</shiro:hasPermission>'
                                + '<shiro:hasPermission  name="sys:user:update">'
                                + '<button class="btn btn-xs btn-warning updateBtn" rid="' + row.id + '">'
                                + '<i class="fa fa-edit fa-btn"></i>修改'
                                + '</button>'
                                + '</shiro:hasPermission>'
                                + button
                                + '<shiro:hasPermission  name="sys:user:delete">'
                                + '<button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '">'
                                + '<i class="fa fa-trash fa-btn"></i>删除'
                                + '</button>'
                                + '</shiro:hasPermission>';

                        } else {
                            return '<shiro:hasPermission  name="sys:user:see">'
                                + '<button class="btn btn-xs  btn-info seeBtn" rid="' + row.id + '">'
                                + '<i class="fa fa-user-times fa-btn"></i>查看'
                                + '</button>'
                                + '</shiro:hasPermission>';
                        }
                    }
                }
            ]
        });
    }


    $(function () {
        //初始化datatable
        initDatatable();

        $("#searchBtn").on('click', function () {
            datatable.ajax.reload();
        });

        //新增
        $("#insertBtn").click(function () {
            openDialog("新增表单", "${basePath}sys/user/insert", "800px", "380px");
        });

        //查看
        $(document).on("click", ".seeBtn", function () {
            var id = $(this).attr("rid");
            openDialogView("查看表单", "${basePath}sys/user/see?id=" + id, "800px", "380px");
        });

        //修改
        $(document).on("click", ".updateBtn", function () {
            var id = $(this).attr("rid");
            openDialog("修改表单", "${basePath}sys/user/update?id=" + id, "800px", "380px");
        });

        //删除
        $(document).on("click", ".deleteBtn", function () {
            var id = $(this).attr("rid");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/user/delete",
                    data: {"id": id},
                    beforeSend: function () {
                        return loading();
                    },
                    success: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            top.layer.msg(rb.msg);
                            refreshTable(datatable);
                        } else {
                            top.layer.msg(rb.msg);
                        }
                    },
                    error: function () {
                        closeloading();
                    }
                });
            };
            confirmx("你确定删除吗？", fun);
        });

        //批量删除
        $("#deleteBatchBtn").click(function () {
            var ids = getIds();
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/user/deleteByIds",
                    data: {"ids": ids},
                    beforeSend: function () {
                        return loading();
                    },
                    success: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            top.layer.msg(rb.msg);
                            refreshTable(datatable);
                        } else {
                            top.layer.msg(rb.msg);
                        }
                    },
                    error: function () {
                        closeloading();
                    }
                });
            };
            if (ids == "") {
                top.layer.msg("请选择要删除的数据!");
                return false;
            } else {
                ids = ids.substr(0, ids.length - 1);
                confirmx("你确定删除吗？", fun);
            }
        });

        //禁用
        $(document).on("click", ".cancelBtn", function () {
            var id = $(this).attr("rid");
            var status = $(this).attr("status");
            var tip = "启用";
            if (status == '1') {
                tip = "禁用";
            }
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/user/status?id=" + id + "&status=" + status,
                    beforeSend: function () {
                        return loading();
                    },
                    success: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            top.layer.msg(rb.msg);
                            refreshTable(datatable);
                        } else {
                            top.layer.msg(rb.msg);
                        }
                    },
                    error: function () {
                        closeloading();
                    }
                });
            };
            confirmx("你确定" + tip + "该用户吗？", fun);
        });

        //组织机构
        $("#organizationTreeBtn").click(function () {
            layer_window = top.layer.open({
                type: 2,
                area: ['300px', '450px'],
                title: "选择机构",
                maxmin: true, //开启最大化最小化按钮
                content: "${basePath}sys/organization/organizationTreeUI?id=" + $("#pid").val(),
                btn: ['确定', '关闭'],
                yes: function (index, layero) {
                    var tree = layero.find("iframe")[0].contentWindow.tree;
                    var nodes = tree.getSelectedNodes();
                    if (nodes == null || nodes == '') {
                        top.layer.msg("请选择机构");
                    } else {
                        $("#organizationName").val(nodes[0].name);
                        $("#organizationCode").val(nodes[0].code);
                        top.layer.close(index);
                    }
                },
                cancel: function (index) {
                    top.layer.close(index);
                }
            });
        });

        //取消组织机构查询
        $("#cancleOrganizationBtn").click(function () {
            $("#organizationName").val("");
            $("#organizationCode").val("");
        });
    });
</script>
</body>
</html>
