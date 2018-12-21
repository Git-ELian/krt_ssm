<#--
 导出需要引入包
-->
<#macro excelOutImport genTable>
<#if genTable.excelOut=='0'>
import org.springframework.ui.ModelMap;
import java.util.ArrayList;
import java.util.List;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.params.ExcelExportEntity;
import cn.afterturn.easypoi.entity.vo.MapExcelConstants;
import cn.afterturn.easypoi.entity.vo.NormalExcelConstants;
</#if>
</#macro>

<#--
 导入需要引入包
-->
<#macro excelInImport genTable>
    <#if genTable.excelIn=='0'>
import org.springframework.web.multipart.MultipartFile;
import com.krt.common.validator.Assert;
import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
    </#if>
</#macro>

<#--
 导入模板
-->
<#macro excelInMethod genTable>
    <#if genTable.excelIn=='0'>
    /**
    * 导入${genTable.comment}
    *
    * @param file
    * @return
    * @throws Exception
    */
    @KrtLog(description = "导入${genTable.comment}")
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:excelIn")
    @PostMapping("${namespace}/${genTable.className?uncap_first}/excelIn")
    @ResponseBody
    public ReturnBean excelIn(@RequestParam("excelFile") MultipartFile file) throws Exception {
        Assert.isExcel(file);
        ImportParams params = new ImportParams();
        params.setTitleRows(1);
        params.setHeadRows(1);
        params.setNeedSave(true);
        //读取excel
        List<${genTable.className}> dataList = ExcelImportUtil.importExcel(file.getInputStream(), ${genTable.className}.class, params);
        ${genTable.className?uncap_first}Service.insertBatch(dataList);
        return ReturnBean.ok();
     }
    </#if>
</#macro>


<#--
 导出模板
-->
<#macro excelOutMethod genTable>
    <#if genTable.excelOut=='0'>
    /**
     * 导出${genTable.comment}
     *
     * @param modelMap 返回模型
     * @param para 参数
     * @return
     */
    @KrtLog(description = "导出${genTable.comment}")
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:excelOut")
    @GetMapping("${namespace}/${genTable.className?uncap_first}/excelOut")
    public String excelOut(ModelMap modelMap,Map para) {
        List<ExcelExportEntity> entityList = new ArrayList<>();
        <#list genTable.genTableColumns as column>
            <#if column.excelOut=='0'>
        entityList.add(new ExcelExportEntity("${column.comment}", "${column.javaField}", 15));
            </#if>
        </#list>
        List dataResult = ${genTable.className?uncap_first}Service.selectExcelList(para);
        modelMap.put(MapExcelConstants.ENTITY_LIST, entityList);
        modelMap.put(MapExcelConstants.MAP_LIST, dataResult);
        modelMap.put(MapExcelConstants.FILE_NAME, "${genTable.comment}");
        modelMap.put(NormalExcelConstants.PARAMS, new ExportParams("${genTable.comment}", "${genTable.comment}"));
        return MapExcelConstants.EASYPOI_MAP_EXCEL_VIEW;
     }
    </#if>
</#macro>