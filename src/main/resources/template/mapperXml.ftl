<#--
 Mapper查询条件
-->
<#macro mapperQuery genTable>
    <#list genTable.genTableColumns as column>
        <#if column.isQuery=='0'>
        <if test="${column.javaField} !=null and ${column.javaField}!=''">
            <#if column.queryType=='1'>
                <#if column.showType=='checkbox'>
                    and find_in_set(${column.name},${"#"}{${column.javaField}})
                </#if>
                <#if column.showType!='checkbox'>
                    and ${column.name} = ${"#"}{${column.javaField}}
                </#if>
            </#if>
            <#if column.queryType=='2'>
                and ${column.name} != ${"#"}{${column.javaField}}
            </#if>
            <#if column.queryType=='3'>
                <![CDATA[ and ${column.name} > ${"#"}{${column.javaField}} ]]>
            </#if>
            <#if column.queryType=='4'>
                <![CDATA[ and ${column.name} >= ${"#"}{${column.javaField}} ]]>
            </#if>
            <#if column.queryType=='5'>
                <![CDATA[ and ${column.name} < ${"#"}{${column.javaField}} ]]>
            </#if>
            <#if column.queryType=='6'>
                <![CDATA[ and ${column.name} <= ${"#"}{${column.javaField}} ]]>
            </#if>
            <#if column.queryType=='7'>
                and ${column.name} like concat('%',${"#"}{${column.javaField}},'%')
            </#if>
            <#if column.queryType=='8'>
                and ${column.name} like concat('%',${"#"}{${column.javaField}})
            </#if>
            <#if column.queryType=='9'>
                and ${column.name} like concat(${"#"}{${column.javaField}},'%')
            </#if>
        </if>
        </#if>
    </#list>
    <#if genTable.order=='0'>
    <if test="orderName!=null and orderName !=''">
        order by ${"$"}{orderName} ${"$"}{orderType}
    </if>
    </#if>
</#macro>
<#--
 导出模板
-->
<#macro excelOut genTable>
    <#if genTable.excelOut=='0'>
    <!-- 导出数据 -->
    <select id="selectExcelList" resultType="java.util.Map">
        select
        <#list genTable.genTableColumns as column><#if column.excelOut='0'>${column.name}<#if (column_has_next)>,</#if></#if></#list>'1'
        from ${genTable.name}
    </select>
    </#if>
</#macro>