package com.jetec.CRM.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "billboardreply")
public class BillboardReplyBean {
	@Id
	private String replyid;	
	private Integer billboardid;	
	private String name;
	private String content;
	private Date createtime;
	
	
	
	
	//回覆
	@JsonIgnore
	@OneToMany(targetEntity = ReplyreplyBean.class ,mappedBy = "replyid", cascade = CascadeType.ALL)
	@OrderBy("createtime DESC")
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
	public String getCreatetime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(createtime);
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	@Override
	public String toString() {
		return "BillboardReplyBean [replyid=" + replyid + ", billboardid=" + billboardid + ", name=" + name
				+ ", content=" + content + ", createtime=" + createtime + "]";
	}
	
	
}
