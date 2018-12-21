<#include "../serviceImpl.ftl">
package ${genTable.genScheme.packageName}.service.impl;

import org.springframework.stereotype.Service;
import ${genTable.genScheme.packageName}.entity.${genTable.className};
import ${genTable.genScheme.packageName}.mapper.${genTable.className}Mapper;
import ${genTable.genScheme.packageName}.service.${genTable.className}Service;
import com.krt.common.base.BaseServiceImpl;
import java.util.List;
import java.util.Map;

/**
 * @author ${genTable.genScheme.coder}
 * @version 1.0
 * @Description: ${genTable.comment}服务接口实现层
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss")}
 */
@Service
public class ${genTable.className}ServiceImpl extends BaseServiceImpl<${genTable.className}Mapper,${genTable.className}> implements ${genTable.className}Service {

    /**
     * 查询treeList
     *
     * @param para
     * @return
     */
    @Override
    public List selectTreeList(Map para) {
         return baseMapper.selectTreeList(para);
    }

    /**
     * 查询树结构
     * @return
     */
    @Override
    public List selectAllTree() {
         return baseMapper.selectAllTree();
    }

    <@excelOut genTable></@excelOut>
}
