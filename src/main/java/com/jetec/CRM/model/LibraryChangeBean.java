package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "librarychange")
public class LibraryChangeBean {
    @Id
    private String librarychangeid;
    private String librarygroup;
    private String libraryoption;
    private String action;
    private String aaa;

    public LibraryChangeBean() {
    }

    public LibraryChangeBean(String librarychangeid, String librarygroup, String libraryoption, String action, String aaa) {
        this.librarychangeid = librarychangeid;
        this.librarygroup = librarygroup;
        this.libraryoption = libraryoption;
        this.action = action;
        this.aaa = aaa;
    }

    @Override
    public String toString() {
        return "LibraryChangeBean{" +
                "librarychangeid='" + librarychangeid + '\'' +
                ", librarygroup='" + librarygroup + '\'' +
                ", libraryoption='" + libraryoption + '\'' +
                ", action='" + action + '\'' +
                '}';
    }

    public String getAaa() {
        return aaa;
    }

    public void setAaa(String aaa) {
        this.aaa = aaa;
    }

    public String getLibrarychangeid() {
        return librarychangeid;
    }

    public void setLibrarychangeid(String librarychangeid) {
        this.librarychangeid = librarychangeid;
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

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
}
