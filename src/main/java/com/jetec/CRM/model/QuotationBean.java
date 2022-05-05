package com.jetec.CRM.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "quotation")
public class QuotationBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer quotationid;//
	private String name;
	private String phone;
	private String email;
	private String fax;
	private String contactname;
	private String contactmoblie;
	private String contactjobtitle;
	private String remark;
	private String user;

	
	@JsonIgnore
	@OneToMany(targetEntity = QuotationDetailBean.class,orphanRemoval=true, cascade = CascadeType.ALL)
	@JoinColumn(name = "quotationid", referencedColumnName = "quotationid")
	private List<QuotationDetailBean> qdb;	
	
	
	
	
	public List<QuotationDetailBean> getQdb() {
		return qdb;
	}
	public void setQdb(List<QuotationDetailBean> qdb) {
		this.qdb = qdb;
	}
	public Integer getQuotationid() {
		return quotationid;
	}
	public void setQuotationid(Integer quotationid) {
		this.quotationid = quotationid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getContactname() {
		return contactname;
	}
	public void setContactname(String contactname) {
		this.contactname = contactname;
	}
	public String getContactmoblie() {
		return contactmoblie;
	}
	public void setContactmoblie(String contactmoblie) {
		this.contactmoblie = contactmoblie;
	}
	public String getContactjobtitle() {
		return contactjobtitle;
	}
	public void setContactjobtitle(String contactjobtitle) {
		this.contactjobtitle = contactjobtitle;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}



	@Override
	public String toString() {
		return "QuotationBean [qdb=" + qdb + "]";
	}
	
	

}
