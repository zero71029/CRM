package com.jetec.CRM.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "market")
public class MarketBean implements Serializable {


    @Id
    private String marketid;//
    private String name;//
    private String user;// 業務
    private String createtime;//起始時間
    private String endtime;//結束時間
    private String message;// 描述
    private Integer cost;// 預算
    private Integer clientid;//客戶id
    private String client;// 客戶
    private Integer contactid;// 聯絡人id
    private String contactname;// 聯絡人
    private String contactphone;// 聯絡人電話
    private String contactextension;//聯絡人電話分機
    private String contactmoblie;// 聯絡人手機
    private String contactemail;// 聯絡人email
    private String contactmethod;//聯絡方式
    private String contacttitle;//聯絡人稱謂
    private String type;// 產業
    private String source;// 機會來源
    private Integer clinch;// 成交機率
    private String stage;// 階段
    private String need;// 需求確認(沒使用了)
    private String roianalyze;// ROI分析(沒使用了)
    private String product;//產品名稱
    private String producttype;//產品類別
    private String phone;// 公司電話
    private String extension;//電話分機
    private String aaa;// 創建時間 字串
    private String bbb;//最後修改時間
    private String opentime;//打開時間
    private String important;//重要性
    private String line;
    private String customerid;//追蹤資訊
    private Integer clicks;//點擊數
    private String fax;//傳真
    private String quote;//報價內容
    private String jobtitle;//職稱
    private String serialnumber;//編號
    private String callbos;//通知主管
    private String callhelp;//求助
    private String fileforeignid;//附件id
    private String founder;//創始人
    private String othersource;//其他來源
    private String closereason;//結案理由
    private String closeextend;//結案理由延伸
    private String receive;//領取人
    @Column(columnDefinition = "TINYINT(1)")
    private Integer receivestate;//領取狀態


    public String getContactmethod() {
        return contactmethod;
    }

    public void setContactmethod(String contactmethod) {
        this.contactmethod = contactmethod;
    }

    // 追蹤資訊
    @OrderBy("tracktime desc")
    @OneToMany(targetEntity = TrackBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "customerid", referencedColumnName = "customerid", insertable = false, updatable = false)
    private List<TrackBean> trackbean;

    //附件
    @OneToMany(targetEntity = MarketFileBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "fileforeignid", referencedColumnName = "fileforeignid", insertable = false, updatable = false)
    private List<MarketFileBean> marketfilelist;

    //留言
//    @OneToMany(targetEntity = BosMessageBean.class, mappedBy = "bosid", cascade = CascadeType.ALL)
    @OneToMany(targetEntity = BosMessageBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "bosid", referencedColumnName = "customerid", insertable = false, updatable = false)
    private List<BosMessageBean> bm;




//	//舊
//	@JsonIgnore
//	@OrderBy("createtime DESC")
//	@OneToMany(mappedBy = "marketid", cascade = CascadeType.ALL)
//	private List<MarketRemarkBean> mrb;

    // 工作項目
//	@JsonIgnore
//	@OneToMany(targetEntity = WorkBean.class, mappedBy = "marketid", cascade = CascadeType.ALL)
//	private List<WorkBean> work;




    public Integer getContactid() {
        return contactid;
    }

    public void setContactid(Integer contactid) {
        this.contactid = contactid;
    }

    public String getOpentime() {
        return opentime;
    }

    public void setOpentime(String opentime) {
        this.opentime = opentime;
    }

    public String getBbb() {
        return bbb;
    }

    public void setBbb(String bbb) {
        this.bbb = bbb;
    }

    public String getCloseextend() {
        return closeextend;
    }

    public void setCloseextend(String closeextend) {
        this.closeextend = closeextend;
    }

    public String getClosereason() {
        return closereason;
    }

    public void setClosereason(String closereason) {
        this.closereason = closereason;
    }

    public List<BosMessageBean> getBm() {
        return bm;
    }

    public void setBm(List<BosMessageBean> bm) {
        this.bm = bm;
    }

    public String getContacttitle() {
        return contacttitle;
    }

    public String getFounder() {
        return founder;
    }

    public void setFounder(String founder) {
        this.founder = founder;
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
        if (fax != null) {
            fax = fax.replace("-", "");
            fax = fax.replace("(", "");
            fax = fax.replace(")", "");
        }

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
        if (contactphone != null) {
            contactphone = contactphone.replace("-", "");
            contactphone = contactphone.replace("(", "");
            contactphone = contactphone.replace(")", "");
        }

        this.contactphone = contactphone;
    }

