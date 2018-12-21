package com.krt.sys.controller;

import com.alibaba.fastjson.JSONObject;
import com.krt.common.base.BaseController;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: KindEditor
 * @date 2017年05月16日
 */
@Slf4j
@Controller
public class KindEditorController extends BaseController {


    private static Logger logger = LoggerFactory.getLogger(KindEditorController.class);

    /**
     * 定义允许上传的文件扩展名
     */
    private HashMap<String, String> extMap = new HashMap<String, String>();

    /**
     * 初始化文件后缀配置
     */
    public void init() {
        extMap.put("image", "gif,jpg,jpeg,png,bmp");
        extMap.put("flash", "swf,flv");
        extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
        extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");
    }

    /**
     * 上传文件
     *
     * @param file
     * @param dir
     * @return
     */
    @PostMapping("kindeditor/fileUpload")
    @ResponseBody
    public Map<String, Object> fileUpload(@RequestParam("file") MultipartFile file, String dir) {
        try {
            init();
            if (dir == null || !extMap.containsKey(dir.toLowerCase())) {
                return getError("文件类型不合法");
            }
            if (file == null || file.isEmpty()) {
                return getError("文件不能为空");
            }
            if (dir != null) {
                if (!Arrays.<String>asList(extMap.get(dir).split(",")).contains(file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1))) {
                    return getError("上传文件扩展名只允许" + extMap.get(dir) + "格式");
                }
            }
            // 计算出文件后缀名
            String fileExt = FilenameUtils.getExtension(file.getOriginalFilename());
            String savePath = request.getSession().getServletContext().getRealPath("/") + "upload/";
            //本地上传文件 放到对应的项目 对应的文件夹下
            logger.debug("path:{}", savePath);
            savePath = savePath.replace("/", System.getProperty("file.separator")) + dir + System.getProperty("file.separator");
            File f = new File(savePath);
            if (!f.exists()) {
                f.mkdirs();
            }
            SimpleDateFormat fileNameFormat = new SimpleDateFormat("yyyyMMddkkmmss_S");
            String fileName = fileNameFormat.format(new Date());
            String saveFilePath = savePath + fileName + "." + fileExt;
            logger.debug("saveFilePath:{}", saveFilePath);
            copy(file.getInputStream(), saveFilePath);
            String fileNameUrl = fileName + "." + fileExt;
            Map<String, Object> msg = new HashMap<String, Object>(2);
            msg.put("error", 0);
            msg.put("url", request.getContextPath() + "/upload/" + dir + "/" + fileNameUrl);
            return msg;
        } catch (Exception e) {
            logger.error("程序异常", e);
            return getError("程序异常");
        }
    }


    /**
     * 文件管理
     *
     * @param request
     * @param response
     */
    @RequestMapping("kindeditor/fileManager")
    public void fileManager(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("application/json;charset=utf-8");
            response.setCharacterEncoding("utf-8");

            // 根目录路径，可以指定绝对路径，比如 /var/www/upload_files/
            String savePath = request.getSession().getServletContext().getRealPath("/") + "upload/";
            String rootPath = savePath.replace("/", System.getProperty("file.separator"));

            logger.debug("rootPath:{}", rootPath);

            // 根目录URL，可以指定绝对路径，比如 http://www.yoursite.com/upload_files/
            String rootUrl = request.getContextPath() + "/upload/";

            logger.debug("rootUrl:{}", rootUrl);
            // 图片扩展名
            String[] fileTypes = new String[]{"gif", "jpg", "jpeg", "png", "bmp"};
            String dirName = request.getParameter("dir");
            if (dirName != null) {
                if (!Arrays.<String>asList(new String[]{"image", "flash", "media", "file"}).contains(dirName)) {
                    response.getWriter().print("Invalid Directory name.");
                }
                rootPath += dirName + System.getProperty("file.separator");
                rootUrl += dirName + "/";
                File saveDirFile = new File(rootPath);
                if (!saveDirFile.exists()) {
                    saveDirFile.mkdirs();
                }
            }
            // 根据path参数，设置各路径和URL
            String path = request.getParameter("path") != null ? request.getParameter("path") : "";
            String currentPath = rootPath + path;
            String currentUrl = rootUrl + path;
            String currentDirPath = path;
            String moveupDirPath = "";
            if (!"".equals(path)) {
                String str = currentDirPath.substring(0, currentDirPath.length() - 1);
                moveupDirPath = str.lastIndexOf("/") >= 0 ? str.substring(0, str.lastIndexOf("/") + 1) : "";
            }
            // 排序形式，name or size or type
            String order = request.getParameter("order") != null ? request.getParameter("order").toLowerCase() : "name";
            // 不允许使用..移动到上一级目录
            if (path.indexOf("..") >= 0) {
                response.getWriter().print("Access is not allowed.");
            }
            // 最后一个字符不是/
            if (!"".equals(path) && !path.endsWith("/")) {
                response.getWriter().print("Parameter is not valid.");
            }
            // 目录不存在或不是目录
            File currentPathFile = new File(currentPath);
            if (!currentPathFile.isDirectory()) {
                response.getWriter().print("Directory does not exist.");
            }
            // 遍历目录取的文件信息
            List<Hashtable> fileList = new ArrayList<Hashtable>();
            if (currentPathFile.listFiles() != null) {
                for (File file : currentPathFile.listFiles()) {
                    Hashtable<String, Object> hash = new Hashtable<String, Object>();
                    String fileName = file.getName();
                    if (file.isDirectory()) {
                        hash.put("is_dir", true);
                        hash.put("has_file", (file.listFiles() != null));
                        hash.put("filesize", 0L);
                        hash.put("is_photo", false);
                        hash.put("filetype", "");
                    } else if (file.isFile()) {
                        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                        hash.put("is_dir", false);
                        hash.put("has_file", false);
                        hash.put("filesize", file.length());
                        hash.put("is_photo", Arrays.<String>asList(fileTypes).contains(fileExt));
                        hash.put("filetype", fileExt);
                    }
                    hash.put("filename", fileName);
                    hash.put("datetime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(file.lastModified()));
                    fileList.add(hash);
                }
            }

            if ("size".equals(order)) {
                Collections.sort(fileList, new SizeComparator());
            } else if ("type".equals(order)) {
                Collections.sort(fileList, new TypeComparator());
            } else {
                Collections.sort(fileList, new NameComparator());
            }
            JSONObject result = new JSONObject();
            result.put("moveup_dir_path", moveupDirPath);
            result.put("current_dir_path", currentDirPath);
            result.put("current_url", currentUrl);
            result.put("total_count", fileList.size());
            result.put("file_list", fileList);
            logger.debug(result.toString());
            response.getWriter().print(result.toString());
        } catch (Exception e) {
            logger.error("程序异常", e);
        }
    }

    class NameComparator implements Comparator {
        @Override
        public int compare(Object a, Object b) {
            Hashtable hashA = (Hashtable) a;
            Hashtable hashB = (Hashtable) b;
            if (((Boolean) hashA.get("is_dir"))
                    && !((Boolean) hashB.get("is_dir"))) {
                return -1;
            } else if (!((Boolean) hashA.get("is_dir"))
                    && ((Boolean) hashB.get("is_dir"))) {
                return 1;
            } else {
                return ((String) hashA.get("filename"))
                        .compareTo((String) hashB.get("filename"));
            }
        }
    }

    class SizeComparator implements Comparator {
        @Override
        public int compare(Object a, Object b) {
            Hashtable hashA = (Hashtable) a;
            Hashtable hashB = (Hashtable) b;
            if (((Boolean) hashA.get("is_dir"))
                    && !((Boolean) hashB.get("is_dir"))) {
                return -1;
            } else if (!((Boolean) hashA.get("is_dir"))
                    && ((Boolean) hashB.get("is_dir"))) {
                return 1;
            } else {
                if (((Long) hashA.get("filesize")) > ((Long) hashB
                        .get("filesize"))) {
                    return 1;
                } else if (((Long) hashA.get("filesize")) < ((Long) hashB
                        .get("filesize"))) {
                    return -1;
                } else {
                    return 0;
                }
            }
        }
    }

    class TypeComparator implements Comparator {
        @Override
        public int compare(Object a, Object b) {
            Hashtable hashA = (Hashtable) a;
            Hashtable hashB = (Hashtable) b;
            if (((Boolean) hashA.get("is_dir"))
                    && !((Boolean) hashB.get("is_dir"))) {
                return -1;
            } else if (!((Boolean) hashA.get("is_dir"))
                    && ((Boolean) hashB.get("is_dir"))) {
                return 1;
            } else {
                return ((String) hashA.get("filetype"))
                        .compareTo((String) hashB.get("filetype"));
            }
        }
    }


    /**
     * @param src 源文件
     * @param tar 目标路径
     * @category 拷贝文件
     */

    public void copy(InputStream src, String tar) throws Exception {
        // 判断源文件或目标路径是否为空
        if (null == src || null == tar || tar.isEmpty()) {
            return;
        }
        OutputStream tarOs = null;
        File tarFile = new File(tar);
        tarOs = new FileOutputStream(tarFile);
        byte[] buffer = new byte[4096];
        int n = 0;
        while (-1 != (n = src.read(buffer))) {
            tarOs.write(buffer, 0, n);
        }
        if (null != src) {
            src.close();
        }
        if (null != tarOs) {
            tarOs.close();
        }

    }

    /**
     * 返回错误信息
     *
     * @param message
     * @return
     */
    public Map<String, Object> getError(String message) {
        Map<String, Object> msg = new HashMap<String, Object>(2);
        msg.put("error", 1);
        msg.put("message", message);
        return msg;
    }

}
