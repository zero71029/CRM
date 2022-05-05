package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "bosmessage")
public class BosMessageBean {

    @Id
    private String  bosmessageid;//id
    private String  bosid;//上一層外鍵	
    private String  name;//留言者
    private String  message;//留言內容
//    private Date createtime;//最後修改時間
    private String lastmodified;

    public BosMessageBean(){

    }

    public BosMessageBean(String bosmessageid, String bosid, String name, String message, String lastmodified) {
        this.bosmessageid = bosmessageid;
        this.bosid = bosid;
        this.name = name;
        this.message = message;
        this.lastmodified = lastmodified;
    }

    public String getLastmodified() {
        return lastmodified;
    }

    public void setLastmodified(String lastmodified) {
        this.lastmodified = lastmodified;
    }

    public String getBosmessageid() {
        return bosmessageid;
    }

    public void setBosmessageid(String bosmessageid) {
        this.bosmessageid = bosmessageid;
    }

    public String getBosid() {
        return bosid;
    }

    public void setBosid(String bosid) {
        this.bosid = bosid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
