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
                            <span class="form-required">*</span>流水号编码
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="code" id="code" value="${number.code}" class="form-control" required></td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>流水号名称
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="name" id="name" value="${number.name}" class="form-control" required></td>
                    </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                        前缀
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="prefix" id="prefix" value="${number.prefix}" class="form-control"></td>
                    <td class="active width-15">
                        <label class="pull-right">
                        后缀
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="suffix" id="suffix" value="${number.suffix}" class="form-control"></td>
                    </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>流水号
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="num" id="num" value="${number.num}" class="form-control"></td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>流水号长度
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="numLength" id="numLength" value="${number.numLength}" class="form-control" required></td>
                    </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                        日期格式化
                        </label>
                    </td>
                    <td class="width-35">
                        <select  name="dateFormat" id="dateFormat" class="form-control">
                            <option value="">==请选择==</option>
                            <option value="%Y%m%d%H%i%s"  ${number.dateFormat=='%Y%m%d%H%i%s'?'selected':''}>年月日时分秒</option>
                            <option value="%Y%m%d%H%i" ${number.dateFormat=='%Y%m%d%H%i'?'selected':''}>年月日时分</option>
                            <option value="%Y%m%d" ${number.dateFormat=='%Y%m%d'?'selected':''}>年月日</option>
                            <option value="%Y%m" ${number.dateFormat=='%Y%m'?'selected':''}>年月</option>
                            <option value="%Y" ${number.dateFormat=='%Y'?'selected':''}>年</option>
                        </select>
                    </td>
                    <td class="active width-15"></td>
                    <td></td>
                    </tr>
            </table>
            <!-- 参数 -->
            <input type="hidden" name="id" id="id" value="${number.id}">
        </form>
    </div>
</div><!-- ./wrapper -->
<script type="text/javascript">

    var validateForm;

    function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        $.ajax({
            type: "POST",
            url:"${basePath}sys/number/update",
            data:$('#krtForm').serialize(),// 要提交的表单
            beforeSend:function(){
                return  validateForm.form() && loading();
            },
            success: function(rb) {
                closeloading();
                if (rb.code == 0) {
                    top.layer.msg(rb.msg);
                    var index = top.layer.getFrameIndex(window.name); //获取窗口索引
                    refreshIframe();
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
        validateForm = $("#krtForm").validate({
            errorContainer: "#messageBox",
            errorPlacement: function(error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-group")){
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            },
            rules: {
                code: {
                    remote: {
                        url: "${basePath}sys/number/checkNumber",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {                     //要传递的数据
                            code: function () {
                                return $("#code").val();
                            },
                            id:function(){
                                return $("#id").val();
                            }
                        }
                    }
                }
            },
            messages: {
                code: {remote: "流水编号已存在"}
            }
        });
        //立即验证
        validateForm.form();
    });

</script>
</body>
</html>