    public String getContactmoblie() {

        StringBuffer sb = new StringBuffer(contactmoblie);
        if(sb.length()==10) {
            sb.insert(4, "-");
            sb.insert(8, "-");
        }

        return sb.toString();
    }

    public void setContactmoblie(String contactmoblie) {
        if (contactmoblie != null) {
            contactmoblie = contactmoblie.replace("-", "");
            contactmoblie = contactmoblie.replace("(", "");
            contactmoblie = contactmoblie.replace(")", "");
        }


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
        phone = phone.replace("-", "");
        phone = phone.replace("(", "");
        phone = phone.replace(")", "");
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

    public String getOthersource() {
        return othersource;
    }

    public void setOthersource(String othersource) {
        this.othersource = othersource;
    }

    public String getReceive() {
        return receive;
    }

    public void setReceive(String receive) {
        this.receive = receive;
    }

    public Integer getReceivestate() {
        return receivestate;
    }

    public void setReceivestate(Integer receivestate) {
        this.receivestate = receivestate;
    }

    @Override
    public String toString() {
        return "MarketBean{" +
                "marketid='" + marketid + '\'' +
                ", name='" + name + '\'' +
                ", user='" + user + '\'' +
                ", createtime='" + createtime + '\'' +
                ", endtime='" + endtime + '\'' +
                ", message='" + message + '\'' +
                ", cost=" + cost +
                ", client='" + client + '\'' +
                ", contactname='" + contactname + '\'' +
                ", contactphone='" + contactphone + '\'' +
                ", contactextension='" + contactextension + '\'' +
                ", contactmoblie='" + contactmoblie + '\'' +
                ", contactemail='" + contactemail + '\'' +
                ", contactmethod='" + contactmethod + '\'' +
                ", contacttitle='" + contacttitle + '\'' +
                ", type='" + type + '\'' +
                ", source='" + source + '\'' +
                ", clinch=" + clinch +
                ", stage='" + stage + '\'' +
                ", need='" + need + '\'' +
                ", roianalyze='" + roianalyze + '\'' +
                ", product='" + product + '\'' +
                ", producttype='" + producttype + '\'' +
                ", phone='" + phone + '\'' +
                ", extension='" + extension + '\'' +
                ", aaa='" + aaa + '\'' +
                ", bbb='" + bbb + '\'' +
                ", opentime='" + opentime + '\'' +
                ", important='" + important + '\'' +
                ", line='" + line + '\'' +
                ", customerid='" + customerid + '\'' +
                ", clicks=" + clicks +
                ", fax='" + fax + '\'' +
                ", clientid=" + clientid +
                ", quote='" + quote + '\'' +
                ", jobtitle='" + jobtitle + '\'' +
                ", serialnumber='" + serialnumber + '\'' +
                ", callbos='" + callbos + '\'' +
                ", callhelp='" + callhelp + '\'' +
                ", fileforeignid='" + fileforeignid + '\'' +
                ", founder='" + founder + '\'' +
                ", othersource='" + othersource + '\'' +
                ", closereason='" + closereason + '\'' +
                ", closeextend='" + closeextend + '\'' +
                ", receive='" + receive + '\'' +
                ", receivestate=" + receivestate +
                '}';
    }

    public Object get(String name) {
        switch (name) {
            case "name":
                return this.name;
            case "user":
                return user;
            case "serialnumber":
                return serialnumber;
            case "endtime":
                return endtime;
            case "message":
                return message;
            case "client":
                return client;
            case "contactname":
                return contactname;
            case "contactphone":
                return contactphone;
            case "contactextension":
                return contactextension;
            case "contactmoblie":
                return contactmoblie;
            case "contactemail":
                return contactemail;
            case "contactmethod":
                return contactmethod;
            case "contacttitle":
                return contacttitle;
            case "type":
                return type;
            case "source":
                return source;
            case "clinch":
                return clinch;
            case "stage":
                return stage;
            case "product":
                return product;
            case "producttype":
                return producttype;
            case "phone":
                return phone;
            case "extension":
                return extension;
            case "aaa":
                return aaa;
            case "important":
                return important;
            case "line":
                return line;
            case "customerid":
                return customerid;
            case "clicks":
                return clicks;
            case "fax":
                return fax;
            case "clientid":
                return clientid;
            case "quote":
                return quote;
            case "jobtitle":
                return jobtitle;
            case "callbos":
                return callbos;
            case "callhelp":
                return callhelp;
            case "fileforeignid":
                return fileforeignid;
            case "founder":
                return founder;
            case "othersource":
                return othersource;
            case "closereason":
                return closereason;
            case "receive":
                return receive;
            default:
                return "輸入錯誤";
        }

    }
}
