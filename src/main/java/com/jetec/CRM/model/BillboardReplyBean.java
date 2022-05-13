package com.jetec.CRM.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "billboardreply")
public class BillboardReplyBean {
	@Id
	private String replyid;	
	private Integer billboardid;	
	private String name;
	private String content;
	private Date lastmodified;
	
	
	
	
	//回覆
	@JsonIgnore
	@OneToMany(targetEntity = ReplyreplyBean.class ,mappedBy = "replyid", cascade = CascadeType.ALL)
	@OrderBy("lastmodified DESC")
	private List<BillboardReplyBean> reply;
	//@他人
	@JsonIgnore
	@OneToMany(targetEntity = ReplyAdviceBbean.class ,mappedBy = "replyid", cascade = CascadeType.ALL)
	private List<BillboardReplyBean> advice;
	//留言附件
	@JsonIgnore
	@OneToMany(targetEntity = ReplyFileBean.class ,mappedBy = "replyid", cascade = CascadeType.ALL)
	private List<ReplyFileBean> file;
	
	
	
	
	
	
	public List<BillboardReplyBean> getAdvice() {
		return advice;
	}
	public void setAdvice(List<BillboardReplyBean> advice) {
		this.advice = advice;
	}
	public List<ReplyFileBean> getFile() {
		return file;
	}
	public void setFile(List<ReplyFileBean> file) {
		this.file = file;
	}
	public List<BillboardReplyBean> getReply() {
		return reply;
	}
	public void setReply(List<BillboardReplyBean> reply) {
		this.reply = reply;
	}
	public String getReplyid() {
		return replyid;
	}
	public void setReplyid(String replyid) {
		this.replyid = replyid;
	}
	public Integer getBillboardid() {
		return billboardid;
	}
	public void setBillboardid(Integer billboardid) {
		this.billboardid = billboardid;
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
		return "BillboardReplyBean{" +
				"replyid='" + replyid + '\'' +
				", billboardid=" + billboardid +
				", name='" + name + '\'' +
				", content='" + content + '\'' +
				", lastmodified=" + lastmodified +
				", reply=" + reply +
				", advice=" + advice +
				", file=" + file +
				'}';
	}
}
