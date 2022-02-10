package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OrderBy;
import javax.persistence.Table;

@Entity
@Table(name = "trackremark")
public class TrackRemarkBean {

	@Id
	private String trackremarkid;//主鍵
	private String trackid;//TrackBean
	private String content;//內容
	@OrderBy("desc")
	private String createtime;
	private String name;//回覆人 
	
	
	
	

	public String getTrackid() {
		return trackid;
	}
	public void setTrackid(String trackid) {
		this.trackid = trackid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTrackremarkid() {
		return trackremarkid;
	}
	public void setTrackremarkid(String trackremarkid) {
		this.trackremarkid = trackremarkid;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}


	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	@Override
	public String toString() {
		return "TrackRemarkBean [trackremarkid=" + trackremarkid + ", trackid=" + trackid + ", content=" + content
				+ ", createtime=" + createtime + ", name=" + name + "]";
	}
	
	
	

}
