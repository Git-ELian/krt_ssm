package com.krt.sys.job;

import com.alibaba.fastjson.JSONObject;
import com.krt.common.util.HttpUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 定时任务
 * @date 2017年05月10日
 */
@Slf4j
@Component
public class KrtJob {

    /**
     * 测试定时任务
     */
    public void job() throws Exception {
        JSONObject json = new JSONObject();
        json.put("alertType", 5);
        json.put("apns", false);
        json.put("audience", "one");
        json.put("content", "您好sd");
        json.put("ptype", "alert");
        json.put("registrationId", "18071adc032014c895f");
        json.put("tag", "push005");
        json.put("type", "android");
        String str = HttpUtils.doPostJson("http://www.krtservice.com/sc-api/api/push/push", json, null);
        log.debug(str);
        log.debug("我是定时任务job 我在执行!");
    }
}
