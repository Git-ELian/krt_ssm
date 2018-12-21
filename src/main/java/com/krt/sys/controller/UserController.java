package com.krt.sys.controller;

import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import com.krt.common.constant.SysConstant;
import com.krt.common.util.AesUtils;
import com.krt.common.util.ShiroUtils;
import com.krt.common.util.StringUtils;
import com.krt.sys.entity.User;
import com.krt.sys.service.RoleService;
import com.krt.sys.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户管理控制层
 * @date 2016年7月16日
 */
@Slf4j
@Controller
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    /**
     * 用户管理页
     *
     * @return
     */
    @RequiresPermissions("sys:user:list")
    @GetMapping("sys/user/list")
    public String list() {
        List roleList = roleService.selectAll();
        request.setAttribute("roleList", roleList);
        return "sys/user/list";
    }

    /**
     * 用户管理
     *
     * @param para
     * @return
     */
    @RequiresPermissions("sys:user:list")
    @PostMapping("sys/user/list")
    @ResponseBody
    public DataTable list(@RequestParam Map para) {
        DataTable dt = userService.selectList(para);
        return dt;
    }

    /**
     * 新增用户页
     *
     * @return
     */
    @RequiresPermissions("sys:user:insert")
    @GetMapping("sys/user/insert")
    public String insert() {
        List roleList = roleService.selectAll();
        request.setAttribute("roleList", roleList);
        return "sys/user/insert";
    }

    /**
     * 添加
     *
     * @param user 用户
     * @return
     */
    @KrtLog(description = "添加用户")
    @RequiresPermissions("sys:user:insert")
    @PostMapping("sys/user/insert")
    @ResponseBody
    public ReturnBean insert(User user) throws UnsupportedEncodingException {
        user.setStatus("0");
        validateEntity(user);
        String password = user.getPassword();
        // 密码加密
        password = AesUtils.getAESEncrypt(password, SysConstant.PASS_KEY);
        user.setPassword(password);
        userService.insert(user);
        return ReturnBean.ok();
    }

    /**
     * 修改用户信息
     *
     * @param id 用户id
     * @return
     */
    @RequiresPermissions("sys:user:update")
    @GetMapping("sys/user/update")
    public String update(Integer id) {
        List roleList = roleService.selectAll();
        request.setAttribute("roleList", roleList);
        Map userMap = userService.selectById(id);
        request.setAttribute("user", userMap);
        return "sys/user/update";
    }

    /**
     * 修改用户
     *
     * @param user 用户
     * @return
     */
    @KrtLog(description = "修改用户")
    @RequiresPermissions("sys:user:update")
    @PostMapping("sys/user/update")
    @ResponseBody
    public ReturnBean update(User user) throws Exception {
        String password = user.getPassword();
        //保持原密码不变
        if (StringUtils.isBlank(password)) {
            User sysUser = userService.selectEntityById(user.getId());
            password = sysUser.getPassword();
            //实体验证前密码解密
            password = AesUtils.getAESDecrypt(password, SysConstant.PASS_KEY);
            user.setPassword(password);
        }
        validateEntity(user);
        // 通过实体验证后密码加密
        password = AesUtils.getAESEncrypt(password, SysConstant.PASS_KEY);
        user.setPassword(password);
        userService.update(user);
        return ReturnBean.ok();
    }

    /**
     * 删除用户
     *
     * @param id 用户id
     * @return
     */
    @KrtLog(description = "删除用户")
    @RequiresPermissions("sys:user:delete")
    @PostMapping("sys/user/delete")
    @ResponseBody
    public ReturnBean delete(Integer id) {
        userService.delete(id);
        return ReturnBean.ok();
    }

    /**
     * 删除用户
     *
     * @param ids 用户ids
     * @return
     */
    @KrtLog(description = "批量删除用户")
    @RequiresPermissions("sys:user:delete")
    @PostMapping("sys/user/deleteByIds")
    @ResponseBody
    public ReturnBean deleteByIds(String ids) {
        userService.deleteByIds(ids);
        return ReturnBean.ok();
    }


    /**
     * 禁用||启用用户
     *
     * @param id
     * @param status
     * @return
     */
    @KrtLog(description = "禁用||启用用户")
    @RequiresPermissions("sys:user:status")
    @PostMapping("sys/user/status")
    @ResponseBody
    public ReturnBean status(Integer id, String status) {
        User user = new User();
        user.setId(id);
        user.setStatus(status);
        userService.update(user);
        return ReturnBean.ok();
    }

    /**
     * 查看用户信息
     *
     * @param id 用户id
     * @return
     */
    @RequiresPermissions("sys:user:see")
    @GetMapping("sys/user/see")
    public String see(Integer id) {
        List roleList = roleService.selectAll();
        request.setAttribute("roleList", roleList);
        Map userMap = userService.selectById(id);
        request.setAttribute("user", userMap);
        return "sys/user/see";
    }

    /**
     * 检测用户名
     *
     * @param username 用户名
     * @param id       用户id
     * @return
     */
    @PostMapping("sys/user/checkUsername")
    @ResponseBody
    public Boolean checkUsername(String username, Integer id) {
        Integer count = userService.checkUsername(username, id);
        if (count > 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 修改密码页
     *
     * @return
     */
    @GetMapping("sys/user/updatePsw")
    public String updatePswUI() {
        return "sys/user/updatePsw";
    }

    /**
     * 修改密码
     *
     * @return
     */
    @KrtLog(description = "修改密码")
    @PostMapping("sys/user/updatePsw")
    @ResponseBody
    public ReturnBean updatePsw() throws UnsupportedEncodingException {
        String password = request.getParameter("password");
        User currentUser = ShiroUtils.getCurrentUser();
        User user = new User();
        user.setId(currentUser.getId());
        // 密码加密
        password = AesUtils.getAESEncrypt(password, SysConstant.PASS_KEY);
        user.setPassword(password);
        userService.update(user);
        return ReturnBean.ok();
    }

    /**
     * 检测用户密码
     *
     * @param oldPassword
     * @return
     */
    @PostMapping("sys/user/checkPsw")
    @ResponseBody
    public boolean checkPsw(String oldPassword) throws UnsupportedEncodingException {
        User currentUser = ShiroUtils.getCurrentUser();
        String passwordRe = currentUser.getPassword();
        // 密码加密
        oldPassword = AesUtils.getAESEncrypt(oldPassword, SysConstant.PASS_KEY);
        if (passwordRe.equals(oldPassword)) {
            return true;
        } else {
            return false;
        }
    }
}
