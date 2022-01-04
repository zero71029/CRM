package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "billboardtop")
public class BillboardTopBean {

	@Id
	private String topid;
	private Integer adminid;
	private Integer billboardid;
	public String getTopid() {
		return topid;
	}
	public void setTopid(String topid) {
		this.topid = topid;
	}
	public Integer getAdminid() {
		return adminid;
	}
	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}
	public Integer getBillboardid() {
		return billboardid;
	}
	public void setBillboardid(Integer billboardid) {
		this.billboardid = billboardid;
	}
	@Override
	public String toString() {
		return "BillboardTop [topid=" + topid + ", adminid=" + adminid + ", billboardid=" + billboardid + "]";
	}

	
	
}
