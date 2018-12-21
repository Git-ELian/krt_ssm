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
      							<span style="color:red">*</span>用户账号
      						</label>
      					</td>
      					<td class="width-35">${currentUser.username}</td>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span style="color:red">*</span>原密码
      						</label>
      					</td>
      					<td class="width-35">
							<input type="password" name="oldPassword" id="oldPassword" class="form-control" rangelength="6,20" required>
						</td>
      				</tr>
      				<tr>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span style="color:red">*</span>密码
      						</label>
      					</td>
      					<td class="width-35">
							<input type="password" name="password" id="password" class="form-control" rangelength="6,20"  required>
						</td>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span style="color:red">*</span>重复密码
      						</label>
      					</td>
      					<td class="width-35">
							<input type="password" name="password2" id="password2" class="form-control" equalTo="#password" rangelength="6,20" required>
						</td>
      				</tr>
      			</table>
      		</form>
      	 </div>
    </div><!-- ./wrapper -->
    <script type="text/javascript">
	    var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
			  $.ajax({   
			         type: "POST",
			         url:"${basePath}sys/user/updatePsw",
			         data:$('#krtForm').serialize(),// 要提交的表单
			         beforeSend:function(){
			         	return  validateForm.form() && loading('');
			         },
			         success: function(rb) {
			        	 closeloading();
			         	if(rb.code==0){
			         		top.layer.msg("操作成功,请退出系统重新登录！");
			         		top.window.location.href = "${basePath}logout";
			         		var index = top.layer.getFrameIndex(window.name); //获取窗口索引
			         		top.layer.close(index);
			     
			         	}else{
			         		top.layer.msg("操作失败");
			         	}
			         },
			         error: function(){
			        	 closeloading();
			         }
			      });
		}
    	$(function(){
    		validateForm= $("#krtForm").validate({
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
					oldPassword: {
						remote: {
						    url: "${basePath}sys/user/checkPsw",     //后台处理程序
						    type: "post",               //数据发送方式
						    dataType: "json",           //接受数据格式   
						    data: {                     //要传递的数据
						    	oldPassword: function() {
						            return $("#oldPassword").val();
						        }
						    }
					    }
    		        }
				},
				messages: {
					oldPassword: {remote: "原密码错误"}
				}
			});
    		//立即验证
    		validateForm.form();
    	});
    </script>
  </body>
</html>
