package com.krt.common.util;

import com.alibaba.fastjson.JSONObject;
import com.krt.common.exception.KrtException;
import lombok.extern.slf4j.Slf4j;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;
import java.util.Map;

/**
 * @author 殷帅
 * @version 1.0
 * @Description: HTTP 访问工具类
 * @date 2016年4月19日
 */
@Slf4j
public class HttpUtils {

    /**
     * 编码
     */
    private static final String CHARSET = "utf-8";

    /**
     * 错误编码
     */
    private static final int HTTP_CODE = 300;

    /**
     * GET请求
     *
     * @param url       请求地址
     * @param headerMap header请求参数
     * @return
     * @throws Exception
     */
    public static String doGet(String url, Map headerMap) throws Exception {
        URL localURL = new URL(url);
        URLConnection connection = localURL.openConnection();
        HttpURLConnection httpURLConnection = (HttpURLConnection) connection;
        httpURLConnection.setRequestProperty("Accept-Charset", CHARSET);
        httpURLConnection.setRequestProperty("Connection", "Keep-Alive");
        httpURLConnection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.6)");
        httpURLConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        setHeader(connection, headerMap);
        InputStream inputStream = null;
        InputStreamReader inputStreamReader = null;
        BufferedReader reader = null;
        StringBuffer resultBuffer = new StringBuffer();
        String tempLine;
        if (httpURLConnection.getResponseCode() >= HTTP_CODE) {
            throw new KrtException("Get请求失败,服务器响应码是{}" + httpURLConnection.getResponseCode());
        }
        try {
            inputStream = httpURLConnection.getInputStream();
            inputStreamReader = new InputStreamReader(inputStream);
            reader = new BufferedReader(inputStreamReader);
            while ((tempLine = reader.readLine()) != null) {
                resultBuffer.append(tempLine);
            }
        } finally {
            if (reader != null) {
                reader.close();
            }
            if (inputStreamReader != null) {
                inputStreamReader.close();
            }
            if (inputStream != null) {
                inputStream.close();
            }
        }
        return resultBuffer.toString();
    }


    /**
     * POST请求
     *
     * @param url          请求参数
     * @param parameterMap 参数Map
     * @param headerMap    header参数
     * @return
     * @throws Exception
     */
    public static String doPost(String url, Map parameterMap, Map headerMap) throws Exception {
        StringBuffer parameterBuffer = new StringBuffer();
        if (parameterMap != null) {
            Iterator<String> iterator = parameterMap.keySet().iterator();
            String key;
            String value;
            while (iterator.hasNext()) {
                key = iterator.next();
                if (parameterMap.get(key) != null) {
                    value = (String) parameterMap.get(key);
                } else {
                    value = "";
                }
                parameterBuffer.append(key).append("=").append(value);
                if (iterator.hasNext()) {
                    parameterBuffer.append("&");
                }
            }
        }
        log.debug("POST请求参数 : " + parameterBuffer.toString());
        URL localURL = new URL(url);
        URLConnection connection = localURL.openConnection();
        HttpURLConnection httpURLConnection = (HttpURLConnection) connection;
        httpURLConnection.setDoOutput(true);
        httpURLConnection.setRequestMethod("POST");
        httpURLConnection.setRequestProperty("Accept-Charset", CHARSET);
        httpURLConnection.setRequestProperty("Connection", "Keep-Alive");
        httpURLConnection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.6)");
        httpURLConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        httpURLConnection.setRequestProperty("Content-Length", String.valueOf(parameterBuffer.length()));
        setHeader(httpURLConnection, headerMap);
        OutputStream outputStream = null;
        OutputStreamWriter outputStreamWriter = null;
        InputStream inputStream = null;
        InputStreamReader inputStreamReader = null;
        BufferedReader reader = null;
        StringBuffer resultBuffer = new StringBuffer();
        String tempLine;
        try {
            outputStream = httpURLConnection.getOutputStream();
            outputStreamWriter = new OutputStreamWriter(outputStream);
            outputStreamWriter.write(parameterBuffer.toString());
            outputStreamWriter.flush();
            if (httpURLConnection.getResponseCode() >= HTTP_CODE) {
                throw new KrtException("Post请求失败, 服务器响应码是{}" + httpURLConnection.getResponseCode());
            }
            inputStream = httpURLConnection.getInputStream();
            inputStreamReader = new InputStreamReader(inputStream);
            reader = new BufferedReader(inputStreamReader);
            while ((tempLine = reader.readLine()) != null) {
                resultBuffer.append(tempLine);
            }
        } finally {
            if (outputStreamWriter != null) {
                outputStreamWriter.close();
            }
            if (outputStream != null) {
                outputStream.close();
            }
            if (reader != null) {
                reader.close();
            }
            if (inputStreamReader != null) {
                inputStreamReader.close();
            }
            if (inputStream != null) {
                inputStream.close();
            }
        }
        return resultBuffer.toString();
    }

    /**
     * json请求
     *
     * @param url           请求地址
     * @param jsonParameter json字符串参数
     * @param headerMap       header参数
     * @return
     * @throws Exception
     */
    public static String doPostJsonStr(String url, String jsonParameter, Map headerMap) throws Exception {
        log.debug("POST请求参数 : " + jsonParameter.toString());
        URL localURL = new URL(url);
        URLConnection connection = localURL.openConnection();
        HttpURLConnection httpURLConnection = (HttpURLConnection) connection;
        httpURLConnection.setDoOutput(true);
        httpURLConnection.setRequestMethod("POST");
        httpURLConnection.setRequestProperty("Accept-Charset", CHARSET);
        httpURLConnection.setRequestProperty("Connection", "Keep-Alive");
        httpURLConnection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.6)");
        httpURLConnection.setRequestProperty("Content-Type", "application/json");
        httpURLConnection.setRequestProperty("Content-Length", String.valueOf(jsonParameter.length()));
        setHeader(httpURLConnection, headerMap);
        OutputStream outputStream = null;
        DataOutputStream dataOutputStream = null;
        InputStream inputStream = null;
        InputStreamReader inputStreamReader = null;
        BufferedReader reader = null;
        StringBuffer resultBuffer = new StringBuffer();
        String tempLine;
        try {
            outputStream = httpURLConnection.getOutputStream();
            dataOutputStream = new DataOutputStream(outputStream);
            dataOutputStream.write(jsonParameter.getBytes("UTF-8"));
            dataOutputStream.flush();
            if (httpURLConnection.getResponseCode() >= HTTP_CODE) {
                throw new KrtException("Post请求失败, 服务器响应码是{}" + httpURLConnection.getResponseCode());
            }
            inputStream = httpURLConnection.getInputStream();
            inputStreamReader = new InputStreamReader(inputStream);
            reader = new BufferedReader(inputStreamReader);
            while ((tempLine = reader.readLine()) != null) {
                resultBuffer.append(tempLine);
            }
        } finally {
            if (dataOutputStream != null) {
                dataOutputStream.close();
            }
            if (outputStream != null) {
                outputStream.close();
            }
            if (reader != null) {
                reader.close();
            }
            if (inputStreamReader != null) {
                inputStreamReader.close();
            }
            if (inputStream != null) {
                inputStream.close();
            }
        }
        return resultBuffer.toString();
    }

    /**
     * post请求（参数为json）
     *
     * @param url        请求地址
     * @param jsonObject 参数
     * @param headerMap  header参数
     * @return
     * @throws Exception
     */
    public static String doPostJson(String url, JSONObject jsonObject, Map headerMap) throws Exception {
        String jsonParameter = jsonObject.toString();
        return doPostJsonStr(url, jsonParameter, headerMap);
    }

    /**
     * 上传文件
     *
     * @param url          请求地址
     * @param parameterMap 参数
     * @param fileMap      文件参数
     * @param headerMap    header参数
     * @return
     * @throws Exception
     */
    public static String doUpload(String url, Map<String, String> parameterMap, Map<String, String> fileMap, Map headerMap) throws Exception {
        // boundary就是request头和上传文件内容的分隔符
        String boundary = "---------------------------123821742118716";
        URL localURL = new URL(url);
        HttpURLConnection httpURLConnection;
        httpURLConnection = (HttpURLConnection) localURL.openConnection();
        httpURLConnection.setConnectTimeout(5000);
        httpURLConnection.setReadTimeout(30000);
        httpURLConnection.setDoOutput(true);
        httpURLConnection.setDoInput(true);
        httpURLConnection.setUseCaches(false);
        httpURLConnection.setRequestMethod("POST");
        httpURLConnection.setRequestProperty("Accept-Charset", CHARSET);
        httpURLConnection.setRequestProperty("Connection", "Keep-Alive");
        httpURLConnection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.6)");
        httpURLConnection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
        setHeader(httpURLConnection, headerMap);
        OutputStream out = null;
        BufferedReader reader = null;
        StringBuffer resultBuffer = new StringBuffer();
        try {
            out = new DataOutputStream(httpURLConnection.getOutputStream());
            // text
            if (parameterMap != null) {
                StringBuffer strBuf = new StringBuffer();
                Iterator<Map.Entry<String, String>> iter = parameterMap.entrySet().iterator();
                while (iter.hasNext()) {
                    Map.Entry<String, String> entry = iter.next();
                    String inputName = entry.getKey();
                    String inputValue = entry.getValue();
                    if (inputValue == null) {
                        continue;
                    }
                    strBuf.append("\r\n").append("--").append(boundary).append("\r\n");
                    strBuf.append("Content-Disposition: form-data; name=\"" + inputName + "\"\r\n\r\n");
                    strBuf.append(inputValue);
                }
                out.write(strBuf.toString().getBytes());
            }
            // file
            if (fileMap != null) {
                Iterator<Map.Entry<String, String>> iter = fileMap.entrySet()
                        .iterator();
                while (iter.hasNext()) {
                    Map.Entry<String, String> entry = iter.next();
                    String inputName = entry.getKey();
                    String inputValue = entry.getValue();
                    if (inputValue == null) {
                        continue;
                    }
                    File file = new File(inputValue);
                    String filename = file.getName();
                    String contentType = "application/octet-stream";
                    StringBuffer strBuf = new StringBuffer();
                    strBuf.append("\r\n").append("--").append(boundary).append("\r\n");
                    strBuf.append("Content-Disposition: form-data; name=\""
                            + inputName + "\"; filename=\"" + filename
                            + "\"\r\n");
                    strBuf.append("Content-Type:" + contentType + "\r\n\r\n");
                    out.write(strBuf.toString().getBytes());
                    DataInputStream in = new DataInputStream(new FileInputStream(file));
                    int bytes = 0;
                    byte[] bufferOut = new byte[1024];
                    while ((bytes = in.read(bufferOut)) != -1) {
                        out.write(bufferOut, 0, bytes);
                    }
                    in.close();
                }
            }
            byte[] endData = ("\r\n--" + boundary + "--\r\n").getBytes();
            out.write(endData);
            out.flush();
            out.close();
            out = null;
            if (httpURLConnection.getResponseCode() >= HTTP_CODE) {
                throw new KrtException("上传文件失败, 服务器响应码是{}" + httpURLConnection.getResponseCode());
            }
            // 读取返回数据
            reader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                resultBuffer.append(line).append("\n");
            }
            reader.close();
            reader = null;
        } finally {
            if (out != null) {
                out.close();
            }
            if (reader != null) {
                reader.close();
            }
            httpURLConnection.disconnect();
        }
        return resultBuffer.toString();
    }

    /**
     * 设置头属性
     *
     * @param connection
     * @param headerMap
     */

    private static void setHeader(URLConnection connection, Map headerMap) {
        if (headerMap != null) {
            Iterator<String> iterator = headerMap.keySet().iterator();
            String key;
            String value;
            while (iterator.hasNext()) {
                key = iterator.next();
                value = headerMap.get(key).toString();
                connection.setRequestProperty(key, value);
            }
        }
    }

    public static void main(String[] args) throws Exception {
        JSONObject json = new JSONObject();
        json.put("alertType", 5);
        json.put("apns", false);
        json.put("audience", "one");
        json.put("content", "您好sd");
        json.put("ptype", "alert");
        json.put("registrationId", "18071adc032014c895f");
        json.put("tag", "push005");
        json.put("type", "android");
        String str = doPostJson("http://www.krtservice.com/sc-api/api/push/push", json, null);
        log.debug(str);
    }

}
