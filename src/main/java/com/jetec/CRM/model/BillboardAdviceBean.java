package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "billboardadvice")
public class BillboardAdviceBean {
	
	@Id
	private String adviceid;
	private String formname;
	private Integer advicefrom;
	private Integer adviceto;
	private Integer billboardid;

	private String reply;
	
	
	
	
	
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public String getFormname() {
		return formname;
	}
	public void setFormname(String formname) {
		this.formname = formname;
	}
	public String getAdviceid() {
		return adviceid;
	}
	public void setAdviceid(String adviceid) {
		this.adviceid = adviceid;
	}
	public Integer getAdvicefrom() {
		return advicefrom;
	}
	public void setAdvicefrom(Integer advicefrom) {
		this.advicefrom = advicefrom;
	}
	public Integer getAdviceto() {
		return adviceto;
	}
	public void setAdviceto(Integer adviceto) {
		this.adviceto = adviceto;
	}
	public Integer getBillboardid() {
		return billboardid;
	}
	public void setBillboardid(Integer billboardid) {
		this.billboardid = billboardid;
	}

	@Override
	public String toString() {
		return "BillboardAdviceBean{" +
				"adviceid='" + adviceid + '\'' +
				", formname='" + formname + '\'' +
				", advicefrom=" + advicefrom +
				", adviceto=" + adviceto +
				", billboardid=" + billboardid +
				", reply='" + reply + '\'' +
				'}';
	}
}
