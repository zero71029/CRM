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
	private  Date lastmodified;
	
	
	
	
	
	
	
	
	
	
	
	
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

	public Date getLastmodified() {
		return lastmodified;
	}

	public void setLastmodified(Date lastmodified) {
		this.lastmodified = lastmodified;
	}

	@Override
	public String toString() {
		return "ReplyTimeBean{" +
				"billboardid=" + billboardid +
				", aaa='" + aaa + '\'' +
				", lastmodified=" + lastmodified +
				'}';
	}
}
