package com.jetec.CRM.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "billboardgroup")
public class BillboardGroupBean {
	
	@Id
	private String billboardgroupid;		
	private String billboardgroup;
	private String billboardoption;

	@JsonIgnore
	@OneToMany(targetEntity = BillboardBean.class ,mappedBy = "billboardgroupid", cascade = CascadeType.ALL)
	private List<BillboardBean> BillboardBeanList;
	

	public String getBillboardgroupid() {
		return billboardgroupid;
	}
	public void setBillboardgroupid(String billboardgroupid) {
		this.billboardgroupid = billboardgroupid;
	}
	public String getBillboardgroup() {
		return billboardgroup;
	}
	public void setBillboardgroup(String billboardgroup) {
		this.billboardgroup = billboardgroup;
	}
	public String getBillboardoption() {
		return billboardoption;
	}
	public void setBillboardoption(String billboardoption) {
		this.billboardoption = billboardoption;
	}
	@Override
	public String toString() {
		return "BillboardGroupBean [billboardgroupid=" + billboardgroupid + ", billboardgroup=" + billboardgroup
				+ ", billboardoption=" + billboardoption + "]";
	}
	
	
}
