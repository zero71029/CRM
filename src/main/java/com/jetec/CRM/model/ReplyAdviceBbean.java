package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "replyadvice")
public class ReplyAdviceBbean {

	
	@Id
	private String replyadvice;
	private String replyid;
	private Integer adviceto;
	public String getReplyadvice() {
		return replyadvice;
	}
	public void setReplyadvice(String replyadvice) {
		this.replyadvice = replyadvice;
	}
	public String getReplyid() {
		return replyid;
	}
	public void setReplyid(String replyid) {
		this.replyid = replyid;
	}
	public Integer getAdviceto() {
		return adviceto;
	}
	public void setAdviceto(Integer adviceto) {
		this.adviceto = adviceto;
	}
	@Override
	public String toString() {
		return "ReplyAdviceBbean [replyadvice=" + replyadvice + ", replyid=" + replyid + ", adviceto=" + adviceto + "]";
	}
	
	
	
}
