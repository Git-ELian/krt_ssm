<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="common/common.jsp" %>
    <!-- theme -->
    <link rel="stylesheet" href="${basePath}static/assets/css/skins/_all-skins.min.css">
    <!-- tab -->
    <link rel="stylesheet" href="${basePath}static/assets/css/tabcss.css">
</head>
<body class="hold-transition skin-blue sidebar-mini fixed" style="overflow:hidden">
<div class="wrapper">
    <header class="main-header">
        <!-- Logo -->
        <a href="welcome2.html" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b> 后台</b></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>科睿特通用管理后台</b></span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <div class="navbar-custom-menu" id="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="javascript:void(0)" id="updatePswBtn"><i class="fa fa-edit"></i><span> 修改密码</span></a>
                    </li>
                    <shiro:hasPermission name="sys:cache:deleteAll">
                        <li>
                            <a href="javascript:void(0)" id="deleteCache"><i class="fa fa-trash"></i><span> 清空缓存</span></a>
                        </li>
                    </shiro:hasPermission>
                    <li>
                        <a href="javascript:void(0)" data-toggle="control-sidebar"><i class="fa fa-gears"></i><span> 主题设置</span></a>
                    </li>
                    <li>
                        <a href="${basePath}logout"><i class="fa fa-sign-out"></i><span> 退出系统</span></a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- Sidebar user panel -->
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="${basePath}static/assets/img/user-128x128.jpg" class="img-circle" alt="User Image">
                </div>
                <div class="pull-left info">
                    <p>${currentUser.name}</p>
                    <a href="#"><i class="fa fa-circle text-success"></i> 欢迎你</a>
                </div>
            </div>
            <!-- 左侧菜单-->
            <!-- Sidebar Menu -->
            <ul class="sidebar-menu" id="menu">
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!--Tab菜单-->
        <div class="content-tabs">
            <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i></button>
            <nav class="page-tabs J_menuTabs">
                <div class="page-tabs-content">
                    <a href="javascript:;" class="active J_menuTab" data-id="index_v1.html">首页</a>
                </div>
            </nav>
            <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i></button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span></button>
                <ul role="menu" class="dropdown-menu dropdown-menu-right">
                    <li class="J_tabShowActive">
                        <a>定位当前选项卡</a>
                    </li>
                    <li class="divider"></li>
                    <li class="J_tabCloseAll">
                        <a>关闭全部选项卡</a>
                    </li>
                    <li class="J_tabCloseOther">
                        <a>关闭其他选项卡</a>
                    </li>
                </ul>
            </div>
            <button class="roll-nav roll-right J_tabFullScreen"><i class="fa fa-arrows-alt"></i></button>
        </div>
        <div class="J_mainContent" id="content-main" style="width: 100%">
            <iframe class="J_iframe" src="${basePath}welcome" name="iframe0" width="100%" height="100%" frameborder="0"></iframe>
        </div>
    </div>
    <!-- /.content-wrapper -->
    <!-- 版本信息Main Footer -->
    <footer class="main-footer">
        <!-- To the right -->
        <div class="pull-right hidden-xs">
            版本号: v1.0
        </div>
        <!-- Default to the left -->
        <strong>Copyright &copy; 2008-2018 <a href="http://www.cnkrt.com/" target="_blank">科睿特软件股份有限公司</a>.</strong> All rights reserved.
    </footer>
    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->
        <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
            <!-- Home tab content -->
            <div class="tab-pane" id="control-sidebar-home-tab"></div>
            <!-- /.tab-pane -->
        </div>
    </aside>
    <!-- /.control-sidebar -->
    <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
<!-- Slimscroll -->
<script src="${basePath}static/assets/libs/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- AdminLTE App -->
<script src="${basePath}static/assets/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${basePath}static/assets/js/demo.js"></script>
<!-- tab 菜单 -->
<script src="${basePath}static/assets/js/contabs.min.js"></script>

<script>
    $(function () {
        //改变iframe高度
        $("#content-main").css("height", $(window).height() - 141);
        $(window).resize(function () {
            $("#content-main").css("height", $(window).height() - 141);
        });
        //获取菜单
        $.ajax({
            type: "POST",
            url: "${basePath}selectRoleRes",
            beforeSend: function () {
                return loading();
            },
            success: function (resList) {
                closeloading();
                //渲染菜单
                var menuHtml = '';
                for (var i = 0; i < resList.length; i++) {
                    var res = resList[i];
                    var icon = res.icon;
                    if (icon == null || icon == '') {
                        icon = "fa-link";
                    }
                    //获取第一级菜单
                    var menu;
                    var menu2 = '';
                    var child1 = res.child;
                    if (child1.length > 0) {
                        menu = '<li class="treeview"><a href="${basePath}' + res.url + '"><i class="fa ' + icon + '"></i> <span>' + res.name + '</span> <i class="fa fa-angle-left pull-right"></i></a>';
                    } else {
                        menu = '<li><a href="${basePath}' + res.url + '" index="' + res.id + '" class="J_menuItem"><i class="fa ' + icon + '"></i> <span>' + res.name + '</span></a>';
                    }
                    for (var j = 0; j < child1.length; j++) {
                        var cres = child1[j];
                        var icon2 = cres.icon;
                        if (icon2 == null || icon2 == '') {
                            icon2 = "fa-circle-o";
                        }
                        var child2 = cres.child;
                        //第二级
                        if (child2.length > 0) {
                            var iconc = '<i class="fa fa-angle-left pull-right"></i>';
                            menu2 = menu2 + '<li><a href="#"><i class="fa ' + icon2 + '"></i>' + cres.name + iconc + '</a>';
                        } else {
                            if (cres.target == '_blank') {
                                menu2 = menu2 + '<li><a href="${basePath}' + cres.url + '" target="_blank"><i class="fa ' + icon2 + '"></i>' + cres.name + '</a>';
                            } else {
                                menu2 = menu2 + '<li><a href="${basePath}' + cres.url + '" index="' + cres.id + '" class="J_menuItem"><i class="fa ' + icon2 + '"></i>' + cres.name + '</a>';
                            }

                        }
                        //第三级
                        var menu3 = '';
                        for (var k = 0; k < child2.length; k++) {
                            var ccres = child2[k];
                            var icon3 = ccres.icon;
                            if (icon3 == null || icon3 == '') {
                                icon3 = "fa-circle-o";
                            }
                            menu3 = menu3 + '<li><a href="${basePath}' + ccres.url + '" index="' + ccres.id + '" class="J_menuItem"><i class="fa ' + icon3 + '"></i>' + ccres.name + '</a>';

                        }
                        if (menu3 != '') {
                            menu3 = '<ul class="treeview-menu" style="display: none;">' + menu3 + '</ul>';
                        }
                        menu2 = menu2 + menu3 + '</li>';
                    }
                    menu = menu + '<ul class="treeview-menu">' + menu2 + '</ul></li>';
                    menuHtml = menuHtml + menu;
                }
                $("#menu").html(menuHtml);
                $('.J_menuItem').on('click', menuItem);
            },
            error: function () {
                closeloading();
            }
        });

        //修改密码
        $("#updatePswBtn").click(function () {
            openDialog("修改密码", "${basePath}sys/user/updatePsw", "800px", "330px");
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