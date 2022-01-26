package com.jetec.CRM.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.Id;
import javax.persistence.OneToMany;


@Entity
@Table(name = "admin")
public class AdminBean {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer adminid;
    private String name;
    private String phone;
    private String 	email;
    private String address;//
    private String password;//
    private String 	state;//
    private String 	position;//職位
    private  Date create_data;//
    private String department;//部門	
    private String 	director;//主管
    private String 	dutyDay;//到職日
    

	@OneToMany(targetEntity = AdminMailBean.class ,mappedBy = "adminid", cascade = CascadeType.ALL)
	private List<AdminMailBean> mail;
	//@他人

	@OneToMany(targetEntity = BillboardAdviceBean.class ,mappedBy = "adviceto", cascade = CascadeType.ALL)
	private List<BillboardAdviceBean> advice;

	@OneToMany(targetEntity = BillboardTopBean.class ,mappedBy = "adminid", cascade = CascadeType.ALL)
	private List<BillboardTopBean> top;
	
    
    
	public List<BillboardTopBean> getTop() {
		return top;
	}
	public void setTop(List<BillboardTopBean> top) {
		this.top = top;
	}
	public List<BillboardAdviceBean> getAdvice() {
		return advice;
	}
	public void setAdvice(List<BillboardAdviceBean> advice) {
		this.advice = advice;
	}
	public String getDutyDay() {
		return dutyDay;
	}
	public void setDutyDay(String dutyDay) {
		this.dutyDay = dutyDay;
	}
	public List<AdminMailBean> getMail() {
		return mail;
	}
	public void setMail(List<AdminMailBean> mail) {
		this.mail = mail;
	}
	public Integer getAdminid() {
		return adminid;
	}
	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		StringBuffer sb = new StringBuffer(phone);
		if(sb.length()>9) {
			sb.insert(4, "-");
			sb.insert(8, "-");
		}
		return sb.toString();
	}
	public void setPhone(String phone) {	
		phone = phone.replace("-", "");
		phone = phone.replace("(", "");
		phone = phone.replace(")", "");	
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Date getCreate_data() {
		return create_data;
	}
	public void setCreate_data(Date create_data) {
		this.create_data = create_data;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	@Override
	public String toString() {
		return "AdminBean [adminid=" + adminid + ", name=" + name + ", phone=" + phone + ", email=" + email
				+ ", address=" + address + ", password=" + password + ", state=" + state + ", position=" + position
				+ ", create_data=" + create_data + ", department=" + department + ", director=" + director + "]";
	}
    
    

}
