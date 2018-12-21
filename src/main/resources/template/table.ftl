<#include "component.ftl">
<#--
表格宏
genTable：表信息
doType 操作类型 insert：添加 update:修改
-->
<#macro table genTable doType>
    <#assign isEnd = true>
    <#list genTable.genTableColumns as column>
        <#assign a=(column_index)/>
        <#-- 新行 可添加 不是隐藏域  -->
        <#if column.isRow=='0' && column.isInsert=='0' && column.showType !='hidden'>
        <#-- 是否正确结尾 -->
            <#if !isEnd>
            <td class="active width-15"></td>
            <td class="width-35"></td>
            </tr>
            </#if>
        <tr>
            <td class="active width-15">
                <label class="pull-right">
                ${column.comment}
                </label>
            </td>
            <td colspan="3">
                <@component column genTable doType '-1'/>
            </td>
        </tr>
            <#assign isEnd = true>
        </#if>
        <#-- 不是新行 可添加 不是隐藏域  -->
        <#if column.isRow =='1' && column.isInsert=='0' && column.showType !='hidden'>
            <#if isEnd>
            <tr>
                <td class="active width-15">
                    <label class="pull-right">
                    ${column.comment}
                    </label>
                </td>
                <td class="width-35">
                    <@component column genTable doType '-1'/>
                </td>
            </#if>
            <#if !isEnd>
                <td class="active width-15">
                    <label class="pull-right">
                    ${column.comment}
                    </label>
                </td>
                <td class="width-35">
                    <@component column genTable doType '-1'/>
                </td>
            </tr>
            </#if>
            <#assign isEnd = !isEnd>
        </#if>
    </#list>
    <#if !isEnd>
    <td class="active width-15"></td>
    <td class="width-35"></td>
    </tr>
    </#if>
    <!-- 隐藏域 -->
    <#list genTable.genTableColumns as column>
        <#if column.showType=='hidden' && doType=='insert'>
        <input type="hidden" name="${column.javaField}" value="">
        </#if>
        <#if column.showType=='hidden' && doType=='update'>
        <input type="hidden" name="${column.javaField}" value="${"$"}{${genTable.className?uncap_first}.${column.javaField}}">
        </#if>
    </#list>
</#macro>