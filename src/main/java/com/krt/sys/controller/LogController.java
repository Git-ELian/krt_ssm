package com.krt.sys.controller;

import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import com.krt.sys.service.LogService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 日志管理控制层
 * @date 2016年7月21日
 */
@Slf4j
@Controller
public class LogController extends BaseController {

    @Autowired
    private LogService logService;

    /**
     * 日志管理页
     *
     * @return
     */
    @RequiresPermissions("sys:log:list")
    @GetMapping("sys/log/list")
    public String list() {
        return "sys/log/list";
    }

    /**
     * 日志管理
     *
     * @return
     */
    @RequiresPermissions("sys:log:list")
    @PostMapping("sys/log/list")
    @ResponseBody
    public DataTable list(@RequestParam Map para) {
        DataTable dt = logService.selectList( para);
        return dt;
    }

    /**
     * 清空日志
     *
     * @return
     */
    @KrtLog(description = "清空日志")
    @RequiresPermissions("sys:log:deleteAll")
    @PostMapping("sys/log/deleteAll")
    @ResponseBody
    public ReturnBean deleteAll() {
        logService.deleteAll();
        return ReturnBean.ok();
    }

}
