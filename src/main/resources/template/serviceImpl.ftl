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
    @Override
    public List selectExcelList(Map para){
        return baseMapper.selectExcelList(para);
    }
    </#if>
</#macro>