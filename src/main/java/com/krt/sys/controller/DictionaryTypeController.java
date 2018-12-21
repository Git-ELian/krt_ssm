package com.krt.sys.controller;

import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import com.krt.sys.entity.DictionaryType;
import com.krt.sys.service.DictionaryTypeService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典类型表控制层
 * @date 2017年04月11日
 */
@Slf4j
@Controller
public class DictionaryTypeController extends BaseController {

    @Autowired
    private DictionaryTypeService dictionaryTypeService;

    /**
     * 字典类型表管理页
     *
     * @return
     */
    @RequiresPermissions("sys:dictionaryType:list")
    @GetMapping("sys/dictionaryType/list")
    public String list() {
        return "sys/dictionaryType/list";
    }

    /**
     * 字典类型表管理
     *
     * @return
     */
    @RequiresPermissions("sys:dictionaryType:list")
    @PostMapping("sys/dictionaryType/list")
    @ResponseBody
    public DataTable list(@RequestParam Map para) {
        DataTable dt = dictionaryTypeService.selectList(para);
        return dt;
    }

    /**
     * 新增字典类型表页
     *
     * @return
     */
    @RequiresPermissions("sys:dictionaryType:insert")
    @GetMapping("sys/dictionaryType/insert")
    public String insert(HttpServletRequest request) {
        return "sys/dictionaryType/insert";
    }

    /**
     * 添加字典类型表
     *
     * @param dictionaryType 字典类型表
     * @return
     */
    @KrtLog(description = "添加字典类型表")
    @RequiresPermissions("sys:dictionaryType:insert")
    @PostMapping("sys/dictionaryType/insert")
    @ResponseBody
    public ReturnBean insert(DictionaryType dictionaryType) {
        validateEntity(dictionaryType);
        Integer count = dictionaryTypeService.checkCode(dictionaryType.getCode(), dictionaryType.getId());
        if (count == 0) {
            dictionaryTypeService.insert(dictionaryType);
            return ReturnBean.ok();
        } else {
            return ReturnBean.error("字典编码已存在");
        }
    }

    /**
     * 修改字典类型表页
     *
     * @param id 字典类型表 id
     * @return
     */
    @RequiresPermissions("sys:dictionaryType:update")
    @GetMapping("sys/dictionaryType/update")
    public String update(Integer id) {
        Map dictionaryTypeMap = dictionaryTypeService.selectById(id);
        request.setAttribute("dictionaryType", dictionaryTypeMap);
        return "sys/dictionaryType/update";
    }

    /**
     * 修改字典类型表
     *
     * @param dictionaryType 字典类型表
     * @return
     */
    @KrtLog(description = "修改字典类型表")
    @RequiresPermissions("sys:dictionaryType:update")
    @PostMapping("sys/dictionaryType/update")
    @ResponseBody
    public ReturnBean update(DictionaryType dictionaryType) {
        validateEntity(dictionaryType);
        Integer count = dictionaryTypeService.checkCode(dictionaryType.getCode(), dictionaryType.getId());
        if (count == 0) {
            dictionaryTypeService.update(dictionaryType);
            return ReturnBean.ok();
        } else {
            return ReturnBean.error("字典编码已存在");
        }
    }

    /**
     * 删除字典类型表
     *
     * @param id   字典类型表 id
     * @param code 字典类型编码
     * @return
     */
    @KrtLog(description = "删除字典类型表")
    @RequiresPermissions("sys:dictionaryType:delete")
    @PostMapping("sys/dictionaryType/delete")
    @ResponseBody
    public ReturnBean delete(Integer id, String code) {
        dictionaryTypeService.delete(id, code);
        return ReturnBean.ok();
    }

    /**
     * 批量删除字典类型表
     *
     * @param ids
     * @param codes
     * @return
     */
    @KrtLog(description = "删除字典类型表")
    @RequiresPermissions("sys:dictionaryType:delete")
    @PostMapping("sys/dictionaryType/deleteByIdsAndCodes")
    @ResponseBody
    public ReturnBean deleteByIdsAndCodes(String ids, String codes) {
        dictionaryTypeService.deleteByIdsAndCodes(ids, codes);
        return ReturnBean.ok();
    }

    /**
     * 获取字典类型
     *
     * @return
     */
    @PostMapping("sys/dictionaryType/dictionaryTypeList")
    @ResponseBody
    public ReturnBean dictionaryTypeList() {
        List list = dictionaryTypeService.selectAll();
        return ReturnBean.ok(list);
    }
}
