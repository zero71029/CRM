package com.jetec.CRM.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "market")
public class MarketBean {

    @Id
    private String marketid;//
    private String name;//
    private String user;// 業務
    private String createtime;//起始時間
    private String endtime;//結束時間
    private String message;// 描述
    private Integer cost;// 預算
    private String client;// 客戶
    private String contactname;// 聯絡人
    private String contactphone;// 聯絡人電話
    private String contactextension;//聯絡人電話分機
    private String contactmoblie;// 聯絡人手機
    private String contactemail;// 聯絡人email
    private String type;// 產業
    private String source;// 機會來源
    private Integer clinch;// 成交機率
    private String stage;// 階段
    private String need;// 需求確認(沒使用了)
    private String roianalyze;// ROI分析(沒使用了)
    private Date ccc;// 創建時間
    private String product;//產品名稱
    private String producttype;//產品類別
    private String phone;// 公司電話
    private String extension;//電話分機
    private String aaa;// 創建時間 字串
    private String important;//重要性
    private String line;
    private String customerid;//追蹤資訊
    private String contactmethod;//聯絡方式
    private Integer clicks;//點擊數
    private String fax;//傳真
    private Integer clientid;//客戶id
    private String quote;//報價內容
    private String jobtitle;//職稱
    private String serialnumber;//編號
    private String  callbos;//通知主管
    private String callhelp;//求助

    public String getContactmethod() {
        return contactmethod;
    }

    public void setContactmethod(String contactmethod) {
        this.contactmethod = contactmethod;
    }

    // 追蹤資訊
    @OneToMany(targetEntity = TrackBean.class, mappedBy = "customerid", cascade = CascadeType.ALL)
    private List<TrackBean> trackbean;

//	//舊
//	@JsonIgnore
//	@OrderBy("createtime DESC")
//	@OneToMany(mappedBy = "marketid", cascade = CascadeType.ALL)
//	private List<MarketRemarkBean> mrb;

    // 工作項目
//	@JsonIgnore
//	@OneToMany(targetEntity = WorkBean.class, mappedBy = "marketid", cascade = CascadeType.ALL)
//	private List<WorkBean> work;


    public String getCallhelp() {
        return callhelp;
    }

    public void setCallhelp(String callhelp) {
        this.callhelp = callhelp;
    }

    public String getCallbos() {
        return callbos;
    }

    public void setCallbos(String callbos) {
        this.callbos = callbos;
    }

    public String getQuote() {
        return quote;
    }

    public void setQuote(String quote) {
        this.quote = quote;
    }

    public String getJobtitle() {
        return jobtitle;
    }

    public void setJobtitle(String jobtitle) {
        this.jobtitle = jobtitle;
    }

    public String getSerialnumber() {
        return serialnumber;
    }

    public void setSerialnumber(String serialnumber) {
        this.serialnumber = serialnumber;
    }

    public Integer getClientid() {
        return clientid;
    }

    public void setClientid(Integer clientid) {
        this.clientid = clientid;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public Integer getClicks() {
        return clicks;
    }

    public void setClicks(Integer clicks) {
        this.clicks = clicks;
    }

    public String getContactextension() {
        return contactextension;
    }

    public void setContactextension(String contactextension) {
        this.contactextension = contactextension;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public String getName() {
        return name;
    }


    public String getMarketid() {
        return marketid;
    }

    public void setMarketid(String marketid) {
        this.marketid = marketid;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getCost() {
        return cost;
    }

    public void setCost(Integer cost) {
        this.cost = cost;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getContactname() {
        return contactname;
    }

    public void setContactname(String contactname) {
        this.contactname = contactname;
    }

    public String getContactphone() {
        return contactphone;
    }

    public void setContactphone(String contactphone) {
        this.contactphone = contactphone;
    }

    public String getContactmoblie() {
        return contactmoblie;
    }

    public void setContactmoblie(String contactmoblie) {
        this.contactmoblie = contactmoblie;
    }

    public String getContactemail() {
        return contactemail;
    }

    public void setContactemail(String contactemail) {
        this.contactemail = contactemail;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public Integer getClinch() {
        return clinch;
    }

    public void setClinch(Integer clinch) {
        this.clinch = clinch;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public String getNeed() {
        return need;
    }

    public void setNeed(String need) {
        this.need = need;
    }

    public String getRoianalyze() {
        return roianalyze;
    }

    public void setRoianalyze(String roianalyze) {
        this.roianalyze = roianalyze;
    }

    public Date getCcc() {
        return ccc;
    }

    public void setCcc(Date ccc) {
        this.ccc = ccc;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAaa() {
        return aaa;
    }

    public void setAaa(String aaa) {
        this.aaa = aaa;
    }

    public String getImportant() {
        return important;
    }

    public void setImportant(String important) {
        this.important = important;
    }

    public String getLine() {
        return line;
    }

    public void setLine(String line) {
        this.line = line;
    }

    public String getCustomerid() {
        return customerid;
    }

    public void setCustomerid(String customerid) {
        this.customerid = customerid;
    }

    public List<TrackBean> getTrackbean() {
        return trackbean;
    }

    public void setTrackbean(List<TrackBean> trackbean) {
        this.trackbean = trackbean;
    }


    @Override
    public String toString() {
        return "MarketBean{" +
                "marketid='" + marketid + '\'' +
                ", name='" + name + '\'' +
                ", user='" + user + '\'' +
                ", endtime='" + endtime + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}
