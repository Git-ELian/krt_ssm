package com.krt.sys.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.ReturnBean;
import com.krt.sys.entity.Res;
import com.krt.sys.service.ResService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 资源管理控制层
 * @date 2016年7月19日
 */
@Slf4j
@Controller
public class ResController extends BaseController {

    @Autowired
    private ResService resService;

    /**
     * 资源管理页
     *
     * @return
     */
    @RequiresPermissions("sys:res:list")
    @GetMapping("sys/res/list")
    public String list() {
        return "sys/res/list";
    }

    /**
     * 资源管理
     *
     * @return
     */
    @RequiresPermissions("sys:res:list")
    @PostMapping("sys/res/list")
    @ResponseBody
    public List list(Integer pid) {
        List list = resService.selectListByPid(pid);
        return list;
    }

    /**
     * 资源树
     *
     * @return
     */
    @PostMapping("sys/res/resTree")
    @ResponseBody
    public List resTree() {
        List rlist = resService.selectAllTree();
        return rlist;
    }

    /**
     * 获取资源树
     *
     * @return
     */
    @GetMapping("sys/res/resTree")
    public String resTreeUI() {
        List list = resService.selectAllTree();
        JSONArray resTree = JSONArray.parseArray(JSON.toJSONString(list));
        request.setAttribute("resTree", resTree.toString());
        return "sys/res/resTree";
    }


    /**
     * 获取子集
     *
     * @param pid
     * @return
     */
    @PostMapping("sys/res/resChild")
    @ResponseBody
    public List resChild(Integer pid) {
        List list = resService.selectListByPid(pid);
        return list;
    }

    /**
     * 添加资源页
     *
     * @return
     */
    @RequiresPermissions("sys:res:insert")
    @GetMapping("sys/res/insert")
    public String insert(Integer id) {
        if (id != null) {
            Map resMap = resService.selectById(id);
            request.setAttribute("res", resMap);
        }
        return "sys/res/insert";
    }

    /**
     * 添加资源
     *
     * @param res 资源实体
     * @return
     */
    @KrtLog(description = "添加资源")
    @RequiresPermissions("sys:res:insert")
    @PostMapping("sys/res/insert")
    @ResponseBody
    public ReturnBean insert(Res res) {
        validateEntity(res);
        if (res.getPid() == null) {
            res.setPid(0);
        }
        resService.insert(res);
        return ReturnBean.ok();
    }

    /**
     * 资源ICON页
     *
     * @return
     */
    @GetMapping("sys/res/resIcon")
    public String resIcon() {
        return "sys/res/resIcon";
    }


    /**
     * 修改资源
     *
     * @param id 资源id
     * @return
     */
    @RequiresPermissions("sys:res:update")
    @GetMapping("sys/res/update")
    public String update(Integer id) {
        Map resMap = resService.selectById(id);
        int pid = resMap.get("pid")==null?0:Integer.valueOf(resMap.get("pid")+"");
        Map pResMap = new HashMap(16);
        if(pid!=0){
            pResMap = resService.selectById(pid);
        }
        request.setAttribute("pResMap", pResMap);
        request.setAttribute("res", resMap);
        return "sys/res/update";
    }

    /**
     * 修改资源
     *
     * @param res 资源实体
     * @return
     */
    @KrtLog(description = "修改资源")
    @RequiresPermissions("sys:res:update")
    @PostMapping("sys/res/update")
    @ResponseBody
    public ReturnBean update(Res res) {
        validateEntity(res);
        if (res.getPid() == null) {
            res.setPid(0);
        }
        resService.update(res);
        return ReturnBean.ok();
    }

    /**
     * 删除资源
     *
     * @param id 资源id
     * @return
     */
    @KrtLog(description = "删除资源")
    @RequiresPermissions("sys:res:delete")
    @PostMapping("sys/res/delete")
    @ResponseBody
    public ReturnBean delete(Integer id) {
        resService.delete(id);
        return ReturnBean.ok();
    }

    /**
     * 资源信息页
     *
     * @param id 资源id
     * @return
     */
    @RequiresPermissions("sys:res:see")
    @GetMapping("sys/res/see")
    public String see(Integer id) {
        Map resMap = resService.selectById(id);
        int pid = resMap.get("pid")==null?0:Integer.valueOf(resMap.get("pid").toString());
        Map pResMap = new HashMap(16);
        if(pid!=0){
            pResMap = resService.selectById(pid);
        }
        request.setAttribute("pResMap", pResMap);
        request.setAttribute("res", resMap);
        return "sys/res/see";
    }
}
