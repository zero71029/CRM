package com.jetec.CRM.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "authorize")
public class AuthorizeBean {
	
	@Id
	private String id;
	private String used;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}

	@Override
	public String toString() {
		return "AuthorizeBean{" +
				"id='" + id + '\'' +
				", used='" + used + '\'' +
				'}';
	}
}
