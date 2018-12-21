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
                        <div class="input-group">
                            <input type="text" name="pname" value="${organization.pname}" id="pname" class="form-control" readonly="readonly">
                            <span class="input-group-btn">
									<button class="btn btn-primary btn-flat" id="organizationTreeBtn" type="button"><i class="fa fa-search"></i></button>
								</span>
                            <!-- 参数 -->
                            <input type="hidden" name="pid" id="pid" value="${organization.pid==null?'0':organization.pid}" class="form-control">
                        </div>
                    </td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>机构名称
                        </label>
                    </td>
                    <td class="width-35">
                        <input type="text" name="name" id="name" class="form-control" value="${organization.name}" required>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>机构代码
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="code" id="code" class="form-control" value="${organization.code}" required></td>
                    <td class="active width-15">
                        <label class="pull-right">
                            <span class="form-required">*</span>机构类别
                        </label>
                    </td>
                    <td class="width-35">
                        <select name="type" id="type" class="form-control" required>
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
                            <span class="form-required">*</span>机构类型
                        </label>
                    </td>
                    <td class="width-35">
                        <select name="grade" id="grade" class="form-control" required>
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
                        <div class="input-group">
                            <input type="text" name="regionName" id="regionName" class="form-control" value="${organization.regionName}" readonly="readonly">
                            <span class="input-group-btn">
									<button class="btn btn-primary btn-flat" id="regionTreeBtn" type="button"><i class="fa fa-search"></i></button>
								</span>
                            <!-- 参数 -->
                            <input type="hidden" name="regionId" id="regionId" class="form-control" value="${organization.regionId}">
                            <input type="hidden" name="regionCode" id="regionCode" class="form-control" value="${organization.regionCode}">
                        </div>
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
<script type="text/javascript">

    var validateForm;

    function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        $.ajax({
            type: "POST",
            url:"${basePath}sys/organization/update",
            data:$('#krtForm').serialize(),// 要提交的表单
            beforeSend:function(){
                return  validateForm.form() && loading();
            },
            success: function(rb) {
                closeloading()
                if(rb.code==0){
                    top.layer.msg(rb.msg);
                    var index = top.layer.getFrameIndex(window.name); //获取窗口索引
                    var pid = $("#pid").val();
                    if(pid==""){
                        pid=0;
                    }
                    var target = top.$(".J_iframe:visible");
                    target[0].contentWindow.reloadTable();
                    top.layer.close(index);
                }else{
                    top.layer.msg(rb.msg);
                }
            },
            error: function(){
                closeloading();
            }
        });
    }

    $(function(){
        validateForm = $("#krtForm").validate({
            rules: {
                username: {
                    remote: {
                        url: "${basePath}sys/organization/checkCode",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {
                            //要传递的数据
                            code: function () {
                                return $("#code").val();
                            },
                            id: function () {
                                return $("#id").val();
                            }
                        }
                    }
                }
            },
            messages: {
                username: {remote: "机构代码已存在"}
            }
        });
        //立即验证
        validateForm.form();

        $("#organizationTreeBtn").click(function () {
            top.layer.open({
                type: 2,
                area: ['300px', '450px'],
                title: "选择菜单",
                maxmin: true, //开启最大化最小化按钮
                content: "${basePath}sys/organization/organizationTreeUI?id=" + $("#pid").val(),
                btn: ['确定', '关闭'],
                yes: function (index, layero) {
                    var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                    var nodes = tree.getSelectedNodes();
                    if (nodes == null) {
                        top.layer.msg("请选择上级机构");
                    } else {
                        $("#pname").val(nodes[0].name);
                        $("#pid").val(nodes[0].id);
                        top.layer.close(index);
                    }
                },
                cancel: function (index) {
                    top.layer.close(index);
                }
            });
        });

        //区域
        $("#regionTreeBtn").click(function () {
            top.layer.open({
                type: 2,
                area: ['300px', '500px'],
                title: "选择区域",
                maxmin: false, //开启最大化最小化按钮
                content: "${basePath}sys/region/regionTree?id=" + $("#regionId").val(),
                btn: ['确定', '关闭'],
                yes: function (index, layero) {
                    var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                    var nodes = tree.getSelectedNodes();
                    if (nodes == null) {
                        top.layer.msg("请选择区域");
                    } else {
                        $("#regionName").val(nodes[0].name);
                        $("#regionCode").val(nodes[0].code);
                        $("#regionId").val(nodes[0].id);
                        top.layer.close(index);
                    }
                },
                cancel: function (index) {
                    top.layer.close(index);
                }
            });
        });

    });

</script>
</body>
</html>
