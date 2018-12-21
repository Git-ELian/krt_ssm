<#include "../mapper.ftl">
package ${genTable.genScheme.packageName}.mapper;

import com.krt.common.base.BaseMapper;
import ${genTable.genScheme.packageName}.entity.${genTable.className};
import java.util.List;
import java.util.Map;

/**
 * @author ${genTable.genScheme.coder}
 * @version 1.0
 * @Description: ${genTable.comment}映射层
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss")}
 */
public interface ${genTable.className}Mapper extends BaseMapper<${genTable.className}>{

    /**
    * 查询tree
    *
    * @param para
    * @return
    */
    List selectTreeList(Map para);
 
    /**
    * 查询树结构
    *
    * @return
    */
    List selectAllTree();

    <@excelOut genTable></@excelOut>
}
