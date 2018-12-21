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
        <div class="box-krt">
            <div class="box-body">
                <div class="table-responsive">
                    <div class="table-button">
                        <shiro:hasPermission name="sys:user:delete">
                            <button title="批量下线" class="btn btn-sm btn-danger" type="button" id="deleteBatchBtn">
                                <i class="fa fa-trash fa-btn"></i>批量下线
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" class="iCheck"></th>
                            <th>用户名</th>
                            <th>主机</th>
                            <th>登录时间</th>
                            <th>最后访问时间</th>
                            <th>过期时间</th>
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
                "url": "${basePath}sys/session/list",
                "type": "post",
                "data": function (d) {

                }
            },
            "columns": [
                {
                    "data": "id",
                    width: "10",
                    render: function (data, type, row) {
                        return '<input type="checkbox" class="iCheck check" self = "' + row.self + '" value="' + data + '">';
                    }
                },
                {"data": "username"},
                {"data": "host"},
                {"data": "startTimestamp"},
                {"data": "lastAccessTime"},
                {"data": "timeout"},
                {
                    "data": "id",
                    render: function (data, type, row) {
                        if (row.self) {
                            return "";
                        } else {
                            return '<shiro:hasPermission  name="sys:user:delete">'
                                + '<button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '">'
                                + '<i class="fa fa-trash fa-btn"></i>强制下线'
                                + '</button>'
                                + '</shiro:hasPermission>';
                        }
                    }
                }
            ],
            "fnDrawCallback": function () {
                checkAll();
            }
        });
    }


    $(function () {

        //初始化datatable
        initDatatable();


        //删除
        $(document).on("click", ".deleteBtn", function () {
            var id = $(this).attr("rid");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/session/deleteUser",
                    data: {"sessionId": id},
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
            confirmx("你确定强制该账号下线吗？", fun);
        });

        //批量删除
        $("#deleteBatchBtn").click(function () {
            var ids = "";
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/session/deleteUsers",
                    data: {"sessionIds": ids},
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
            $(".check").each(function () {
                if ($(this).prop("checked") && $(this).attr("self") == 'false') {
                    ids = ids + ($(this).val()) + ","
                }
            });
            if (ids == "") {
                top.layer.msg("请选择要强制下线账号!");
                return false;
            } else {
                ids = ids.substr(0, ids.length - 1);
                confirmx("你确定强制这些账号下线吗？", fun);
            }
        });
    });
</script>
</body>
</html>
