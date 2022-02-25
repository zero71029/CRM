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
    private Date createtime;//創建時間
    public BosMessageBean(){

    }

    public BosMessageBean(String bosmessageid, String bosid, String name, String message) {
        this.bosmessageid = bosmessageid;
        this.bosid = bosid;
        this.name = name;
        this.message = message;
    }

    @Override
    public String toString() {
        return "{" +
                "'bosmessageid':'" + bosmessageid + '\'' +
                ", 'bosid':'" + bosid + '\'' +
                ", 'name':'" + name + '\'' +
                ", 'message':'" + message + '\'' +
                ", 'createtime':" + createtime +
                '}';
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

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
}
