package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="potentialcustomerhelper")
public class PotentialCustomerHelperBean {
	@Id
	private String helperid;
	private String name;
	private Integer customerid;
	private Integer adminid;
	public String getHelperid() {
		return helperid;
	}
	public void setHelperid(String helperid) {
		this.helperid = helperid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getCustomerid() {
		return customerid;
	}
	public void setCustomerid(Integer customerid) {
		this.customerid = customerid;
	}
	public Integer getAdminid() {
		return adminid;
	}
	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}
	@Override
	public String toString() {
		return "PotentialCustomerHelperBean [helperid=" + helperid + ", name=" + name + ", customerid=" + customerid
				+ ", adminid=" + adminid + "]";
	}
	
	
}
