package com.jetec.CRM.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "authorize")
public class AuthorizeBean {
	
	@Id
	private String id;
	private String used;
	private Date createtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	@Override
	public String toString() {
		return "AuthorizeBean [id=" + id + ", used=" + used + ", createtime=" + createtime + "]";
	}
	
	
;	

}
