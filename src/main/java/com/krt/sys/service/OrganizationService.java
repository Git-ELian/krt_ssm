package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.Organization;

import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 组织机构服务接口层
 * @date 2017年05月17日
*/
public interface OrganizationService extends BaseService<Organization> {

	/**
	 * 检查机构代码是否重复
	 * @param id
	 * @param code
	 * @return
	 */
     Integer checkCode(Integer id, String code);

	/**
	 * 获取组织树
	 * @return
	 */
	 List selectAllTree();

	/**
	 * 根据参数查询
	 * @param para
	 * @return
	 */
	 List selectListNoPage(Map para);

}
