<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="common/common.jsp" %>
    <script type="text/javascript">
        if (self.location != top.location) {
            top.location.href = self.location.href;
        }
    </script>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="javascript:void(0)"><b>科睿特通用管理后台</b></a>
    </div><!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">欢迎登录系统</p>
        <div class="form-group has-feedback">
            <input type="text" class="form-control" id="username" placeholder="用户名">
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <input type="password" class="form-control" id="password" placeholder="密码">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <input type="text" class="form-control" id="verifyCode" name="verifyCode" placeholder="验证码">
            <span class="glyphicon glyphicon-warning-sign form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <img alt="验证码" id="verifyCodeUrl" src="<%=basePath%>captcha.jpg" onclick="changeImg();">
        </div>
        <div class="row">
            <div class="col-xs-8"></div><!-- /.col -->
            <div class="col-xs-4">
                <button type="submit" id="loginBtn" class="btn btn-primary btn-block btn-flat">登录</button>
            </div><!-- /.col -->
        </div>
    </div><!-- /.login-box-body -->
</div><!-- /.login-box -->
<script>
    $(function () {
        $("#loginBtn").click(function () {
            var username = $("#username").val().trim();
            var password = $("#password").val().trim();
            var verifyCode = $("#verifyCode").val().trim();
            if (username == '') {
                layer.msg("用户账号不可为空");
                return false;
            }
            if (password == '') {
                layer.msg("密码不可为空");
                return false;
            }
            if (verifyCode == '') {
                layer.msg("验证码不可为空");
                return false;
            }
            $.ajax({
                url: "${basePath}login",
                type: "POST",
                data: {"username": username, "password": password, "verifyCode": verifyCode},// 要提交的表单
                beforeSend: function () {
                    return loading();
                },
                success: function (rb) {
                    closeloading();
                    if (rb.code == 0) {
                        location.href = "${basePath}index";
                    } else {
                        layer.msg(rb.msg);
                        changeImg();
                    }
                },
                error: function () {
                    layer.msg('程序错误!');
                }
            });
        });
    });

    //刷新验证码
    function changeImg() {
        var imgSrc = $("#verifyCodeUrl");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }

    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        var urls = url.split("?");
        url = urls[0] + "?timestamp=" + timestamp;
        return url;
    }
</script>
</body>
</html>
