package com.krt.sys.util;

import com.krt.sys.entity.QuartzJob;
import org.apache.log4j.Logger;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * @Description: 若一个方法一次执行不完下次轮转时则等待改方法执行完后才执行下一次操作
 * @author 殷帅
 * @date 2016年3月8日
 * @version 1.0
 */
@DisallowConcurrentExecution
public class QuartzJobFactoryDisallowConcurrentExecution implements Job {
	
	public final Logger log = Logger.getLogger(this.getClass());

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		QuartzJob scheduleJob = (QuartzJob) context.getMergedJobDataMap().get("quartzJob");
		TaskUtils.invokMethod(scheduleJob);
	}
}