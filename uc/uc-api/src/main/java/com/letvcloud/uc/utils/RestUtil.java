package com.letvcloud.uc.utils;

import com.google.gson.Gson;
import org.apache.http.HttpException;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.*;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

public class RestUtil{
    
    private static final Logger LOG = LoggerFactory.getLogger(RestUtil.class);
    private static final String CONTENT_CHARSET = "UTF-8";
    private static final int TIMEOUT_MIN = 20;
    
    public static String get(String uri) throws Exception {
    
        return doRest(uri, "GET");
    }
    
    public static String post(String uri) throws Exception {
    
        return doRest(uri, "POST");
    }
    
    public static String put(String uri) throws Exception {
    
        return doRest(uri, "PUT");
    }
    
    public static String post(String uri, Map param) throws Exception {
    
        return doRest(uri, "POST", param);
    }
    
    public static String put(String uri, Map param) throws Exception {
    
        return doRest(uri, "PUT", param);
    }
    
    public static String delete(String uri) throws Exception {
    
        return doRest(uri, "DELETE");
    }
    
    public static String doRest(String uri, String methodName) throws Exception {
    
        return doRest(uri, methodName, new HashMap<String, String>());
    }
    
    public static String doRest(String uri, String methodName, Map<String, String> param) throws Exception {
    
        if (methodName == null || "".equals(methodName))
            methodName = "GET";
        
        String data = "";
        LOG.debug(methodName + " rest:" + uri);
        
        HttpClient httpClient = new DefaultHttpClient();
        HttpParams params = httpClient.getParams();
        HttpConnectionParams.setSoTimeout(params, 1000 * 60 * TIMEOUT_MIN);
        HttpRequestBase request = null;
        if ("GET".equals(methodName)) {
            StringBuilder builder = new StringBuilder(uri);
            if (null != param && param.size() > 0) {
                builder.append("?");
                int j = 0;
                for (Map.Entry<String, String> entry : param.entrySet()) {
                    if (j > 0) {
                        builder.append("&");
                    }
                    builder.append(entry.getKey());
                    builder.append("=");
                    builder.append(entry.getValue());
                    j++;
                }
            }
            request = new HttpGet(builder.toString());
        } else if ("POST".equals(methodName)) {
            request = new HttpPost(uri);
            Gson gson = new Gson();
            String jsonStr = gson.toJson(param);
            StringEntity s = new StringEntity(jsonStr, "utf-8");
            s.setContentEncoding("UTF-8");
            s.setContentType("application/json");
            ((HttpPost) request).setEntity(s);
        } else if ("PUT".equals(methodName)) {
            request = new HttpPut(uri);
            Gson gson = new Gson();
            String jsonStr = gson.toJson(param);
            StringEntity s = new StringEntity(jsonStr, "utf-8");
            s.setContentEncoding("UTF-8");
            s.setContentType("application/json");
            ((HttpPut) request).setEntity(s);
        }
        /*
         * else if ("PUT".equals(methodName)) { request = new HttpPost(uri);
         * Gson gson = new Gson(); String jsonStr = gson.toJson(param); //
         * List<NameValuePair> nvps = new ArrayList<NameValuePair>(); // for
         * (Object key : param.keySet()) { // NameValuePair pair = new
         * BasicNameValuePair((String) key, // (String) param.get(key)); //
         * nvps.add(pair); // } // ((HttpEntityEnclosingRequestBase)
         * request).setEntity(new // UrlEncodedFormEntity(nvps, HTTP.UTF_8));
         * StringEntity s = new StringEntity(jsonStr, "utf-8");
         * s.setContentEncoding("UTF-8"); s.setContentType("application/json");
         * ((HttpPost) request).setEntity(s); }
         */
        else if ("DELETE".equals(methodName)) {
            request = new HttpDelete(uri);
        }
        
        try {
            HttpResponse response = httpClient.execute(request);
            int statusCode = response.getStatusLine().getStatusCode();
            if (statusCode != HttpStatus.SC_OK) {
                LOG.error("Method failed: " + response.getStatusLine() + " for url " + uri);
                throw new Exception("Method failed: " + response.getStatusLine() + " for url " + uri);
            }
            InputStream inputStream = response.getEntity().getContent();
            BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, CONTENT_CHARSET));
            StringBuffer stringBuffer = new StringBuffer();
            String str = "";
            while ((str = br.readLine()) != null) {
                stringBuffer.append(str);
            }
            data = stringBuffer.toString();
            
        } catch (HttpException e) {
            // LOG.error("Please check your provided http address!");
            throw e;
        } catch (IOException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        } finally {
            try {
                httpClient.getConnectionManager().shutdown();
            } catch (Exception e) {
                throw e;
            }
        }
        LOG.debug("rest data:" + data);
        return data;
    }
}