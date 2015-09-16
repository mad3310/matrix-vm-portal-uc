package com.letvcloud.uc.utils;

import java.util.regex.Pattern;

/**
 * Created by zhaoliang5 on 2015/6/18 9:57.
 */
public class CheckUtils {
    private static final String emailRegex = "^([a-z0-9A-Z_]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";

    private static final String mobileRegex = "^13[0-9]{9}$|14[0-9]{9}$|15[0-9]{9}$|17[0-9]{9}$|18[0-9]{9}$";
    private static final String numRegex = "([0-9]*)";

    public static boolean isEmail(String email) {
        return check(emailRegex, email);
    }

    public static boolean isMobile(String mobile) {
        return check(mobileRegex, mobile);
    }
    public static boolean isNum(String mobile) {
        return check(numRegex, mobile);
    }

    public static boolean check(String regex, CharSequence input) {
        return Pattern.compile(regex).matcher(input).matches();
    }
}
