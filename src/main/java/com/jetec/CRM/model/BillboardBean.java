package com.jetec.CRM.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "billboard")
public class BillboardBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer billboardid;
	private String user; //發表人	
	private String theme; //主題	
	private String content; //內容	
	private String state; //狀態
	private String replytime; //最後回覆時間	
	private String time;//
	private String top;//
	private String readcount;//保留給已讀人數用
	private String billboardgroupid;
	private String billtowngroup;
	private String  remark;//備註
	private Date lastmodified; //創造時間
	
	//以讀人數
	@JsonIgnore
	@OneToMany(targetEntity = BillboardReadBean.class ,mappedBy = "billboardid", cascade = CascadeType.ALL)
	private List<BillboardReadBean> read;
	//回覆
	@JsonIgnore
	@OneToMany(targetEntity = BillboardReplyBean.class ,mappedBy = "billboardid", cascade = CascadeType.ALL)
	@OrderBy("lastmodified DESC")
	private List<BillboardReplyBean> reply;
	//分類群組
	@ManyToOne(targetEntity = BillboardGroupBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "billboardgroupid", referencedColumnName = "billboardgroupid", insertable = false, updatable = false)
	private BillboardGroupBean bgb;
	@JsonIgnore
	@OneToMany(targetEntity = BillboardFileBean.class ,mappedBy = "billboardid", cascade = CascadeType.ALL)
	private List<BillboardFileBean> file;
	
	//@他人
	@JsonIgnore
	@OneToMany(targetEntity = BillboardAdviceBean.class ,mappedBy = "billboardid", cascade = CascadeType.ALL)
	private List<BillboardAdviceBean> advice; 
	
	//最後回覆時間
	@JsonIgnore
	@OneToOne(targetEntity = ReplyTimeBean.class , cascade = CascadeType.ALL)
	@JoinColumn(name="billboardid", referencedColumnName="billboardid")
	private ReplyTimeBean rrr;
	
	
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public List<BillboardAdviceBean> getAdvice() {
		return advice;
	}
	public void setAdvice(List<BillboardAdviceBean> advice) {
		this.advice = advice;
	}
	public List<BillboardFileBean> getFile() {
		return file;
	}
	public void setFile(List<BillboardFileBean> file) {
		this.file = file;
	}
	public BillboardGroupBean getBgb() {
		return bgb;
	}
	public void setBgb(BillboardGroupBean bgb) {
		this.bgb = bgb;
	}
	

	
	
	public String getReplytime() {
		return replytime;
	}
	public void setReplytime(String replytime) {
		this.replytime = replytime;
	}
	public String getBilltowngroup() {
		return billtowngroup;
	}
	public void setBilltowngroup(String billtowngroup) {
		this.billtowngroup = billtowngroup;
	}
	public List<BillboardReplyBean> getReply() {
		return reply;
	}
	public void setReply(List<BillboardReplyBean> reply) {
		this.reply = reply;
	}

	public String getBillboardgroupid() {
		return billboardgroupid;
	}
	public void setBillboardgroupid(String billboardgroupid) {
		this.billboardgroupid = billboardgroupid;
	}
	public List<BillboardReadBean> getRead() {
		return read;
	}
	public void setRead(List<BillboardReadBean> read) {
		this.read = read;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}

	public String getTop() {
		return top;
	}
	public void setTop(String top) {
		this.top = top;
	}
	public String getReadcount() {
		return readcount;
	}
	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}
	public Integer getBillboardid() {
		return billboardid;
	}
	public void setBillboardid(Integer billboardid) {
		this.billboardid = billboardid;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

	public Date getLastmodified() {
		return lastmodified;
	}

	public void setLastmodified(Date lastmodified) {
		this.lastmodified = lastmodified;
	}

	@Override
	public String toString() {
		return "BillboardBean{" +
				"billboardid=" + billboardid +
				", user='" + user + '\'' +
				", theme='" + theme + '\'' +
				", content='" + content + '\'' +
				", state='" + state + '\'' +
				", lastmodified=" + lastmodified +
				", replytime='" + replytime + '\'' +
				", time='" + time + '\'' +
				", top='" + top + '\'' +
				", readcount='" + readcount + '\'' +
				", billboardgroupid='" + billboardgroupid + '\'' +
				", billtowngroup='" + billtowngroup + '\'' +
				", remark='" + remark + '\'' +
				'}';
	}
}
