package com.krt.sys.util;

import com.krt.common.util.SpringUtils;
import com.krt.sys.entity.Dictionary;
import com.krt.sys.service.DictionaryService;

import java.util.List;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典工具类
 * @date 2016年3月8日
 */
public class DicUtils {

    private static DictionaryService dictionaryService = SpringUtils.getBean(DictionaryService.class);

    /**
     * 根据类型查询
     *
     * @param type
     * @return
     */
    public static List<Dictionary> dic(String type) {
        List<Dictionary> list = dictionaryService.selectDicByType(type);
        return list;
    }

    /**
     * 根据PID和类型查询
     *
     * @param type
     * @return
     */
    public static List<Dictionary> cDic(Integer pid, String type) {
        List<Dictionary> list = dictionaryService.selectDicByPidAndType(pid, type);
        return list;
    }

    /**
     * 根据code查询字典信息
     * @param code
     * @return
     */
    public static Dictionary dicInfo(String code){
        Dictionary dictionary = dictionaryService.selectEntityByCode(code);
        return dictionary;
    }

}
