package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "track")
public class TrackBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;//
	private Integer customerid;//潛在客戶
	private String trackdescribe;//	描述	
	private String result;//結果
	private String remark;//備註
	private String tracktime;//時間	
	
	

	@ManyToOne(targetEntity = PotentialCustomerBean.class)
	@JoinColumn(name = "customerid", referencedColumnName = "customerid", insertable = false, updatable = false)
	private PotentialCustomerBean pcb;// 分類

	public PotentialCustomerBean getPcb() {
		return pcb;
	}
	public void setPcb(PotentialCustomerBean pcb) {
		this.pcb = pcb;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCustomerid() {
		return customerid;
	}
	public void setCustomerid(Integer customerid) {
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
		return "TrackBean [id=" + id + ", customerid=" + customerid + ", trackdescribe=" + trackdescribe + ", result="
				+ result + ", remark=" + remark + ", tracktime=" + tracktime + "]";
	}
	
	
	
	
}
