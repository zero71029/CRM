package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "replyfile")
public class ReplyFileBean {
	
    @Id   
    private String replyfileid;;
    private String replyid;
    private String url;
    private String authorize;
    private String name;
	public String getReplyfileid() {
		return replyfileid;
	}
	public void setReplyfileid(String replyfileid) {
		this.replyfileid = replyfileid;
	}
	public String getReplyid() {
		return replyid;
	}
	public void setReplyid(String replyid) {
		this.replyid = replyid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getAuthorize() {
		return authorize;
	}
	public void setAuthorize(String authorize) {
		this.authorize = authorize;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "ReplyFileBean [replyfileid=" + replyfileid + ", replyid=" + replyid + ", url=" + url + ", authorize="
				+ authorize + ", name=" + name + "]";
	}

}

