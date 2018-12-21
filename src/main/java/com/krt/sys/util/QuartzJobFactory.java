package com.krt.sys.util;
import com.krt.sys.entity.QuartzJob;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;


/**
 * @Description: 计划任务执行处 无状态
 * @author 殷帅
 * @date 2016年3月8日
 * @version 1.0
 */
public class QuartzJobFactory implements Job {

	public final Logger log = Logger.getLogger(this.getClass());

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		QuartzJob scheduleJob = (QuartzJob) context.getMergedJobDataMap().get("quartzJob");
		TaskUtils.invokMethod(scheduleJob);
	} 
}