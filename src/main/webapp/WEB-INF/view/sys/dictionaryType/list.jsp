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
        <div class="search" id="search">
            <div class="panel-body">
                <div class="col-sm-12">
                    <form class="form-inline" action="">
                        <div class="form-group" style="margin:5px">
                            <label for="code" class="control-label">字典编码</label>
                            <input type="text" class="form-control" placeholder="字典编码" id="code">
                        </div>
                        <div class="form-group" style="margin:5px">
                            <label for="name" class="control-label">字典名称</label>
                            <input type="text" class="form-control" placeholder="字典名称" id="name">
                        </div>
                        <div class="form-group" style="margin:5px">
                            <div class="text-center">
                                <button type="button" id="searchBtn" class="btn btn-primary btn-sm"><i class="fa fa-search fa-btn"></i>搜索</button>

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
                        <shiro:hasPermission name="sys:dictionary:delete">
                            <button type="button" class="btn btn-sm btn-danger" id="deleteBatchBtn">
                                <i class="fa fa-trash fa-btn"></i>批量删除
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" class="iCheck"></th>
                            <th>字典编码</th>
                            <th>字典名称</th>
                            <th>备注</th>
                            <th>排序</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                        <tr>
                            <td></td>
                            <td>
                                <input type="text" name="code" id="code0" class="form-control input-150">
                            </td>
                            <td>
                                <input type="text" name="name" id="name0" class="form-control input-150">
                            </td>
                            <td>
                                <input type="text" name="remark" id="remark0" class="form-control input-150">
                            </td>
                            <td>
                                <input type="text" name="sortNo" id="sortNo0" class="form-control input-150">
                            </td>
                            <td>
                                <shiro:hasPermission name="sys:dictionaryType:insert">
                                    <button class="btn btn-xs btn-success" id="insertBtn">
                                        <i class="fa fa-plus fa-btn"></i>新增
                                    </button>
                                </shiro:hasPermission>
                            </td>
                        </tr>
                    </table>
                </div>
            </div><!-- /.box-body -->
        </div>
    </section><!-- /.content -->
</div><!-- ./wrapper -->
<!-- page script -->
<script language="javascript" type="text/javascript">
    var datatable;
    function initDatatable() {
        datatable = $('#datatable').DataTable({
            ordering: true,
            order: [[4, 'asc']],
            "ajax": {
                "url": "${basePath}sys/dictionaryType/list",
                "type": "post",
                "data": function (d) {
                    d.code = $('#code').val();
                    d.name = $('#name').val();
                    d.orderName = camel2Underline(d.columns[d.order[0].column].data);
                    d.orderType = d.order[0].dir;
                }
            },
            "columns": [
                {
                    "data": "id",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="checkbox" class="iCheck check" value="' + data + '" code="' + row.code + '">';
                    }
                },
                {
                    "data": "code",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="text" name="code" value="' + data + '" id="code' + row.id + '" class="form-control input-150">';
                    }
                },
                {
                    "data": "name",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="text" name="name" value="' + data + '" id="name' + row.id + '"  class="form-control input-150">';
                    }
                },
                {
                    "data": "remark",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="text" name="remark" value="' + data + '" id="remark' + row.id + '"  class="form-control input-150">';
                    }
                },
                {
                    "data": "sortNo",
                    render: function (data, type, row) {
                        return '<input type="text" name="sortNo" value="' + data + '" id="sortNo' + row.id + '"  class="form-control input-150">';
                    }
                },
                {
                    "data": "id",
                    "orderable": false,
                    "render": function (data, type, row) {
                        return '<input type="hidden" row="id" value="' + data + '">'
                            + '<shiro:hasPermission name="sys:dictionary:list">'
                            + '<button class="btn btn-xs btn-success dicBtn" rid="' + data + '" code="' + row.code + '">'
                            + '<i class="fa  fa-list fa-btn"></i>键值管理'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:dictionaryType:update">'
                            + '<button class="btn btn-xs btn-warning updateBtn" rid="' + data + '">'
                            + '<i class="fa fa-edit fa-btn"></i>修改'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:dictionaryType:delete">'
                            + '<button class="btn btn-xs btn-danger deleteBtn" rid="' + data + '" code="' + row.code + '">'
                            + '<i class="fa fa-trash fa-btn"></i>删除'
                            + '</button>'
                            + '</shiro:hasPermission>';
                    }
                }
            ]
        });
    }

    $(document).ready(function () {

        //初始化datatable
        initDatatable();

        $("#searchBtn").on('click', function () {
            datatable.ajax.reload();
        });

        //新增
        $("#insertBtn").click(function () {
            var code = $("#code0").val();
            if (code == null || code == '') {
                top.layer.msg("字典编码不可为空！");
                return false;
            }
            var name = $("#name0").val();
            if (name == null || name == '') {
                top.layer.msg("字典名称不可为空！");
                return false;
            }
            var sortNo = $("#sortNo0").val();
            if (sortNo == null || sortNo == '') {
                top.layer.msg("排序不可为空！");
                return false;
            }
            $.ajax({
                type: "POST",
                url: "${basePath}sys/dictionaryType/insert",
                dataType: "json",
                data: {"code": $("#code0").val(), "name": $("#name0").val(), "remark": $("#remark0").val(), "sortNo": $("#sortNo0").val()},
                beforeSend: function () {
                    return loading();
                },
                success: function (rb) {
                    closeloading();
                    if (rb.code == 0) {
                        top.layer.msg(rb.msg);
                        $("#code0").val("");
                        $("#name0").val("");
                        $("#remark0").val("");
                        $("#sortNo0").val("");
                        refreshTable(datatable);
                    } else {
                        top.layer.msg(rb.msg);
                    }
                },
                error: function () {
                    closeloading();
                }
            });
        });

        //修改
        $(document).on("click", ".updateBtn", function () {
            var id = $(this).attr("rid");
            var code = $("#code" + id).val();
            if (code == null || code == '') {
                top.layer.msg("字典编码不可为空！");
                return false;
            }
            var name = $("#name" + id).val();
            if (name == null || name == '') {
                top.layer.msg("字典名称不可为空！");
                return false;
            }
            var sortNo = $("#sortNo" + id).val();
            if (sortNo == null || sortNo == '') {
                top.layer.msg("排序不可为空！");
                return false;
            }
            $.ajax({
                type: "POST",
                url: "${basePath}sys/dictionaryType/update",
                dataType: "json",
                data: {"id": id, "code": $("#code" + id).val(), "name": $("#name" + id).val(), "remark": $("#remark" + id).val(), "sortNo": $("#sortNo" + id).val()},
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

        //删除
        $(document).on("click", ".deleteBtn", function () {
            var id = $(this).attr("rid");
            var code = $(this).attr("code");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/dictionaryType/delete?id=" + id + "&code=" + code,
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
            confirmx("你确定删除吗？", fun);
        });

        //批量删除
        $("#deleteBatchBtn").click(function () {
            var ids = "";
            var codes = "";
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/dictionaryType/deleteByIdsAndCodes",
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

        //键值管理
        $(document).on("click", ".dicBtn", function () {
            var type = $(this).attr("code");
            window.location.href = "${basePath}sys/dictionary/list?pid=0&type=" + type;
        });
    });
</script>
</body>
</html>
