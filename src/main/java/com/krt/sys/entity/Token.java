package com.krt.sys.entity;

import com.krt.common.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 用户token表实体类
 * @date 2017年04月28日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Token extends BaseEntity {

    /**
     * 用户id
     */
    private Integer userId;
    /**
     * token令牌
     */
    private String accessToken;

    /**
     * 用于刷新Access Token 的 Refresh Token
     */
    private String refreshToken;
    /**
     * 过期时间
     */
    private Date expireTime;
}