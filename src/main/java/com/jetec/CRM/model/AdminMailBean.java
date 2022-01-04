package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "adminmail")
public class AdminMailBean {
    @Id   
    private String adminmail;
    private Integer adminid;
    private Integer billboardid;
    private String reply;
    
    
    
    
    
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getAdminmail() {
		return adminmail;
	}
	public void setAdminmail(String adminmail) {
		this.adminmail = adminmail;
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
		return "AdminmailBean [adminmail=" + adminmail + ", adminid=" + adminid + ", billboardid=" + billboardid + "]";
	}

    

}
