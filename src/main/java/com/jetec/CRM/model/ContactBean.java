package com.jetec.CRM.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "contact")
public class ContactBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer contactid;
    private Integer clientid;
    private String name;//聯絡人名稱
    private String company;//公司
    private String jobtitle;//職務
    private String email;//
    private String phone;//
    private String extension;//電話分機
    private String moblie;//手機
    private String city;
    private String town;
    private String postal;
    private String address;//
    private String department;//部門
    private String director;//直屬主管
    private String fax;//
    private String remark;//備註
    private String user;//負責人
    private String contacttime;//上次聯絡時間
    private String line;//


    @ManyToOne(targetEntity = ClientBean.class)
    @JoinColumn(name = "clientid", referencedColumnName = "clientid", insertable = false, updatable = false)
    private ClientBean client;

    //工作項目
    @JsonIgnore
    @OneToMany(targetEntity = WorkBean.class, mappedBy = "contactid", cascade = CascadeType.ALL)
    private List<WorkBean> work;


    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public String getLine() {
        return line;
    }

    public void setLine(String line) {
        this.line = line;
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

    public ClientBean getClient() {
        return client;
    }

    public void setClient(ClientBean client) {
        this.client = client;
    }

    public Integer getContactid() {
        return contactid;
    }

    public void setContactid(Integer contactid) {
        this.contactid = contactid;
    }

    public Integer getClientid() {
        return clientid;
    }

    public void setClientid(Integer clientid) {
        this.clientid = clientid;
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
            sb.insert(3, "-");
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
        try {
            StringBuffer sb = new StringBuffer(moblie);
            if (sb.length() > 9) {
                sb.insert(4, "-");
                sb.insert(8, "-");
            }
            return sb.toString();
        } catch (Exception e) {
            // TODO: handle exception
        }

        return moblie;

    }

    public void setMoblie(String moblie) {
        moblie = moblie.replace("-", "");
        this.moblie = moblie;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    @Override
    public String toString() {
        return "ContactBean{" +
                "contactid=" + contactid +
                ", clientid=" + clientid +
                ", name='" + name + '\'' +
                ", company='" + company + '\'' +
                ", jobtitle='" + jobtitle + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", extension='" + extension + '\'' +
                ", moblie='" + moblie + '\'' +
                ", city='" + city + '\'' +
                ", town='" + town + '\'' +
                ", postal='" + postal + '\'' +
                ", address='" + address + '\'' +
                ", department='" + department + '\'' +
                ", director='" + director + '\'' +
                ", fax='" + fax + '\'' +
                ", remark='" + remark + '\'' +
                ", user='" + user + '\'' +
                ", contacttime='" + contacttime + '\'' +
                ", line='" + line + '\'' +
                ", client=" + client +
                ", work=" + work +
                '}';
    }
}
