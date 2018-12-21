<#--
 导出模板
-->
<#macro excelOut genTable>
    <#if genTable.excelOut=='0'>
    /**
     * 导出excel
     *
     * @param para
     * @return
     */
    List selectExcelList(Map para);
    </#if>
</#macro>