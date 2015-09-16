package com.letvcloud.uc.mapper.annotations;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;

/**
 * Created by chenliusong on 2015/6/17.
 */

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Documented
@Component
public @interface MyBatisDao {
    String value() default "";
}
