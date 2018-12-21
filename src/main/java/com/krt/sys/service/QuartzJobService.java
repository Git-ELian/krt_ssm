package com.krt.sys.service;


import com.krt.common.base.BaseService;
import com.krt.sys.entity.QuartzJob;
import org.quartz.SchedulerException;

import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 任务调度服务接口层
 * @date 2016年7月22日
 */
public interface QuartzJobService extends BaseService<QuartzJob> {

    /**
     * 启动 or 停止任务
     *
     * @param id
     * @param status
     * @throws Exception
     */
    void updateStatus(Integer id, String status) throws SchedulerException;

    /**
     * 停止任务
     *
     * @param quartzJob
     * @throws SchedulerException
     */
    void deleteJob(QuartzJob quartzJob) throws SchedulerException;

    /**
     * 添加任务
     *
     * @param quartzJob
     * @throws SchedulerException
     */
    void addJob(QuartzJob quartzJob) throws SchedulerException;

    /**
     * 立即执行一次任务
     *
     * @param id
     * @throws SchedulerException
     */
    void doOnce(Integer id) throws SchedulerException;

    /**
     * 检测任务名 和 组名
     *
     * @param para
     * @return
     */
    Integer checkName(Map para);

    /**
     * 服务器启动初始化正在运行的任务
     *
     * @throws Exception
     */
    void init() throws Exception;

}
