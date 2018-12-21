<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common_form.jsp" %>
</head>
<body>
<div class="wrapper">
    <div class="form-box">
        <table class="table table-bordered table-krt">
            <tr>
                <td class="active width-15">
                    <label class="pull-right">
                        <span class="form-required">*</span>角色名称
                    </label>
                </td>
                <td class="width-35">
                    <input type="text" name="roleName" id="name" value="${role.name}" class="form-control" required>
                </td>
                <td class="active width-15">
                    <label class="pull-right">
                        <span class="form-required">*</span>角色编码
                    </label>
                </td>
                <td class="width-35">
                    <input type="text" name="roleCode" id="code" value="${role.code}" class="form-control" required>
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
        <input type="hidden" name="id" value="${role.id}">
    </div>
</div>
</body>
</html>
