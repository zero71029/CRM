package com.jetec.CRM.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

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
	private String customerid;//潛在顧客	
	private Integer marketid;//銷售機會
	private Date createtime;//創造時間	
	private String track;
	
	//客戶
	@JsonIgnore
	@ManyToOne(targetEntity = ClientBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "clientid", referencedColumnName = "clientid", insertable = false, updatable = false)
	private ClientBean client;
	//聯繫人
	@JsonIgnore
	@ManyToOne(targetEntity = ContactBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "contactid", referencedColumnName = "contactid", insertable = false, updatable = false)
	private ContactBean contact;
	//潛在顧客
	@JsonIgnore
	@ManyToOne(targetEntity = PotentialCustomerBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "customerid", referencedColumnName = "customerid", insertable = false, updatable = false)
	private PotentialCustomerBean customer;
	//銷售機會
	@JsonIgnore
	@ManyToOne(targetEntity = MarketBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "marketid", referencedColumnName = "marketid", insertable = false, updatable = false)
	private MarketBean market;
	
	
	
	
	@JsonIgnore
	@OrderBy("tracktime DESC")
	@OneToMany(mappedBy = "customerid", cascade = CascadeType.ALL)
	private List<TrackBean> trackList;
	
	
	
	public String getCustomerid() {
		return customerid;
	}
	public String getTrack() {
		return track;
	}
	public void setTrack(String track) {
		this.track = track;
	}
	public List<TrackBean> getTrackList() {
		return trackList;
	}
	public void setTrackList(List<TrackBean> trackList) {
		this.trackList = trackList;
	}
	public void setCustomerid(String customerid) {
		this.customerid = customerid;
	}
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
		return "WorkBean [track=" + track + ", trackList=" + trackList + "]";
	}
}
