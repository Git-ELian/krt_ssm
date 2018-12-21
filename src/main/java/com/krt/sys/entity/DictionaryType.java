package com.krt.sys.entity;

import com.krt.common.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;


/**
 * @author 殷帅
 * @version 1.0
 * @Description: 字典类型表实体类
 * @date 2017年04月11日
 */
@Getter
@Setter
@ToString(callSuper = true)
public class DictionaryType extends BaseEntity {

	/**
	 * 类型编码
	 */
	@NotBlank(message = "类型编码不能为空")
	private String code;

	/**
	 * 类型名称
	 */
	@NotBlank(message = "类型名称不能为空")
	private String name;

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 排序
	 */
	@NotNull(message = "排序不能为空")
	private Integer sortNo;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getSortNo() {
		return sortNo;
	}

	public void setSortNo(Integer sortNo) {
		this.sortNo = sortNo;
	}
}