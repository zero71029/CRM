package com.jetec.CRM.model;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;



 //計算幾人讀過用
@Entity
@Table(name = "billboardread")
public class BillboardReadBean {
	
	@Id
	private String readid;	
	private Integer billboardid;	
	private String name;
	public String getReadid() {
		return readid;
	}
	public void setReadid(String readid) {
		this.readid = readid;
	}
	public Integer getBillboardid() {
		return billboardid;
	}
	public void setBillboardid(Integer billboardid) {
		this.billboardid = billboardid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	 @Override
	 public String toString() {
		 return "BillboardReadBean{" +
				 "readid='" + readid + '\'' +
				 ", billboardid=" + billboardid +
				 ", name='" + name + '\'' +
				 '}';
	 }
 }
