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
                    <!-- 参数 -->
                    <input type="hidden" name="pid" id="pid" value="${param.pid}">
                    <input type="hidden" name="type" id="type" value="${param.type}">
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
                        <c:if test="${fid!='-1'}">
                            <button type="button" class="btn btn-primary btn-sm" onclick="location.href='${basePath}sys/dictionary/list?pid=${fid}&type=${param.type}'"><i class="fa fa-mail-reply fa-btn"></i>返回上一级</button>
                        </c:if>
                        <c:if test="${fid=='-1'}">
                            <button type="button" class="btn btn-primary btn-sm" onclick="location.href='${basePath}sys/dictionaryType/list'"><i class="fa fa-mail-reply fa-btn"></i>返回上一级</button>
                        </c:if>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" class="iCheck"></th>
                            <th>字典编码</th>
                            <th>字典名称</th>
                            <th>字典类型</th>
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
                                <input type="text" name="type" id="type0" value="${param.type}" readonly="readonly" class="form-control input-150">
                            </td>
                            <td>
                                <input type="text" name="remark" id="remark0" class="form-control input-150">
                            </td>
                            <td>
                                <input type="text" name="sortNo" id="sortNo0" class="form-control input-150">
                            </td>
                            <td>
                                <!-- 参数 -->
                                <input type="hidden" name="pid" id="pid0" value="${param.pid}">
                                <shiro:hasPermission name="sys:dictionary:insert">
                                    <button class="btn btn-xs btn-primary" id="insertBtn">
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
</div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->
<!-- page script -->
<script type="text/javascript">
    var datatable;
    function initDatatable() {
        datatable = $('#datatable').DataTable({
            ordering: true,
            order: [[5, 'asc']],
            "ajax": {
                "url": "${basePath}sys/dictionary/list",
                "type": "post",
                "data": function (d) {
                    d.pid = $('#pid').val();
                    d.type = $('#type').val();
                    d.name = $('#name').val();
                    d.code = $('#code').val();
                    d.orderName = camel2Underline(d.columns[d.order[0].column].data);
                    d.orderType = d.order[0].dir;
                }
            },
            "columns": [
                {
                    "data": "id",
                    "orderable": false,
                    render: function (data, type, row, hang) {
                        return '<input type="checkbox" class="iCheck check" value="' + data + '">';
                    }
                },
                {
                    "data": "code",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="text" name="code" value="' + row.code + '" id="code' + row.id + '" class="form-control input-150">';
                    }
                },
                {
                    "data": "name",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="text" name="name" value="' + row.name + '" readonly="readonly" id="name' + row.id + '"  class="form-control input-150">';
                    }
                },
                {
                    "data": "type",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="text" name="type" value="' + row.type + '" readonly="readonly" id="type' + row.id + '"  class="form-control input-150">';
                    }
                },
                {
                    "data": "remark",
                    "orderable": false,
                    render: function (data, type, row) {
                        return '<input type="text" name="remark" value="' + row.remark + '" id="remark' + row.id + '"  class="form-control input-150">';
                    }
                },
                {
                    "data": "sortNo",
                    render: function (data, type, row) {
                        return '<input type="text" name="sortNo" value="' + row.sortNo + '" id="sortNo' + row.id + '"  class="form-control input-150">'
                            + '<input type="hidden" name="pid" value="' + row.pid + '" id="pid' + row.id + '"  class="form-control input-150">';
                    }
                },
                {
                    "data": "id",
                    "render": function (data, type, row) {
                        return '<input type="hidden" name="id" value="' + row.id + '">'
                            + '<shiro:hasPermission name="sys:dictionary:list">'
                            + '<button class="btn btn-xs btn-success dicBtn" rid="' + row.id + '" type="' + row.type + '">'
                            + '<i class="fa  fa-list fa-btn"></i>键值管理'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:dictionary:update">'
                            + '<button class="btn btn-xs btn-warning updateBtn" rid="' + row.id + '">'
                            + '<i class="fa fa-edit fa-btn"></i>修改'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="sys:dictionary:delete">'
                            + '<button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '">'
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
        //pace监听ajax
        $(document).ajaxStart(function () {
            Pace.restart();
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
                url: "${basePath}sys/dictionary/insert",
                data: "json",
                data: {
                    "pid": $("#pid0").val(),
                    "code": $("#code0").val(),
                    "name": $("#name0").val(),
                    "type": $("#type0").val(),
                    "remark": $("#remark0").val(),
                    "sortNo": $("#sortNo0").val()
                },
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
                url: "${basePath}sys/dictionary/update",
                data: "json",
                data: {
                    "id": id,
                    "code": $("#code" + id).val(),
                    "name": $("#name" + id).val(),
                    "pid": $("#pid" + id).val(),
                    "type": $("#type" + id).val(),
                    "remark": $("#remark" + id).val(),
                    "sortNo": $("#sortNo" + id).val()
                },
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
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/dictionary/delete",
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
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/dictionary/deleteByIds",
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
                    ids = ids + ($(this).val()) + ","
                }
            });
            if (ids == "") {
                top.layer.msg("请选择要删除的数据!");
                return false;
            } else {
                ids = ids.substr(0, ids.length - 1);
                confirmx("你确定删除吗？", fun);
            }
        });
        //键值管理
        $(document).on("click", ".dicBtn", function () {
            var type = $(this).attr("type");
            var pid = $(this).attr("rid");
            window.location.href = "${basePath}sys/dictionary/list?pid=" + pid + "&type=" + type;
        });
    });
</script>
</body>
</html>
