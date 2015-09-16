package com.letvcloud.uc.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util{
    
    private static char md5Chars[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    
    private static MessageDigest messagedigest;
    
    public static String getFileMD5String(File file) throws IOException {
    
        try {
            messagedigest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        FileInputStream in = new FileInputStream(file);
        FileChannel ch = in.getChannel();
        MappedByteBuffer byteBuffer = ch.map(FileChannel.MapMode.READ_ONLY, 0, file.length());
        messagedigest.update(byteBuffer);
        ch.close();
        in.close();
        return bufferToHex(messagedigest.digest());
    }
    
    public static String getStringMD5String(String str) throws Exception {
    
        messagedigest = MessageDigest.getInstance("MD5");
        messagedigest.update(str.getBytes());
        return bufferToHex(messagedigest.digest());
    }
    
    public static boolean check(String str, String md5) throws Exception {
    
        if (getStringMD5String(str).equals(md5))
            return true;
        else
            return false;
    }
    
    public static boolean check(File f, String md5) throws Exception {
    
        if (getFileMD5String(f).equals(md5))
            return true;
        else
            return false;
    }
    
    private static String bufferToHex(byte bytes[]) {
    
        return bufferToHex(bytes, 0, bytes.length);
    }
    
    private static String bufferToHex(byte bytes[], int m, int n) {
    
        StringBuffer stringbuffer = new StringBuffer(2 * n);
        int k = m + n;
        for (int l = m; l < k; l++) {
            appendHexPair(bytes[l], stringbuffer);
        }
        return stringbuffer.toString();
    }
    
    private static void appendHexPair(byte bt, StringBuffer stringbuffer) {
    
        char c0 = md5Chars[(bt & 0xf0) >> 4];
        char c1 = md5Chars[bt & 0xf];
        stringbuffer.append(c0);
        stringbuffer.append(c1);
    }
}
