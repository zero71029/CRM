package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "changemessage")
public class ChangeMessageBean {

    @Id
    private String changemessageid;
    private String changeid;
    private String name;
    private String filed;
    private String source;
    private String after;
    private String createtime;

    public ChangeMessageBean() {
    }

    public ChangeMessageBean(String changemessageid, String changeid, String filed, String source, String after, String createtime) {
        this.changemessageid = changemessageid;
        this.changeid = changeid;
        this.filed = filed;
        this.source = source;
        this.after = after;
        this.createtime = createtime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getChangemessageid() {
        return changemessageid;
    }

    public void setChangemessageid(String changemessageid) {
        this.changemessageid = changemessageid;
    }

    public String getChangeid() {
        return changeid;
    }

    public void setChangeid(String changeid) {
        this.changeid = changeid;
    }

    public String getFiled() {
        return filed;
    }

    public void setFiled(String filed) {
        this.filed = filed;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getAfter() {
        return after;
    }

    public void setAfter(String after) {
        this.after = after;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }


    @Override
    public String toString() {
        return "ChangeMessageBean{" +
                "changemessageid='" + changemessageid + '\'' +
                ", changeid='" + changeid + '\'' +
                ", filed='" + filed + '\'' +
                ", source='" + source + '\'' +
                ", after='" + after + '\'' +
                ", createtime='" + createtime + '\'' +
                '}';
    }
}
