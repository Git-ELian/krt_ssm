package com.krt.sys.controller;

import com.krt.common.base.BaseController;
import com.krt.sys.entity.User;
import com.krt.sys.service.RoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Description:后台首页控制层
 * @author 殷帅
 * @date 2016年7月16日
 * @version 1.0
 */
@Slf4j
@Controller
public class IndexController extends BaseController {
	
	@Autowired
	private RoleService roleService;

	/**
	 * 后台管理页
	 * 
	 * @return
	 */
	@GetMapping("index")
	public String index() {
		return "index";
	}

	/**
	 * 欢迎页
	 * @return
	 */
	@GetMapping("welcome")
	public String welcome(){
		return "welcome";
	}
	
	/**
	 * 用户登录成功 获取URL菜单
	 * @return
	 */
	@PostMapping("selectRoleRes")
	@ResponseBody
	public List selectRoleRes(){
		User currentUser = getCurrentUser();
		log.debug("当前登录用户:currentUser:{}",currentUser);
		String roleCode = currentUser.getRoleCode();
		log.debug("当前用户角色:roleCode:{}",roleCode);
		List resList = roleService.selectRoleUrlRes(roleCode,0);
		return resList;
	}


}
