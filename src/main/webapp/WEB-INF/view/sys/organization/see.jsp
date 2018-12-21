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
                            上级机构
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="pname" value="${organization.pname}" id="pname" class="form-control">
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            机构名称
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="name" id="name" class="form-control" value="${organization.name}" required>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            机构代码
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="code" id="code" class="form-control" value="${organization.code}" required></td>
                    <td class="active width-15">
                        <label class="pull-right">
                            机构类别
                        </label>
                    </td>
                    <td class="width-35">
                        <select name="type" id="type" class="form-control" disabled required>
                            <option value="">==请选择==</option>
                            <c:forEach items="${krt:dic('organization_type')}" var="type">
                                <option value="${type.code}"  ${organization.type==type.code?'selected':''}>${type.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            机构类型
                        </label>
                    </td>
                    <td class="width-35">
                        <select name="grade" id="grade" class="form-control" disabled required>
                            <option value="">==请选择==</option>
                            <c:forEach items="${krt:dic('organization_grade')}" var="grade">
                                <option value="${grade.code}" ${organization.grade==grade.code?'selected':''}>${grade.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            主要负责人
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="primaryMan" id="primaryMan" value="${organization.primaryMan}" class="form-control" >
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            副负责人
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="viceMan" id="viceMan" value="${organization.viceMan}" class="form-control">
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            联系人
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="linkMan"  id="linkMan" value="${organization.linkMan}" class="form-control"></td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            邮编
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="zipcode" id="zipcode" value="${organization.zipcode}" class="form-control"></td>
                    <td class="active width-15">
                        <label class="pull-right">
                            手机号码
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="phone" id="phone" value="${organization.phone}" class="form-control"></td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            邮箱
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="email" id="email" value="${organization.email}" class="form-control"></td>
                    <td class="active width-15">
                        <label class="pull-right">
                            区域信息
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="regionName" id="regionName" class="form-control" value="${organization.regionName}">
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            联系地址
                        </label>
                    </td>
                    <td colspan="3"><input type="text" name="address" id="address" value="${organization.address}" class="form-control"></td>
                </tr>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            备注
                        </label>
                    </td>
                    <td colspan="3">
                        <textarea type="text" name="remark" id="remark" cols="3"  class="form-control">${organization.remark}</textarea>
                    </td>
                </tr>
                <!-- 参数 -->
                <input type="hidden" name="id" id="id" value="${organization.id}">
            </table>
        </form>
    </div>
</div><!-- ./wrapper -->
</body>
</html>
