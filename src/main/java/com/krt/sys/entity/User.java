package com.krt.sys.entity;


import com.krt.common.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

/**
 * @Description: 用户实体类
 * @author 殷帅
 * @date 2017年03月27日
 * @version 1.0
 */
@Getter
@Setter
@ToString(callSuper = true)
public class User extends BaseEntity {

	/**
	 * 用户名
	 */
	@NotBlank(message="用户名不能为空!!!")
	private String username;

	/**
	 * 密码
	 */
	@NotBlank(message="密码不能为空")
	@Length(min=6,max = 20,message="密码长度不能小于6位,大于20位")
	private String password;

	/**
	 * 姓名
	 */
	@NotBlank(message="姓名不能为空")
	private String name;

	/**
	 * 账号状态 0：正常 1：禁用
	 */
	private String status;

	/**
	 * 角色编码
	 */
	@NotBlank(message="角色编码不能为空")
	private String roleCode;

	/**
	 * 机构编码
	 */
	private String organizationCode;

	/**
	 * 区域码
	 */
	private String regionCode;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getOrganizationCode() {
		return organizationCode;
	}

	public void setOrganizationCode(String organizationCode) {
		this.organizationCode = organizationCode;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
}