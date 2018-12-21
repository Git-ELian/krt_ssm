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
                    var target = top.$(".J_iframe:visible");
                    target[0].contentWindow.reloadTable();
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

        $("#${genTable.className?uncap_first}TreeBtn").click(function () {
            top.layer.open({
                type: 2,
                area: ['300px', '450px'],
                title: "选择${genTable.comment}",
                maxmin: true, //开启最大化最小化按钮
                content: "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/${genTable.className?uncap_first}Tree?id=" + $("#pid").val(),
                btn: ['确定', '关闭'],
                yes: function (index, layero) {
                    var tree = layero.find("iframe")[0].contentWindow.tree;
                    var nodes = tree.getSelectedNodes();
                    if (nodes == null || nodes == '') {
                        top.layer.msg("请选择${genTable.comment}");
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

        $("#cancle${genTable.className}TreeBtn").click(function () {
            $("#pname").val("");
            $("#pid").val("");
        });
    });
</script>
</body>
</html>
