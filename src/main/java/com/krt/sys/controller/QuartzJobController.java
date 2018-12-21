package com.krt.sys.controller;

import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import com.krt.common.util.SpringUtils;
import com.krt.sys.entity.QuartzJob;
import com.krt.sys.service.QuartzJobService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.quartz.CronScheduleBuilder;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 任务调度控制层
 * @date 2016年7月22日
 */
@Slf4j
@Controller
public class QuartzJobController extends BaseController {

    @Autowired
    private QuartzJobService quartzJobService;

    /**
     * 表达式设置
     *
     * @return
     */
    @GetMapping("sys/quartzJob/quartzCron")
    public String quartzCron() {
        return "sys/quartzJob/quartzCron";
    }

    /**
     * 任务调度管理
     *
     * @return
     */
    @RequiresPermissions("sys:quartzJob:list")
    @GetMapping("sys/quartzJob/list")
    public String list() {
        return "sys/quartzJob/list";
    }

    /**
     * 任务调度管理
     *
     * @return
     */
    @RequiresPermissions("sys:quartzJob:list")
    @PostMapping("sys/quartzJob/list")
    @ResponseBody
    public DataTable list(@RequestParam Map para) {
        DataTable dg = quartzJobService.selectList(para);
        return dg;
    }

    /**
     * 添加任务
     *
     * @return
     */
    @RequiresPermissions("sys:quartzJob:insert")
    @GetMapping("sys/quartzJob/insert")
    public String insert() {
        return "sys/quartzJob/insert";
    }

    /**
     * 添加任务
     *
     * @param quartzJob
     * @return
     */
    @KrtLog(description = "添加任务")
    @RequiresPermissions("sys:quartzJob:insert")
    @PostMapping("sys/quartzJob/insert")
    @ResponseBody
    public ReturnBean insert(QuartzJob quartzJob) {
        try {
            CronScheduleBuilder.cronSchedule(quartzJob.getExpression());
        } catch (Exception e) {
            return ReturnBean.error("cron表达式有误，不能被解析！");
        }
        Object obj = null;
        try {
            if (quartzJob.getSpringId() != null && !"".equals(quartzJob.getSpringId())) {
                obj = SpringUtils.getBean(quartzJob.getSpringId());
            } else {
                Class clazz = Class.forName(quartzJob.getBeanClass());
                obj = clazz.newInstance();
            }
        } catch (Exception e) {
            return ReturnBean.error("执行任务类不存在");
        }
        if (obj == null) {
            return ReturnBean.error("执行任务类不存在");
        } else {
            Class clazz = obj.getClass();
            Method method = null;
            try {
                method = clazz.getMethod(quartzJob.getMethod());
            } catch (Exception e) {
                return ReturnBean.error("未找到目标方法");
            }
            if (method == null) {
                return ReturnBean.error("未找到目标方法");
            }
        }
        quartzJob.setStatus("0");
        quartzJob.setIsConcurrent("0");
        quartzJobService.insert(quartzJob);
        return ReturnBean.ok();
    }

    /**
     * 启动 or 停止任务
     *
     * @param id
     * @param status
     * @return
     */
    @KrtLog(description = "启动or停止任务")
    @PostMapping("sys/quartzJob/startOrStop")
    @ResponseBody
    public ReturnBean startOrStop(Integer id, String status) throws SchedulerException {
        quartzJobService.updateStatus(id, status);
        return ReturnBean.ok();
    }

    /**
     * 修改任务页
     *
     * @return
     */
    @RequiresPermissions("sys:quartzJob:update")
    @GetMapping("sys/quartzJob/update")
    public String update(Integer id, Model model) {
        Map quartzJob = quartzJobService.selectById(id);
        model.addAttribute("quartzJob", quartzJob);
        return "sys/quartzJob/update";
    }

    /**
     * 修改任务
     *
     * @param quartzJob
     * @return
     */
    @KrtLog(description = "修改任务")
    @RequiresPermissions("sys:quartzJob:update")
    @PostMapping("sys/quartzJob/update")
    @ResponseBody
    public ReturnBean update(QuartzJob quartzJob) {
        try {
            CronScheduleBuilder.cronSchedule(quartzJob.getExpression());
        } catch (Exception e) {
            return ReturnBean.error("cron表达式有误，不能被解析！");
        }
        Object obj = null;
        try {
            if (quartzJob.getSpringId() != null && !"".equals(quartzJob.getSpringId())) {
                obj = SpringUtils.getBean(quartzJob.getSpringId());
            } else {
                Class clazz = Class.forName(quartzJob.getBeanClass());
                obj = clazz.newInstance();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnBean.error("执行任务类不存在");
        }
        if (obj == null) {
            return ReturnBean.error("执行任务类不存在");
        } else {
            Class clazz = obj.getClass();
            Method method = null;
            try {
                method = clazz.getMethod(quartzJob.getMethod());
            } catch (Exception e) {
                return ReturnBean.error("未找到目标方法");
            }
            if (method == null) {
                return ReturnBean.error("未找到目标方法");
            }
        }
        quartzJobService.update(quartzJob);
        return ReturnBean.ok();
    }

    /**
     * 删除任务
     *
     * @param id
     * @return
     */
    @KrtLog(description = "删除任务")
    @RequiresPermissions("sys:quartzJob:delete")
    @PostMapping("sys/quartzJob/delete")
    @ResponseBody
    public ReturnBean delete(Integer id) {
        quartzJobService.delete(id);
        return ReturnBean.ok();
    }


    /**
     * 批量删除任务
     *
     * @param ids
     * @return
     */
    @KrtLog(description = "批量删除任务")
    @RequiresPermissions("sys:quartzJob:delete")
    @PostMapping("sys/quartzJob/deleteByIds")
    @ResponseBody
    public ReturnBean deleteByIds(String ids) {
        quartzJobService.deleteByIds(ids);
        return ReturnBean.ok();
    }

    /**
     * 立即执行一次任务
     *
     * @param id
     * @return
     */
    @KrtLog(description = "立即执行一次任务")
    @RequiresPermissions("sys:quartzJob:doOnce")
    @PostMapping("sys/quartzJob/doOnce")
    @ResponseBody
    public ReturnBean doOnce(Integer id) throws SchedulerException {
        quartzJobService.doOnce(id);
        return ReturnBean.ok();
    }

    /**
     * 检测任务名和组名
     *
     * @param id    任务id
     * @param name  任务名
     * @param group 组名
     * @return
     */
    @PostMapping("sys/quartzJob/checkName")
    @ResponseBody
    public Boolean checkName(Integer id, String name, String group) {
        Map para = new HashMap(3);
        para.put("id", id);
        para.put("name", name);
        para.put("group", group);
        Integer count = quartzJobService.checkName(para);
        if (count > 0) {
            return false;
        } else {
            return true;
        }

    }
}
