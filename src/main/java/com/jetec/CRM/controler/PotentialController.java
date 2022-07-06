package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.ClientService;
import com.jetec.CRM.controler.service.DirectorService;
import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.controler.service.SystemService;
import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.TrackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.access.prepost.PreAuthorize;
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
        Map<String, Object> result = new HashMap<>();
        result.put("customer", PCS.getById(customerid));
        result.put("track", PCS.getTrackByCustomerid(customerid));
        result.put("bosmessage", DS.getBosMessageList(customerid));
        result.put("changeMessage", DS.getChangeMessage(customerid));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表
    @RequestMapping("/CustomerList")
    public Map<String, Object> clientList(@RequestParam("pag") Integer pag) {
        System.out.println("*****讀取潛在客戶列表*****");
        pag--;
        Map<String, Object> result = new HashMap<>();
        result.put("list", PCS.getList(pag));
        result.put("todayTotal", PCS.gettodayTotal());
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 所有筆數
    @RequestMapping("/MaxPag")
    public long MaxPag() {
        return PCS.getMaxPag();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表(結案)
    @RequestMapping("/closed")
    @ResponseBody
    public List<PotentialCustomerBean> closed() {
        System.out.println("*****讀取潛在客戶列表*****");
        return PCS.closed();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索潛在客戶by負責人
    @RequestMapping("/admin/{name}")
    @ResponseBody
    public List<PotentialCustomerBean> selectAdmin(@PathVariable("name") String name) {
        System.out.println("搜索潛在客戶");
        name.trim();
        return PCS.selectPotentialCustomer(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索日期
    @RequestMapping("/selectDate")
    public List<PotentialCustomerBean> selectDate(@RequestParam("startDay") String startDay, @RequestParam("endDay") String endDay) {
        System.out.println("搜索潛在客戶 日期");
        if (startDay == null || startDay.equals("") ) {
//			startDay = zTools.getTime(new Date());
//			startDay = startDay.substring(0,10);
//			startDay = startDay + " 00:00";
            startDay = "2022-02-01 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        if (endDay.equals("") ) {
            endDay = zTools.getTime(new Date());
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
        return PCS.selectStatus(status);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 搜索潛在客戶by來源
    @SuppressWarnings("unchecked")
    @RequestMapping("/selectSource")
    public List<PotentialCustomerBean> selectSource(@RequestBody Map<String, Object> data) {
        System.out.println("搜索潛在客戶by來源");
        List<PotentialCustomerBean> result = new ArrayList<>();
        for (String source : (List<String>) data.get("source")) {

            result.addAll(PCS.selectSource(source));
            result.addAll(PCS.selectIndustry(source));
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//添加協助者
    @RequestMapping("/addHelper/{customerid}/{helper}")
    public List<PotentialCustomerHelperBean> addHelper(@PathVariable("customerid") String customerid,
                                                       @PathVariable("helper") String helper) {
        System.out.println("添加協助者");
        return PCS.addHelper(customerid, helper);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除協助者
    @RequestMapping("/delHelper/{customerid}/{helper}")
    public List<PotentialCustomerHelperBean> delHelper(@PathVariable("customerid") String customerid,
                                                       @PathVariable("helper") String helperid) {
        System.out.println("刪除協助者");
        return PCS.delHelper(customerid, helperid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by追蹤時間
    @RequestMapping("/selectTrackDate")
    public List<PotentialCustomerBean> selectTrackDate(@RequestParam("from") String from,  @RequestParam("to") String to) {
        System.out.println("搜索潛在客戶by追蹤時間");
        List<PotentialCustomerBean> list = PCS.selectPotentialCustomerTrack(from, to);
        LinkedHashSet<PotentialCustomerBean> hashSet = new LinkedHashSet<>(list);
        List<PotentialCustomerBean> result = new ArrayList<>(hashSet);
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取追蹤資訊
    @RequestMapping("/client/{customerid}")
    public List<TrackBean> client(@PathVariable("customerid") String customerid) {
        System.out.println("讀取追蹤資訊");
        return PCS.getTrackByCustomerid(customerid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存回覆追蹤資訊
    @RequestMapping("/saveTrackRemark/{trackid}/{content}")
    public List<TrackBean> saveTrackRemark(@PathVariable("trackid") String trackid,
                                           @PathVariable("content") String content, HttpSession session) {
        System.out.println("存回覆追蹤資訊");
        AdminBean aBean = (AdminBean) session.getAttribute("user");
        return PCS.saveTrackRemark(trackid, content, aBean.getName());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤資訊
    @RequestMapping("/removeTrack/{trackid}")
    public List<TrackBean> removeTrack(@PathVariable("trackid") String trackid) {
        System.out.println("刪除追蹤資訊");
        String customerid = PCS.removeTrack(trackid);
        return PCS.getTrackByCustomerid(customerid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤回覆
    @RequestMapping("/removeTrackremark/{trackremarkid}/{trackid}")
    public List<TrackBean> removeTrackremark(@PathVariable("trackremarkid") String trackremarkid,
                                             @PathVariable("trackid") String trackid) {
        System.out.println("刪除追蹤回覆");
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
        if(cBean != null){
            map.put("company", cBean);
            map.put("contact", CS.getByNameAndCompany(cBean.getUser(), company));
        }
        return map;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索詢問內容
    @RequestMapping("/selectcontent")
    public List<PotentialCustomerBean> selectcontent(@RequestBody Map<String, String> data) {
        System.out.println("搜索詢問內容");
        System.out.println(data.get("selectcontent"));
        System.out.println(PCS.selectcontent(data.get("selectcontent")));
        return PCS.selectcontent(data.get("selectcontent"));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //求助
    @RequestMapping("/CallHelp/{customerid}")
    @ResponseBody
    public String CallHelp(@PathVariable("customerid") String customerid) {
        System.out.println("求助");
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
        System.out.println("搜索潛在客戶ByAll");
        if (startDay == null || startDay.equals("")) {
            startDay = "2022-02-01 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        if (endDay.equals("")) {
            endDay = zTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        System.out.println(startDay);
        System.out.println(endDay);
        return PCS.selectPotential(startDay, endDay, key, val);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //領取任務
    @RequestMapping("/getReceive/{customerid}")
    @ResponseBody
    public Map<String, String> getReceive(HttpSession session, @PathVariable("customerid") String customerid) {
        System.out.println("領取任務");
        Map<String, String> result = new HashMap<>();
        PotentialCustomerBean pcBean = PCS.getById(customerid);
        if (pcBean != null) {
            AdminBean aBean = (AdminBean) session.getAttribute("user");
            if (pcBean.getReceive() == null || pcBean.getReceive().isEmpty()                                          ) {
                ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "領取任務", pcBean.getReceive(), aBean.getName(), LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                ss.saveChangeMesssage(cmBean);
                cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "負責人", pcBean.getUser(), aBean.getName(), LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                ss.saveChangeMesssage(cmBean);
                pcBean.setReceive(aBean.getName());
                pcBean.setUser(aBean.getName());
                PCS.SavePotentialCustomer(pcBean);
                result.put("state", "領取成功");
                result.put("user", aBean.getName());
                return result;
            }
            ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "領取任務", aBean.getName(), "null", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            ss.saveChangeMesssage(cmBean);
            cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pcBean.getCustomerid(), aBean.getName(), "負責人", aBean.getName(), "null", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            ss.saveChangeMesssage(cmBean);
            pcBean.setReceive(null);
            pcBean.setUser(null);
            PCS.SavePotentialCustomer(pcBean);
            result.put("state", "取消成功");
            result.put("user", null);
            return result;
        }
        result.put("state", "請先建立任務");
        result.put("user", null);
        return result;
    }

}
