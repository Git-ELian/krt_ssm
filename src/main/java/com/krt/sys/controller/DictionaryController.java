package com.krt.sys.controller;

import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import com.krt.common.constant.SysConstant;
import com.krt.sys.entity.Dictionary;
import com.krt.sys.service.DictionaryService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典表控制层
 * @date 2017年04月11日
 */
@Slf4j
@Controller
public class DictionaryController extends BaseController {

    @Autowired
    private DictionaryService dictionaryService;

    /**
     * 字典表管理页
     *
     * @return
     */
    @RequiresPermissions("sys:dictionary:list")
    @GetMapping("sys/dictionary/list")
    public String list(String pid) {
        String fid = "-1";
        if (!SysConstant.DIC_PID.equals(pid) && !"".equals(pid)) {
            Map m = dictionaryService.selectById(Integer.valueOf(pid));
            fid = m.get("pid") + "";
        }
        request.setAttribute("fid", fid);
        return "sys/dictionary/list";
    }

    /**
     * 字典表管理

     * @return
     */
    @RequiresPermissions("sys:dictionary:list")
    @PostMapping("sys/dictionary/list")
    @ResponseBody
    public DataTable list(@RequestParam Map para) {
        DataTable dt = dictionaryService.selectList(para);
        return dt;
    }

    /**
     * 新增字典表页
     *
     * @return
     */
    @RequiresPermissions("sys:dictionary:insert")
    @GetMapping("sys/dictionary/insert")
    public String insert() {
        return "sys/dictionary/insert";
    }

    /**
     * 添加字典表
     *
     * @param dictionary 字典表
     * @return
     */
    @KrtLog(description = "添加字典表")
    @RequiresPermissions("sys:dictionary:insert")
    @PostMapping("sys/dictionary/insert")
    @ResponseBody
    public ReturnBean insert(Dictionary dictionary) {
        validateEntity(dictionary);
        Integer count = dictionaryService.checkCode(dictionary.getType(), dictionary.getCode(), dictionary.getId());
        if (count == 0) {
            dictionaryService.insert(dictionary);
            return ReturnBean.ok();
        } else {
            return ReturnBean.error("字典编码已存在");
        }
    }

    /**
     * 修改字典表页
     *
     * @param id 字典表 id
     * @return
     */
    @RequiresPermissions("sys:dictionary:update")
    @GetMapping("sys/dictionary/update")
    public String update(Integer id) {
        Map dictionaryMap = dictionaryService.selectById(id);
        request.setAttribute("dictionary", dictionaryMap);
        return "sys/dictionary/update";
    }

    /**
     * 修改字典表
     *
     * @param dictionary 字典表
     * @return
     */
    @KrtLog(description = "修改字典表")
    @RequiresPermissions("sys:dictionary:update")
    @PostMapping("sys/dictionary/update")
    @ResponseBody
    public ReturnBean update(Dictionary dictionary) {
        validateEntity(dictionary);
        // 检测字典代码是否重复
        Integer count = dictionaryService.checkCode(dictionary.getType(), dictionary.getCode(), dictionary.getId());
        if (count == 0) {
            dictionaryService.update(dictionary);
            return ReturnBean.ok();
        } else {
            return ReturnBean.error("字典编码已存在");
        }
    }

    /**
     * 删除字典表
     *
     * @param id 字典表 id
     * @return
     */
    @KrtLog(description = "删除字典表")
    @RequiresPermissions("sys:dictionary:delete")
    @PostMapping("sys/dictionary/delete")
    @ResponseBody
    public ReturnBean delete(Integer id) {
        dictionaryService.delete(id);
        return ReturnBean.ok();
    }

    /**
     * 批量删除字典表
     *
     * @param ids 字典表 ids
     * @return
     */
    @KrtLog(description = "批量删除字典表")
    @RequiresPermissions("sys:dictionary:delete")
    @PostMapping("sys/dictionary/deleteByIds")
    @ResponseBody
    public ReturnBean deleteByIds(String ids) {
        dictionaryService.deleteByIds(ids);
        return ReturnBean.ok();
    }

    /**
     * 获取字典
     * @param type
     * @return
     */
    @PostMapping("sys/dictionary/dictionaryList")
    @ResponseBody
    public ReturnBean dictionaryList(String type){
        List list = dictionaryService.selectDicByType(type);
        return ReturnBean.ok(list);
    }
}
