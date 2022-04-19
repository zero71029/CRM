package com.jetec.CRM.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "client")
public class ClientBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer clientid;//
	private String name;//
	private String sort;//類別
	private String url;//網站
	private String email;//網站
	private String industry;//產業
	private String uniformnumber;//統一號碼
	private String phone;//
	private String extension;//電話分機
	private String fax;//
	private String peoplenumber;//員工人數
	private String billcity;//帳單城市
	private String billtown;//帳單地區
	private String billpostal;//帳單郵遞區號
	private String billaddress;//帳單地址
	private String delivercity;//送貨城市
	private String delivertown;//送貨地區
	private String deliverpostal;//送貨郵遞區號
	private String deliveraddress;//送貨地址
	private String remark;//描述
	private String user;//負責人
	private Integer state;//狀態
	private String serialnumber;//編號

	
	//聯繫人
	@JsonIgnore
	@OneToMany(targetEntity = ContactBean.class ,mappedBy = "clientid", cascade = CascadeType.ALL)
	private List<ContactBean> contact;
	//工作項目
	@JsonIgnore
	@OneToMany(targetEntity = WorkBean.class ,mappedBy = "clientid", cascade = CascadeType.ALL)
	private List<WorkBean> work;
	//其他地址
	@JsonIgnore
	@OneToMany(targetEntity = ClientAddressBean.class ,mappedBy = "clientid", cascade = CascadeType.ALL)
	private List<ClientAddressBean> address;
	//標籤
	@JsonIgnore
	@OneToMany(targetEntity = ClientTagBean.class ,mappedBy = "clientid", cascade = CascadeType.ALL)
	@OrderBy("name")
	private List<ClientTagBean> tag;

	public String getSerialnumber() {
		return serialnumber;
	}

	public void setSerialnumber(String serialnumber) {
		this.serialnumber = serialnumber;
	}

	public String getExtension() {
		return extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
	}

	public List<ClientTagBean> getTag() {
		return tag;
	}
	public void setTag(List<ClientTagBean> tag) {
		this.tag = tag;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public List<ClientAddressBean> getAddress() {
		return address;
	}
	public void setAddress(List<ClientAddressBean> address) {
		this.address = address;
	}
	public List<WorkBean> getWork() {
		return work;
	}
	public void setWork(List<WorkBean> work) {
		this.work = work;
	}
	public List<ContactBean> getContact() {
		return contact;
	}
	public void setContact(List<ContactBean> contact) {
		this.contact = contact;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBilltown() {
		return billtown;
	}
	public void setBilltown(String billtown) {
		this.billtown = billtown;
	}
	public String getDelivertown() {
		return delivertown;
	}
	public void setDelivertown(String delivertown) {
		this.delivertown = delivertown;
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
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getUniformnumber() {
		return uniformnumber;
	}
	public void setUniformnumber(String uniformnumber) {
		this.uniformnumber = uniformnumber;
	}
	public String getPhone() {
		StringBuffer sb = new StringBuffer(phone);
		if(sb.length()==10) {
			sb.insert(3, "-");
			sb.insert(7, "-");
		}
		if(sb.length()==9) {
			sb.insert(2, "-");
			sb.insert(6, "-");
		}
		if(sb.length()==8) {
			sb.insert(5, "-");
		}
		if(sb.length()==7) {
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
	public String getFax() {
		StringBuffer sb = new StringBuffer(fax);
		if(sb.length()==10) {
			sb.insert(3, "-");
			sb.insert(7, "-");
		}
		if(sb.length()==9) {
			sb.insert(2, "-");
			sb.insert(6, "-");
		}
		if(sb.length()==8) {
			sb.insert(5, "-");
		}
		if(sb.length()==7) {
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
	public String getPeoplenumber() {
		return peoplenumber;
	}
	public void setPeoplenumber(String peoplenumber) {
		this.peoplenumber = peoplenumber;
	}
	public String getBillcity() {
		return billcity;
	}
	public void setBillcity(String billcity) {
		this.billcity = billcity;
	}
	public String getBillpostal() {
		return billpostal;
	}
	public void setBillpostal(String billpostal) {
		this.billpostal = billpostal;
	}
	public String getBilladdress() {
		return billaddress;
	}
	public void setBilladdress(String billaddress) {
		this.billaddress = billaddress;
	}
	public String getDelivercity() {
		return delivercity;
	}
	public void setDelivercity(String delivercity) {
		this.delivercity = delivercity;
	}
	public String getDeliverpostal() {
		return deliverpostal;
	}
	public void setDeliverpostal(String deliverpostal) {
		this.deliverpostal = deliverpostal;
	}
	public String getDeliveraddress() {
		return deliveraddress;
	}
	public void setDeliveraddress(String deliveraddress) {
		this.deliveraddress = deliveraddress;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "ClientBean{" +
				"clientid=" + clientid +
				", name='" + name + '\'' +
				", sort='" + sort + '\'' +
				'}';
	}
}
