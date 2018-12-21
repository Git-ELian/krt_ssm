<#include "../plugins.ftl">
<#include "../table.ftl">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="${level}common/common_form.jsp" %>
    <@header genTable 'insert'></@header>
</head>
<body>
<div class="wrapper">
    <div class="form-box">
        <form action="#" id="krtForm" class="form-horizontal">
            <table class="table table-bordered table-krt">
                <@table genTable 'insert'></@table>
            </table>
        </form>
    </div>
</div><!-- ./wrapper -->
<@editorjs genTable 'insert'></@editorjs>
<script type="text/javascript">
    var validateForm;
    function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        $.ajax({
            type: "POST",
            url: "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/insert",
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
            ignore: "",
            errorContainer: "#messageBox",
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-group")) {
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
