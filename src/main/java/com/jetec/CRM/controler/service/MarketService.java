package com.jetec.CRM.controler.service;

import com.github.benmanes.caffeine.cache.Cache;
import com.jetec.CRM.Tool.ZeroCode;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class MarketService {
    @Autowired
    MarketRepository mr;
    @Autowired
    TrackRepository tr;
    @Autowired
    QuotationRepository qr;
    @Autowired
    AgreementRepository ar;
    @Autowired
    UpfileService US;
    @Autowired
    MarketStateRepository msr;

    Logger logger = LoggerFactory.getLogger("MarketService");
    @Autowired
    Cache<String, Object> caffeineCache;

    public MarketBean save(MarketBean marketBean) {
        String uuid = ZeroTools.getUUID();

        //如果沒有customerid
        if (marketBean.getCustomerid() == null || marketBean.getCustomerid().isEmpty() || marketBean.getCustomerid().equals("")) {
            marketBean.setCustomerid(uuid);
        }
        //如果沒有Fileforeignid
        if (marketBean.getFileforeignid() == null || marketBean.getFileforeignid().isEmpty() || marketBean.getFileforeignid().equals("")) {
            marketBean.setFileforeignid(uuid);
        }
        //如果是新案件
        if (marketBean.getMarketid() == null || marketBean.getMarketid().isEmpty()) {
            //如果新案件  資料庫內有Fileforeignid
            if (mr.existsByFileforeignid(marketBean.getFileforeignid())) return null;
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
        } else {
            caffeineCache.asMap().remove(ZeroCode.Redis_Market_Id + marketBean.getMarketid());
            logger.info("刪除緩存 ");
        }
        //插入日期
        if (marketBean.getAaa().equals("")) {
            marketBean.setAaa(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        }
        marketBean.setBbb(LocalDateTime.now().toString());


        return mr.save(marketBean);
    }

    /////////////////////////////////////////////////////////////////////////////////////
    // 銷售機會列表
    public List<MarketBean> getList(Integer pag, Integer size) {
        Pageable p = PageRequest.of(pag, size, Direction.DESC, "aaa");
//        Page<MarketBean> page = mr.findStage(p);
        Page<MarketBean> page = mr.findByStageNotAndStageNot("失敗結案", "成功結案", p);
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
        MarketBean cache = (MarketBean) caffeineCache.getIfPresent(ZeroCode.Redis_Market_Id + id);
        //如果沒有緩存
        if (cache == null) {
            MarketBean marketBean = mr.findById(id).orElse(null);
            try {
                caffeineCache.put(ZeroCode.Redis_Market_Id + id, marketBean);
                logger.info("添加caffeine緩存 {}" , ZeroCode.Redis_Market_Id + id);
            } catch (Exception e) {
                logger.info("添加caffeine緩存失敗 {}",ZeroCode.Redis_Market_Id + id);
            }
            return marketBean;
        }
        logger.info("使用caffeine緩存 {}" , ZeroCode.Redis_Market_Id + id);
        return cache;
    }


    /////////////////////////////////////////////////////////////////////////////////////
    // 刪除銷售機會
    public void delMarket(List<String> id) {
        for (String i : id) {
            mr.deleteById(i);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會
    public List<MarketBean> selectMarket(String name) {
        name = name.trim();
        boolean boo = true;
        Sort sort = Sort.by(Direction.DESC, "aaa");
        // 搜索名稱
        List<MarketBean> result = new ArrayList<>(mr.findByNameLikeIgnoreCase("%" + name + "%", sort));

        // 用業務搜索
        for (MarketBean p : mr.findByUserLikeIgnoreCase("%" + name + "%", sort)) {
            for (MarketBean bean : result) {
                if (bean.getMarketid().equals(p.getMarketid())) {
                    boo = false;
                    break;
                }
            }
            if (boo)
                result.add(p);
        }
        // 用客戶搜索
        for (MarketBean p : mr.findByClientLikeIgnoreCase("%" + name + "%", sort)) {
            for (MarketBean bean : result) {
                if (bean.getMarketid().equals(p.getMarketid())) {
                    boo = false;
                    break;
                }
            }
            if (boo)
                result.add(p);
        }
        // 用聯絡人搜索
        for (MarketBean p : mr.findByContactnameLikeIgnoreCase("%" + name + "%", sort)) {
            for (MarketBean bean : result) {
                if (bean.getMarketid().equals(p.getMarketid())) {
                    boo = false;
                    break;
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
                qdb.setId(ZeroTools.getUUID());
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
        return qr.findById(id).orElse(null);
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
        return ar.findById(id).orElse(null);
    }

    /**
     * 搜索銷售機會by日期
     *
     * @param startTime 开始时间
     * @param endTime   结束时间
     * @return {@link List}<{@link MarketBean}>
     */
    public List<MarketBean> selectDate(String startTime, String endTime) {
//        List<MarketBean> result = mr.findAaa(startTime, endTime);
//        for (MarketBean bean : result) {
//            bean.setTrackbean(tr.findByCustomerid(bean.getCustomerid()));
//        }
        return mr.findAaa(startTime, endTime);

    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會列表
    public List<MarketBean> selectContantPhone(String phone) {
        List<MarketBean> result = mr.findByContactphone(phone);
        boolean isBoolean = true;
        for (MarketBean bean : mr.findByContactmoblie(phone)) {
            for (MarketBean phonebeBean : result) {
                if (bean.getMarketid().equals(phonebeBean.getMarketid())) {
                    isBoolean = false;
                    break;
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
        List<MarketBean> result = new ArrayList<>();
        for (String typeString : data) {
            result.addAll(mr.findProducttype(typeString));
            result.addAll(mr.findSource(typeString));
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by產業
    public List<MarketBean> selectIndustry(List<String> data) {
        List<MarketBean> result = new ArrayList<>();
        for (String typeString : data) {
            result.addAll(mr.selectType(typeString));
        }
        return result;
    }

    //搜索銷售機會by產品類別
    public List<MarketBean> selectClinch(String clinch) {
        return mr.selectClinch(clinch);
    }

    //搜索銷售機會by預算
    public List<MarketBean> selectBudget(String start, String to) {
        return mr.selectBudget(start, to);
    }

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
                for (int i = 0; i < result.size(); i++) {
                    for (int x = i + 1; x < result.size(); x++) {
                        if (result.get(i).getTrackbean().get(0).getTracktime().compareTo(result.get(x).getTrackbean().get(0).getTracktime()) < 0) {
                            MarketBean w = result.get(i);
                            result.set(i, result.get(x));
                            result.set(x, w);
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
                String phone = val.get(0).replaceAll("-", "");
                System.out.println(phone);
                result.addAll(mr.findByContactphoneLikeAndAaaBetween("%" + phone + "%", startDay, endDay, sort));
                result.addAll(mr.findByContactmoblieLikeAndAaaBetween("%" + phone + "%", startDay, endDay, sort));
                result.addAll(mr.findByFaxLikeAndAaaBetween("%" + phone + "%", startDay, endDay, sort));

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
                for (String producttype : val) {
                    result.addAll(mr.findByProducttypeAndAaaBetween(producttype, startDay, endDay, sort));
                }
                break;
            case "product":
                result.addAll(mr.findByProductLikeIgnoreCaseOrNameLikeIgnoreCaseOrMessageLikeIgnoreCaseAndAaaBetween("%" + val.get(0) + "%", "%" + val.get(0) + "%", "%" + val.get(0) + "%", startDay, endDay, sort));
                break;
            case "quote":
                result.addAll(mr.findByQuoteLikeIgnoreCaseAndAaaBetween("%" + val.get(0) + "%", startDay, endDay, sort));
                break;
            case "closereason":
                result.addAll(mr.findByClosereasonAndAaaBetween(val.get(0), startDay, endDay, sort));
                break;
            case "createtime":
                for (String type : val)
                result.addAll(mr.findByCreatetimeAndAaaBetween(type, startDay, endDay, sort));
                break;
        }
        System.out.println("搜索出 "+ result.size()+" 筆資料");
        return result;
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //添加使用者狀態
    public void saveMarketState(Integer adminid, String field, String state, String type) {
        msr.save(new MarketStateBean(ZeroTools.getUUID(), adminid, field, state, type));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //getM使用者狀態列表
    public List<MarketStateBean> getMarketStateList(Integer adminid) {

        return msr.findByAdminid(adminid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //刪除使用者狀態
    public void delState(String marketstateid) {
        msr.deleteById(marketstateid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //使用者狀態  主程式
    public Map<String, Object> getStateList(List<MarketStateBean> stateList, Integer pag, Integer size) {
        Sort sort = Sort.by(Direction.DESC, "aaa");
        //準備
        Map<String, Object> resoult = new HashMap<>();
        List<MarketBean> list = new ArrayList<>();
        List<MarketBean> Marketlist = new ArrayList<>();
        List<String> admin = new ArrayList<>();
        List<String> state = new ArrayList<>();
        List<Integer> receive = new ArrayList<>();
        String stateday = null;
        String startday = "2022-02-01 00:00";
        String endday;
        for (MarketStateBean b : stateList) {
            if (b.getField().equals("admin")) admin.add(b.getState());
            if (b.getField().equals("day")) stateday = b.getState();
            if (b.getField().equals("state")) state.add(b.getState());
            if (b.getField().equals("receive") && Objects.equals(b.getState(), "領取")) receive.add(1);
            if (b.getField().equals("receive") && Objects.equals(b.getState(), "分配")) receive.add(2);
        }
        //日期處理
        if (stateday == null) {
            endday = ZeroTools.getTime(new Date());
        } else {
            String[] tokens = stateday.split("~");
            startday = tokens[0] + " 00:00";
            endday = tokens[1] + " 23:59";
        }

        //主搜索 選擇用哪一個搜索
        if (admin.size() > 0) {
            for (String name : admin) {
                System.out.println(name);
                list.addAll(mr.findByUserAndAaaBetween(name, startday, endday, sort));
            }
        } else if (state.size() > 0) {
            for (String name : state) {
                list.addAll(mr.findByStageAndAaaBetween(name, startday, endday, sort));
            }
        } else if (receive.size() > 0) {
            for (Integer receicestate : receive) {
                list.addAll(mr.findByReceivestateAndAaaBetween(receicestate, startday, endday));
            }
        } else {
            list.addAll(mr.findAaa(startday, endday));
        }


        //再過濾
        if (state.size() > 0) {
            List<MarketBean> s = new ArrayList<>(list);
            list.clear();
            for (String sta : state) {
                for (MarketBean marketBean : s) {
                    if (sta.equals(marketBean.getStage())) list.add(marketBean);
                }
            }
        }
        if (receive.size() > 0) {
            List<MarketBean> s = new ArrayList<>(list);
            list.clear();
            for (Integer sta : receive) {
                for (MarketBean marketBean : s) {
                    if (sta.equals(marketBean.getReceivestate())) list.add(marketBean);
                }
            }
        }


        //排序
        list = list.stream().sorted(Comparator.comparing(MarketBean::getAaa).reversed()).collect(Collectors.toList());


        //pag 手寫分頁
        int total = list.size();
        for (int i = pag * size; i < pag * size + size; i++) {
            if (i + 1 > total) break;
            Marketlist.add(list.get(i));
        }

        //輸出
        resoult.put("list", Marketlist);
        resoult.put("total", total);
        return resoult;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //檢查有無使用者狀態
    public boolean existMarketState(Integer adminid, String filed, String state) {
        return msr.existsByAdminidAndFieldAndState(adminid, filed, state);

    }

    public boolean existMarketByFileforeignid(String fileforeignid) {
        return mr.existsByFileforeignid(fileforeignid);


    }

    public boolean existMarketStateByState(Integer adminid, String state) {
        return msr.existsByAdminidAndField(adminid, state);
    }

    public MarketStateBean getMarketField(Integer adminid, String field) {
        return msr.findByAdminidAndField(adminid, field);


    }

    public void sevaMarketStateBean(MarketStateBean marketStateBean) {
        msr.save(marketStateBean);
    }

    public void delAllState(Integer adminid) {
        msr.deleteByAdminid(adminid);
    }

    //刪除使用者狀態
    public void delMarketState(Integer adminid, String field, String state) {
        MarketStateBean msBean = msr.findByAdminidAndFieldAndState(adminid, field, state);
        msr.delete(msBean);

    }

    public List<MarketBean> getAll() {
        return mr.findAll();
    }

    //轉賣 時間到自動結案
    public void AutoCloseCase(String Createtime) {
        System.out.println("======================================================================");
        System.out.println("自動結案");
        LocalDate ld = LocalDate.now();
        LocalDate yesterday =  ld.plusDays(-1);
        List<MarketBean> list = mr.findByCreatetimeAndEndtimeLessThanEqualAndStageNotAndStageNot(Createtime, yesterday.toString(), "失敗結案", "成功結案");
        list.forEach((e) -> {
            System.out.println(e);
            e.setClosereason("自動結案");
            e.setStage("失敗結案");
            e.setBbb(LocalDateTime.now().toString());
//            e.setBbb(ZeroTools.getTime(new Date()));
            mr.save(e);
        });
        System.out.println(list.size());
    }

    //
    public List<MarketBean> getCreatetimeAndEndtime(String Createtime) {
        return mr.findByCreatetimeAndEndtimeLessThanEqualAndStageNotAndStageNot(Createtime, LocalDate.now().toString(), "失敗結案", "成功結案");

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //讀取 自動結案
    public Map<String, Object> getAutoClose() {
        Map<String, Object> result = new HashMap<>();
        result.put("list", mr.findByClosereason("自動結案", Sort.by(Direction.DESC, "aaa")));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //market BY 階段 和 業務
    public List<MarketBean> getMarketByStageAndUser(String stage, String user) {
        String day = LocalDate.now().minusDays(3).toString();
        return mr.findByStageAndUserAndAaaLessThan(stage, user, day);
    }

    public boolean existMarketById(String marketid) {
        return mr.existsById(marketid);
    }

    public MarketBean findByCustomerid(String id) {
        return mr.findByCustomerid(id);
    }

    public int countTrackNumBYTimeAndRemark(String startDay, String endDay, String name) {
        return tr.countByRemarkAndTracktimeBetween(name,startDay,endDay);
    }
}
