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
                        <div class="table-button">
                            <shiro:hasPermission name="sys:cache:deleteAll">
                                <button type="button" class="btn btn-sm btn-danger" id="deleteCache">
                                    <i class="fa fa-trash fa-btn"></i>清空缓存
                                </button>
                            </shiro:hasPermission>
                        </div>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>缓存名称</th>
                            <th>读取总命中率</th>
                            <th>读取命中次数</th>
                            <th>读取失效次数</th>
                            <th>内存中对象数</th>
                            <th>硬盘中对象数</th>
                            <th>内存中占用</th>
                            <th>硬盘中占用</th>
                            <th>详情</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="cache" varStatus="status">
                            <tr>
                                <td>${status.index+1}</td>
                                <td>${cache.cacheName}</td>
                                <td>${cache.cacheHitPercent}</td>
                                <td>${cache.cacheHitCount}</td>
                                <td>${cache.cacheMissCount}</td>
                                <td>${cache.localHeapCount}</td>
                                <td>${cache.localDiskCount}</td>
                                <td>${cache.localHeapSize}</td>
                                <td>${cache.localDiskSize}</td>
                                <td>
                                    <shiro:hasPermission name="sys:cache:cacheNameDetail">
                                        <button class="btn btn-xs btn-info seeBtn" cacheName="${cache.cacheName}"><i class="fa fa-eye fa-btn"></i>查看</button>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="sys:cache:delete">
                                        <button class="btn btn-xs btn-danger deleteBtn" cacheName="${cache.cacheName}"><i class="fa fa-trash fa-btn"></i>删除</button>
                                    </shiro:hasPermission>

                                </td>
                            </tr>
                        </c:forEach>
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

    $(function () {

        //查看
        $(document).on("click", ".seeBtn", function () {
            var cacheName = $(this).attr("cacheName");
            window.location.href = "${basePath}sys/ehcache/cacheNameDetail?cacheName=" + cacheName;
        });

        //删除
        $(document).on("click", ".deleteBtn", function () {
            var cacheName = $(this).attr("cacheName");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/ehcache/delete",
                    data: {"cacheName": cacheName},
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
            confirmx("你确定删除缓存吗？", fun);
        });

        //清空系统缓存
        $("#deleteCache").click(function () {
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/ehcache/deleteAll",
                    beforeSend: function () {
                        return loading();
                    },
                    success: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            top.layer.msg(rb.msg);
                        } else {
                            top.layer.msg(rb.msg);
                        }
                    },
                    error: function () {
                        closeloading();
                    }
                });
            }
            confirmx("你确定清空系统缓存吗？", fun);
        });
    });
</script>
</body>
</html>
