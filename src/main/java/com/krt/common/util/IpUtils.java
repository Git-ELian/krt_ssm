package com.krt.common.util;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: IP工具类
 * @date 2017年04月11日
 */
public class IpUtils {

    /**
     * 获取当前网络ip
     * @param request
     * @return
     */
    public static String getIpAddr(HttpServletRequest request){
        String ipUnknown = "unknown";
        String ipLocaltion = "127.0.0.1";
        String ipLocaltionInet = "10:0:0:0:0:0:0:1";
        String ipSplitStr = ",";
        int ipLength = 15;
        String ipAddress = request.getHeader("x-forwarded-for");
        if(ipAddress == null || ipAddress.length() == 0 || ipUnknown.equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if(ipAddress == null || ipAddress.length() == 0 || ipUnknown.equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ipAddress == null || ipAddress.length() == 0 || ipUnknown.equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
            if(ipLocaltion.equals(ipAddress) || ipLocaltionInet.equals(ipAddress)){
                //根据网卡取本机配置的IP
                InetAddress inet=null;
                try {
                    inet = InetAddress.getLocalHost();
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
                ipAddress= inet.getHostAddress();
            }
        }
        //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        //"***.***.***.***".length() = 15
        if(ipAddress!=null && ipAddress.length()>ipLength){
            if(ipAddress.indexOf(ipSplitStr)>0){
                ipAddress = ipAddress.substring(0,ipAddress.indexOf(ipSplitStr));
            }
        }
        return ipAddress;
    }
}
