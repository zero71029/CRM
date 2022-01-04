package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="agreement")
public class AgreementBean {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer agreementid;//

	private String company;//
	private String phone;//
	private String email;	//
	private String fax;//
	private String contactname;//
	private String contactmoblie;//
	private String contactjobtitle;	//
	private String city;//
	private String postal;//
	private String address;//
	private String specialterms;//
	private String agreementdescribe ;//
	private String agreementname;//
	private String agreementjobtitle ;//
	private String agreementtime;//
	private String companyname;//
	private String companyjobtitle;//
	private String companytime;//
	private String user;//
	private String createtime;//
	private String endtime;

	public Integer getAgreementid() {
		return agreementid;
	}
	public void setAgreementid(Integer agreementid) {
		this.agreementid = agreementid;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getContactname() {
		return contactname;
	}
	public void setContactname(String contactname) {
		this.contactname = contactname;
	}
	public String getContactmoblie() {
		return contactmoblie;
	}
	public void setContactmoblie(String contactmoblie) {
		this.contactmoblie = contactmoblie;
	}
	public String getContactjobtitle() {
		return contactjobtitle;
	}
	public void setContactjobtitle(String contactjobtitle) {
		this.contactjobtitle = contactjobtitle;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getPostal() {
		return postal;
	}
	public void setPostal(String postal) {
		this.postal = postal;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getSpecialterms() {
		return specialterms;
	}
	public void setSpecialterms(String specialterms) {
		this.specialterms = specialterms;
	}
	public String getAgreementdescribe() {
		return agreementdescribe;
	}
	public void setAgreementdescribe(String agreementdescribe) {
		this.agreementdescribe = agreementdescribe;
	}
	public String getAgreementname() {
		return agreementname;
	}
	public void setAgreementname(String agreementname) {
		this.agreementname = agreementname;
	}
	public String getAgreementjobtitle() {
		return agreementjobtitle;
	}
	public void setAgreementjobtitle(String agreementjobtitle) {
		this.agreementjobtitle = agreementjobtitle;
	}
	public String getAgreementtime() {
		return agreementtime;
	}
	public void setAgreementtime(String agreementtime) {
		this.agreementtime = agreementtime;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getCompanyjobtitle() {
		return companyjobtitle;
	}
	public void setCompanyjobtitle(String companyjobtitle) {
		this.companyjobtitle = companyjobtitle;
	}
	public String getCompanytime() {
		return companytime;
	}
	public void setCompanytime(String companytime) {
		this.companytime = companytime;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	@Override
	public String toString() {
		return "AgreementBean [agreementid=" + agreementid + ", company=" + company + ", phone=" + phone + ", email="
				+ email + ", fax=" + fax + ", contactname=" + contactname + ", contactmoblie=" + contactmoblie
				+ ", contactjobtitle=" + contactjobtitle + ", city=" + city + ", postal=" + postal + ", address="
				+ address + ", specialterms=" + specialterms + ", agreementdescribe=" + agreementdescribe
				+ ", agreementname=" + agreementname + ", agreementjobtitle=" + agreementjobtitle + ", agreementtime="
				+ agreementtime + ", companyname=" + companyname + ", companyjobtitle=" + companyjobtitle
				+ ", companytime=" + companytime + ", user=" + user + ", createtime=" + createtime + ", endtime="
				+ endtime + "]";
	}


}
