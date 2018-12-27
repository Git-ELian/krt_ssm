package com.krt.sys.controller;


import com.krt.sys.entity.EmpLog;
import com.krt.sys.service.EmpLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @author 匿名
 * @create 2018-12-25 11:43
 * @desc 员工日志管理控制层
 **/

@Controller
@RequestMapping("/sys/empLog")
public class EmpLogController {

    @Autowired
    private EmpLogService empLogService;

    @RequestMapping(value = "/allLog")
//    @GetMapping("sys/empLog/allPaper")
    public String list(Model model){
        List<EmpLog> logs = empLogService.queryAllLog();
        model.addAttribute("logs", logs);
        return "allLog";
    }

    @RequestMapping("toAddLog")
    public String toAddLog(){
        return "addPaper";
    }

    @RequestMapping("/addLog")
    public String addLog(EmpLog log){
        empLogService.addLog(log);
        return "redirect:/sys/empLog/allLog";
    }

    @RequestMapping("/del/{logId}")
    public String delLog(@PathVariable("logId") Integer id){
        empLogService.deleteLogById(id);
        return "redirect:/sys/empLog/allLog";
    }

    @RequestMapping("toUpdateLog")
    public String toUpdatePaper(Model model, Integer id){
        model.addAttribute("log", empLogService.queryById(id));
        return "updatePaper";
    }

    @RequestMapping("/updateLog")
    public String updateLog(Model model, EmpLog log){
        empLogService.updateLog(log);
        log = empLogService.queryById(log.getLogId());
        model.addAttribute("log", log);
        return "redirect:/sys/empLog/allLog";
    }
}
