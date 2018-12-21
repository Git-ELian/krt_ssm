package com.krt.sys.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.ReturnBean;
import com.krt.sys.entity.Organization;
import com.krt.sys.service.OrganizationService;
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
 * @Description: 组织机构控制层
 * @date 2017年05月17日
 */
@Slf4j
@Controller
public class OrganizationController extends BaseController {

    @Autowired
    private OrganizationService organizationService;

    /**
     * 组织机构管理页
     *
     * @return
     */
    @RequiresPermissions("sys:organization:list")
    @GetMapping("sys/organization/list")
    public String listUI() {
        return "sys/organization/list";
    }

    /**
     * 组织机构管理
     *
     * @return
     */
    @RequiresPermissions("sys:organization:list")
    @PostMapping("sys/organization/list")
    @ResponseBody
    public List list() {
        Map para = new HashMap(1);
        Integer pid = Integer.valueOf(request.getParameter("pid"));
        log.debug("pid:{}",pid);
        para.put("pid",pid);
        List list = organizationService.selectListNoPage(para);
        return list;
    }

    /**
     * 新增组织机构页
     *
     * @return
     */
    @RequiresPermissions("sys:organization:insert")
    @GetMapping("sys/organization/insert")
    public String insert() {
        //父级
        String id = request.getParameter("id");
        if(id!=null){
            Map organization = organizationService.selectById(Integer.valueOf(id));
            request.setAttribute("organization",organization);
        }
        return "sys/organization/insert";
    }

    /**
     * 添加组织机构
     *
     * @param organization 组织机构
     * @return
     */
    @KrtLog(description = "添加组织机构")
    @RequiresPermissions("sys:organization:insert")
    @PostMapping("sys/organization/insert")
    @ResponseBody
    public ReturnBean insert(Organization organization) {
        validateEntity(organization);
        organizationService.insert(organization);
        return ReturnBean.ok();
    }

    /**
     * 修改组织机构页
     *
     * @param id 组织机构 id
     * @return
     */
    @RequiresPermissions("sys:organization:update")
    @GetMapping("sys/organization/update")
    public String update(Integer id) {
        Map organizationMap = organizationService.selectById(id);
        request.setAttribute("organization", organizationMap);
        return "sys/organization/update";
    }

    /**
     * 修改组织机构
     *
     * @param organization 组织机构
     * @return
     */
    @KrtLog(description = "修改组织机构")
    @RequiresPermissions("sys:organization:update")
    @PostMapping("sys/organization/update")
    @ResponseBody
    public ReturnBean update(Organization organization) {
        validateEntity(organization);
        organizationService.update(organization);
        return ReturnBean.ok();
    }

    /**
     * 删除组织机构
     *
     * @param id 组织机构 id
     * @return
     */
    @KrtLog(description = "删除组织机构")
    @RequiresPermissions("sys:organization:delete")
    @PostMapping("sys/organization/delete")
    @ResponseBody
    public ReturnBean delete(Integer id) {
        organizationService.delete(id);
        return ReturnBean.ok();
    }

    /**
     * 加载组织机构树
     * @return
     */
    @PostMapping("sys/organization/organizationTree")
    @ResponseBody
    public List organizationTree(){
        List list  = organizationService.selectAllTree();
        return list;
    }

    /**
     * 组织机构树
     *
     * @return
     */
    @GetMapping("sys/organization/organizationTreeUI")
    public String organizationTreeUI() {
        List list = organizationService.selectAllTree();
        JSONArray organizationTree = JSONArray.parseArray(JSON.toJSONString(list));
        request.setAttribute("organizationTree", organizationTree.toString());
        return "sys/organization/organizationTreeUI";
    }

    /**
     * 检查机构代码是否重复
     * @param id
     * @param code
     * @return
     */
    @PostMapping("sys/organization/checkCode")
    @ResponseBody
    public Boolean checkCode(Integer id,String code){
       Integer count =  organizationService.checkCode(id,code);
       if(count>0){
           return false;
       }else{
           return true;
       }
    }

    /**
     * 修改组织机构页
     *
     * @param id 组织机构 id
     * @return
     */
    @RequiresPermissions("sys:organization:see")
    @GetMapping("sys/organization/see")
    public String see(Integer id) {
        Map organizationMap = organizationService.selectById(id);
        request.setAttribute("organization", organizationMap);
        return "sys/organization/see";
    }
}
