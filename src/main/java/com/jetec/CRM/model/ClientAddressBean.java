package com.jetec.CRM.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="clientaddress")
public class ClientAddressBean {
	
	
	
	
	
	@Id
	private String addressid	;
	private Integer clientid;	
	private String city;
	private String town;
	private String postal;
	private String address;
	private Date createtime;
	
	
	//客戶
	@ManyToOne(targetEntity = ClientBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "clientid", referencedColumnName = "clientid", insertable = false, updatable = false)
	private ClientBean client;
	
	
	
	
	public String getAddressid() {
		return addressid;
	}
	public void setAddressid(String addressid) {
		this.addressid = addressid;
	}
	public Integer getClientid() {
		return clientid;
	}
	public void setClientid(Integer clientid) {
		this.clientid = clientid;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getTown() {
		return town;
	}
	public void setTown(String town) {
		this.town = town;
	}
	public String getPostal() {
		return postal;
	}
	public void setPostal(String postal) {
		this.postal = postal;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	@Override
	public String toString() {
		return "ClientAddressBean [addressid=" + addressid + ", clientid=" + clientid + ", city=" + city + ", town="
				+ town + ", postal=" + postal + ", address=" + address + ", createtime=" + createtime + "]";
	}

	
}
