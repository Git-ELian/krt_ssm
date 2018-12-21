package com.krt.sys.service;

import com.krt.common.base.BaseService;
import com.krt.sys.entity.Number;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 流水号服务接口层
 * @date 2017年05月17日
*/
public interface NumberService extends BaseService<Number> {

	/**
	 * 获取流水号
	 * @param code 通过数据库行级锁获取流水号
	 * @return
	 */
	 String selectNum(String code);

	/**
	 * 检测流水号编码
	 * @param id
	 * @param code
	 * @return
	 */
    Integer checkNumber(Integer id, String code);
}
