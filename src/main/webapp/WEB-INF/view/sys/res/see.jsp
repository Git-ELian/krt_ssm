<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common_form.jsp" %>
</head>
<body>
<div class="wrapper">
    <div class="form-box">
        <form action="#" id="krtForm" class="form-horizontal">
            <table class="table table-bordered table-krt">
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            上级菜单
                        </label>
                    </td>
                    <td class="width-35">
                        <div class="input-group">
                            <input type="text" name="pname" id="pname" value="${pResMap.name}" class="form-control" readonly="readonly">
                        </div>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>名称
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="name" id="name" value="${res.name}" class="form-control" rangelength="1,50" required>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            链接
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="url" id="url" value="${res.url}" class="form-control">
                        <span class="help-inline">点击菜单跳转的页面,按钮为空</span>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            权限标志
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="permission" id="permission" value="${res.permission}"
                               class="form-control">
                        <span class="help-inline">控制器中定义的权限标识<br/>如：@RequiresPermissions("权限标识")</span>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            图标
                        </label>
                    </td>
                    <td class="width-35">
                        <i id="iconIcon" class="fa ${res.icon==''?'icon-hide':res.icon}"></i>
                        <span id="iconIconLabel">${res.icon==''?'无':res.icon}</span>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            类别
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="radio" name="type" value="url" class="i-checks" ${res.type=='url'?'checked':''}> 菜单
                        <input type="radio" name="type" value="button" class="i-checks" ${res.type=='button'?'checked':''}> 按钮
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            目标
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="target" id="target" class="form-control" value="${res.target}">
                        <span class="help-inline">链接打开的目标窗口，不填默认：mainFrame</span>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>排序
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="sortNo" id="sortNo" value="${res.sortNo}" class="form-control" digits="true" required>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">备注</label>
                    </td>
                    <td colspan="3">
                        <textarea rows="2" name="remark" class="form-control">${res.remark}</textarea>
                    </td>
                </tr>
            </table>
            <!-- 参数 -->
            <input type="hidden" name="id" value="${res.id}">
        </form>
    </div>
</div><!-- ./wrapper -->
</body>
</html>
