package com.jetec.CRM.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="potentialcustomer")
public class PotentialCustomerBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer customerid;
	private String name;
	private String company;
	private String jobtitle;
	private String email;
	private String phone;
	private String moblie;
	private String fax;
	private String department;
	private String 	director;
	private String industry;
	private Integer companynum;
	private String source;
	private String 	fromactivity;
	private String user;
	private String contacttime;
	private String status;
	private String city;
	private String town;
	private String postal;
	private String address;
	private String remark;
	private Date createtime;
	private String important;
	
	
	@JsonIgnore
	@OrderBy("tracktime DESC")
	@OneToMany(mappedBy = "customerid", cascade = CascadeType.ALL)
	private List<TrackBean> trackbean;
	
	@JsonIgnore
	@OneToMany(mappedBy = "customerid", cascade = CascadeType.ALL)
	private List<PotentialCustomerHelperBean> helper;	
	
	//工作項目
	@JsonIgnore
	@OneToMany(targetEntity = WorkBean.class ,mappedBy = "customerid", cascade = CascadeType.ALL)
	private List<WorkBean> work;
	
	
	
	
	
	public String getImportant() {
		return important;
	}
	public void setImportant(String important) {
		this.important = important;
	}
	public List<PotentialCustomerHelperBean> getHelper() {
		return helper;
	}
	public void setHelper(List<PotentialCustomerHelperBean> helper) {
		this.helper = helper;
	}
	public String getCreatetime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		return sdf.format(createtime);
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public List<WorkBean> getWork() {
		return work;
	}
	public void setWork(List<WorkBean> work) {
		this.work = work;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getTown() {
		return town;
	}
	public void setTown(String town) {
		this.town = town;
	}
	public String getPostal() {
		return postal;
	}
	public void setPostal(String postal) {
		this.postal = postal;
	}
	public List<TrackBean> getTrackbean() {
		return trackbean;
	}
	public void setTrackbean(List<TrackBean> trackbean) {
		this.trackbean = trackbean;
	}
	public Integer getCustomerid() {
		return customerid;
	}
	public void setCustomerid(Integer customerid) {
		this.customerid = customerid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getJobtitle() {
		return jobtitle;
	}
	public void setJobtitle(String jobtitle) {
		this.jobtitle = jobtitle;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		StringBuffer sb = new StringBuffer(phone);
		if(sb.length()==10) {
			sb.insert(3, "-");
			sb.insert(7, "-");
		}
		if(sb.length()==9) {
			sb.insert(2, "-");
			sb.insert(6, "-");
		}
		if(sb.length()==8) {
			sb.insert(5, "-");
		}
		if(sb.length()==7) {
			sb.insert(4, "-");
		}
		return sb.toString();	
	}
	public void setPhone(String phone) {
		phone = phone.replace("-", "");
		phone = phone.replace("(", "");
		phone = phone.replace(")", "");	
		this.phone = phone;
	}
	public String getMoblie() {
		StringBuffer sb = new StringBuffer(moblie);
		if(sb.length()>9) {
			sb.insert(4, "-");
			sb.insert(8, "-");
		}
		return sb.toString();
	}
	public void setMoblie(String moblie) {
		moblie = moblie.replace("-", "");
		this.moblie = moblie;
	}
	public String getFax() {
		StringBuffer sb = new StringBuffer(fax);
		if(sb.length()==10) {
			sb.insert(3, "-");
			sb.insert(7, "-");
		}
		if(sb.length()==9) {
			sb.insert(2, "-");
			sb.insert(6, "-");
		}
		if(sb.length()==8) {
			sb.insert(5, "-");
		}
		if(sb.length()==7) {
			sb.insert(4, "-");
		}
		return sb.toString();
	}
	public void setFax(String fax) {
		fax = fax.replace("-", "");
		fax = fax.replace("(", "");
		fax = fax.replace(")", "");	
		this.fax = fax;
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
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public Integer getCompanynum() {
		return companynum;
	}
	public void setCompanynum(Integer companynum) {
		this.companynum = companynum;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getFromactivity() {
		return fromactivity;
	}
	public void setFromactivity(String fromactivity) {
		this.fromactivity = fromactivity;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getContacttime() {
		return contacttime;
	}
	public void setContacttime(String contacttime) {
		this.contacttime = contacttime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Override
	public String toString() {
		return " [customerid=" + customerid + ", name=" + name + ", company=" + company
				+ ", jobtitle=" + jobtitle + ", email=" + email + ", phone=" + phone + ", moblie=" + moblie + ", fax="
				+ fax + ", department=" + department + ", director=" + director + ", industry=" + industry
				+ ", companynum=" + companynum + ", source=" + source + ", fromactivity=" + fromactivity + ", user="
				+ user + ", contacttime=" + contacttime + ", status=" + status + ", city=" + city + ", town=" + town
				+ ", postal=" + postal + ", address=" + address + ", remark=" + remark + ", createtime=" + createtime
				+ "]";
	}


	
	
}
