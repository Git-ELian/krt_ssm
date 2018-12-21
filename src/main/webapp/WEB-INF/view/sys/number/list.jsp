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
                        <shiro:hasPermission name="sys:number:insert">
                            <button title="添加" type="button" id="insertBtn" class="btn btn-success btn-sm">
                                <i class="fa fa-plus"></i> 添加
                            </button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="sys:number:delete">
                            <button class="btn btn-sm btn-danger" id="deleteBatchBtn">
                                <i class="fa fa-trash fa-btn"></i>批量删除
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" class="iCheck"></th>
                            <th>流水号编码</th>
                            <th>流水号名称</th>
                            <th>当前流水号</th>
                            <th>示例</th>
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
                "url": "${basePath}sys/number/list",
                "type": "post",
                "data": function (d) {

                }
            },
            "columns": [
                {
                    "data": "id",
                    width: "10",
                    render: function (data, type, row) {
                        return '<input type="checkbox" class="iCheck check" value="' + data + '" status="' + row.status + '">';
                    }
                },
                {"data": "code"},
                {"data": "name"},
                {"data": "num"},
                {"data": "formatNum"},
                {
                    "data": "id",
                    "render": function (data, type, row) {
                        return '<shiro:hasPermission name="sys:number:update">'
                            + '<button class="btn btn-xs btn-warning updateBtn" rid="' + row.id + '">'
                            + '<i class="fa fa-edit fa-btn"></i>修改'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:number:delete">'
                            + '<button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '">'
                            + '<i class="fa fa-trash fa-btn"></i>删除'
                            + '</button>'
                            + '</shiro:hasPermission>';
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
            openDialog("新增表单", "${basePath}sys/number/insert", "800px", "400px");
        });

        //修改
        $(document).on("click", ".updateBtn", function () {
            var id = $(this).attr("rid");
            openDialog("修改表单", "${basePath}sys/number/update?id=" + id, "800px", "380px");
        });

        //删除
        $(document).on("click", ".deleteBtn", function () {
            var id = $(this).attr("rid");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/number/delete?id=" + id,
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
            confirmx("你确定删除吗？", fun);
        });

        //批量删除
        $("#deleteBatchBtn").click(function () {
            var ids = getIds();
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/number/deleteByIds",
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
            if (ids == "") {
                top.layer.msg("请选择要删除的数据!");
                return false;
            } else {
                ids = ids.substr(0, ids.length - 1);
                confirmx("你确定删除吗？", fun);
            }
        });

    });
</script>
</body>
</html>
