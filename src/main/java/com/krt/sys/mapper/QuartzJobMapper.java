package com.krt.sys.mapper;

import com.krt.common.base.BaseMapper;
import com.krt.sys.entity.QuartzJob;

import java.util.List;
import java.util.Map;

/**
 * @Description: 任务调度映射层
 * @author 殷帅
 * @date 2016年7月22日
 * @version 1.0
 */
public interface QuartzJobMapper extends BaseMapper<QuartzJob> {

	/**
	 * 根据id查询定时任务
	 * @param id 定时任务id
	 * @return
	 */
	@Override
	QuartzJob selectEntityById(Integer id);

	/**
	 * 检测定时任务的组名和任务名时候重复
	 * @param para
	 * @return
	 */
	Integer checkName(Map para);

	/**
	 * 获取定时任务列表
	 * @return
	 */
	List<QuartzJob> selectEntityList();
}