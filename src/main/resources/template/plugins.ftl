<#-- 编辑器css -->
<#macro header genTable doType>
<#-- 定义变量判断编辑器 防止重复引入 -->
    <#assign HasEditor = true>
    <#list genTable.genTableColumns as column>
    <#-- 增加页面 -->
        <#if doType=='insert'>
            <#if column.showType=='editor' && column.isInsert=='0' && HasEditor>
            <link rel="stylesheet" href="${"$"}{basePath}static/assets/libs/kindeditor/themes/default/default.css"/>
            <style>
                div.upload > .ke-upload-area > .ke-button-common {
                    background: transparent;
                    height: 20px;
                }
                div.upload > .ke-upload-area > .ke-button-common > .ke-button {
                    background: transparent;
                    color: white;
                }
                .ke-button{
                    font-size: 14px;
                }
            </style>
                <#assign HasEditor = false>
            </#if>
        </#if>
    <#-- 修改页面 -->
        <#if doType=='update'>
            <#if column.showType=='editor' && column.isEdit=='0' && HasEditor>
            <link rel="stylesheet" href="${"$"}{basePath}static/assets/libs/kindeditor/themes/default/default.css"/>
            <style>
                div.upload > .ke-upload-area > .ke-button-common {
                    background: transparent;
                    height: 20px;
                }

                div.upload > .ke-upload-area > .ke-button-common > .ke-button {
                    background: transparent;
                    color: white;
                }
            </style>
                <#assign HasEditor = false>
            </#if>
        </#if>
    </#list>
</#macro>

<#-- 编辑器js -->
<#macro editorjs genTable doType>
<#-- 定义变量判断编辑器 防止重复引入 -->
    <#assign HasEditor = false>
    <#list genTable.genTableColumns as column>
    <#-- 增加页面 -->
        <#if doType=='insert'>
            <#if column.showType=='editor' && column.isInsert=='0' && !HasEditor>
            <script src="${"$"}{basePath}static/assets/libs/kindeditor/kindeditor-min.js"></script>
                <#assign HasEditor = true>
            </#if>
        </#if>
    <#-- 修改页面 -->
        <#if doType=='update'>
            <#if column.showType=='editor' && column.isEdit=='0' && !HasEditor>
            <script src="${"$"}{basePath}static/assets/libs/kindeditor/kindeditor-min.js"></script>
                <#assign HasEditor = true>
            </#if>
        </#if>
    </#list>
<#-- 共用属性 -->
    <#if HasEditor>
    <script type="text/javascript">
    KindEditor.ready(function(K) {
    </#if>
<#-- 增加页面 -->
    <#if doType=='insert'>
        <#list genTable.genTableColumns as column>
            <#if column.showType=='editor' && column.isInsert=='0'>
                var ${column.javaField}Editor = K.create('textarea[id="${column.javaField}"]', {
                    resizeType: 1,
                    allowPreviewEmoticons: false,
                    allowImageUpload: true,//允许上传图片
                    allowFileManager: true, //允许对上传图片进行管理
                    uploadJson: '${"$"}{basePath}kindeditor/fileUpload',
                    fileManagerJson: '${"$"}{basePath}kindeditor/fileManager',
                    afterUpload: function () {
                        this.sync();
                    },
                    afterBlur: function () {
                        this.sync();
                    },
                    width: '100%',
                    height: '300px',
                    formatUploadUrl: false
                });
            </#if>
            <#if column.showType=='file' && column.isInsert=='0'>
                var ${column.javaField}Btn = K.uploadbutton({
                    button: K('${"#"}${column.javaField}Btn')[0],
                    fieldName: 'file',
                    url: '${"$"}{basePath}kindeditor/fileUpload?dir=file',
                    afterUpload: function (msg) {
                        if (msg.error == '0') {
                            K('${"#"}${column.javaField}').val(msg.url);
                        } else {
                            layer.msg(msg.message);
                        }
                    }
                });
                ${column.javaField}Btn.fileBox.change(function (e) {
                    ${column.javaField}Btn.submit();
                });
            </#if>
            <#if column.showType=='img' && column.isInsert=='0'>
                var ${column.javaField}Btn = K.uploadbutton({
                    button: K('${"#"}${column.javaField}Btn')[0],
                    fieldName: 'file',
                    url: '${"$"}{basePath}kindeditor/fileUpload?dir=image',
                    afterUpload: function (msg) {
                        if (msg.error == '0') {
                            K('${"#"}${column.javaField}').val(msg.url);
                        } else {
                            layer.msg(msg.message);
                        }
                    }
                });
                ${column.javaField}Btn.fileBox.change(function (e) {
                    ${column.javaField}Btn.submit();
                });
            </#if>
        </#list>
    </#if>
<#-- 修改页面 -->
    <#if doType=='update'>
        <#list genTable.genTableColumns as column>
            <#if column.showType=='editor' && column.isInsert=='0'>
                var ${column.javaField}Editor = K.create('textarea[name="${column.javaField}"]', {
                    resizeType: 1,
                    allowPreviewEmoticons: false,
                    allowImageUpload: true,//允许上传图片
                    allowFileManager: true, //允许对上传图片进行管理
                    uploadJson: '${"$"}{basePath}kindeditor/fileUpload',
                    fileManagerJson: '${"$"}{basePath}kindeditor/fileManager',
                    afterUpload: function () {
                        this.sync();
                    },
                    afterBlur: function () {
                        this.sync();
                    },
                    width: '100%',
                    height: '300px',
                    formatUploadUrl: false
                });
            </#if>
            <#if column.showType=='file' && column.isInsert=='0'>
                var ${column.javaField}Btn = K.uploadbutton({
                    button: K('${"#"}${column.javaField}Btn')[0],
                    fieldName: 'file',
                    url: '${"$"}{basePath}kindeditor/fileUpload?dir=file',
                    afterUpload: function (msg) {
                        if (msg.error == '0') {
                            K('${"#"}${column.javaField}').val(msg.url);
                        } else {
                            layer.msg(msg.message);
                        }
                    }
                });
                ${column.javaField}Btn.fileBox.change(function (e) {
                    ${column.javaField}Btn.submit();
                });
            </#if>
            <#if column.showType=='img' && column.isInsert=='0'>
                var ${column.javaField}Btn = K.uploadbutton({
                    button: K('${"#"}${column.javaField}Btn')[0],
                    fieldName: 'file',
                    url: '${"$"}{basePath}kindeditor/fileUpload?dir=image',
                    afterUpload: function (msg) {
                        if (msg.error == '0') {
                            K('${"#"}${column.javaField}').val(msg.url);
                        } else {
                            layer.msg(msg.message);
                        }
                    }
                });
                ${column.javaField}Btn.fileBox.change(function (e) {
                    ${column.javaField}Btn.submit();
                });
            </#if>
        </#list>
    </#if>
    <#if HasEditor>
    });
    </script>
    </#if>
</#macro>