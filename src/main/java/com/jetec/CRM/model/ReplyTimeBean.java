package com.jetec.CRM.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name ="replytime")
public class ReplyTimeBean {
	
	@Id
	private Integer billboardid;
	private String aaa;
	private  Date createtime;
	
	
	
	
	
	
	
	
	
	
	
	
	public Integer getBillboardid() {
		return billboardid;
	}
	public void setBillboardid(Integer billboardid) {
		this.billboardid = billboardid;
	}
	public String getAaa() {
		return aaa;
	}
	public void setAaa(String aaa) {
		this.aaa = aaa;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	@Override
	public String toString() {
		return "ReplyTimeBean [billboardid=" + billboardid + ", aaa=" + aaa + ", createtime=" + createtime + "]";
	}
	
	
}
