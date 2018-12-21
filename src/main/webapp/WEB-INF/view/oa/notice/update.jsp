<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../common/common_form.jsp" %>
    <link rel="stylesheet" href="${basePath}assets/plugins/kindeditor/themes/default/default.css"/>
    <style>
        div.upload> .ke-upload-area>.ke-button-common{
            background: transparent;
            height: 20px;
        }
        div.upload> .ke-upload-area>.ke-button-common >.ke-button{
            background: transparent;
            color:white;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="form-box">
        <form action="#" id="krtForm" class="form-horizontal">
            <table class="table table-bordered table-krt">
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            标题
                        </label>
                    </td>
                    <td class="width-35"><input type="text" name="title" id="title" class="form-control" rangelength="1,50" value="${notice.title}" required ></td>
                    <td class="active width-15">
                        <label class="pull-right">
                            图片
                        </label>
                    </td>
                    <td class="width-35">
                        <div class="input-group">
                            <input class="form-control" type="text" id="img" name="img" class="form-control" value="${notice.img}" readonly="readonly" />
                            <span class="input-group-btn">
                              <button class="btn btn-primary btn-flat upload" id="uploadButton" type="button" value="上传" ignore>上传</button>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="active width-15">
                        <label class="pull-right">
                            内容
                        </label>
                    </td>
                    <td colspan="3">
                        <textarea type="text" name="content" id="content" class="form-control" required>${notice.content}</textarea>
                    </td>
                </tr>
                <!-- 参数 -->
                <input type="hidden" name="author" value="${notice.author}"/>
                <input type="hidden" name="id" value="${notice.id}"/>
            </table>
        </form>
    </div>
</div><!-- ./wrapper -->
<script src="${basePath}static/assets/libs/kindeditor/kindeditor-min.js"></script>
<script>
    var editor;
    KindEditor.ready(function(K) {
        editor = K.create('textarea[name="content"]', {
            resizeType : 1,
            resizeType : 1,
            allowPreviewEmoticons: false,
            allowImageUpload:true,//允许上传图片
            allowFileManager:true, //允许对上传图片进行管理
            uploadJson:'${basePath}kindeditor/fileUpload', //上传图片的java代码，只不过放在jsp中
            fileManagerJson:'${basePath}kindeditor/fileManager',
            afterUpload: function(){this.sync();}, //图片上传后，将上传内容同步到textarea中
            afterBlur: function(){this.sync();},   ////失去焦点时，将上传内容同步到textarea中
            width:'100%',
            height:'350px',
            formatUploadUrl:false,
        });

        var uploadbutton = K.uploadbutton({
            button: K('#uploadButton')[0],
            fieldName: 'file',
            url: '${basePath}kindeditor/fileUpload?dir=image',
            afterUpload: function (msg) {
                if (msg.error == '0') {
                    K('#img').val(msg.url);
                } else {
                    layer.msg(msg.message);
                }
            }
        });
        uploadbutton.fileBox.change(function (e) {
            uploadbutton.submit();
        });
    });
</script>
<script type="text/javascript">

    var validateForm;

    function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
        $.ajax({
            type: "POST",
            url: "${basePath}oa/notice/update",
            data: $('#krtForm').serialize(),// 要提交的表单
            beforeSend: function () {
                return validateForm.form() && loading();
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
            error: function () {
                closeloading();
            }
        });
    }

    $(function () {
        validateForm = $("#krtForm").validate({
            errorContainer: "#messageBox",
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-group")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            },
        });
        //立即验证
        validateForm.form();
    });

</script>
</body>
</html>
