package com.jetec.CRM.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
	private String workid;//
	private String name;//主題
	private String endtime;//到期日
	private String important;//重要性
	private String remake;//備註
	private String user;//負責人
	private String state;//狀態
	private Integer clientid;//客戶
	private Integer contactid;//聯絡人
	private String customerid;//潛在顧客	
	private String marketid;//銷售機會

	private String track;
	private String marketname;
	private String customername;
	private String aaa;//創造時間
	//客戶
	@JsonIgnore
	@ManyToOne(targetEntity = ClientBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "clientid", referencedColumnName = "clientid", insertable = false, updatable = false)
	private ClientBean client;
//	聯繫人
	@JsonIgnore
	@ManyToOne(targetEntity = ContactBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "contactid", referencedColumnName = "contactid", insertable = false, updatable = false)
	private ContactBean contact;


	@Override
	public String toString() {
		return "WorkBean{" +
				"workid='" + workid + '\'' +
				", name='" + name + '\'' +
				", endtime='" + endtime + '\'' +
				", important='" + important + '\'' +
				", remake='" + remake + '\'' +
				", user='" + user + '\'' +
				", state='" + state + '\'' +
				", clientid=" + clientid +
				", contactid=" + contactid +
				", customerid='" + customerid + '\'' +
				", marketid='" + marketid + '\'' +

				", track='" + track + '\'' +
				", marketname='" + marketname + '\'' +
				", customername='" + customername + '\'' +
				", client=" + client +
				", contact=" + contact +
				", trackList=" + trackList +
				'}';
	}

	@JsonIgnore
	@OrderBy("tracktime DESC")
	@OneToMany(mappedBy = "customerid", cascade = CascadeType.ALL)
	private List<TrackBean> trackList;


	public String getAaa() {
		return aaa;
	}

	public void setAaa(String aaa) {
		this.aaa = aaa;
	}

	public String getMarketname() {
		return marketname;
	}
	public void setMarketname(String marketname) {
		this.marketname = marketname;
	}
	public String getCustomername() {
		return customername;
	}
	public void setCustomername(String customername) {
		this.customername = customername;
	}
	public ClientBean getClient() {
		return client;
	}
	public void setClient(ClientBean client) {
		this.client = client;
	}
	public ContactBean getContact() {
		return contact;
	}
	public void setContact(ContactBean contact) {
		this.contact = contact;
	}

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


	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getWorkid() {
		return workid;
	}
	public void setWorkid(String workid) {
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


	public String getMarketid() {
		return marketid;
	}
	public void setMarketid(String marketid) {
		this.marketid = marketid;
	}


}
