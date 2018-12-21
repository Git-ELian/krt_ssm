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
                        <shiro:hasPermission name="oa:notice:insert">
                            <button title="添加" type="button" id="insertBtn" data-placement="left" data-toggle="tooltip" class="btn btn-success btn-sm">
                                <i class="fa fa-plus"></i> 添加
                            </button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="oa:notice:delete">
                            <button class="btn btn-sm btn-danger" id="deleteBatchBtn">
                                <i class="fa fa-trash fa-btn"></i>批量删除
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" class="iCheck"></th>
                            <th>图片</th>
                            <th>标题</th>
                            <th>作者</th>
                            <th>发布时间</th>
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
    </section>
    <!-- /.content -->
</div>
<!-- ./wrapper -->
<script type="text/javascript">
    var datatable;
    function initDatatable() {
        datatable = $('#datatable').DataTable({
            "dom": 'rt<"dataTables_page"<"col-sm-6 col-xs-12"il><"col-sm-6 col-xs-12"p>>',
            "lengthChange": true,//选择lenth
            "autoWidth": false,//自动宽度
            "searching": false,//搜索
            "processing": false,//loding
            "serverSide": true,//服务器模式
            "ordering": false,//排序
            "pageLength": 10,//初始化lenth
            "deferRender": true,
            "language": {
                "url": "${basePath}static/assets/libs/datatables/language/zh_cn.json"
            },
            "ajax": {
                "url": "${basePath}oa/notice/list",
                "type": "post",
                "data": function (d) {

                }
            },
            "columns": [
                {
                    "data": "id",
                    width: "10",
                    render: function (data, type) {
                        return '<input type="checkbox" class="iCheck check" value="' + data + '">';
                    }
                },
                {
                    "data": "img",
                    "render": function (data, type, row) {
                        return "<img src='" + data + "' class='attachment-img'/>";
                    }
                },
                {"data": "title"},
                {"data": "author"},
                {"data": "insertTime"},
                {
                    "data": "id",
                    "render": function (data, type, row) {
                        return '<shiro:hasPermission name="oa:notice:update">'
                            + '<button class="btn btn-xs btn-warning updateBtn" rid="' + row.id + '">'
                            + '<i class="fa fa-edit fa-btn"></i>修改'
                            + '</button>'
                            + '</shiro:hasPermission>'
                            + '<shiro:hasPermission name="oa:notice:delete">'
                            + '<button class="btn btn-xs btn-danger deleteBtn" rid="' + row.id + '">'
                            + '<i class="fa fa-trash fa-btn"></i>删除'
                            + '</button>'
                            + '</shiro:hasPermission>';
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

        $("#searchBtn").on('click', function () {
            datatable.ajax.reload();
        });

        //新增
        $("#insertBtn").click(function () {
            openDialog("新增表单", "${basePath}oa/notice/insert", "860px", "550px");
        });

        //修改
        $(document).on("click", ".updateBtn", function () {
            var id = $(this).attr("rid");
            openDialog("修改表单", "${basePath}oa/notice/update?id=" + id, "860px", "500px");
        });

        //删除
        $(document).on("click", ".deleteBtn", function () {
            var id = $(this).attr("rid");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}oa/notice/delete?id=" + id,
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
                    url: "${basePath}oa/notice/deleteByIds",
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
