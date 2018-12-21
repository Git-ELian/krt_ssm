<#include "../service.ftl">
package ${genTable.genScheme.packageName}.service;

import ${genTable.genScheme.packageName}.entity.${genTable.className};
import com.krt.common.base.BaseService;
import java.util.List;
import java.util.Map;

/**
 * @author ${genTable.genScheme.coder}
 * @version 1.0
 * @Description: ${genTable.comment}服务接口层
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss")}
 */
public interface ${genTable.className}Service extends BaseService<${genTable.className}>{

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
