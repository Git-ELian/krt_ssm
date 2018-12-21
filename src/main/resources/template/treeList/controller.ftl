<#include "../controller.ftl">
package ${genTable.genScheme.packageName}.controller;

import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import ${genTable.genScheme.packageName}.entity.${genTable.className};
import ${genTable.genScheme.packageName}.service.${genTable.className}Service;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
<@excelInImport genTable></@excelInImport>
<@excelOutImport genTable></@excelOutImport>

/**
 * @author ${genTable.genScheme.coder}
 * @version 1.0
 * @Description: ${genTable.comment}控制层
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss")}
 */
@Controller
public class ${genTable.className}Controller extends BaseController {

    @Autowired
    private ${genTable.className}Service ${genTable.className?uncap_first}Service;

    /**
     * ${genTable.comment}管理页
     *
     * @return
     */
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:list")
    @GetMapping("${namespace}/${genTable.className?uncap_first}/list")
    public String list() {
        return "${namespace}/${genTable.className?uncap_first}/list";
    }

    /**
     * ${genTable.comment}管理
     *
     * @param para 搜索参数
     * @return
     */
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:list")
    @PostMapping("${namespace}/${genTable.className?uncap_first}/list")
    @ResponseBody
    public ReturnBean list(@RequestParam Map para) {
        List list = ${genTable.className?uncap_first}Service.selectTreeList(para);
        return ReturnBean.ok(list);
    }
    /**
     * 新增${genTable.comment}页
     *
     * @return
     */
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:insert")
    @GetMapping("${namespace}/${genTable.className?uncap_first}/insert")
    public String insert(Integer id) {
        if (id != null) {
        Map ${genTable.className?uncap_first}Map = ${genTable.className?uncap_first}Service.selectById(id);
            request.setAttribute("${genTable.className?uncap_first}", ${genTable.className?uncap_first}Map);
        }
        return "${namespace}/${genTable.className?uncap_first}/insert";
    }

    /**
     * 添加${genTable.comment}
     *
     * @param ${genTable.className?uncap_first} ${genTable.comment}
     * @return
     */
    @KrtLog(description = "添加${genTable.comment}")
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:insert")
    @PostMapping("${namespace}/${genTable.className?uncap_first}/insert")
    @ResponseBody
    public ReturnBean insert(${genTable.className} ${genTable.className?uncap_first}) {
        ${genTable.className?uncap_first}Service.insert(${genTable.className?uncap_first});
        return ReturnBean.ok();
    }

    /**
     * 修改${genTable.comment}页
     *
     * @param id ${genTable.comment} id
     * @return
     */
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:update")
    @GetMapping("${namespace}/${genTable.className?uncap_first}/update")
    public String update(Integer id) {
    Map ${genTable.className?uncap_first}Map = ${genTable.className?uncap_first}Service.selectById(id);
        request.setAttribute("${genTable.className?uncap_first}", ${genTable.className?uncap_first}Map);
        int pid = ${genTable.className?uncap_first}Map.get("pid")==null?0:Integer.valueOf(${genTable.className?uncap_first}Map.get("pid").toString());
        Map pMap = new HashMap(16);
        if(pid!=0){
            pMap = ${genTable.className?uncap_first}Service.selectById(pid);
        }
        request.setAttribute("pMap", pMap);
        return "${namespace}/${genTable.className?uncap_first}/update";
    }

    /**
     * 修改${genTable.comment}
     *
     * @param ${genTable.className?uncap_first} ${genTable.comment}
     * @return
     */
    @KrtLog(description = "修改${genTable.comment}")
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:update")
    @PostMapping("${namespace}/${genTable.className?uncap_first}/update")
    @ResponseBody
    public ReturnBean update(${genTable.className} ${genTable.className?uncap_first}) {
        ${genTable.className?uncap_first}Service.update(${genTable.className?uncap_first});
        return ReturnBean.ok();
    }

    /**
     * 删除${genTable.comment}
     *
     * @param id ${genTable.comment} id
     * @return
     */
    @KrtLog(description = "删除${genTable.comment}")
    @RequiresPermissions("<#if genTable.genScheme.permissionName!=''>${genTable.genScheme.permissionName}:</#if>${genTable.className?uncap_first}:delete")
    @PostMapping("${namespace}/${genTable.className?uncap_first}/delete")
    @ResponseBody
    public ReturnBean delete(Integer id) {
        ${genTable.className?uncap_first}Service.delete(id);
        return ReturnBean.ok();
    }

    /**
     * 获取${genTable.comment}树
     *
     * @return
     */
    @GetMapping("${namespace}/${genTable.className?uncap_first}/${genTable.className?uncap_first}TreeUI")
    public String ${genTable.className?uncap_first}TreeUI() {
        List list = ${genTable.className?uncap_first}Service.selectAllTree();
        JSONArray ${genTable.className?uncap_first}Tree = JSONArray.parseArray(JSON.toJSONString(list));
        request.setAttribute("${genTable.className?uncap_first}Tree", ${genTable.className?uncap_first}Tree.toString());
        return "${namespace}/${genTable.className?uncap_first}/${genTable.className?uncap_first}Tree";
    }

    /**
     * ${genTable.comment}树
     *
     * @return
     */
    @PostMapping("${namespace}/${genTable.className?uncap_first}/${genTable.className?uncap_first}Tree")
    @ResponseBody
    public ReturnBean ${genTable.className?uncap_first}Tree() {
        List list = ${genTable.className?uncap_first}Service.selectAllTree();
        return ReturnBean.ok(list);
    }

    <@excelInMethod genTable></@excelInMethod>

    <@excelOutMethod genTable></@excelOutMethod>
}
