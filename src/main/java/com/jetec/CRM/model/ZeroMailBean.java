package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "zeromail")
public class ZeroMailBean {
    public ZeroMailBean() {
    }

    public ZeroMailBean(String zeromailid, String createtime, Integer num) {
        this.zeromailid = zeromailid;
        this.createtime = createtime;
        this.num = num;
    }

    @Id
    private String zeromailid;
    private String createtime;
    private Integer num;


    public String getZeromailid() {
        return zeromailid;
    }

    public void setZeromailid(String zeromailid) {
        this.zeromailid = zeromailid;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }
}


