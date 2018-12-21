package com.krt.sys.controller;

import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import com.krt.sys.entity.Number;
import com.krt.sys.service.NumberService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 流水号控制层
 * @date 2017年05月17日
 */
@Slf4j
@Controller
public class NumberController extends BaseController {

	@Autowired
	private NumberService numberService;


	/**
	 * 流水号管理页
	 *
	 * @return
	 */
	@RequiresPermissions("sys:number:list")
	@GetMapping("sys/number/list")
	public String list() {
		return "sys/number/list";
	}

	/**
	 * 流水号管理
	 *
	 * @return
	 */
	@RequiresPermissions("sys:number:list")
	@PostMapping("sys/number/list")
	@ResponseBody
	public DataTable list(@RequestParam Map para) {
		DataTable dt = numberService.selectList(para);
		return dt;
	}

	/**
	 * 新增流水号页
	 *
	 * @return
	 */
	@RequiresPermissions("sys:number:insert")
	@GetMapping("sys/number/insert")
	public String insert() {
		return "sys/number/insert";
	}

	/**
	 * 添加流水号
	 *
	 * @param number 流水号
	 * @return
	 */
	@KrtLog(description = "添加流水号")
	@RequiresPermissions("sys:number:insert")
	@PostMapping("sys/number/insert")
	@ResponseBody
	public ReturnBean insert(Number number) {
		validateEntity(number);
		numberService.insert(number);
		return ReturnBean.ok();
	}

	/**
	 * 修改流水号页
	 *
	 * @param id 流水号 id
	 * @param request
	 * @return
	 */
	@RequiresPermissions("sys:number:update")
	@GetMapping("sys/number/update")
	public String update(Integer id, HttpServletRequest request) {
		Map numberMap = numberService.selectById(id);
		request.setAttribute("number", numberMap);
		return "sys/number/update";
	}

	/**
	 * 修改流水号
	 *
	 * @param number 流水号
	 * @return
	 */
	@KrtLog(description = "修改流水号")
	@RequiresPermissions("sys:number:update")
	@PostMapping("sys/number/update")
	@ResponseBody
	public ReturnBean update(Number number) {
		validateEntity(number);
		numberService.update(number);
		return  ReturnBean.ok();
	}

	/**
	 * 删除流水号
	 *
	 * @param id 流水号 id
	 * @return
	 */
	@KrtLog(description = "删除流水号")
	@RequiresPermissions("sys:number:delete")
	@PostMapping("sys/number/delete")
	@ResponseBody
	public ReturnBean delete(Integer id) {
		numberService.delete(id);
		return ReturnBean.ok();
	}

	/**
	 * 批量删除流水号
	 *
	 * @param ids 流水号 ids
	 * @return
	 */
	@KrtLog(description = "批量删除流水号")
	@RequiresPermissions("sys:number:delete")
	@PostMapping("sys/number/deleteByIds")
	@ResponseBody
	public ReturnBean deleteByIds(String ids) {
		numberService.deleteByIds(ids);
		return ReturnBean.ok();
	}

	/**
	 * 检查流水号编码是否重复
	 * @param id
	 * @param code
	 * @return
	 */
	@PostMapping("sys/number/checkNumber")
	@ResponseBody
	public Boolean checkNumber(Integer id,String code){
		Integer count = numberService.checkNumber(id,code);
		if(count>0){
			return false;
		}else{
			return true;
		}
	}
}
