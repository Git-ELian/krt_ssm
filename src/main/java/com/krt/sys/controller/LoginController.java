package com.krt.sys.controller;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.krt.common.annotation.KrtLog;
import com.krt.common.base.BaseController;
import com.krt.common.bean.ReturnBean;
import com.krt.common.constant.SysConstant;
import com.krt.common.util.AesUtils;
import com.krt.common.util.ServletUtils;
import com.krt.common.util.ShiroUtils;
import com.krt.common.util.StringUtils;
import com.krt.sys.dto.LoginForm;
import com.krt.sys.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: 系统登录控制层
 * @date 2016年7月15日
 */
@Slf4j
@Controller
public class LoginController extends BaseController {

    @Autowired
    private Producer producer;

    /**
     * 获取验证码
     *
     * @return
     * @throws ServletException
     * @throws IOException
     */
    @GetMapping("captcha.jpg")
    public ModelAndView captcha() throws ServletException, IOException {
        response.setDateHeader("Expires", 0);
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("image/jpeg");
        //生成文字验证码
        String text = producer.createText();
        //生成图片验证码
        BufferedImage image = producer.createImage(text);
        //保存到shiro session
        ShiroUtils.setSessionAttribute(Constants.KAPTCHA_SESSION_KEY, text);
        ServletOutputStream out = response.getOutputStream();
        try {
            ImageIO.write(image, "jpg", out);
            out.flush();
        } finally {
            out.close();
        }
        return null;
    }

    /**
     * 登陆页
     *
     * @return
     */
    @GetMapping("login")
    public String login() {
        // 判断session是否登录成功
        User user = getCurrentUser();
        if (user != null) {
            //已登录直接跳转到首页
            return "redirect:index";
        } else {
            if (ServletUtils.isAjax(request)) {
                //通知ajax session失效
                response.setHeader("Session-Status", "timeout");
            }
            return "login";
        }
    }

    /**
     * 用户登录
     * @param loginForm
     * @return
     */
    @KrtLog(description = "后台登录", type = "0",para = false)
    @PostMapping("login")
    @ResponseBody
    public ReturnBean login(LoginForm loginForm) {
        ReturnBean rb;
        try {
            validateEntity(loginForm);
            String verifyCode = ShiroUtils.getKaptcha(Constants.KAPTCHA_SESSION_KEY);
            log.debug("验证码:{}", verifyCode);
            if (StringUtils.isNotBlank(verifyCode) && verifyCode.equalsIgnoreCase(loginForm.getVerifyCode())) {
                // 密码AES加密
                String password = AesUtils.getAESEncrypt(loginForm.getPassword(), SysConstant.PASS_KEY);
                // shiro的登录
                UsernamePasswordToken token = new UsernamePasswordToken(loginForm.getUsername(), password);
                Subject currentUser = SecurityUtils.getSubject();
                // 失败会抛出异常
                currentUser.login(token);
                rb = ReturnBean.ok();
            } else {
                rb = ReturnBean.error("验证码错误");
            }
        } catch (UnknownAccountException e) {
            return ReturnBean.error("账号不正确");
        } catch (IncorrectCredentialsException e) {
            return ReturnBean.error("密码不正确");
        } catch (LockedAccountException e) {
            return ReturnBean.error("账号已被锁定,请联系管理员");
        } catch (Exception e) {
            log.error("登录失败", e);
            return ReturnBean.error();
        }
        return rb;
    }

    /**
     * 退出
     */
    @GetMapping("logout")
    public String logout() {
        request.getSession().invalidate();
        return "login";
    }

}
