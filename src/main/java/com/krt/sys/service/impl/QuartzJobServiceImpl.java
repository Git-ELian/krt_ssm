package com.krt.sys.service.impl;


import com.krt.common.base.BaseServiceImpl;
import com.krt.sys.entity.QuartzJob;
import com.krt.sys.enums.JobStaus;
import com.krt.sys.mapper.QuartzJobMapper;
import com.krt.sys.service.QuartzJobService;
import com.krt.sys.util.QuartzJobFactory;
import com.krt.sys.util.QuartzJobFactoryDisallowConcurrentExecution;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 任务调度服务实现层
 * @date 2016年7月22日
 */
@Slf4j
@Service
public class QuartzJobServiceImpl extends BaseServiceImpl<QuartzJobMapper, QuartzJob> implements QuartzJobService {

    @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;


    /**
     * 启动 or 停止任务
     *
     * @param id
     * @param status
     * @throws Exception
     */
    @Override
    public void updateStatus(Integer id, String status) throws SchedulerException {
        QuartzJob quartzJob = baseMapper.selectEntityById(id);
        if (quartzJob == null) {
            return;
        }
        if (JobStaus.STOP.getStatus().equals(status)) {
            log.debug("停止任务");
            deleteJob(quartzJob);
            quartzJob.setStatus("0");
        } else if (JobStaus.START.getStatus().equals(status)) {
            log.debug("启动任务");
            quartzJob.setStatus("1");
            addJob(quartzJob);
        }
        baseMapper.update(quartzJob);
    }

    /**
     * 停止任务
     *
     * @param quartzJob
     * @throws SchedulerException
     */
    @Override
    public void deleteJob(QuartzJob quartzJob) throws SchedulerException {
        Scheduler scheduler = schedulerFactoryBean.getScheduler();
        JobKey jobKey = JobKey.jobKey(quartzJob.getName(), quartzJob.getGroup());
        scheduler.deleteJob(jobKey);
    }

    /**
     * 添加任务
     *
     * @param quartzJob
     * @throws SchedulerException
     */
    @Override
    public void addJob(QuartzJob quartzJob) throws SchedulerException {
        if (quartzJob == null || !JobStaus.STOP.getStatus().equals(quartzJob.getStatus())) {
            return;
        }
        Scheduler scheduler = schedulerFactoryBean.getScheduler();
        TriggerKey triggerKey = TriggerKey.triggerKey(quartzJob.getName(), quartzJob.getGroup());
        CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
        // 不存在，创建一个
        if (null == trigger) {
            Class clazz = "1".equals(quartzJob.getIsConcurrent()) ? QuartzJobFactory.class : QuartzJobFactoryDisallowConcurrentExecution.class;
            JobDetail jobDetail = JobBuilder.newJob(clazz).withIdentity(quartzJob.getName(), quartzJob.getGroup()).build();
            jobDetail.getJobDataMap().put("quartzJob", quartzJob);
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(quartzJob.getExpression());
            trigger = TriggerBuilder.newTrigger().withIdentity(quartzJob.getName(), quartzJob.getGroup()).withSchedule(scheduleBuilder).build();
            scheduler.scheduleJob(jobDetail, trigger);
        } else {
            // Trigger已存在，那么更新相应的定时设置
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(quartzJob.getExpression());
            // 按新的cronExpression表达式重新构建trigger
            trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
            // 按新的trigger重新设置job执行
            scheduler.rescheduleJob(triggerKey, trigger);
        }
    }

    /**
     * 立即执行一次任务
     *
     * @param id
     * @throws SchedulerException
     */
    @Override
    public void doOnce(Integer id) throws SchedulerException {
        QuartzJob quartzJob = baseMapper.selectEntityById(id);
        Scheduler scheduler = schedulerFactoryBean.getScheduler();
        JobKey jobKey = JobKey.jobKey(quartzJob.getName(), quartzJob.getGroup());
        scheduler.triggerJob(jobKey);
    }

    /**
     * 检测任务名 和 组名
     *
     * @param para
     * @return
     */
    @Override
    public Integer checkName(Map para) {
        return baseMapper.checkName(para);
    }

    /**
     * 服务器启动初始化正在运行的任务
     *
     * @throws Exception
     */
    @Override
    @PostConstruct
    public void init() throws Exception {
        //获取所有需要运行的任务
        List<QuartzJob> jobList = baseMapper.selectEntityList();
        for (QuartzJob quartzJob : jobList) {
            addJob(quartzJob);
        }
    }

}
