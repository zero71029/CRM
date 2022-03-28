package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "marketstate")
public class MarketStateBean {

	@Id
	private String marketstateid;//
	private Integer adminid;
	private String 	field;
	private String state;
	public String getMarketstateid() {
		return marketstateid;
	}
	public void setMarketstateid(String marketstateid) {
		this.marketstateid = marketstateid;
	}
	public Integer getAdminid() {
		return adminid;
	}
	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "MarketStateBean [marketstateid=" + marketstateid + ", adminid=" + adminid + ", field=" + field
				+ ", state=" + state + "]";
	}
	public MarketStateBean(String marketstateid, Integer adminid, String field, String state) {
		super();
		this.marketstateid = marketstateid;
		this.adminid = adminid;
		this.field = field;
		this.state = state;
	}
	public MarketStateBean() {
		super();
	}
	

	
	
	
}
