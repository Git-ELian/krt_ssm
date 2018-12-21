<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common_form.jsp" %>
</head>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <div class="form-box">
        <form action="#" id="krtForm" class="form-horizontal">
            <table class="table table-bordered table-krt">
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>角色名称
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="name" id="name" value="${role.name}" class="form-control" required>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>角色编码
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="code" id="code" value="${role.code}" class="form-control" required>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15"><label class="pull-right">是否启用</label>
                    </td>
                    <td class="width-35">
                        <select name="status" class="form-control">
                            <option value="0" ${role.status=='0'?'selected':''}>正常</option>
                            <option value="1" ${role.status=='1'?'selected':''}>禁用</option>
                        </select>
                        <span class="help-inline">正常代表角色可用，禁用表示该角色的用户都不可用</span>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>排序
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="sortNo" id="sortNo" class="form-control" digits="true" value="${role.sortNo}" required>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15"><label class="pull-right">备注</label>
                    </td>
                    <td colspan="3">
                        <textarea name="remark" rows="2" class="form-control">${role.remark}</textarea>
                    </td>
                </tr>
            </table>
            <!-- 参数 -->
            <input type="hidden" id="id" name="id" value="${role.id}">
        </form>
    </div>
</div>
<!-- ./wrapper -->
<script type="text/javascript">
    var validateForm;
    function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        $.ajax({
            type: "POST",
            url: "<%=basePath%>sys/role/update",
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
            rules: {
                name: {
                    remote: {
                        url: "<%=basePath%>sys/role/checkName",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {                     //要传递的数据
                            name: function () {
                                return $("#name").val();
                            },
                            id: function () {
                                return $("#id").val();
                            }
                        }
                    }
                },
                code: {
                    remote: {
                        url: "<%=basePath%>sys/role/checkCode",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {                     //要传递的数据
                            code: function () {
                                return $("#code").val();
                            },
                            id: function () {
                                return $("#id").val();
                            }
                        }
                    }
                },
            },
            messages: {
                name: {remote: "角色名已存在"},
                code: {remote: "角色编码已存在"}
            }
        });
        //立即验证
        validateForm.form();
    });
</script>
</body>
</html>
