<#include "validate.ftl">
<#--
组件
column 字段属性
genTable 表属性
doType 操作类型 insert：添加 update:修改
index 是否是子表单 是：>=0 不是 -1
-->
<#macro component column genTable doType index>
<#-- 文本组件 -->
    <#if column.showType=='text' && doType=='insert'>
    <input type="text" id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="form-control"<@validate (column.validate!"")/>>
    </#if>
    <#if column.showType=='text' && doType=='update'>
    <input type="text" id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" value="${"$"}{${genTable.className?uncap_first}.${column.javaField}}" class="form-control"<@validate (column.validate!"")/>>
    </#if>
    <#if column.showType=='text' && doType=='query'>
    <input type="text" id="${column.javaField}" name="${column.javaField}" class="form-control">
    </#if>
<#-- 多行文本组件 -->
    <#if column.showType=='textarea' && doType=='insert'>
    <textarea rows="2" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="form-control"<@validate (column.validate!"")/>></textarea>
    </#if>
    <#if column.showType=='textarea' && doType=='update'>
    <textarea rows="2" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="form-control"<@validate (column.validate!"")/>>${"$"}{${genTable.className?uncap_first}.${column.javaField}}</textarea>
    </#if>
    <#if column.showType=='textarea' && doType=='query'>
    <textarea rows="2" name="${column.javaField}" class="form-control"></textarea>
    </#if>
<#-- 单选框组件 -->
    <#if column.showType=='radio' && doType=='insert'>
        <#if column.dicType != ''>
        <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
            <input type="radio" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="i-checks" value="${"$"}{${column.javaField}Dic.code}"<@validate (column.validate!"")/>> ${"$"}{${column.javaField}Dic.name}
        </c:forEach>
        </#if>
    </#if>
    <#if column.showType=='radio' && doType=='update'>
        <#if column.dicType != ''>
        <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
            <input type="radio"  name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" ${"$"}{ ${genTable.className?uncap_first}.${column.javaField}==${column.javaField}Dic.code ? 'checked':''} class="i-checks" value="${"$"}{${column.javaField}Dic.code}"<@validate (column.validate!"")/>> ${"$"}{${column.javaField}Dic.name}
        </c:forEach>
        </#if>
    </#if>
    <#if column.showType=='radio' && doType=='query'>
        <#if column.dicType != ''>
        <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
            <input type="radio" name="${column.javaField}" class="i-checks" value="${"$"}{${column.javaField}Dic.code}"> ${"$"}{${column.javaField}Dic.name}
        </c:forEach>
        </#if>
    </#if>
<#-- 复选框组件 -->
    <#if column.showType=='checkbox' && doType=='insert'>
        <#if column.dicType != ''>
        <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
            <input type="checkbox" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="i-checks" value="${"$"}{${column.javaField}Dic.code}"<@validate (column.validate!"")/>> ${"$"}{${column.javaField}Dic.name}
        </c:forEach>
        </#if>
    </#if>
    <#if column.showType=='checkbox' && doType=='update'>
        <#if column.dicType != ''>
        <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
            <input type="checkbox" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}"
            <c:if test="${"$"}{krt:contains(${genTable.className?uncap_first}.${column.javaField}, ${column.javaField}Dic.code)}">checked</c:if>
            class="i-checks" value="${"$"}{${column.javaField}Dic.code}"<@validate (column.validate!"")/>> ${"$"}{${column.javaField}Dic.name}
        </c:forEach>
        </#if>
    </#if>
    <#if column.showType=='checkbox' && doType=='query'>
        <#if column.dicType != ''>
        <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
            <input type="checkbox" name="${column.javaField}" class="i-checks" value="${"$"}{${column.javaField}Dic.code}"> ${"$"}{${column.javaField}Dic.name}
        </c:forEach>
        </#if>
    </#if>
<#-- 下拉框框组件 -->
    <#if column.showType=='select' && doType=='insert'>
    <select class="form-control" id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}"<@validate (column.validate!"")/>>
        <option value="">==请选择==</option>
        <#if column.dicType != ''>
            <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
                <option value="${"$"}{${column.javaField}Dic.code}">${"$"}{${column.javaField}Dic.name}</option>
            </c:forEach>
        </#if>
    </select>
    </#if>
    <#if column.showType=='select' && doType=='update'>
    <select class="form-control" id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}"<@validate (column.validate!"")/>>
        <option value="">==请选择==</option>
        <#if column.dicType != ''>
            <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
                <option value="${"$"}{${column.javaField}Dic.code}" ${"$"}{ ${genTable.className?uncap_first}.${column.javaField}==${column.javaField}Dic.code ? 'selected':''}>${"$"}{${column.javaField}Dic.name}</option>
            </c:forEach>
        </#if>
    </select>
    </#if>
    <#if column.showType=='select' && doType=='query'>
    <select class="form-control" id="${column.javaField}" name="${column.javaField}">
        <option value="">==请选择==</option>
        <#if column.dicType != ''>
            <c:forEach items="${"$"}{krt:dic('${column.dicType}')}" var="${column.javaField}Dic">
                <option value="${"$"}{${column.javaField}Dic.code}">${"$"}{${column.javaField}Dic.name}</option>
            </c:forEach>
        </#if>
    </select>
    </#if>
