package com.jetec.CRM.model;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "replyreply")
public class ReplyreplyBean {
	
	@Id
	private String id;	
	private String replyid;		
	private String name;
	private String content;
	private Date lastmodified;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReplyid() {
		return replyid;
	}
	public void setReplyid(String replyid) {
		this.replyid = replyid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public Date getLastmodified() {
		return lastmodified;
	}

	public void setLastmodified(Date lastmodified) {
		this.lastmodified = lastmodified;
	}

	@Override
	public String toString() {
		return "ReplyreplyBean{" +
				"id='" + id + '\'' +
				", replyid='" + replyid + '\'' +
				", name='" + name + '\'' +
				", content='" + content + '\'' +
				", lastmodified=" + lastmodified +
				'}';
	}
}
