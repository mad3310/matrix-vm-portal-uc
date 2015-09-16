package com.letvcloud.uc.controller;

import com.alibaba.fastjson.JSONObject;
import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.saas.util.CDNFileProxy;
import com.letvcloud.uc.utils.FileOperateUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("fileUpload")
public class FileUploadController extends BaseController {



	@RequestMapping("/uploadFile")
	@ResponseBody
    public String upLoadFile(HttpServletRequest request,@RequestParam MultipartFile file,
    		@RequestParam(required=false) String size) throws  BusinessException{
		String uuid=this.getCurrentUser(request).getUserUnique();
		File f = FileOperateUtil.getFile(request,file,uuid);
    	String fileUrl="";
    	JSONObject jsonObject = new JSONObject();
    	Map<String,Object> map = checkImage(f,size);
    	if(map!=null){
    		if((Boolean)map.get("check")){
    			fileUrl = CDNFileProxy.uploadFile(f);
				fileUrl.replace("/", "\\");
			}else{
    			jsonObject.put("msgCode", map.get("msgCode"));
    		}
    	}else{
    		//请选择图片
    		jsonObject.put("msgCode", "0");
    	}
    	jsonObject.put("path", fileUrl);
    	return jsonObject.toString();

    }
	
	private Map<String,Object> checkImage(File file,String str){
		 Map<String,Object> map = new HashMap<String,Object>();
		 int n = 5;
		 if(StringUtils.isNotBlank(str)){
			 n = Integer.parseInt(str);
		 }
		 if(file.exists()){
			String filepath = file.getPath();
	        String ext = filepath.substring(filepath.lastIndexOf(".")).toUpperCase();
	        map.put("check", true);
	        long size = file.length();
	        if(size > n*1024*1024){//n为2或者5
	        	//图片大于5M
	        	String msgCode = "1";
	        	map.put("check", false);
	        	map.put("msgCode", msgCode);
	        }
		       /*if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG"){
		        	//("图片限于bmp,png,gif,jpeg,jpg格式");
		         	return false;
        	   }*/
	        if(!StringUtils.equals(ext, ".JPG") && !StringUtils.equals(ext, ".PNG")){
	        	//图片限于jpg,png格式
	        	String msgCode = "2";
	        	map.put("check", false);
	        	map.put("msgCode", msgCode);
	        }
	        return map;
		 }
		 return null;     
	}

}
