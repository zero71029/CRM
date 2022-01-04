package com.jetec.CRM.model;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "quotationdetail")
public class QuotationDetailBean {
	
	@Id

	private String id ;//
	private Integer quotationid;	
	private String product;	
	private String producttype;	
	private Integer price;	
	private Integer num;	
	private Integer total;
	
	
	
	@ManyToOne(targetEntity = QuotationBean.class,fetch = FetchType.EAGER)
	@JoinColumn(name = "quotationid", referencedColumnName = "quotationid", insertable = false, updatable = false)
	private QuotationBean qb;// 分類
	
	
	
	
	


	public QuotationBean getQb() {
		return qb;
	}
	public void setQb(QuotationBean qb) {
		this.qb = qb;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getQuotationid() {
		return quotationid;
	}
	public void setQuotationid(Integer quotationid) {
		this.quotationid = quotationid;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getProducttype() {
		return producttype;
	}
	public void setProducttype(String producttype) {
		this.producttype = producttype;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "QuotationDetailBean [id=" + id + ", quotationid=" + quotationid + ", product=" + product
				+ ", producttype=" + producttype + ", price=" + price + ", num=" + num + ", total=" + total + "]";
	}
	
	
	

}
