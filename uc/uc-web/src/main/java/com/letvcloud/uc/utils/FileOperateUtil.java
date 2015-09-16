package com.letvcloud.uc.utils;

import com.letvcloud.saas.exception.BusinessException;
import com.letvcloud.saas.util.DateTimeUtil;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 文件上传下载操作类
 *
 * @author linzhengyu
 * @date 2014年7月30日
 */
public class FileOperateUtil {
    private static final String UPLOADDIR = "resources" + File.separator + "upload" + File.separator;
    private static final String DOWNLOADDIR = "resources" + File.separator + "templateFiles" + File.separator;

    public static void download(HttpServletRequest request, HttpServletResponse response, String storeName,
                                String contentType, String realName) throws BusinessException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;

//		String ctxPath = request.getSession().getServletContext().getRealPath("/") + FileOperateUtil.DOWNLOADDIR;
        //add by wangpeng 2014-12-16
        String ctxPath = request.getServletContext().getRealPath("/") + FileOperateUtil.DOWNLOADDIR;
        String downLoadPath = ctxPath + storeName;

        long fileLength = new File(downLoadPath).length();

        response.setContentType(contentType);
        response.setHeader("Content-disposition", "attachment; filename="
                + new String(realName.getBytes("utf-8"), "ISO8859-1"));
        response.setHeader("Content-Length", String.valueOf(fileLength));

        try {
            bis = new BufferedInputStream(new FileInputStream(downLoadPath));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            throw new BusinessException("E000015", downLoadPath);
        }
        bos = new BufferedOutputStream(response.getOutputStream());
        byte[] buff = new byte[2048];
        int bytesRead;
        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
            bos.write(buff, 0, bytesRead);
        }
        bis.close();
        bos.close();
    }

    public static File getFile(HttpServletRequest request, MultipartFile file,String uuid) throws BusinessException {
        String uploadDir = UPLOADDIR;
        File dirPath = prepareSavedDir(request, uploadDir);
        String saveFileName = getSavedFileName();
        String oriName = String.valueOf(System.currentTimeMillis())+uuid+getFileExtension(file.getOriginalFilename());
        String newFileName = saveFileName + oriName;
        try {
            file.transferTo(new File(dirPath + File.separator + newFileName));
        } catch (IllegalStateException e) {
            throw new BusinessException("E000014", e.getMessage());
        } catch (IOException e) {
            throw new BusinessException("E000014", e.getMessage());
        }
        return new File(dirPath + File.separator + newFileName);
    }

    public static File prepareSavedDir(HttpServletRequest request, String relativePath) throws BusinessException {
//		File dir = new File(request.getSession().getServletContext().getRealPath(relativePath));
        //add by wangpeng 2014-12-16
        File dir = new File(request.getServletContext().getRealPath(relativePath));
        if (!dir.exists()) {
            if (!dir.mkdirs()) {
                throw new BusinessException("E000014", "文件[" + dir + "]不存在");
            }
        }
        return dir;
    }

    public static String getSavedFileName() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MILLISECOND, 1);
        Date date = calendar.getTime();
        return DateTimeUtil.toDateStr(date, "yyyyMMddHHmmss") + "-";
    }

    /**
     * 获取文件扩展名
     * @param fileName
     * @return
     */
    private static String getFileExtension(String fileName) {
        if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0) {
            return fileName.substring(fileName.lastIndexOf("."));
        } else {
            return "";
        }
    }

    /**
     * 是否包含中文
     * @param str
     * @return
     */
    public static boolean isContainChinese(String str) {

        Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
        Matcher m = p.matcher(str);
        if (m.find()) {
            return true;
        }
        return false;
    }
}
