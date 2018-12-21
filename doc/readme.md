## 使用说明

- 维护人：殷帅    发现框架bug请及时反馈  直接Q我.
- 本框架适合类型：ssm + mysql 、iE9或以上浏览器、google、火狐访问
- 演示地址：[http://192.168.1.186:8888/krt-ssm/login](http://192.168.1.186:8888/krt-ssm/login)

##结构说明
    ● --java
    ●      --com
    ●           --krt
    ●                --api                          接口包 （系统提供的接口）
    ●                --common                       核心包（系统共用的库 初始化）
    ●                --oa                           oa管理（oa模块）
    ●                --system                       系统管理（系统的基础模块）
    ●      --generator                              代码生成器
    ● --resources                                   系统资源文件
    ●   --mybatis
    ●            --mapper                           mapper映射文件
    ●   --spring                                    spring配置文件
    ●   --db.properties                             数据库配置
    ●   --ehcache.xml                               缓存配置
    ●   --generator.properties                      代码生成器配置
    ●   --log4j.properties                          日志配置
    ● --webapp                                      web路径
    ●        --static                               静态文件
    ●        --upload                               上传文件
    ●        --WEB_INF
    ●                --view                         jsp页面
    
##涉及技术
    1、后端
        核心框架：Spring 4.3.0.RELEASE
        安全框架：Apache Shiro 1.3.2
        定时任务：Quartz 2.2.1
        视图框架：Spring 4.3.0.RELEASE
        服务端验证：Hibernate Validator 5.4.1
        布局框架：jsp
        持久层框架：MyBatis 3.3.1
        分页工具：Pagehelper 3.7.5
        数据库连接池：Alibaba Druid 1.0.29
        项目监控：javamelody 1.60.0
        缓存框架：Ehcache
        接口工具：swagger 2.4.0
        日志管理：SLF4J 1.7、Log4j
        验证码：kaptcha 0.0.9
        工具类：Apache Commons、fastjson 1.2.30、 krt-generator-ssm
    2、前端
        JQ框架：jQuery 2.1.4
        CSS框架：Twitter Bootstrap 3.3.5 + AdminLte 2.3.7
        客户端验证：jQuery Validate Plugin 1.15。
        数据表格：dataTable 1.10.7
        树数据列表：treetable Plugin 3.2.0
        树结构控件：zTree 3.5
        工具类框架：Layer 3.0.3
        富文本：kindeditor

##开发流程
    1、SVN下载源码、拷贝数据库
    2、清理SVN文件、修改项目名、数据库名、pom的项目名
    3、db.properties 数据库配置、generator.properties 代码生成器配置
    4、修改web.xml  将krt-ssm 修改为新的项目名、修改log4j.properties 将krt-ssm 修改为新的项目名
    5、上传到新的SVN、供其他同事下载开发

##注意事项
    1、框架遵循java驼峰规范、数据库一律采用小写字母加下划线  不允许大小写混合 数据库表名sys_：系统模块表 名开头 业务表名：推荐 业务_表名 例如:oa_notice
    2、使用代码生成器 请添加表注释和字段注释
    3、非中间表一律添加id,inserter,insert_time,updater,update_time 5个字段
    4、Controller：get表示访问jsp,post请求数据
    5、Service：使用了AOP事务 注意方法名 可看spring-mybatis.xml
    6、类、方法、属性的注释尽量规范
    7、减少使用System.out.println()、用log.debug()代替
    8、对于复杂的分页、需要自定义分页方法
        例如：
            select id,name from
            (select id from t_user)s1 left join
            (select name,user_id from t_user_info)s2 on s1.id = s2.user_id
        PageHelper 生成的语句是
            select * from
            (select id,name from
            (select id from t_user)s1 left join
            (select name,user_id from t_user_info)s2 on s1.id = s2.user_id
            )temp limit 0,10
        当t_user数据量太大时  就有问题了
        我们想要的是
            select id,name from
            (select id from t_user limit 0,10)s1 left join
            (select name,user_id from t_user_info)s2 on s1.id = s2.user_id
        这时候 就要自己写分页
        controller：
            para.put("start",start);
            para.put("length",length);
            DataTable dt = service.selectListPara(Integer start, Integer length, Map para);
        service：
            public DataTable selectListPara(Integer start, Integer length, Map para) {
                DataTable dataTable = new DataTable();
                Long count = mapper.selectListCount(para);
                para.put("start", start);
                para.put("length", length);
                ListMap> list = mapper.selectListPara(para);
                dataTable.setData(list);
                dataTable.setRecordsTotal(Long.valueOf(length));
                dataTable.setRecordsFiltered(count);
                return dataTable;
            }
        mapper:
            <select id="selectListPara" resultType="java.util.Map">
                select id,name from
                (select id from t_user limit ${start},${length})s1 left join
                (select name,user_id from t_user_info)s2 on s1.id = s2.user_id
            <select>

           <select id="selectListCount" resultType="java.lang.Long">
                select count(id) from t_user
            <select>
    9 代码生成器的jar包 放在公司的私服上 为SNAPSHOT版 下载SNAPSHOT的jar请配置 MAVNE的settings.xml
        在<profiles></profiles>节点里添加以下代码
        <profile>
            <id>nexus</id>
            <activation>
            <activeByDefault>true</activeByDefault>
            </activation>
            <repositories>
                <repository>
                    <id>maven-releases</id>
                    <url>http://192.168.1.100:8081/nexus/content/repositories/releases/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>false</enabled></snapshots>
                </repository>
                <repository>
                    <id>maven-snapshots</id>
                    <url>http://192.168.1.100:8081/nexus/content/repositories/snapshots/</url>
                    <releases><enabled>false</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </repository>
            </repositories>
        </profile>

## 版本：1.0 更新时间：2017-6-21
    1、初始化系统
    
## 版本：1.1 更新时间：2017-6-30
    1、添加列表批量删除功能
    2、 同步升级代码生成器
    3、 Assert类 添加返回true||false 方法
    4、 bug修复    
    
## 版本：1.2 更新时间：2017-7-6
    1、 添加多数据源功能 实现数据库读写分离 添加 KrtDataSourceAspect切面（默认注释了AOP注解  若有多数据源的使用需求请还原注解）、core下的db包
    2、 多数据源配置 放在 resources下的dynamicDataSource文件夹 替换系统配置
    3、 事务bug修复

## 版本：1.3 更新时间：2017-7-8

    1、 UI优化
    2、 优化系统日志模块
    3、 整合spring && redis && shiro 实现系统缓存 、redis实现springCache、shiro权限、分布式session管理
    4、 cache     包新增 RediShiroCacheManager、 RedisShiroCache
    5、 exception 包新增  KrtSessionNotFoundException(用于guava处理session的二级缓存)
    6、 shiro     包新增 RedisSessionDAO、SessionCache
    7、 resources 新增 redis文件夹 redis.properties、spring-shiro.xml、spring-redis.xml
    8、 代码生成器更新到1.3
   
## 使用redis接管系统缓存步骤：
    1、将resources/redis文件夹中的 redis.properties 拷贝到resources根目录 并修改redis配置
    2、将resources/redis文件夹中的 spring-shiro.xml 替换 resources/spring/spring-shiro.xml
    3、 将resources/redis文件夹中的 spring-redis.xml 拷贝到resources/spring目录
    4、 spring-context.xml的propertyConfigurer 添加  redis.properties
        spring-context.xml 添加 spring-redis.xml引用
        spring-context.xml 去掉 spring-ehcache.xml引用 并删除 spring-ehcache.xml
    5、 去掉 ehcache.xml
        删除系统的 Ehcache缓存管理模块
        删除resources/redis文件夹          
        
## 版本：1.4 更新时间：2017-08-08

    1、 框架结构调整、core包改成common、便于后面的模块化结构统一
    2、 修改common/ReturnBean、添加统一响应码 枚举ReturnCode 便于接口对接开发
    3、 修改BaseService insert 方法改为返回Integer 主键
    4、 系统部分bug修复、部分样式调整
    5、 添加清空系统缓存操作（首页按钮）
    6、 修复quartz线程关闭问题
    7、 代码生成器同步更新到1.4、数据库文件更新admin-v1.4.sql
    8、 更新KrtLog 添加属性para :控制日志是否记录方法的参数 true:记录（默认） false:不记录

## 版本：1.4.1 更新时间：2017-09-12

    1、新增FileUtil工具类    
    2、重新封装HttpUtil类
    
## 版本：1.5 更新时间：2017-10-16
    
    1、 重点优化了项目的ui 更友好支持响应式 重构项目的静态文件目录 
    2、 添加quartz.properties自定义控制quartz
    3、 优化log4j日志显示格式
    4、 代码生成器同步更新到1.5（UI更新、代码规范遵循阿里代码规范）、数据库文件更新admin-v1.5.sql
    5、 修复系统bug、页面用变量${basePath} 代替 <%=basePath%>
    6、 根据阿里代码规范修改框架代码
    
## 版本：1.6 更新时间：2017-10-24
    
    1、 BaseService
          去掉：
             DataTable selectList(Integer start, Integer length); //无参数分页
             selectListPara(Integer start, Integer length, Map para) //带参数分页
          新增：
             DataTable selectList(Map para); //分页
    2、 BaseServiceImpl 
          去掉：
              DataTable selectList(Integer start, Integer length); //无参数分页
              selectListPara(Integer start, Integer length, Map para) //带参数分页
          新增：
              DataTable selectList(Map para); //分页
    3、 BaseMapper    
          去掉：
             List<Map> selectList(); //无参数分页
             List<Map> selectListPara(Map para); //带参数分页
          新增：
             List<Map> selectList(Map para); //分页
             List selectAll(); //查询全部
    4、controller 利用spring注解@RequestParam自动获取参数装载到map 避免手动获取
          eg:以前管理列表controller获取参数： 
                 public DataTable list(Integer start, Integer length) {
                        Map para = new HashMap(5);
                        para.put("username", request.getParameter("username"));
                        para.put("name", request.getParameter("name"));
                        para.put("roleCode", request.getParameter("roleCode"));
                        para.put("organizationCode", request.getParameter("organizationCode"));
                        para.put("status", request.getParameter("status"));
                        DataTable dt = userService.selectListPara(start, length, para);
                        return dt;
                 }
          现在自动获取参数：
                 public DataTable list(@RequestParam Map para) {
                        DataTable dt = userService.selectList(para);
                        return dt;
                 }
    5、自定义分页方法
          controller：
              DataTable dt = service.selectList(Map para);
              
          service：
              public DataTable selectList(Map para) {
                  DataTable dataTable = new DataTable();
                  Long count = mapper.selectListCount(para);
                  ListMap> list = mapper.selectList(para);
                  dataTable.setData(list);
                  dataTable.setRecordsFiltered(count);
                  return dataTable;
              }
              
          mapper:
              <select id="selectList" resultType="java.util.Map">
                  select id,name from
                  (select id from t_user limit ${start},${length})s1 left join
                  (select name,user_id from t_user_info)s2 on s1.id = s2.user_id
              <select>
      
              <select id="selectListCount" resultType="java.lang.Long">
                  select count(id) from t_user
              <select>
             
    6、 代码生成器同步更新到1.6   
    7、 系统管理添加在线用户管理模块
    8、 数据库同步更新到1.6版  
            
## 版本：1.6.1 更新时间：2017-11-20

     1、集成fastDFS   
     2、api token鉴权升级
![](https://www.krtimg.com/group1/M00/01/6D/05XcSFoQxcuAalBIAACyVzTT52Y891.png)

## 版本：1.6.2 更新时间：2018-01-04
    1、修改RedisSessionDAO修复分布式session bug
    
## 版本：1.6.3 更新时间：2018-03-10
    1、优化区域管理
    2、代码生成器升级到1.6.3
        新增new GenPermissionUtil(packageName, tableName, entityName);
        添加资源菜单功能~ 
        默认添加管理菜单、新增按钮、修改按钮、删除按钮
        菜单的默认排序为99、级别为顶级 （手动修改排序 和 父级菜单即可）
        系统资源管理做了系统缓存、需要修改任意资源 才能看到新的数据
![](https://www.krtimg.com/group1/M00/00/1C/rAA0KVqjPoKAfhS7AABun5LJDAg529.png)

## 版本：1.6.4 更新时间：2018-04-18
    1、使用KrtWebSessionManager 替换之前的二级缓存GuavaCache方案 减少shiro多次请求readSession频繁访问redis
       删除SessionCache
       新增KrtWebSessionManager
       修改redis/spring-shiro.xml
       
## 版本：1.6.5 更新时间：2018-04-25
    1、修复token重复检测bug

## 版本：1.6.6 更新时间：2018-04-28
    1、框架添加批量添加方法 insertBatch
    2、代码生成器1.6.6.2-SNAPSHOT（支持oracle、批量添加方法生成）
    3、修改system 简写成sys
    4、修改数据库 t_ 改成 sys_ ,sql 升级到 krt-ssm-1.6.6.sql
    5、common 新增mvc 包CustomObjectMapper 将json序列化的null转为空字符串
                         
## 版本：2.0.0 更新时间：2018-05-05
    1、新增krt.properties 全局配置 代码可以通过 SysContant.getValue(key)获取
    1、结构调整 service 拆分接口层 和 实现层 （便于服务化解耦拓展、service方法太多不易浏览）
    2、使用lombok 简化bean 省去get set toString 方法
    3、优化系统日志 采用异步线程录入日志 提升性能 代码使用lombok的@Slf4j 简化日志使用 新增日志拦截器打印系统操作日志 优化log4j配置
    4、优化系统缓存
    5、新增 gen包 代码生成WEB版 目前支持单表生成（列表搜索条件、列自定义、新增、修改表单属性、验证、排序、字典绑定） 
       后续将支持主从表、树 、复杂表单属性
    6、新增自定义标签 ${krt:dic}  ${krt:cDic} 简化字典的使用
    以前：
     控制层:
     @Autowired
     private DictionaryTypeService dictionaryTypeService;
     List xxList = dictionaryService.selectDicByType("字典编码");
     request.setAttribute("xxList",xxList);
     页面层
     <select class="form-control" name="type" required>
        <option value="">==请选择==</option>
        <c:forEach items="${xxList}" var="type">
            <option value="${type.code}">${type.name}</option>
        </c:forEach>
    </select>
    现在：
     控制层无需任何代码
     页面层：
     <select class="form-control" name="type" required>
         <option value="">==请选择==</option>
         <c:forEach items="${krt:dic('region_type')}" var="type">
             <option value="${type.code}">${type.name}</option>
         </c:forEach>
     </select>
     
 ## 版本：2.0.1 更新时间：2018-05-10
    1、代码生成器支持主从表（可能有bug）、树 、复杂表单属性
 
 ## 版本：2.0.2 更新时间：2018-05-18
    1、SWAGGER添加动态开关 在krt.properties配置swagger.enable  true可以访问接口页面 false不可以访问 建议生成环境设置成false
    2、重新编写HttpUtils工具类 工具类命名规则：包名util  类名XXUtils(学习Apache、spring 命名方式)
    3、代码生成器列表支持自定义排序（不支持tree结构）（支持多排序、不支持组合排序（请按代码举一反三））
    4、代码生成器支持导入、导出功能 导入选择以实体类型导入、导出以Map导出（拓展性更强）
     如果需要map导入 实体导出、指定模板  请自行写代码处理
[easyPoi文档](http://easypoi.mydoc.io/)
     
    
    
    
    
    
    
    
    
    
    
    
                      