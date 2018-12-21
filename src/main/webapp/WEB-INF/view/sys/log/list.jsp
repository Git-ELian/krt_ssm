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
                        <div class="form-group">
                            <label for="username" class="control-label" style="padding:0 10px">用户账号</label>
                            <input type="text" class="form-control" placeholder="用户账号" id="username">
                        </div>
                        <div class="form-group">
                            <label for="description" class="control-label" style="padding:0 10px">操作内容</label>
                            <input type="text" class="form-control" placeholder="操作内容" id="description">
                        </div>
                        <div class="form-group">
                            <label for="type" class="control-label" style="padding:0 10px">日志类别</label>
                            <select class="form-control" id="type">
                                <option value="">==请选择==</option>
                                <option value="0">登录日志</option>
                                <option value="1">操作日志</option>
                                <option value="2">异常日志</option>

                            </select>
                        </div>
                        <div class="form-group">
                            <label for="useTime" class="control-label" style="padding:0 10px">耗时</label>
                            <select class="form-control" id="useTime">
                                <option value="">==请选择==</option>
                                <option value="10000">大于10秒</option>
                                <option value="5000">大于5秒</option>
                                <option value="3000">大于4秒</option>
                                <option value="3000">大于3秒</option>
                                <option value="2000">大于2秒</option>
                                <option value="1000">大于1秒</option>
                            </select>
                        </div>
                        <div class="form-group">
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
                        <shiro:hasPermission name="sys:log:deleteAll">
                            <button type="button" class="btn btn-sm btn-danger" id="deleteBtn">
                                <i class="fa fa-trash fa-btn"></i>清空所有日志
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th></th>
                            <th>用户账号</th>
                            <th>操作内容</th>
                            <th>操作类别</th>
                            <th>请求URL</th>
                            <th>请求ip</th>
                            <th>耗时(毫秒)</th>
                            <th>操作时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div><!-- /.box-body -->
        </div>
    </section><!-- /.content -->
</div><!-- ./wrapper -->
<!-- page script -->
<script type="text/javascript">
    var datatable;
    function initDatatable() {
        datatable = $('#datatable').DataTable({
            ordering: true,
            order: [[7, 'desc']],
            "ajax": {
                "url": "${basePath}sys/log/list",
                "type": "post",
                "data": function (d) {
                    d.username = $('#username').val();
                    d.description = $('#description').val();
                    d.type = $('#type').val();
                    d.useTime = $("#useTime").val();
                    d.orderName = camel2Underline(d.columns[d.order[0].column].data);
                    d.orderType = d.order[0].dir;
                }
            },
            "columns": [
                {
                    "class": 'details-control',
                    "orderable": false,
                    "data": null,
                    "defaultContent": ''
                },
                {"data": "username","orderable": false},
                {"data": "description","orderable": false},
                {
                    "data": "type",
                    "orderable": false,
                    render: function (data, type, row) {
                        if (data == '0') {
                            return '<span class="badge bg-yellow">登录日志</span>';
                        } else if (data == '1') {
                            return '<span class="badge bg-green">操作日志</span>';
                        } else if (data == '2') {
                            return '<span class="badge bg-red">异常日志</span>';
                        }
                    }
                },
                {"data": "requestUrl","orderable": false},
                {"data": "requestIp","orderable": false},
                {"data": "useTime"},
                {"data": "insertTime"}
            ]
        });
    }

    /**
     * 格式化
     * @param d
     * @returns {string}
     */
    function formatData(d) {
        var type = "";
        if (d.type == '0') {
            type = '登录日志';
        } else if (d.type == '1') {
            type = '操作日志';
        } else if (d.type == '2') {
            type = '异常日志';
        }
        var result = '<b>用户名:</b>' + d.username + '<br/>'
            + '<b>请求URL:</b>' + d.requestUrl + '<br/>'
            + '<b>请求参数:</b>' + d.requestParams + '<br/>'
            + '<b>请求方式:</b>' + d.requestMethod + '<br/>'
            + '<b>请求方法全称:</b>' + d.requestMethodName + '<br/>'
            + '<b>请求IP:</b>' + d.requestIp + '<br/>'
            + '<b>描述:</b>' + d.description + '<br/>'
            + '<b>耗时:</b>' + d.useTime + '<br/>'
            + '<b>日志类别:</b>' + type + '<br/>'
            + '<b>异常编码:</b>' + d.exceptionCode + '<br/>'
            + '<b>异常详情:</b>' + d.exceptionDetail + '<br/>'
            + '<b>客户端信息:</b>' + d.userAgent + '<br/>';
        return result;
    }

    $(function () {
        //pace监听ajax
        $(document).ajaxStart(function () {
            Pace.restart();
        });
        initDatatable();

        //详情事件
        $('#datatable tbody').on('click', 'td.details-control', function () {
            var tr = $(this).closest('tr');
            var row = datatable.row(tr);
            if (row.child.isShown()) {
                row.child.hide();
                tr.removeClass('details');
            } else {
                var result = formatData(row.data());
                row.child(result).show();
                tr.addClass('details');
            }
        });

        $("#searchBtn").on('click', function () {
            datatable.ajax.reload();
        });

        //删除
        $("#deleteBtn").click(function () {
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/log/deleteAll",
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
            confirmx("你确定清空系统日志吗？", fun);
        });

    });
</script>
</body>
</html>
