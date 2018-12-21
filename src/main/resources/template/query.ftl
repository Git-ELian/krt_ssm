<#include "component.ftl">
<#--
查询
genTable 表参数
-->
<#macro query genTable>
    <#list genTable.genTableColumns as column>
        <#if column.isQuery=='0'>
        <div class="form-group" style="margin:5px">
            <label <#if column.showType!='radio' && column.showType!='checkbox'>for="${column.javaField}"</#if> class="control-label" style="padding:0 5px">${column.comment}</label>
            <@component column genTable 'query' 'n'></@component>
        </div>
        </#if>
    </#list>
</#macro>