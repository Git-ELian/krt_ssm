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
      							<span class="form-required">*</span>组名 
      						</label>
      					</td>
      					<td class="width-35"><input type="text" name="group" id="group" class="form-control"  required></td>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span class="form-required">*</span>任务名
      						</label>
      					</td>
      					<td class="width-35"><input type="text" name="name" id="name" class="form-control" required></td>
      				</tr>
      				<tr>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span class="form-required">*</span>cron表达式
      						</label>
      					</td>
      					<td class="width-35">
      						<div class="input-group">
								<input type="text" name="expression" id="expression" class="form-control" required>
								<span class="input-group-btn">
									<button class="btn btn-primary btn-flat" id="cronBtn" type="button"><i class="fa fa-cog"></i></button>
								</span>
							</div>
      					</td>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span class="form-required">*</span>类路径 
      						</label>
      					</td>
      					<td class="width-35">
      						<input type="text" name="beanClass" id="beanClass" class="form-control" required>
      						<span class="help-inline">与springId选填一个</span>
      					</td>
      				</tr>
      				<tr>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span class="form-required">*</span>springId
      						</label>
      					</td>
      					<td class="width-35">
							<input type="text" name="springId" id="springId" class="form-control" required>
							<span class="help-inline">spring管理的bean名称</span>
      					</td>
      					<td class="active width-15">
      						<label class="pull-right">
      							<span class="form-required">*</span>方法名
      						</label>
      					</td>
      					<td class="width-35">
      							<input type="text" name="method" id="method" class="form-control"  required>
      							<span class="help-inline">执行任务的方法名</span>
						</td>
      				</tr>
      				<tr>
      					<td class="active width-15">
      						<label class="pull-right">描述</label>
      					</td>
      					<td colspan="3">
      						<textarea rows="2" name="description" class="form-control"></textarea>
      					</td>
      				</tr>
      			</table>
      		</form>
      	 </div>
    </div><!-- ./wrapper -->
    
    <script type="text/javascript">
		$("#cronBtn").click(function(){
			top.layer.open({
				type: 2, 
				title:"生成con表达式",
				area: ['820px',  '600px'],
			    content: '${basePath}sys/quartzJob/quartzCron',
			    btn: ['确定', '关闭'],
			    yes: function(index, layero){ //或者使用btn1
			    	var cron = layero.find("iframe")[0].contentWindow.$("#cron").val();
	            	$("#expression").val(cron);
	            	validateForm.form();
	                top.layer.close(index);
			    },cancel: function(index){ //或者使用btn2
			    	 top.layer.close(index);
			    }
			});
		});
	</script>
    <script type="text/javascript">
	    var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
			  $.ajax({   
			         type: "POST",
			         url:"${basePath}sys/quartzJob/insert",
			         data:$('#krtForm').serialize(),// 要提交的表单
			         beforeSend:function(){
			         	return  validateForm.form() && loading('');
			         },
			         success: function(rb) {
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
			         error: function(){
			        	 closeloading();
			         }
			      });
		}
        $(function () {
            validateForm= $("#krtForm").validate({
                rules: {
                    name: {
                        remote: {
                            url: "${basePath}sys/quartzJob/checkName",     //后台处理程序
                            type: "post",               //数据发送方式
                            dataType: "json",           //接受数据格式
                            data: {                     //要传递的数据
                                name: function() {
                                    return $("#name").val();
                                },
                                group: function() {
                                    return $("#group").val();
                                }
                            }
                        }
                    },
                },
                messages: {
                    name: {remote: "组名和任务名组合重复"}
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-group")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            //立即验证
            validateForm.form();
        });
    </script>
  </body>
</html>
