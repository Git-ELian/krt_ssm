package com.krt.sys.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import com.krt.sys.dto.ResTree;
import com.krt.sys.entity.Role;
import com.krt.sys.service.RoleService;
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
 * @Description: 角色管理控制层
 * @date 2016年7月16日
 */
@Slf4j
@Controller
public class RoleController extends BaseController {

    @Autowired
    private RoleService roleService;

    /**
     * 角色管理页
     *
     * @return
     */
    @RequiresPermissions("sys:role:list")
    @GetMapping("sys/role/list")
    public String list() {
        return "sys/role/list";
    }

    /**
     * 角色管理
     *
     * @return
     */
    @RequiresPermissions("sys:role:list")
    @PostMapping("sys/role/list")
    @ResponseBody
    public DataTable list(@RequestParam Map para) {
        DataTable dt = roleService.selectList(para);
        return dt;
    }

    /**
     * 添加角色页
     *
     * @return
     */
    @RequiresPermissions("sys:role:insert")
    @GetMapping("sys/role/insert")
    public String insert() {
        return "sys/role/insert";
    }

    /**
     * 添加角色
     *
     * @param role 角色
     * @return
     */
    @KrtLog(description = "添加角色")
    @RequiresPermissions("sys:role:insert")
    @PostMapping("sys/role/insert")
    @ResponseBody
    public ReturnBean insert(Role role) {
        validateEntity(role);
        roleService.insert(role);
        return ReturnBean.ok();
    }

    /**
     * 修改角色信息
     *
     * @param id      角色id
     * @return
     */
    @RequiresPermissions("sys:role:update")
    @GetMapping("sys/role/update")
    public String update(Integer id) {
        Map roleMap = roleService.selectById(id);
        request.setAttribute("role", roleMap);
        return "sys/role/update";
    }

    /**
     * 修改角色
     *
     * @param role 角色
     * @return
     */
    @KrtLog(description = "修改角色")
    @RequiresPermissions("sys:role:update")
    @PostMapping("sys/role/update")
    @ResponseBody
    public ReturnBean update(Role role) {
        validateEntity(role);
        roleService.update(role);
        return ReturnBean.ok();
    }

    /**
     * 删除角色
     *
     * @param id 角色id
     * @return
     */
    @KrtLog(description = "删除角色")
    @RequiresPermissions("sys:role:delete")
    @PostMapping("sys/role/delete")
    @ResponseBody
    public ReturnBean delete(Integer id, String code) {
        roleService.delete(id, code);
        return ReturnBean.ok();
    }

    /**
     * 批量删除角色
     * @param ids
     * @param codes
     * @return
     */
    @KrtLog(description = "批量删除角色")
    @RequiresPermissions("sys:role:delete")
    @PostMapping("sys/role/deleteByIdsAndCodes")
    @ResponseBody
    public ReturnBean deleteByIdsAndCodes(String ids, String codes) {
        roleService.deleteByIdsAndCodes(ids, codes);
        return ReturnBean.ok();
    }

    /**
     * 查看角色信息
     *
     * @param id      角色id
     * @return
     */
    @RequiresPermissions("sys:role:see")
    @GetMapping("sys/role/see")
    public String see(Integer id) {
        Map roleMap = roleService.selectById(id);
        request.setAttribute("role", roleMap);
        return "sys/role/see";
    }

    /**
     * 检测角色名
     *
     * @param roleName 角色名
     * @param id       角色id
     * @return
     */
    @PostMapping("sys/role/checkName")
    @ResponseBody
    public Boolean checkName(String roleName, Integer id) {
        Integer count = roleService.checkName(roleName, id);
        if (count > 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 检测角色编码
     *
     * @param code 角色编码
     * @param id   角色id
     * @return
     */
    @PostMapping("sys/role/checkCode")
    @ResponseBody
    public Boolean checkCode(String code, Integer id) {
        Integer count = roleService.checkCode(code, id);
        if (count > 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 权限设置树形页
     *
     * @param code 角色编码
     * @return
     */
    @RequiresPermissions("sys:role:res")
    @GetMapping("sys/role/roleResTree")
    public String roleResTree(String code) {
        List<ResTree> resTree = roleService.selectRoleResTree(code);
        request.setAttribute("resTree",JSONArray.parseArray(JSON.toJSONString(resTree)));
        return "sys/role/roleResTree";
    }

    /**
     * 权限设置
     *
     * @param roleCode 角色编码
     * @param resIds   资源ids
     * @return
     */
    @KrtLog(description = "权限设置")
    @RequiresPermissions("sys:role:res")
    @PostMapping("sys/role/roleRes")
    @ResponseBody
    public ReturnBean roleRes(String roleCode, String resIds) {
        roleService.updateRoleRes(roleCode, resIds);
        return ReturnBean.ok();
    }
}
