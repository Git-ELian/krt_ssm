<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../common/common.jsp" %>
  </head>
  <body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
      	<div class="form-box">
      		<form action="#" id="krtForm" class="form-horizontal">
      			<table class="table table-bordered table-krt">
      				<tr>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span class="form-required">*</span>用户账号
      						</label>
      					</td>
      					<td class="width-35">
							<input type="text" name="username" id="username" value="${user.username}" class="form-control" readonly="readonly" rangelength="2,20" required>
						</td>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span class="form-required">*</span>用户姓名
      						</label>
      					</td>
      					<td class="width-35">
							<input type="text" name="name" id="name" value="${user.name}" class="form-control" rangelength="1,10" required readonly="readonly">
						</td>
      				</tr>
      				<tr>
      					<td class="active width-15">
      						<label class="pull-right">
      							密码
      						</label>
      					</td>
      					<td class="width-35">
      						<input type="password" name="password" id="password" class="form-control" readonly="readonly">
      						<span class="help-inline">密码不填写，则保持原密码不变</span>
      					</td>
      					<td class="active width-15">
      						<label class="pull-right">
      							重复密码
      						</label>
      					</td>
      					<td class="width-35">
							<input type="password" name="password2" id="password2" class="form-control" equalTo="#password" readonly="readonly">
						</td>
      				</tr>
      				<tr>
      					<td class="active width-15">
      						<label class="pull-right">所属角色</label>
      					</td>
      					<td class="width-35">
      						<select name="roleCode" class="form-control" required disabled>
      							<option value="">==请选择==</option>
								<c:forEach items="${roleList}" var="role">
									<c:if test="${role.code!='admin'}">
										<option value="${role.code}" ${role.code==user.roleCode?"selected":""}>${role.name}</option>
									</c:if>
								</c:forEach>
      						</select>
      					</td>
						<td class="active width-15">
							<label class="pull-right">组织机构</label>
						</td>
						<td class="width-35">
							<input type="text" name="organizationName" value="${user.organizationName}" id="organizationName" class="form-control" readonly="readonly">
						</td>
      				</tr>
      			</table>
      			<!-- 参数 -->
      			<input type="hidden" name="id" id="id" value="${user.id}">
      		</form>
      	 </div>
    </div><!-- ./wrapper -->
  </body>
</html>
