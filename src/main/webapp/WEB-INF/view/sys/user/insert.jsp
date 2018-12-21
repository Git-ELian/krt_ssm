<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common_form.jsp" %>
</head>
<body>
<div class="wrapper">
    <div class="form-box" style="margin: 10px;">
        <form action="#" id="krtForm" class="form-horizontal">
            <table class="table table-bordered table-krt">
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>用户账号
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="username" id="username" class="form-control"  isUserName="true" required>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>用户姓名
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="name" id="name" class="form-control" rangelength="1,10" required>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>密码
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="password" name="password" id="password" class="form-control" rangelength="6,20" required>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>重复密码
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="password" name="password2" id="password2" class="form-control" equalTo="#password" rangelength="6,20" required>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right"><span class="form-required">*</span>所属角色</label>
                    </td>
                    <td class="width-35">
                        <select name="roleCode" class="form-control"  required>
                            <option value="">==请选择==</option>
                            <c:forEach items="${roleList}" var="role">
                                <c:if test="${role.code!='admin'}">
                                    <option value="${role.code}">${role.name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">组织机构</label>
                    </td>
                    <td class="width-35">
                        <div class="input-group">
                            <input type="text" name="organizationName" value="${user.organizationName}" id="organizationName" class="form-control" readonly="readonly">
                            <span class="input-group-btn">
									<button class="btn btn-primary btn-flat" id="organizationTreeBtn" type="button"><i class="fa fa-search"></i></button>
								</span>
                            <!-- 参数 -->
                            <input type="hidden" name="organizationId" id="organizationId" value="${user.organizationId}" class="form-control">
                            <input type="hidden" name="organizationCode" id="organizationCode" value="${user.organizationCode}" class="form-control">
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div><!-- ./wrapper -->

<script type="text/javascript">
    var validateForm;

    function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        $.ajax({
            type: "POST",
            url: "${basePath}sys/user/insert",
            data: $('#krtForm').serialize(),// 要提交的表单
            beforeSend: function () {
                return validateForm.form() && loading();
            },
            success: function (rb) {
                closeloading();
                if (rb.code == 0) {
                    top.layer.msg(rb.msg);
                    var index = top.layer.getFrameIndex(window.name); //获取窗口索引
                    refreshTable();
                    top.layer.close(index);
                } else {
                    top.layer.msg(rb.msg);
                }
            },
            error: function () {
                closeloading();
            }
        });
    }
    $(function () {
        validateForm = $("#krtForm").validate({
            errorContainer: "#messageBox",
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-group")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            },
            rules: {
                username: {
                    remote: {
                        url: "${basePath}sys/user/checkUsername",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {                     //要传递的数据
                            username: function () {
                                return $("#username").val();
                            }
                        }
                    }
                }
            },
            messages: {
                username: {remote: "用户名已存在"}
            }
        });
        //立即验证
        validateForm.form();
        $("#organizationTreeBtn").click(function () {
            top.layer.open({
                type: 2,
                area: ['300px', '450px'],
                title: "选择机构",
                maxmin: true, //开启最大化最小化按钮
                content: "${basePath}sys/organization/organizationTreeUI?id=" + $("#pid").val(),
                btn: ['确定', '关闭'],
                yes: function (index, layero) {
                    var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                    var nodes = tree.getSelectedNodes();
                    if (nodes == null) {
                        top.layer.msg("请选择机构");
                    } else {
                        $("#organizationName").val(nodes[0].name);
                        $("#organizationCode").val(nodes[0].code);
                        $("#organizationId").val(nodes[0].id);
                        top.layer.close(index);
                    }
                },
                cancel: function () {
                    top.layer.close(layer_window);
                }
            });
        });
    });
</script>
</body>
</html>
