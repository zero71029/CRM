package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.*;
import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.TrackRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@ResponseBody
@RequestMapping("/Potential")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')OR hasAuthority('國貿')")
public class PotentialController {

    Logger logger = LoggerFactory.getLogger("PotentialController");
    @Autowired
    PotentialCustomerService PCS;
    @Autowired
    TrackRepository tr;
    @Autowired
    ClientService CS;
    @Autowired
    DirectorService DS;
    @Autowired
    ZeroTools zTools;
    @Autowired
    SystemService ss;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//初始化
    @RequestMapping("/init/{customerid}")
    public Map<String, Object> init(@PathVariable("customerid") String customerid) {
        logger.info("*****潛在客戶初始化*****");
        Map<String, Object> result = new HashMap<>();
        PotentialCustomerBean pcb = PCS.getById(customerid);
        pcb.setOpentime(LocalDateTime.now().toString());
        result.put("customer", pcb);
        result.put("track", PCS.getTrackByCustomerid(customerid));
        result.put("bosmessage", DS.getBosMessageList(customerid));
        result.put("changeMessage", DS.getChangeMessage(customerid));
        return result;
    }

    //讀取潛在客戶列表
    @RequestMapping("/CustomerList")
    public Map<String, Object> clientList(@RequestParam("pag") Integer pag) {
        logger.info("*****讀取潛在客戶列表*****");
        pag--;
        if (pag < 0) pag = 0;
        Map<String, Object> result = new HashMap<>();
        result.put("list", PCS.getList(pag));
        result.put("todayTotal", PCS.gettodayTotal());
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 所有筆數
//    @RequestMapping("/MaxPag")
//    public long MaxPag() {
//        return PCS.getMaxPag();
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表(結案)
    @RequestMapping("/closed")
    @ResponseBody
    public List<PotentialCustomerBean> closed() {
        System.out.println("*****讀取潛在客戶列表(結案)*****");
        return PCS.closed();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索潛在客戶by負責人
    @RequestMapping("/admin/{name}")
    @ResponseBody
    public List<PotentialCustomerBean> selectAdmin(@PathVariable("name") String name) {
        logger.info("搜索潛在客戶 {}", name);
        return PCS.selectPotentialCustomer(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索日期
    @RequestMapping("/selectDate")
    public List<PotentialCustomerBean> selectDate(@RequestParam("startDay") String startDay, @RequestParam("endDay") String endDay) {
        logger.info("搜索潛在客戶 日期");
        if (startDay == null || startDay.equals("")) {
//			startDay = zTools.getTime(new Date());
//			startDay = startDay.substring(0,10);
//			startDay = startDay + " 00:00";
            startDay = "2022-02-01 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        if (endDay.equals("")) {
            endDay = ZeroTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        System.out.println(startDay);
        System.out.println(endDay);
        return PCS.selectDate(startDay, endDay);


//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//// 設定日期格式
//		if (from.equals("")) {
//			from = "2020-11-30";
//		}
//		if (to.equals("")) {
//			to = sdf.format(new Date());
//		} else {
//			to = to + " 23:59:59";
//		}
//		from = from + " 00:00:00";
//// 進行轉換
//		Date formDate;
//		Date toDate;
//		try {
//			formDate = sdf.parse(from);
//			toDate = sdf.parse(to);
//			return PCS.selectDate(formDate, toDate);
//		} catch (ParseException e) {
//
//		}
//		return null;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by狀態
    @RequestMapping("/status/{status}")
    public List<PotentialCustomerBean> selectStatus(@PathVariable("status") String status) {
        System.out.println("搜索潛在客戶");
        logger.info("搜索潛在客戶 {}", status);
        return PCS.selectStatus(status);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 搜索潛在客戶by來源
//    @SuppressWarnings("unchecked")
//    @RequestMapping("/selectSource")
//    public List<PotentialCustomerBean> selectSource(@RequestBody Map<String, Object> data) {
//        System.out.println("搜索潛在客戶by來源");
//        List<PotentialCustomerBean> result = new ArrayList<>();
//        for (String source : (List<String>) data.get("source")) {
//
//            result.addAll(PCS.selectSource(source));
//            result.addAll(PCS.selectIndustry(source));
//        }
//        return result;
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//添加協助者
//    @RequestMapping("/addHelper/{customerid}/{helper}")
//    public List<PotentialCustomerHelperBean> addHelper(@PathVariable("customerid") String customerid,
//                                                       @PathVariable("helper") String helper) {
//        System.out.println("添加協助者");
//        return PCS.addHelper(customerid, helper);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除協助者
//    @RequestMapping("/delHelper/{customerid}/{helper}")
//    public List<PotentialCustomerHelperBean> delHelper(@PathVariable("customerid") String customerid,
//                                                       @PathVariable("helper") String helperid) {
//        System.out.println("刪除協助者");
//        return PCS.delHelper(customerid, helperid);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by追蹤時間
    @RequestMapping("/selectTrackDate")
    public List<PotentialCustomerBean> selectTrackDate(@RequestParam("from") String from, @RequestParam("to") String to) {
        logger.info("搜索潛在客戶by追蹤時間");
        List<PotentialCustomerBean> list = PCS.selectPotentialCustomerTrack(from, to);
        LinkedHashSet<PotentialCustomerBean> hashSet = new LinkedHashSet<>(list);
        return new ArrayList<>(hashSet);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取追蹤資訊
    @RequestMapping("/client/{customerid}")
    public List<TrackBean> client(@PathVariable("customerid") String customerid) {
        logger.info("讀取追蹤資訊 {}", customerid);
        return PCS.getTrackByCustomerid(customerid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//回覆 追蹤資訊
    @RequestMapping("/saveTrackRemark/{trackid}/{content}")
    public List<TrackBean> saveTrackRemark(@PathVariable("trackid") String trackid,
                                           @PathVariable("content") String content, HttpSession session) {
        AdminBean aBean = (AdminBean) session.getAttribute("user");
        logger.info("{} 回覆追蹤資訊 {}", aBean.getName(), content);
        return PCS.saveTrackRemark(trackid, content, aBean.getName());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤資訊
    @RequestMapping("/removeTrack/{trackid}")
    public List<TrackBean> removeTrack(@PathVariable("trackid") String trackid) {
        logger.info("刪除追蹤資訊 {}", trackid);
        String customerid = PCS.removeTrack(trackid);
        return PCS.getTrackByCustomerid(customerid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤回覆
    @RequestMapping("/removeTrackremark/{trackremarkid}/{trackid}")
    public List<TrackBean> removeTrackremark(@PathVariable("trackremarkid") String trackremarkid,
                                             @PathVariable("trackid") String trackid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 刪除追蹤回覆 {}",adminBean.getName(),trackremarkid);
        PCS.removeTrackremark(trackremarkid);
        Sort sort = Sort.by(Direction.DESC, "tracktime");
        return tr.findByCustomerid(tr.getById(trackid).getCustomerid(), sort);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶細節byName
    @RequestMapping("/getCompany/{company}")
    public Map<String, Object> getCompanyByName(@PathVariable("company") String company) {
        Map<String, Object> map = new HashMap<>();
        ClientBean cBean = CS.getCompanyByName(company);
        logger.info("讀取客戶細節byName {}",company);
        if (cBean != null) {
            map.put("company", cBean);
            map.put("contact", CS.getByNameAndCompany(cBean.getUser(), company));
        }
        return map;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索詢問內容
    @RequestMapping("/selectcontent")
    public List<PotentialCustomerBean> selectcontent(@RequestBody Map<String, String> data) {
        logger.info("搜索詢問內容 {}",data.get("selectcontent"));
        return PCS.selectcontent(data.get("selectcontent"));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //求助
    @RequestMapping("/CallHelp/{customerid}")
    @ResponseBody
    public String CallHelp(@PathVariable("customerid") String customerid) {
        logger.info("求助 {}",customerid);
        PotentialCustomerBean mbean = PCS.getById(customerid);
        if (mbean.getCallhelp() == null || !mbean.getCallhelp().equals("1")) {
            mbean.setCallhelp("1");
            PCS.SavePotentialCustomer(mbean);
            return "求助";
        } else {
            mbean.setCallhelp("0");
            PCS.SavePotentialCustomer(mbean);
            return "取消";
        }
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶ByAll
    @RequestMapping("/selectPotential")
    public List<PotentialCustomerBean> selectPotential(@RequestParam("startDay") String startDay, @RequestParam("endDay") String endDay, @RequestParam("key") String key, @RequestParam("val") List<String> val) {
        logger.info("搜索潛在客戶  key={} val={}",key,val);
        if (startDay == null || startDay.equals("")) {
            startDay = "2022-02-01 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        if (endDay.equals("")) {
            endDay = ZeroTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        System.out.println(startDay);
        System.out.println(endDay);
        return PCS.selectPotential(startDay, endDay, key, val);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //領取任務
    @RequestMapping("/getReceive")
    @ResponseBody
    public Map<String, Object> getReceive(HttpSession session, PotentialCustomerBean newBean) {
        AdminBean aBean = (AdminBean) session.getAttribute("user");
        logger.info("{} 領取淺在顧客 務 {}",aBean.getName(),newBean.getCustomerid());
        Map<String, Object> result = new HashMap<>();
        PotentialCustomerBean pcBean = PCS.getById(newBean.getCustomerid());
        //避免同時開同一頁面
        if (pcBean.getBbb() != null) {
            if (pcBean.getBbb().compareTo(newBean.getOpentime()) > 0) {
                logger.info("資料已被其他人更新,不能領取");
                result.put("state", false);
                result.put("receivestate", "3");
                result.put("user", null);
                return result;
            }
        }
        // 領取
        if (pcBean != null) {
            if (pcBean.getReceive() == null || pcBean.getReceive().isEmpty() || !Objects.equals(aBean.getName(), pcBean.getUser())) {
                ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "領取任務", pcBean.getReceive(), aBean.getName(), LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                ss.saveChangeMesssage(cmBean);
                cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "負責人", pcBean.getUser(), aBean.getName(), LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                ss.saveChangeMesssage(cmBean);
                cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "領取狀態", pcBean.getReceivestate() + "", "1", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                ss.saveChangeMesssage(cmBean);
                newBean.setReceive(aBean.getName());
                newBean.setUser(aBean.getName());
                newBean.setReceivestate(1);
                //存時間
                newBean.setBbb(LocalDateTime.now().toString());
                logger.info("{} 領取成功 {}", aBean.getName(), newBean.getCustomerid());
                PCS.SavePotentialCustomer(newBean);
                result.put("state", true);
                result.put("receivestate", "1");
                result.put("user", aBean.getName());
                return result;
            }
            ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "領取任務", aBean.getName(), "null", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            ss.saveChangeMesssage(cmBean);
            cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "負責人", aBean.getName(), "null", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            ss.saveChangeMesssage(cmBean);
            cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "領取狀態", pcBean.getReceivestate() + "", "3", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            ss.saveChangeMesssage(cmBean);
            newBean.setReceive(null);
            newBean.setUser(null);
            newBean.setReceivestate(3);
            newBean.setBbb(LocalDateTime.now().toString());
            logger.info("{} 取消任務 {}", aBean.getName(), newBean.getCustomerid());
            PCS.SavePotentialCustomer(newBean);
            result.put("state", true);
            result.put("receivestate", "3");
            result.put("user", null);
            return result;
        }
        result.put("state", "請先建立任務");
        result.put("user", null);
        return result;
    }

}
