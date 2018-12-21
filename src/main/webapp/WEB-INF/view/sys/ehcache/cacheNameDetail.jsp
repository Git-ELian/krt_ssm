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
                        <button type="button" class="btn btn-primary btn-sm" onclick="window.history.back();"><i class="fa fa-mail-reply fa-btn"></i>返回</button>
                    </div>
                    <table id="datatable" class="table table-striped table-bordered table-hover table-krt">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>缓存对象名称</th>
                            <th>命中次数</th>
                            <th>大小</th>
                            <th>最后创建/更新时间</th>
                            <th>最后访问时间</th>
                            <th>过期时间</th>
                            <th>timeToIdle(秒)</th>
                            <th>timeToLive(秒)</th>
                            <th>version</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${caches}" var="cache" varStatus="status">
                            <tr>
                                <td>${status.index+1}</td>
                                <td>${cache.key}</td>
                                <td>${cache.hitCount}</td>
                                <td>${cache.size}</td>
                                <td>${cache.latestOfCreationAndUpdateTime}</td>
                                <td>${cache.lastAccessTime}</td>
                                <td>${cache.expirationTime}</td>
                                <td>${cache.timeToIdle}</td>
                                <td>${cache.timeToLive}</td>
                                <td>${cache.version}</td>
                                <td>
                                    <shiro:hasPermission name="sys:cache:cacheNameDetail">
                                        <button class="btn btn-xs btn-info seeBtn" cacheValue="${cache.objectValue}"><i class="fa fa-eye fa-btn"></i>查看Value</button>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="sys:cache:delete">
                                        <button class="btn btn-xs btn-danger deleteBtn" cacheName="${cacheName}" key="${cache.key}"><i class="fa fa-trash fa-btn"></i>删除</button>
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
        <!-- /.col -->
    </section>
    <!-- /.content -->
</div>
<!-- ./wrapper -->

<script type="text/javascript">
    $(function () {
        $(".seeBtn").click(function () {
            var cacheValue = $(this).attr("cacheValue");
            top.layer.alert(cacheValue);
        })
        //删除
        $(".deleteBtn").click(function () {
            var cacheName = $(this).attr("cacheName");
            var key = $(this).attr("key");
            var fun = function () {
                $.ajax({
                    type: "POST",
                    url: "${basePath}sys/ehcache/delete",
                    data: {"cacheName": cacheName, "key": key},
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
    });
</script>
</body>
</html>
