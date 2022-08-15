package com.jetec.CRM.controler.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jetec.CRM.Tool.ZeroCode;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.model.MarketFileBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.TrackBean;
import com.jetec.CRM.model.TrackRemarkBean;
import com.jetec.CRM.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

@Service
@Transactional
public class PotentialCustomerService {

    @Autowired
    AdminRepository ar;
    @Autowired
    PotentialCustomerRepository PCR;
    @Autowired
    TrackRepository tr;
    @Autowired
    PotentialCustomerHelperRepository pchr;
    @Autowired
    TrackRemarkRepository trr;

    @Autowired
    UpfileService US;
    @Autowired
    StringRedisTemplate stringRedisTemplate;

    Logger logger = LoggerFactory.getLogger("PotentialCustomerService.class");
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存潛在客戶列表
    public PotentialCustomerBean SavePotentialCustomer(PotentialCustomerBean pcb) {
        String uuid = ZeroTools.getUUID();
        if (pcb.getFileforeignid() == null || pcb.getFileforeignid().isEmpty() || pcb.getFileforeignid().equals("")) {
            pcb.setFileforeignid(uuid);
        }
        if (pcb.getCustomerid() == null || pcb.getCustomerid().isEmpty()) {
            pcb.setCustomerid(uuid);
            if (US.existsByFileforeignid(pcb.getFileforeignid())) {
                List<MarketFileBean> list = US.getByfileForeignid(pcb.getFileforeignid());
                for (MarketFileBean fileBean : list) {
                    fileBean.setFileforeignid(uuid);
                    fileBean.setAuthorize(uuid);
                    US.save(fileBean);
                }
            }
            pcb.setFileforeignid(uuid);
        }
        if (pcb.getAaa() == null || pcb.getAaa().isEmpty())
            pcb.setAaa(ZeroTools.getTime(new Date()));
        if (pcb.getFileforeignid() == null || Objects.equals("", pcb.getFileforeignid()))
            pcb.setCustomerid(ZeroTools.getUUID());

        try {
            stringRedisTemplate.delete(ZeroCode.Redis_Customer_Id + pcb.getCustomerid());
            logger.info("刪除redis緩存 "+ZeroCode.Redis_Customer_Id + pcb.getCustomerid());

        } catch (Exception e) {
            System.out.println("刪除緩存失敗");
        }
        return PCR.save(pcb);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表
    public List<PotentialCustomerBean> getList(Integer pag) {
        Pageable p = PageRequest.of(pag, 100, Direction.DESC, "aaa");
        List<PotentialCustomerBean> result = new ArrayList<>();
        if (pag.equals(0)) {
            result.addAll(PCR.findByUser(""));
            result.addAll(PCR.findByUserIsNull());
        }
        Page<PotentialCustomerBean> page = PCR.findStatus(p);
        result.addAll(page.getContent());
        return result;
    }

    public PotentialCustomerBean getById(String id) {
        String jsonString = null;
        //讀取緩存
        try {
            jsonString = stringRedisTemplate.opsForValue().get(ZeroCode.Redis_Customer_Id + id);
        } catch (Exception e) {
            System.out.println("讀取緩存失敗");
        }

        //如果沒有緩存
        if (jsonString == null) {
            PotentialCustomerBean bean = PCR.findById(id).orElse(null);
            //添加redis
            ObjectMapper objectMapper = new ObjectMapper();
            try {
                stringRedisTemplate.opsForValue().set(ZeroCode.Redis_Customer_Id + bean.getCustomerid(), objectMapper.writeValueAsString(bean), 4, TimeUnit.HOURS);
                System.out.println("添加緩存" + bean.getCustomerid());
            } catch (Exception e) {

            }
            return bean;
        }
        //有緩存 轉成bean
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.readValue(jsonString, PotentialCustomerBean.class);
        } catch (JsonProcessingException e) {
            return PCR.findById(id).orElse(null);
        }


    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//要求最大分頁數
//    public long getMaxPag() {
//        Pageable p = (Pageable) PageRequest.of(0, 40);
//        Page<PotentialCustomerBean> page = (Page<PotentialCustomerBean>) PCR.findStatus(p);
////		全部有幾頁
//        return page.getTotalElements();//全部幾筆
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表(結案)
    public List<PotentialCustomerBean> closed() {
        List<PotentialCustomerBean> result = PCR.findByStatus("不合格");
        result.addAll(PCR.findByStatus("合格"));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除潛在客戶
    public void delPotentialCustomer(List<String> id) {
        for (String i : id) {
            tr.deleteByCustomerid(i);
            PCR.deleteById(i);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶
    public List<PotentialCustomerBean> selectPotentialCustomer(String name) {
        boolean boo = true;
        Sort sort = Sort.by(Direction.DESC, "aaa");
// 搜索名稱
        List<PotentialCustomerBean> result = new ArrayList<>(PCR.findByNameLikeIgnoreCase("%" + name + "%", sort));

// 用業務搜索
        for (PotentialCustomerBean p : PCR.findByUserLikeIgnoreCase("%" + name + "%", sort)) {
            for (PotentialCustomerBean bean : result) {
                if (Objects.equals(bean.getCustomerid(), p.getCustomerid())) {
                    boo = false;
                    break;
                }
            }
            if (boo)
                result.add(p);
            boo = true;
        }
// 用公司搜索
        for (PotentialCustomerBean p : PCR.findByCompanyLikeIgnoreCase("%" + name + "%", sort)) {
            for (PotentialCustomerBean bean : result) {
                if (Objects.equals(bean.getCustomerid(),p.getCustomerid()) ) {
                    boo = false;
                    break;
                }
            }
            if (boo)
                result.add(p);
            boo = true;
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索創造日期
    public List<PotentialCustomerBean> selectDate(String startDay, String endDay) {
        return PCR.findCreatetime(startDay, endDay);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by狀態
    public List<PotentialCustomerBean> selectStatus(String status) {
        // TODO Auto-generated method stub
        return PCR.findByStatus(status);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by來源
    public List<PotentialCustomerBean> selectSource(String source) {
        return PCR.findBySource(source);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by產業
    public List<PotentialCustomerBean> selectIndustry(String industry) {
        return PCR.findByIndustry(industry);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//添加協助者
//    public List<PotentialCustomerHelperBean> addHelper(String customerid, String helper) {
//        PotentialCustomerBean pcBean = PCR.getById(customerid);
//        for (PotentialCustomerHelperBean helperBean : pcBean.getHelper()) {
//            if (helperBean.getName().equals(helper)) {
//                return pcBean.getHelper();
//            }
//        }
//        if (pcBean.getUser().equals(helper)) {
//            return pcBean.getHelper();
//        }
//        PotentialCustomerHelperBean newBean = new PotentialCustomerHelperBean();
//        newBean.setHelperid(zTools.getUUID());
//        newBean.setCustomerid(customerid);
//        newBean.setName(helper);
//        newBean.setAdminid(ar.findByName(helper).getAdminid());
//        pchr.save(newBean);
//        System.out.println(pchr.findByCustomerid(customerid));
//        return pchr.findByCustomerid(customerid);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除協助者
//    public List<PotentialCustomerHelperBean> delHelper(String customerid, String helperid) {
//        System.out.println(helperid);
//        pchr.deleteById(helperid);
//
//        System.out.println(pchr.findByCustomerid(customerid));
//        return pchr.findByCustomerid(customerid);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by追蹤時間
    public List<PotentialCustomerBean> selectPotentialCustomerTrack(String from, String to) {
        return PCR.findByTrackbeanTracktimeBetween(from, to);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//回覆追蹤資訊
    public List<TrackBean> saveTrackRemark(String trackid, String content, String name) {
        TrackRemarkBean trbean = new TrackRemarkBean();
        trbean.setName(name);
        trbean.setTrackid(trackid);
        trbean.setContent(content);
        trbean.setTrackremarkid(ZeroTools.getUUID());
        trbean.setCreatetime(ZeroTools.getTime(new Date()));
        trr.save(trbean);
        Sort sort = Sort.by(Direction.DESC, "tracktime");
        //trackid取得TrackBean , TrackBean取得Customerid ,Customerid取得 List<TrackBean>
        return tr.findByCustomerid(tr.getById(trackid).getCustomerid(), sort);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤資訊
    public String removeTrack(String trackid) {
        String Customerid = tr.getById(trackid).getCustomerid();
        tr.deleteById(trackid);
        return Customerid;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤回覆
    public void removeTrackremark(String trackremarkid) {
        trr.deleteById(trackremarkid);

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取追蹤資訊
    public List<TrackBean> getTrackByCustomerid(String customerid) {
        Sort sort = Sort.by(Direction.DESC, "tracktime");
        return tr.findByCustomerid(customerid, sort);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索詢問內容

    public List<PotentialCustomerBean> selectcontent(String selectcontent) {
        return PCR.findByRemarkLikeIgnoreCase("%" + selectcontent + "%");
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//今天總計
    public Integer gettodayTotal() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String ddd = sdf.format(new Date());

        return PCR.gettodayTotal(ddd + " 00:00", ddd + " 23:59");

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//判斷潛在客戶存在
    public boolean existsById(String customerid) {
        return PCR.existsById(customerid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶ByAll
    public List<PotentialCustomerBean> selectPotential(String startDay, String endDay, String key, List<String> val) {
        Sort sort = Sort.by(Direction.DESC, "aaa");
        System.out.println(key);
        System.out.println(val);
        List<PotentialCustomerBean> result = new ArrayList<>();
        switch (key) {
            case "UserList"://負責人
                for (String user : val)
                    result.addAll(PCR.findByUserAndAaaBetween(user, startDay, endDay, sort));
                break;
            case "name"://聯絡人,公司名稱
                result.addAll(PCR.findByNameLikeIgnoreCaseOrCompanyLikeIgnoreCaseAndAaaBetween("%" + val.get(0) + "%", "%" + val.get(0) + "%", startDay, endDay, sort));
                break;
            case "content"://詢問內容
                result.addAll(PCR.findByRemarkLikeIgnoreCaseAndAaaBetween("%" + val.get(0) + "%", startDay, endDay, sort));
                break;
            case "inStateList"://狀態
                for (String state : val)
                    result.addAll(PCR.findByStatusAndAaaBetween(state, startDay, endDay, sort));
                break;
            case "industry"://產業
                for (String industry : val)
                    result.addAll(PCR.findByIndustryAndAaaBetween(industry, startDay, endDay, sort));
                break;
            case "phone"://產業
                for (String phone : val) {
                    phone = phone.replace("-", "");
                    phone = phone.replace("(", "");
                    phone = phone.replace(")", "");
                    result.addAll(PCR.findByPhoneLikeAndAaaBetween("%" + phone + "%", startDay, endDay, sort));
                    result.addAll(PCR.findByMoblieLikeAndAaaBetween("%" + phone + "%", startDay, endDay, sort));
                    result.addAll(PCR.findByFaxLikeAndAaaBetween("%" + phone + "%", startDay, endDay, sort));
                }
                break;
        }
        return result;
    }

    //提交主管by淺在客戶

    public List<PotentialCustomerBean> getPotentialSubmitBos() {
        return PCR.findByStatus("提交主管");
    }
}
