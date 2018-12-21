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
                        <shiro:hasPermission name="sys:role:insert">
                            <button title="添加" id="insertBtn" data-placement="left" data-toggle="tooltip" class="btn btn-success btn-sm">
                                <i class="fa fa-plus"></i> 添加
                            </button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="sys:role:delete">
                            <button class="btn btn-sm btn-danger" id="deleteBatchBtn">
                                <i class="fa fa-trash fa-btn"></i>批量删除
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" class="iCheck"></th>
                            <th>角色名称</th>
                            <th>角色编码</th>
                            <th>备注</th>
                            <th>排序</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div> <!-- /.box-body -->
        </div>
    </section>
    <!-- /.content -->
</div>
<!-- ./wrapper -->
<script type="text/javascript">
    var datatable;
    function initDatatable() {
        datatable = $('#datatable').DataTable({
            ordering: true,
            order: [[4, 'asc']],
            "ajax": {
                "url": "${basePath}sys/role/list",
                "type": "post",
                "data": function (d) {
                    d.orderName = camel2Underline(d.columns[d.order[0].column].data);
                    d.orderType = d.order[0].dir;
                }
            },
            "columns": [
                {
                    "data": "id",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="checkbox" class="iCheck check" value="' + data + '"  code="' + row.code + '">';
                    }
                },
                {
                    "data": "name",
                    "orderable": false
                },
                {
                    "data": "code",
                    "orderable": false
                },
                {
                    "data": "remark",
                    "orderable": false
                },
                {"data": "sortNo"},
                {
                    "data": "id",
                    "orderable": false,
                    "render": function (data, type, full) {
                        return '<shiro:hasPermission name="sys:role:see">'
                            + '<button class="btn btn-xs btn-info seeBtn" rid="' + data + '">'
                            + '<i class="fa fa-eye fa-btn"></i>查看'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:role:update">'
                            + '<button class="btn btn-xs btn-warning updateBtn" rid="' + data + '">'
                            + '<i class="fa fa-edit fa-btn"></i>修改'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:role:delete">'
                            + '<button class="btn btn-xs btn-danger deleteBtn" rid="' + data + '" code="' + full.code + '">'
                            + '<i class="fa fa-trash fa-btn"></i>删除'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:role:res">'
                            + '<button class="btn btn-xs btn-success permBtn" code="' + full.code + '">'
                            + '<i class="fa fa-edit fa-btn"></i>权限设置'
                            + '</button>'
                            + '</shiro:hasPermission>';
                    }
                }
            ]
        });
    }
    //jequery
    $(function () {

        //初始化datatable
        initDatatable();

        $("#searchBtn").on('click', function () {
            datatable.ajax.reload();
        });

        //新增
        $("#insertBtn").click(function () {
            openDialog("新增表单", "${basePath}sys/role/insert", "800px", "380px");
        });

        //查看
        $(document).on("click", ".seeBtn", function () {
            var id = $(this).attr("rid");
            openDialogView("查看表单", "${basePath}sys/role/see?id=" + id, "800px", "380px");
        });

        //修改
        $(document).on("click", ".updateBtn", function () {
            var id = $(this).attr("rid");
            openDialog("修改表单", "${basePath}sys/role/update?id=" + id, "800px", "380px");
        });

        //删除
        $(document).on("click", ".deleteBtn", function () {
            var id = $(this).attr("rid");
            var code = $(this).attr("code");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/role/delete?id=" + id + "&code=" + code,
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
            };
            confirmx("你确定删除吗？", fun);
        });

        //批量删除
        $("#deleteBatchBtn").click(function () {
            var ids = "";
            var codes = "";
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/role/deleteByIdsAndCodes",
                    data: {"ids": ids, "codes": codes},
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
                    ids = ids + ($(this).val()) + ","
                    codes = codes + ($(this).attr("code")) + ","
                }
            });
            if (ids == "") {
                top.layer.msg("请选择要删除的数据!");
                return false;
            } else {
                ids = ids.substr(0, ids.length - 1);
                codes = codes.substr(0, codes.length - 1);
                confirmx("你确定删除吗？", fun);
            }
        });

        //权限设置
        $(document).on("click", ".permBtn", function () {
            var code = $(this).attr("code");
            top.layer.open({
                type: 2,
                area: ['300px', '600px'],
                title: "选择菜单",
                maxmin: true, //开启最大化最小化按钮
                content: "${basePath}sys/role/roleResTree?code=" + code,
                btn: ['确定', '关闭'],
                yes: function (index, layero) {
                    var tree = layero.find("iframe")[0].contentWindow.tree;
                    var nodesIds = new Array();
                    var nodes = tree.getCheckedNodes(true);
                    for (var i = 0; i < nodes.length; i++) {
                        nodesIds[i] = nodes[i].id;
                    }
                    var res_ids = nodesIds.join(",");
                    //提交
                    $.ajax({
                        type: "POST",
                        url: "${basePath}sys/role/roleRes",
                        data: {
                            "roleCode": code,
                            "resIds": res_ids
                        },//参数
                        beforeSend: function () {
                            return loading();
                        },
                        success: function (rb) {
                            closeloading();
                            if (rb.code == 0) {
                                top.layer.msg(rb.msg);
                                top.layer.close(index);
                            } else {
                                top.layer.msg(rb.msg);
                            }
                        },
                        error: function () {
                            closeloading();
                        }
                    });
                },
                cancel: function (index) {
                    top.layer.close(index);
                }
            });
        });
    });
</script>
</body>
</html>
