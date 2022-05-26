package com.jetec.CRM.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "potentialcustomer")
public class PotentialCustomerBean implements Serializable {
    @Id
    private String customerid;
    private String name;//名稱
    private String company;//公司
    private String jobtitle;//職稱
    private String email;
    private String phone;
    private String moblie;//手機
    private String fax;
    private String department;//部門
    private String director;//主管
    private String industry;//產業
    private String companynum;//改 聯絡方式
    private String source;//來源
    private String fromactivity;//來自活動
    private String user;//業務
    private String contacttime;//上次聯絡時間
    private String status;
    private String city;
    private String town;
    private String postal;
    private String address;
    private String remark;//備註
    private String important;//重要性
    private String line;
    private String extension;//電話分機
    private String aaa;//創建時間
    private String bbb;//最後回覆時間
    private String opentime;//打開時間
    private String serialnumber;//編號
    private String callhelp;//求助
    private String fileforeignid;//附件id
    private String contacttitle;//聯絡人稱謂
    private String founder;//創始人
    private String othersource;//其他來源
    private String closereason;//結案理由
    private String closeextend;//結案理由延伸
    @Override
    public String toString() {
        return "PotentialCustomerBean{" +
                "marketfilelist=" + marketfilelist +
                '}';
    }

    //附件
    @OneToMany(targetEntity = MarketFileBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "fileforeignid", referencedColumnName = "fileforeignid", insertable = false, updatable = false)
    private List<MarketFileBean> marketfilelist;


    @JsonIgnore
    @OrderBy("tracktime DESC")
    @OneToMany(mappedBy = "customerid", cascade = CascadeType.ALL)
    private List<TrackBean> trackbean;

    @JsonIgnore
    @OneToMany(mappedBy = "customerid", cascade = CascadeType.ALL)
    private List<PotentialCustomerHelperBean> helper;

    //工作項目
    @JsonIgnore
    @OneToMany(targetEntity = WorkBean.class, mappedBy = "customerid", cascade = CascadeType.ALL)
    private List<WorkBean> work;

    //留言
    @OneToMany(targetEntity = BosMessageBean.class, mappedBy = "bosid", cascade = CascadeType.ALL)
    private List<BosMessageBean> bm;


    public String getCloseextend() {
        return closeextend;
    }

    public void setCloseextend(String closeextend) {
        this.closeextend = closeextend;
    }

    public String getBbb() { return bbb; }

    public void setBbb(String bbb) {this.bbb = bbb; }

    public String getOpentime() { return opentime; }

    public void setOpentime(String opentime) {this.opentime = opentime;}

    public String getClosereason() {
        return closereason;
    }

    public void setClosereason(String closereason) {
        this.closereason = closereason;
    }

    public String getOthersource() {
        return othersource;
    }

    public void setOthersource(String othersource) {
        this.othersource = othersource;
    }

    public String getFounder() {
        return founder;
    }

    public void setFounder(String founder) {
        this.founder = founder;
    }

    public String getContacttitle() {
        return contacttitle;
    }

    public void setContacttitle(String contacttitle) {
        this.contacttitle = contacttitle;
    }

    public String getFileforeignid() {
        return fileforeignid;
    }

    public void setFileforeignid(String fileforeignid) {
        this.fileforeignid = fileforeignid;
    }

    public List<MarketFileBean> getMarketfilelist() {
        return marketfilelist;
    }

    public void setMarketfilelist(List<MarketFileBean> marketfilelist) {
        this.marketfilelist = marketfilelist;
    }

    public String getCallhelp() {
        return callhelp;
    }

    public void setCallhelp(String callhelp) {
        this.callhelp = callhelp;
    }

    public String getSerialnumber() {
        return serialnumber;
    }

    public void setSerialnumber(String serialnumber) {
        this.serialnumber = serialnumber;
    }

    public List<BosMessageBean> getBm() {
        return bm;
    }

    public void setBm(List<BosMessageBean> bm) {
        this.bm = bm;
    }

    public String getAaa() {
        return aaa;
    }

    public void setAaa(String aaa) {
        this.aaa = aaa;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public String getCustomerid() {
        return customerid;
    }

    public void setCustomerid(String customerid) {
        this.customerid = customerid;
    }

    public String getLine() {
        return line;
    }

    public void setLine(String line) {
        this.line = line;
    }

    public String getImportant() {
        return important;
    }

    public void setImportant(String important) {
        this.important = important;
    }

    public List<PotentialCustomerHelperBean> getHelper() {
        return helper;
    }

    public void setHelper(List<PotentialCustomerHelperBean> helper) {
        this.helper = helper;
    }


    public List<WorkBean> getWork() {
        return work;
    }

    public void setWork(List<WorkBean> work) {
        this.work = work;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }

    public String getPostal() {
        return postal;
    }

    public void setPostal(String postal) {
        this.postal = postal;
    }

    public List<TrackBean> getTrackbean() {
        return trackbean;
    }

    public void setTrackbean(List<TrackBean> trackbean) {
        this.trackbean = trackbean;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getJobtitle() {
        return jobtitle;
    }

    public void setJobtitle(String jobtitle) {
        this.jobtitle = jobtitle;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        StringBuffer sb = new StringBuffer(phone);
        if (sb.length() == 10) {
            sb.insert(2, "-");
            sb.insert(7, "-");
        }
        if (sb.length() == 9) {
            sb.insert(2, "-");
            sb.insert(6, "-");
        }
        if (sb.length() == 8) {
            sb.insert(5, "-");
        }
        if (sb.length() == 7) {
            sb.insert(4, "-");
        }
        return sb.toString();
    }

    public void setPhone(String phone) {
        phone = phone.replace("-", "");
        phone = phone.replace("(", "");
        phone = phone.replace(")", "");
        this.phone = phone;
    }

    public String getMoblie() {
        StringBuffer sb = new StringBuffer(moblie);
        if (sb.length() > 9) {
            sb.insert(4, "-");
            sb.insert(8, "-");
        }
        return sb.toString();
    }

    public void setMoblie(String moblie) {
        moblie = moblie.replace("-", "");
        this.moblie = moblie;
    }

    public String getFax() {
        StringBuffer sb = new StringBuffer(fax);
        if (sb.length() == 10) {
            sb.insert(2, "-");
            sb.insert(7, "-");
        }
        if (sb.length() == 9) {
            sb.insert(2, "-");
            sb.insert(6, "-");
        }
        if (sb.length() == 8) {
            sb.insert(5, "-");
        }
        if (sb.length() == 7) {
            sb.insert(4, "-");
        }
        return sb.toString();
    }

    public void setFax(String fax) {
        fax = fax.replace("-", "");
        fax = fax.replace("(", "");
        fax = fax.replace(")", "");
        this.fax = fax;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getCompanynum() {
        return companynum;
    }

    public void setCompanynum(String companynum) {
        this.companynum = companynum;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getFromactivity() {
        return fromactivity;
    }

    public void setFromactivity(String fromactivity) {
        this.fromactivity = fromactivity;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getContacttime() {
        return contacttime;
    }

    public void setContacttime(String contacttime) {
        this.contacttime = contacttime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }


}
