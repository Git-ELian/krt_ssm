package com.krt.oa.entity;

import com.krt.common.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 通知公告表实体类
 * @date 2017年05月31日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Notice extends BaseEntity {

	/**
	 * 标题
	 */
	private String title;

	/**
	 * 图片
	 */
	private String img;

	/**
	 * 内容
	 */
	private String content;

	/**
	 * 作者
	 */
	private String author;
}