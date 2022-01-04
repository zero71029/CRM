package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="library")
public class LibraryBean {
    @Id   
    private String libraryid;
    private String librarygroup;
    private String libraryoption;
	public String getLibraryid() {
		return libraryid;
	}
	public void setLibraryid(String libraryid) {
		this.libraryid = libraryid;
	}
	public String getLibrarygroup() {
		return librarygroup;
	}
	public void setLibrarygroup(String librarygroup) {
		this.librarygroup = librarygroup;
	}
	public String getLibraryoption() {
		return libraryoption;
	}
	public void setLibraryoption(String libraryoption) {
		this.libraryoption = libraryoption;
	}
	@Override
	public String toString() {
		return "LibraryBean [libraryid=" + libraryid + ", librarygroup=" + librarygroup + ", libraryoption="
				+ libraryoption + "]";
	}
    
    
}
