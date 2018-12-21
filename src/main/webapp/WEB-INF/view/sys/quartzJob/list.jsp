<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common_list.jsp" %>
</head>
<body class="bg-color">
<div class="wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="box-krt">
            <div class="box-body">
                <div class="table-responsive">
                    <div class="table-button">
                        <shiro:hasPermission name="sys:quartzJob:insert">
                            <button title="添加" id="insertBtn" data-placement="left" data-toggle="tooltip" class="btn btn-success btn-sm">
                                <i class="fa fa-plus"></i> 添加
                            </button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="sys:quartzJob:delete">
                            <button class="btn btn-sm btn-danger" id="deleteBatchBtn">
                                <i class="fa fa-trash fa-btn"></i>批量删除
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" class="iCheck"></th>
                            <th>任务名</th>
                            <th>组名</th>
                            <th>cron表达式</th>
                            <th>类路径</th>
                            <th>springId</th>
                            <th>方法名</th>
                            <th>状态</th>
                            <th>描述</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</div>
<!-- ./wrapper -->
<!-- page script -->
<script type="text/javascript">
    var datatable;
    function initDatatable() {
        datatable = $('#datatable').DataTable({
            "ajax": {
                "url": "${basePath}sys/quartzJob/list",
                "type": "post"
            },
            "columns": [
                {
                    "data": "id",
                    width: "10",
                    render: function (data, type, row) {
                        return '<input type="checkbox" class="iCheck check" value="' + data + '" status="' + row.status + '">';
                    }
                },
                {"data": "name"},
                {"data": "group"},
                {"data": "expression"},
                {"data": "beanClass"},
                {"data": "springId"},
                {"data": "method"},
                {
                    "data": "status",
                    render: function (data, type, row) {
                        if (data == '1') {
                            return '<span class="badge bg-green">正在运行</span>';
                        } else {
                            return '<span class="badge bg-red">停止中</span>';
                        }
                    }
                },
                {"data": "description"},
                {
                    "data": "id",
                    "render": function (data, type, row) {
                        if (row.status == '0') {
                            return '<shiro:hasPermission name="sys:quartzJob:startOrstop">'
                                + '<button class="btn btn-xs btn-info startOrstopBtn" rid="' + row.id + '" status="' + row.status + '">'
                                + '<i class="fa fa-eye fa-btn"></i>启动任务'
                                + '</button>'
                                + '</shiro:hasPermission>'
                                + '<shiro:hasPermission name="sys:quartzJob:update">'
                                + '<button class="btn btn-xs btn-warning updateBtn" rid="' + row.id + '">'
                                + '<i class="fa fa-edit fa-btn"></i>修改'
                                + '</button>'
                                + '</shiro:hasPermission>'
                                + '<shiro:hasPermission name="sys:quartzJob:delete">'
                                + '<button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '">'
                                + '<i class="fa fa-trash fa-btn"></i>删除'
                                + '</button>'
                                + '</shiro:hasPermission>';
                        } else if (row.status == '1') {
                            return '<shiro:hasPermission name="sys:quartzJob:startOrstop">'
                                + '<button class="btn btn-xs btn-info startOrstopBtn" rid="' + row.id + '" status="' + row.status + '">'
                                + '<i class="fa fa-eye fa-btn"></i>停止任务'
                                + '</button>'
                                + '</shiro:hasPermission>'
                                + '<shiro:hasPermission name="sys:quartzJob:doOnce">'
                                + '<button class="btn btn-xs btn-success doOnceBtn" rid="' + row.id + '" status="' + row.status + '">'
                                + '<i class="fa fa-bol fa-btn"></i>立即执行一次'
                                + '</button>'
                                + '</shiro:hasPermission>';
                        }
                    }
                }
            ]
        });
    }
    //jequery
    $(function () {
        //pace监听ajax
        $(document).ajaxStart(function () {
            Pace.restart();
        });
        //初始化datatable
        initDatatable();
        //新增
        $("#insertBtn").click(function () {
            openDialog("新增表单", "${basePath}sys/quartzJob/insert", "800px", "450px", "");
        });
        //启动or停止任务
        $(document).on("click", ".startOrstopBtn", function () {
            var id = $(this).attr("rid");
            var status = $(this).attr("status");
            var tip = "";
            if (status == '0') {
                tip = "启动";
            } else {
                tip = "停止";
            }
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/quartzJob/startOrStop?id=" + id + "&status=" + status,
                    data: $('#krtForm').serialize(),// 要提交的表单
                    beforeSend: function () {
                        return loading();
                    },
                    success: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            top.layer.msg(rb.msg);
                            refreshTable();
                        } else {
                            top.layer.msg(rb.msg);
                        }
                    },
                    error: function () {
                        closeloading();
                    }
                });
            }
            confirmx("你确定" + tip + "任务吗？", fun);

        });
        //修改
        $(document).on("click", ".updateBtn", function () {
            var id = $(this).attr("rid");
            openDialog("修改表单", "${basePath}sys/quartzJob/update?id=" + id, "800px", "450px", "");
        });
        //删除
        $(document).on("click", ".deleteBtn", function () {
            var id = $(this).attr("rid");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/quartzJob/delete",
                    data: {"id": id},
                    beforeSend: function () {
                        return loading();
                    },
                    success: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            top.layer.msg(rb.msg);
                            refreshTable();
                        } else {
                            top.layer.msg(rb.msg);
                        }
                    },
                    error: function () {
                        closeloading();
                    }
                });
            }
            confirmx("你确定删除吗？", fun);
        });
        //批量删除
        $("#deleteBatchBtn").click(function () {
            var ids = "";
            var flag = true;
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/quartzJob/deleteByIds",
                    data: {"ids": ids},
                    beforeSend: function () {
                        return loading();
                    },
                    success: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            top.layer.msg(rb.msg);
                            refreshTable();
                        } else {
                            top.layer.msg(rb.msg);
                        }
                    },
                    error: function () {
                        closeloading();
                    }
                });
            };
            $(".check").each(function () {
                if ($(this).prop("checked")) {
                    var status = $(this).attr("status");
                    if (status == '1') {
                        flag = false;
                        top.layer.msg("请先停止任务!");
                        return false;
                    }
                    ;
                    ids = ids + ($(this).val()) + ",";
                }
            });
            if (ids == "" && flag) {
                top.layer.msg("请选择要删除的数据!");
                return false;
            } else if (flag) {
                ids = ids.substr(0, ids.length - 1);
                confirmx("你确定删除吗？", fun);
            }
        });
        //立即执行
        $(document).on("click", ".doOnceBtn", function () {
            var id = $(this).attr("rid");
            $.ajax({
                type: "POST",
                url: "${basePath}sys/quartzJob/doOnce",
                data: {"id": id},
                beforeSend: function () {
                    return loading();
                },
                success: function (rb) {
                    closeloading();
                    if (rb.code == 0) {
                        top.layer.msg(rb.msg);
                        refreshTable();
                    } else {
                        top.layer.msg(rb.msg);
                    }
                },
                error: function () {
                    closeloading();
                }
            });
        });
    });
</script>
</body>
</html>
