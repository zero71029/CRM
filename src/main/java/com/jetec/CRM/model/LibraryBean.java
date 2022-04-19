package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "library")
public class LibraryBean {
    @Id
    private String libraryid;
    private String librarygroup;
    private String libraryoption;
    private String remark;

    public LibraryBean() {
    }

    public LibraryBean(String libraryid, String librarygroup, String libraryoption, String remark) {
        this.libraryid = libraryid;
        this.librarygroup = librarygroup;
        this.libraryoption = libraryoption;
        this.remark = remark;
    }

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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "LibraryBean [libraryid=" + libraryid + ", librarygroup=" + librarygroup + ", libraryoption="
                + libraryoption + "]";
    }


}
