package com.jetec.CRM.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "work")
public class WorkBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer workid;//
	private String name;//主題
	private String endtime;//到期日
	private String important;//重要性
	private String remake;//備註
	private String user;//負責人
	private String state;//狀態
	private Integer clientid;//客戶
	private Integer contactid;//聯絡人
	private Integer customerid;//潛在顧客	
	private Integer marketid;//銷售機會
	private Date createtime;//創造時間	
	
	//客戶
	@ManyToOne(targetEntity = ClientBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "clientid", referencedColumnName = "clientid", insertable = false, updatable = false)
	private ClientBean client;
	//聯繫人
	@ManyToOne(targetEntity = ContactBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "contactid", referencedColumnName = "contactid", insertable = false, updatable = false)
	private ContactBean contact;
	//潛在顧客
	@ManyToOne(targetEntity = PotentialCustomerBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "customerid", referencedColumnName = "customerid", insertable = false, updatable = false)
	private PotentialCustomerBean customer;
	//潛在顧客
	@ManyToOne(targetEntity = MarketBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "marketid", referencedColumnName = "marketid", insertable = false, updatable = false)
	private MarketBean market;
	
	
	
	
	public PotentialCustomerBean getCustomer() {
		return customer;
	}
	public void setCustomer(PotentialCustomerBean customer) {
		this.customer = customer;
	}
	public MarketBean getMarket() {
		return market;
	}
	public void setMarket(MarketBean market) {
		this.market = market;
	}
	public ContactBean getContact() {
		return contact;
	}
	public void setContact(ContactBean contact) {
		this.contact = contact;
	}
	public ClientBean getClient() {
		return client;
	}
	public void setClient(ClientBean client) {
		this.client = client;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getWorkid() {
		return workid;
	}
	public void setWorkid(Integer workid) {
		this.workid = workid;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getImportant() {
		return important;
	}
	public void setImportant(String important) {
		this.important = important;
	}
	public String getRemake() {
		return remake;
	}
	public void setRemake(String remake) {
		this.remake = remake;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Integer getClientid() {
		return clientid;
	}
	public void setClientid(Integer clientid) {
		this.clientid = clientid;
	}
	public Integer getContactid() {
		return contactid;
	}
	public void setContactid(Integer contactid) {
		this.contactid = contactid;
	}
	public Integer getCustomerid() {
		return customerid;
	}
	public void setCustomerid(Integer customerid) {
		this.customerid = customerid;
	}
	public Integer getMarketid() {
		return marketid;
	}
	public void setMarketid(Integer marketid) {
		this.marketid = marketid;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	@Override
	public String toString() {
		return "WorKBean [workid=" + workid + ", name=" + name + ", endtime=" + endtime + ", important=" + important
				+ ", remake=" + remake + ", user=" + user + ", state=" + state + ", clientid=" + clientid
				+ ", contactid=" + contactid + ", customerid=" + customerid + ", marketid=" + marketid + ", createtime="
				+ createtime + "]";
	}
}
