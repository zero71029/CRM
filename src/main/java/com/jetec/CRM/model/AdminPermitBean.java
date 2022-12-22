package com.jetec.CRM.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "admin_permit")
public class AdminPermitBean {
    @Id
    @Column(columnDefinition = "char(32)")
    private String permitid;
    private Integer admin;
    private String level;

    public AdminPermitBean() {
    }


    public AdminPermitBean(String permitid, Integer admin, String level) {
        this.permitid = permitid;
        this.admin = admin;
        this.level = level;
    }

    public String getPermitid() {
        return permitid;
    }

    public void setPermitid(String permitid) {
        this.permitid = permitid;
    }

    public Integer getAdmin() {
        return admin;
    }

    public void setAdmin(Integer admin) {
        this.admin = admin;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }
}
