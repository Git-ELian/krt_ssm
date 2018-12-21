package com.krt.sys.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.ReturnBean;
import com.krt.sys.entity.Region;
import com.krt.sys.service.RegionService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;
import java.util.Map;

/**
 * @version 1.0
 * @Description：区域控制层
 * @author：殷帅
 * @date：2016-07-26
 */
@Slf4j
@Controller
public class RegionController extends BaseController {

    @Autowired
    private RegionService regionService;


    /**
     * 区域管理
     *
     * @return
     */
    @RequiresPermissions("sys:region:list")
    @GetMapping("sys/region/list")
    public String list() {
        return "sys/region/list";
    }

    /**
     * 获取子集
     *
     * @param pid
     * @return
     */
    @PostMapping("sys/region/regionChild")
    @ResponseBody
    public List regionChild(Integer pid) {
        List list = regionService.selectListByPid(pid);
        return list;
    }

    /**
     * 新增区域页
     *
     * @return
     */
    @RequiresPermissions("sys:region:insert")
    @GetMapping("sys/region/insert")
    public String insert(Integer id) {
        if (id != null) {
            Map regionMap = regionService.selectById(id);
            request.setAttribute("region", regionMap);
        }
        return "sys/region/insert";
    }

    /**
     * 添加区域
     *
     * @param region 区域
     * @return
     */
    @KrtLog(description = "添加区域")
    @RequiresPermissions("sys:region:insert")
    @PostMapping("sys/region/insert")
    @ResponseBody
    public ReturnBean insert(Region region) {
        if (region.getPid() == null) {
            region.setPid(0);
        }
        validateEntity(region);
        regionService.insert(region);
        return ReturnBean.ok();
    }

    /**
     * 修改区域页
     *
     * @param id 区域 id
     * @return
     */
    @RequiresPermissions("sys:region:update")
    @GetMapping("sys/region/update")
    public String update(Integer id) {
        Map regionMap = regionService.selectById(id);
        request.setAttribute("region", regionMap);
        return "sys/region/update";
    }

    /**
     * 修改区域
     *
     * @param region 区域
     * @return
     */
    @KrtLog(description = "修改区域")
    @RequiresPermissions("sys:region:update")
    @PostMapping("sys/region/update")
    @ResponseBody
    public ReturnBean update(Region region) {
        if (region.getPid() == null) {
            region.setPid(0);
        }
        validateEntity(region);
        regionService.update(region);
        return ReturnBean.ok();
    }

    /**
     * 删除区域
     *
     * @param id 区域 id
     * @return
     */
    @KrtLog(description = "删除区域")
    @RequiresPermissions("sys:region:delete")
    @PostMapping("sys/region/delete")
    @ResponseBody
    public ReturnBean delete(Integer id) {
        regionService.delete(id);
        return ReturnBean.ok();
    }

    /**
     * 区域树
     *
     * @return
     */
    @GetMapping("sys/region/regionTree")
    public String regionTree() {
        List list = regionService.selectRegionTree();
        request.setAttribute("regionTree", JSONArray.parseArray(JSON.toJSONString(list)));
        return "sys/region/regionTree";
    }


    /**
     * 区域树
     *
     * @return
     */
    @PostMapping("sys/region/regionTree")
    @ResponseBody
    public List regionTreeData() {
        return regionService.selectRegionTree();
    }

    /**
     * 检测区域编码
     *
     * @param id
     * @param code
     * @return
     */
    @PostMapping("sys/region/checkCode")
    @ResponseBody
    public boolean checkCode(Integer id, String code) {
        Integer count = regionService.checkCode(id, code);
        if (count > 0) {
            return false;
        } else {
            return true;
        }
    }
}
