<#--
list组件
genTable 表属性
-->
<#macro list genTable>
    <#list genTable.genTableColumns as column>
        <#if column.isList=='0'>
        <th>${column.comment}</th>
        </#if>
    </#list>
</#macro>

<#--
excel导入 导出js
-->
<#macro excelJS genTable namespace>
    <#if genTable.excelIn=='0'>
    <script src="${"$"}{basePath}static/assets/libs/kindeditor/kindeditor-min.js"></script>
    </#if>
    <#if genTable.excelIn=='0' || genTable.excelOut=='0'>
    <script type="text/javascript">
            <#if genTable.excelIn=='0'>
            KindEditor.ready(function (K) {
                var excelInBtn = K.uploadbutton({
                    button: K('#excelIn')[0],
                    fieldName: 'excelFile',
                    url: "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/excelIn",
                    afterUpload: function (rb) {
                        closeloading();
                        if (rb.code == 0) {
                            datatable.ajax.reload();
                            layer.msg(rb.msg);
                        } else {
                            layer.msg(rb.msg);
                        }
                    }
                });
                excelInBtn.fileBox.change(function (e) {
                    loading();
                    excelInBtn.submit();
                });
            });
            $("#excelInBtn").click(function () {
                $("input[name='excelFile']").click();
            });
            </#if>
            <#if genTable.excelOut=='0'>
            $("#excelOutBtn").click(function () {
                window.location.href = "${"$"}{basePath}${namespace}/${genTable.className?uncap_first}/excelOut";
            })
            </#if>
    </script>
    </#if>
</#macro>

<#--
datatable 排序
-->
<#macro datatableOrder genTable>
    <#if genTable.order=='0'>
        <#assign flag=true/>
        <#assign index=0/>
        <#list genTable.genTableColumns as column>
            <#if column.isList=='0'>
                <#if flag>
                    <#assign index=index+1/>
                </#if>
                <#if column.isSort=='0'>
                    <#assign flag=false/>
                </#if>
            </#if>
        </#list>
    ordering: true,
    order: [[${index}, 'asc']],
    </#if>
</#macro>

<#--
datatable获取查询参数组件
genTable 表属性
-->
<#macro datatableParam genTable>
    <#list genTable.genTableColumns as column>
        <#if column.isQuery=='0'>
            <#if column.showType=='checkbox'>
            d.${column.javaField} = function () {
                var ${column.javaField}CheVal = "";
                $('input[name="${column.javaField}"]:checked').each(function(){
                    ${column.javaField}CheVal = ${column.javaField}CheVal + ${"$"}(this).val() + ",";
                });
                if(${column.javaField}CheVal.length>0){
                    ${column.javaField}CheVal = ${column.javaField}CheVal.substr(0,${column.javaField}CheVal.length-1);
                }
                return ${column.javaField}CheVal;
            };
            </#if>
            <#if column.showType=='radio'>
            d.${column.javaField} = ${"$"}("input[name='${column.javaField}']:checked").val();
            </#if>
            <#if column.showType!='checkbox' && column.showType!='radio'>
            d.${column.javaField} = ${"$"}("#${column.javaField}").val();
            </#if>
        </#if>
    </#list>
            <#if genTable.order=='0'>
            d.orderName = camel2Underline(d.columns[d.order[0].column].data);
            d.orderType = d.order[0].dir;
            </#if>
</#macro>

<#--
datatable循环数据组件
genTable 表属性
-->
<#macro datatableData genTable>
            {
                "data": "id",
                <#if genTable.order=='0'>"orderable": false,</#if>
                    render: function (data, type) {
                    return '<input type="checkbox" class="iCheck check" value="' + data + '">';
                }
            },
    <#if genTable.order=='0'>
        <#list genTable.genTableColumns as column>
            <#if column.isList=='0' && column.isSort=='0'>
            {
            "data": "${column.javaField}"
            },
            </#if>
            <#if column.isList=='0' && column.isSort=='1'>
            {
            "data": "${column.javaField}",
            "orderable": false
            },
            </#if>
        </#list>
    </#if>
    <#if genTable.order=='1'>
        <#list genTable.genTableColumns as column>
            <#if column.isList=='0'>
            {"data": "${column.javaField}"},
            </#if>
        </#list>
    </#if>
</#macro>