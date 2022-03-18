package com.jetec.CRM.controler.service;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class MarketService {
    @Autowired
    MarketRepository mr;
    @Autowired
    MarketRemarkRepository mrr;
    @Autowired
    TrackRepository tr;
    @Autowired
    QuotationRepository qr;
    @Autowired
    AgreementRepository ar;
    @Autowired
    ZeroTools zTools;
    @Autowired
    UpfileService US;

    public MarketBean save(MarketBean marketBean) {
        String uuid = zTools.getUUID();
        if (marketBean.getFileforeignid() == null || marketBean.getFileforeignid().isEmpty() || marketBean.getFileforeignid().equals("")) {
            marketBean.setFileforeignid(uuid);
        }
        if (marketBean.getMarketid() == null || marketBean.getMarketid().isEmpty()) {//如果是新案件
            marketBean.setMarketid(uuid);
            //更換Fileforeignid
            if (US.existsByFileforeignid(marketBean.getFileforeignid()) && marketBean.getFileforeignid().length() != 32) {
                List<MarketFileBean> list = US.getByfileForeignid(marketBean.getFileforeignid());
                for (MarketFileBean fileBean : list) {
                    fileBean.setFileforeignid(uuid);
                    fileBean.setAuthorize(uuid);
                    US.save(fileBean);
                }
                marketBean.setFileforeignid(uuid);
            }
        }
        //插入日期
        if (marketBean.getAaa() == "") {
            marketBean.setAaa(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        }
        return mr.save(marketBean);
    }

    /////////////////////////////////////////////////////////////////////////////////////
    // 銷售機會列表
    public List<MarketBean> getList(Integer pag) {
        Pageable p = PageRequest.of(pag, 20, Direction.DESC, "aaa");
        Page<MarketBean> page = mr.findStage(p);
        List<MarketBean> result = new ArrayList<>();
        if (pag == 0)
            result.addAll(mr.findByCallhelpAndStageNotAndStageNot("1", "失敗結案", "成功結案"));
        result.addAll(page.getContent());
        Sort sort = Sort.by(Direction.DESC, "tracktime");
        for (MarketBean bean : result) {
            List<TrackBean> list = tr.findByCustomerid(bean.getCustomerid(), sort);
            bean.setTrackbean(list);
        }
        return result;
    }

    //所有筆數
    public Integer getTotal() {
        return mr.getTotal();
    }

    /////////////////////////////////////////////////////////////////////////////////////
    // 銷售機會列表(結案)
    public List<MarketBean> CloseMarket() {
        Sort sort = Sort.by(Direction.DESC, "marketid");
        List<MarketBean> result = mr.findByStage("成功結案", sort);
        result.addAll(mr.findByStage("失敗結案", sort));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////
    public MarketBean getById(String id) {
        return mr.getById(id);
    }

    /////////////////////////////////////////////////////////////////////////////////////
    public void SaveRemark(MarketRemarkBean mrb) {
        mrr.save(mrb);
    }

    /////////////////////////////////////////////////////////////////////////////////////
    // 刪除銷售機會
    public void delMarket(List<String> id) {
        for (String i : id) {
            mrr.deleteByMarketid(i);
            mr.deleteById(i);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會
    public List<MarketBean> selectMarket(String name) {
        name = name.trim();
        List<MarketBean> result = new ArrayList<MarketBean>();
        boolean boo = true;
        Sort sort = Sort.by(Direction.DESC, "aaa");
        // 搜索名稱
        for (MarketBean p : mr.findByNameLikeIgnoreCase("%" + name + "%", sort)) {
            result.add(p);
        }

        // 用業務搜索
        for (MarketBean p : mr.findByUserLikeIgnoreCase("%" + name + "%", sort)) {
            for (MarketBean bean : result) {
                if (bean.getMarketid() == p.getMarketid()) {
                    boo = false;
                }
            }
            if (boo)
                result.add(p);
        }
        // 用客戶搜索
        for (MarketBean p : mr.findByClientLikeIgnoreCase("%" + name + "%", sort)) {
            for (MarketBean bean : result) {
                if (bean.getMarketid() == p.getMarketid()) {
                    boo = false;
                }
            }
            if (boo)
                result.add(p);
        }
        // 用聯絡人搜索
        for (MarketBean p : mr.findByContactnameLikeIgnoreCase("%" + name + "%", sort)) {
            for (MarketBean bean : result) {
                if (bean.getMarketid() == p.getMarketid()) {
                    boo = false;
                }
            }
            if (boo)
                result.add(p);
        }
        for (MarketBean bean : result) {
            bean.setTrackbean(tr.findByCustomeridOrderByTracktimeDesc(bean.getCustomerid()));
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////
//刪除備註
    public void delRemark(Integer remarkId) {
        mrr.deleteById(remarkId);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存追蹤
    public TrackBean SaveTrack(TrackBean trackBean) {
        return tr.save(trackBean);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存報價單
    public QuotationBean SaveQuotation(QuotationBean qBean) {
        System.out.println(qBean.getQdb());
        for (QuotationDetailBean qdb : qBean.getQdb()) {
            if (qdb.getId() == null || qdb.getId().length() == 0) {
                qdb.setId(zTools.getUUID());
                qdb.setQuotationid(qBean.getQuotationid());
            }
        }
        QuotationBean save = qr.save(qBean);
        qr.delNull();
        return save;

//		qr.alterINCREMENT();

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取報價單細節
    public QuotationBean getQuotationById(Integer id) {
        return qr.getById(id);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//報價單列表
    public List<QuotationBean> getQuotationList() {
        Sort sort = Sort.by(Direction.DESC, "quotationid");
        return qr.findAll(sort);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存合約	
    public void SaveAgreement(AgreementBean aBean) {
        ar.save(aBean);

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取合約細節
    public AgreementBean getAgreementBeanById(Integer id) {
        return ar.getById(id);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 搜索銷售機會by日期
    public List<MarketBean> selectDate(String startTime, String endTime) {
//        List<MarketBean> result = mr.findAaa(startTime, endTime);
//        for (MarketBean bean : result) {
//            bean.setTrackbean(tr.findByCustomerid(bean.getCustomerid()));
//        }
        return mr.findAaa(startTime, endTime);

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by狀態
    public List<MarketBean> selectStage(String name) {
        Sort sort = Sort.by(Direction.DESC, "marketid");
        return mr.findByStage(name, sort);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會列表
    public List<MarketBean> selectContantPhone(String phone) {
        List<MarketBean> result = mr.findByContactphone(phone);
        Boolean isBoolean = true;
        for (MarketBean bean : mr.findByContactmoblie(phone)) {
            for (MarketBean phonebeBean : result) {
                if (bean.getMarketid() == phonebeBean.getMarketid()) {
                    isBoolean = false;
                }
            }
            if (isBoolean)
                result.add(bean);
            isBoolean = true;
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by產品類別
    public List<MarketBean> selectProductType(List<String> data) {
        List<MarketBean> result = new ArrayList<MarketBean>();
        for (String typeString : data) {
            result.addAll(mr.findProducttype(typeString));
            result.addAll(mr.findSource(typeString));
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by產業
    public List<MarketBean> selectIndustry(List<String> data) {
        List<MarketBean> result = new ArrayList<MarketBean>();
        for (String typeString : data) {
            result.addAll(mr.selectType(typeString));
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by產品類別
    public List<MarketBean> selectClinch(String clinch) {
        // TODO Auto-generated method stub
        return mr.selectClinch(clinch);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by預算
    public List<MarketBean> selectBudget(String start, String to) {
        // TODO Auto-generated method stub
        return mr.selectBudget(start, to);
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//今天總計
    public Integer gettodayTotal() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String ddd = sdf.format(new Date());
        return mr.gettodayTotal(ddd + " 00:00", ddd + " 23:59");
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取過期任務
    public List<MarketBean> getEndCast(String name) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        return mr.getEndCast(name, sdf.format(new Date()));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取提交主管
    public List<MarketBean> getSubmitBos() {
        return mr.getSubmitBos();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //檢查有無銷售機會
    public boolean existMarket(String customerid) {
        return mr.existsByCustomerid(customerid);

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索銷售機會by負責人
    public List<MarketBean> selectMarketByUser(String name) {
        return mr.findUser(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索銷售機會by延長申請
    public List<MarketBean> CallBos() {
        return mr.findByCallbos("1");
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索銷售機會
    public List<MarketBean> selectMarketByAll(String startDay, String endDay, String key, List<String> val) {
        Sort sort = Sort.by(Direction.DESC, "aaa");
        System.out.println(key);
        System.out.println(val);
        List<MarketBean> result = new ArrayList<>();
        switch (key) {
            case "tractime":
                System.out.println(val);
                String start = val.get(0) + " 00:00";
                String end = val.get(1) + " 23:59";
                //@Query(value = "SELECT  DISTINCT(customerid) FROM track  WHERE tracktime BETWEEN ?1 AND ?2", nativeQuery = true)
                List<String> customeridList = tr.setectTrackTime(start, end);
                for (String customerid : customeridList) {
                    MarketBean marketBean = mr.findByCustomerid(customerid);
                    if (marketBean != null) {
                        marketBean.setTrackbean(tr.findByCustomeridOrderByTracktimeDesc(customerid));
                        result.add(marketBean);
                    }

                }
//                result = result.stream().sorted(Comparator.comparing(MarketBean::getAaa).reversed()).collect(Collectors.toList());
                for (int i =0 ;i<result.size();i++){
                    for (int x =i+1 ;x<result.size();x++){
                        if(result.get(i).getTrackbean().get(0).getTracktime().compareTo(result.get(x).getTrackbean().get(0).getTracktime()) < 0 ){
                                MarketBean w = result.get(i);
                                result.set(i,result.get(x)) ;
                                result.set(x,w);
                            }
                    }
                }

                break;
            case "UserList":
                for (String user : val)
                    result.addAll(mr.findByUserAndAaaBetween(user, startDay, endDay, sort));
                break;
            case "name":
                result.addAll(mr.findByNameLikeIgnoreCaseOrClientLikeIgnoreCaseAndAaaBetween("%" + val.get(0) + "%", "%" + val.get(0) + "%", startDay, endDay, sort));
                break;
            case "ContantPhone":
                result.addAll(mr.findByContactphoneLikeIgnoreCaseAndAaaBetween("%" + val.get(0) + "%", startDay, endDay, sort));
                break;
            case "inStateList":
                for (String state : val)
                    result.addAll(mr.findByStageAndAaaBetween(state, startDay, endDay, sort));
                break;
            case "inContact":
                result.addAll(mr.findByContactnameLikeIgnoreCaseAndAaaBetween("%" + val.get(0) + "%", startDay, endDay, sort));
                break;
            case "source":
                for (String type : val)
                    result.addAll(mr.findByTypeAndAaaBetween(type, startDay, endDay, sort));
                break;
            case "checkedSources"://機會來源
                for (String source : val)
                    result.addAll(mr.findBySourceAndAaaBetween(source, startDay, endDay, sort));
                break;
            case "clinch"://成交機率
                result.addAll(mr.findByClinchAndAaaBetween(Integer.parseInt(val.get(0)), startDay, endDay, sort));
                break;
            case "checkedCities"://產品類別
                for (String producttype : val)
                    result.addAll(mr.findByProducttypeAndAaaBetween(producttype, startDay, endDay, sort));
                break;
            case "product":
                result.addAll(mr.findByProductLikeIgnoreCaseOrNameLikeIgnoreCaseOrMessageLikeIgnoreCaseAndAaaBetween("%" + val.get(0) + "%", "%" + val.get(0) + "%", "%" + val.get(0) + "%", startDay, endDay, sort));
                break;
        }

        return result;
    }
}