<#-- 编辑器组件 -->
    <#if column.showType=='editor' && doType=='insert'>
    <textarea id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="form-control"<@validate (column.validate!"")/>></textarea>
    </#if>
    <#if column.showType=='editor' && doType=='update'>
    <textarea id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="form-control"<@validate (column.validate!"")/>>${"$"}{${genTable.className?uncap_first}.${column.javaField}}</textarea>
    </#if>
    <#if column.showType=='editor' && doType=='query'>
    <textarea id="${column.javaField}<#if index!='-1'>${index}</#if>" name="${column.javaField}" class="form-control"></textarea>
    </#if>
<#-- 日期组件 -->
    <#if column.showType=='date' && doType=='insert'>
    <input type="text" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" id="${column.javaField}<#if index!='-1'>${index}</#if>" class="Wdate form-control" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"<@validate (column.validate!"")/>/>
    </#if>
    <#if column.showType=='date' && doType=='update'>
    <input type="text" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" id="${column.javaField}<#if index!='-1'>${index}</#if>" value="${"$"}{${genTable.className?uncap_first}.${column.javaField}}" class="Wdate form-control" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"<@validate (column.validate!"")/>/>
    </#if>
    <#if column.showType=='date' && doType=='query'>
    <input type="text" name="${column.javaField}" id="${column.javaField}" value="${"$"}{${genTable.className?uncap_first}.${column.javaField}}" class="Wdate form-control" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
    </#if>
<#-- 文件组件 -->
    <#if column.showType=='file' && doType=='insert'>
    <div class="input-group">
        <input class="form-control" type="text" id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="form-control" readonly="readonly"<@validate (column.validate!"")/>/>
        <span class="input-group-btn">
              <button class="btn btn-primary btn-flat upload" id="${column.javaField}Btn" type="button" value="上传" ignore>上传</button>
        </span>
    </div>
    </#if>
    <#if column.showType=='file' && doType=='update'>
    <div class="input-group">
        <input class="form-control" type="text" id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" value="${"$"}{${genTable.className?uncap_first}.${column.javaField}}" class="form-control" readonly="readonly"<@validate (column.validate!"")/>/>
        <span class="input-group-btn">
          <button class="btn btn-primary btn-flat upload" id="${column.javaField}Btn" type="button" value="上传" ignore>上传</button>
        </span>
    </div>
    </#if>
<#-- 图片上传 -->
    <#if column.showType=='img' && doType=='insert'>
    <div class="input-group">
        <input class="form-control" type="text" id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" class="form-control" readonly="readonly"<@validate (column.validate!"")/>/>
        <span class="input-group-btn">
             <button class="btn btn-primary btn-flat upload" id="${column.javaField}Btn" type="button" value="上传" ignore>上传</button>
             <button class="btn btn-primary btn-flat" style="width: 70px" id="${column.javaField}SeeBtn" type="button" value="预览" ignore>预览</button>
        </span>
    </div>
    <script>
        $("#${column.javaField}SeeBtn").click(function () {
            var url = $("#${column.javaField}").val();
            if (url != null && url != '') {
                url = '${"$"}{filePath}' + url;
                window.open(url, "_blank");
            }
        });
    </script>
    </#if>
    <#if column.showType=='img' && doType=='update'>
    <div class="input-group">
        <input class="form-control" type="text" id="${column.javaField}<#if index!='-1'>${index}</#if>" name="<#if index!='-1'>${genTable.className?uncap_first}[${index}].</#if>${column.javaField}" value="${"$"}{${genTable.className?uncap_first}.${column.javaField}}" class="form-control" readonly="readonly"<@validate (column.validate!"")/>/>
        <span class="input-group-btn">
              <button class="btn btn-primary btn-flat upload" id="${column.javaField}Btn" type="button" value="上传" ignore>上传</button>
              <button class="btn btn-primary btn-flat" style="width: 70px" id="${column.javaField}SeeBtn" type="button" value="预览" ignore>预览</button>
            </span>
    </div>
    <script>
        $("#${column.javaField}SeeBtn").click(function () {
            var url = $("#${column.javaField}").val();
            if (url != null && url != '') {
                url = '${"$"}{filePath}' + url;
                window.open(url, "_blank");
            }
        });
    </script>
    </#if>
<#-- 父级树 -->
    <#if column.showType=='ptree' && column.name=='pid' && doType=='insert'>
    <div class="input-group">
        <input type="text" name="pname" value="${"$"}{${genTable.className?uncap_first}.name}" id="pname" class="form-control" readonly="readonly"<@validate (column.validate!"")/>>
        <span class="input-group-btn">
            <button class="btn btn-primary btn-flat" id="${genTable.className?uncap_first}TreeBtn" type="button"><i class="fa fa-search"></i></button>
            <button class="btn btn-danger btn-flat" id="cancle${genTable.className}TreeBtn" type="button"><i class="fa fa-times"></i></button>
        </span>
        <#-- 参数 -->
        <input type="hidden" name="pid" id="pid" value="${"$"}{${genTable.className?uncap_first}.id==null?" 0":${genTable.className?uncap_first}.id}" class="form-control">
    </div>
    </#if>
    <#if column.showType=='ptree' && column.name=='pid' && doType=='update'>
    <div class="input-group">
        <input type="text" id="pname" value="${"$"}{pMap.name}" class="form-control" readonly="readonly">
        <span class="input-group-btn">
            <button class="btn btn-primary btn-flat" id="${genTable.className?uncap_first}TreeBtn" type="button"><i class="fa fa-search"></i></button>
            <button class="btn btn-danger btn-flat" id="cancle${genTable.className}TreeBtn" type="button"><i class="fa fa-times"></i></button>
        </span>
        <!-- 参数 -->
        <input type="hidden" name="pid" id="pid" value="${"$"}{pMap.id}" class="form-control">
    </div>
    </#if>
</#macro>
