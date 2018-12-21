<#include "../service.ftl">
package ${genTable.genScheme.packageName}.service;

import ${genTable.genScheme.packageName}.entity.${genTable.className};
import com.krt.common.base.BaseService;
import java.util.Map;
import java.util.List;

/**
 * @author ${genTable.genScheme.coder}
 * @version 1.0
 * @Description: ${genTable.comment}服务接口层
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss")}
 */
public interface ${genTable.className}Service extends BaseService<${genTable.className}>{

<@excelOut genTable></@excelOut>

}
