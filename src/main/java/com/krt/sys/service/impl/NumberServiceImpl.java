package com.krt.sys.service.impl;

import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.Number;
import com.krt.sys.mapper.NumberMapper;
import com.krt.sys.service.NumberService;
import org.springframework.aop.framework.AopContext;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 流水号服务实现层
 * @date 2017年05月17日
*/
@Service
public class NumberServiceImpl extends BaseServiceImpl<NumberMapper, Number> implements NumberService {

	@CacheEvict(value="numCache",allEntries=true)
	@Override
	public void delete(Integer id) {
		super.delete(id);
	}

	@CacheEvict(value="numCache",allEntries=true)
	@Override
	public void update(Number entity) {
		super.update(entity);
	}

	@Cacheable(value = "numCache")
	public Map selectByCode(String code){
		return baseMapper.selectByCode(code);
	}

    @Override
	public Integer checkNumber(Integer id, String code) {
		return baseMapper.checkNumber(id,code);
    }

	/**
	 * 获取流水号
	 * @param code 通过数据库行级锁获取流水号
	 * @return
	 */
	@Override
	public String selectNum(String code){
		Map numMap = ((NumberServiceImpl)AopContext.currentProxy()).selectByCode(code);
		Integer id = Integer.valueOf(numMap.get("id")+"");
		Map paraMap = new HashMap(1);
		paraMap.put("idd",id);
		return baseMapper.selectNum(paraMap);
	}
}
