package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "clienttag")
public class ClientTagBean {
	
	@Id
	private String clienttagid;
	private String name;
	private Integer clientid;
	
	
	
	
	
	public String getClienttagid() {
		return clienttagid;
	}
	public void setClienttagid(String clienttagid) {
		this.clienttagid = clienttagid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getClientid() {
		return clientid;
	}
	public void setClientid(Integer clientid) {
		this.clientid = clientid;
	}
	@Override
	public String toString() {
		return "ClientTagBean [clienttagid=" + clienttagid + ", name=" + name + ", clientid=" + clientid + "]";
	}
	
	

}
