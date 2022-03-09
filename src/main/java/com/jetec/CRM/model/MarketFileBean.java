package com.jetec.CRM.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Timestamp;


@Entity
@Table(name = "marketfile")
public class MarketFileBean {

    @Id
    private String fileid;;
    private String fileforeignid;
    private String url;
    private String authorize;
    private String name;
    private Timestamp createtime;

    public MarketFileBean() {
    }

    public MarketFileBean(String fileid, String fileforeignid, String url, String authorize, String name) {
        this.fileid = fileid;
        this.fileforeignid = fileforeignid;
        this.url = url;
        this.authorize = authorize;
        this.name = name;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    public String getFileid() {
        return fileid;
    }

    public void setFileid(String fileid) {
        this.fileid = fileid;
    }



    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getAuthorize() {
        return authorize;
    }

    public void setAuthorize(String authorize) {
        this.authorize = authorize;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFileforeignid() {
        return fileforeignid;
    }

    public void setFileforeignid(String fileforeignid) {
        this.fileforeignid = fileforeignid;
    }

    @Override
    public String toString() {
        return "MarketFileBean{" +
                "fileid='" + fileid + '\'' +
                ", fileforeignid='" + fileforeignid + '\'' +
                ", url='" + url + '\'' +
                ", authorize='" + authorize + '\'' +
                ", name='" + name + '\'' +
                ", createtime=" + createtime +
                '}';
    }
}
