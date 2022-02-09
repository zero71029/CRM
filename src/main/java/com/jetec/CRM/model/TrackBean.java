package com.jetec.CRM.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "track")
public class TrackBean {
	
	@Id	
	private String trackid;//
	private String customerid;//潛在客戶
	private String trackdescribe;//	描述	
	private String result;//結果
	private String remark;//備註
	private String tracktime;//時間	
	
	//工作項目
	@OrderBy("createtime desc")
	@OneToMany(targetEntity = TrackRemarkBean.class ,mappedBy = "trackid", cascade = CascadeType.ALL)
	private List<TrackRemarkBean> trackremark;
	
	@JsonIgnore
	@ManyToOne(targetEntity = PotentialCustomerBean.class)
	@JoinColumn(name = "customerid", referencedColumnName = "customerid", insertable = false, updatable = false)
	private PotentialCustomerBean pcb;// 分類

	
	
	
	
	
	
	
	public List<TrackRemarkBean> getTrackremark() {
		return trackremark;
	}
	public void setTrackremark(List<TrackRemarkBean> trackremark) {
		this.trackremark = trackremark;
	}
	public PotentialCustomerBean getPcb() {
		return pcb;
	}
	public void setPcb(PotentialCustomerBean pcb) {
		this.pcb = pcb;
	}


	public String getTrackid() {
		return trackid;
	}
	public void setTrackid(String trackid) {
		this.trackid = trackid;
	}
	public String getCustomerid() {
		return customerid;
	}
	public void setCustomerid(String customerid) {
		this.customerid = customerid;
	}
	public String getTrackdescribe() {
		return trackdescribe;
	}
	public void setTrackdescribe(String trackdescribe) {
		this.trackdescribe = trackdescribe;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getTracktime() {
		return tracktime;
	}
	public void setTracktime(String tracktime) {
		this.tracktime = tracktime;
	}
	@Override
	public String toString() {
		return "TrackBean [trackid=" + trackid + ", customerid=" + customerid + ", trackdescribe=" + trackdescribe
				+ ", result=" + result + ", remark=" + remark + ", tracktime=" + tracktime + "]";
	}

	
	
	
	
}
