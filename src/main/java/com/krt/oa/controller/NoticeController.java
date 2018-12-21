package com.krt.oa.controller;

import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.DataTable;
import com.krt.common.bean.ReturnBean;
import com.krt.oa.entity.Notice;
import com.krt.oa.service.NoticeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.annotation.Resource;
import java.util.Map;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 通知公告表控制层
 * @date 2017年05月31日
 */
@Controller
public class NoticeController extends BaseController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 通知公告表管理页
     *
     * @return
     */
    @RequiresPermissions("oa:notice:list")
    @GetMapping("oa/notice/list")
    public String list() {
        return "oa/notice/list";
    }

    /**
     * 通知公告表管理
     *
     * @return
     */
    @RequiresPermissions("oa:notice:list")
    @PostMapping("oa/notice/list")
    @ResponseBody
    public DataTable list(@RequestParam Map para) {
        DataTable dt = noticeService.selectList(para);
        return dt;
    }

    /**
     * 新增通知公告表页
     *
     * @return
     */
    @RequiresPermissions("oa:notice:insert")
    @GetMapping("oa/notice/insert")
    public String insert() {
        return "oa/notice/insert";
    }

    /**
     * 添加通知公告表
     *
     * @param notice 通知公告表
     * @return
     */
    @KrtLog(description = "添加通知公告表",para = false)
    @RequiresPermissions("oa:notice:insert")
    @PostMapping("oa/notice/insert")
    @ResponseBody
    public ReturnBean insert(Notice notice) {
        noticeService.insert(notice);
        return ReturnBean.ok();
    }

    /**
     * 修改通知公告表页
     *
     * @param id 通知公告表 id
     * @return
     */
    @RequiresPermissions("oa:notice:update")
    @GetMapping("oa/notice/update")
    public String update(Integer id) {
        Map noticeMap = noticeService.selectById(id);
        request.setAttribute("notice", noticeMap);
        return "oa/notice/update";
    }

    /**
     * 修改通知公告表
     *
     * @param notice 通知公告表
     * @return
     */
    @KrtLog(description = "修改通知公告表",para = false)
    @RequiresPermissions("oa:notice:update")
    @PostMapping("oa/notice/update")
    @ResponseBody
    public ReturnBean update(Notice notice) {
        noticeService.update(notice);
        return ReturnBean.ok();
    }

    /**
     * 删除通知公告表
     *
     * @param id 通知公告表 id
     * @return
     */
    @KrtLog(description = "删除通知公告表")
    @RequiresPermissions("oa:notice:delete")
    @PostMapping("oa/notice/delete")
    @ResponseBody
    public ReturnBean delete(Integer id) {
        noticeService.delete(id);
        return ReturnBean.ok();
    }

    /**
     * 批量删除通知公告表
     *
     * @param ids 通知公告表 ids
     * @return
     */
    @KrtLog(description = "批量删除通知公告表")
    @RequiresPermissions("oa:notice:delete")
    @PostMapping("oa/notice/deleteByIds")
    @ResponseBody
    public ReturnBean deleteByIds(String ids) {
        noticeService.deleteByIds(ids);
        return ReturnBean.ok();
    }
}
