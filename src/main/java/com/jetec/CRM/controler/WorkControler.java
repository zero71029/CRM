package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.*;
import com.jetec.CRM.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/work")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')OR hasAuthority('國貿')")
public class WorkControler {
    @Autowired
    WorkSerivce ws;
    @Autowired
    ClientService cs;
    @Autowired
    PotentialCustomerService pcs;
    @Autowired
    MarketService ms;

    @Autowired
    PotentialCustomerService PCS;
    @Autowired
    DirectorService DS;
    Logger logger  = LoggerFactory.getLogger("WorkControler");
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/init/{id}")
    @ResponseBody
    public Map<String, Object> Market(@PathVariable("id") String id) {
        System.out.println("工作項目初始化");
        Map<String, Object> result = new HashMap<>();

        result.put("bean", ws.getById(id));
        result.put("changeMessageList", DS.getChangeMessage(id));
        return result;
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存工作項目
    @RequestMapping("/SaveWork")
    public String SaveWork(WorkBean worKBean) {
        System.out.println("存工作項目");
        System.out.println(worKBean);
        if (worKBean.getWorkid() == null || worKBean.getWorkid().isEmpty()) worKBean.setWorkid(ZeroTools.getUUID());
        if (worKBean.getAaa() == null || worKBean.getAaa().isEmpty())
            worKBean.setAaa(ZeroTools.getTime(new Date()));
        WorkBean save = ws.SaveWork(worKBean);
        return "redirect:/work/detail/" + save.getWorkid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//工作項目列表
    @ResponseBody
    @RequestMapping("/workList")
    public Map<String, Object> workList(@RequestParam("pag") Integer pag) {
        System.out.println("工作項目列表");
        pag--;
        return ws.getList(pag);
    }

    // 取得所有筆數
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//工作項目列表(結案)
    @RequestMapping("/closed")
    public String closed(Model model) {
        model.addAttribute("list", ws.closed());
        return "/Market/workList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 讀取工作項目細節
    @RequestMapping("/detail/{id}")
    public String detail(Model model, @PathVariable("id") String id) {
        System.out.println("*****讀取工作項目細節****");
        model.addAttribute("bean", ws.getById(id));
        System.out.println(ws.getById(id));

        return "/Market/work";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表
    @RequestMapping("/clientList")
    @ResponseBody
    public List<Map<String,String>> clientList(HttpServletRequest req) {
        ServletContext sce = req.getServletContext();
        List<Map<String,String>> result = new ArrayList<>();
        List<ClientBean> list =(List<ClientBean>) sce.getAttribute("client");
        for (ClientBean clientBean : list) {
            Map<String,String> map =new HashMap<>();
            map.put("name",clientBean.getName());
            map.put("clientid",clientBean.getClientid()+"");
            result.add(map);
        }
        return result;
//        return cs.getList();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表by clientid
    @RequestMapping("/contactList/{clientid}")
    @ResponseBody
    public List<ContactBean> contactList(@PathVariable("clientid") Integer clientid) {
        
        return ws.getContactList(clientid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索客戶
    @RequestMapping("/selectclient/{name}")
    @ResponseBody
    public List<ClientBean> selectclient(@PathVariable("name") String name) {
        System.out.println("搜索客戶");
        return cs.selectclient(name);
    }



    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在顧客
    @RequestMapping("/selectCustomer/{name}")
    @ResponseBody
    public List<PotentialCustomerBean> selectCustomer(@PathVariable("name") String name) {
        System.out.println("搜索潛在顧客");
        return pcs.selectPotentialCustomer(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會
    @RequestMapping("/selectMarket/{name}")
    @ResponseBody
    public List<MarketBean> selectMarket(@PathVariable("name") String name) {
        System.out.println("搜索銷售機會");
        return ms.selectMarket(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除工作項目
    @RequestMapping("/delWork")
    @ResponseBody
    public String delMarket(@RequestParam("id") List<String> id) {
        System.out.println("*****刪除工作項目*****");
        ws.delWorkt(id);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索工作項目
    @RequestMapping("/selectWork")
    @ResponseBody
    public Map<String, Object> selectWork(@RequestParam("name") String name, @RequestParam("pag") Integer pag) {
        System.out.println("搜索工作項目");
        name = name.trim();
        pag--;
        return ws.sekectWork(name, pag);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存追蹤by工作項目
    @RequestMapping("/SaveTrackByWork/{workid}")
    @ResponseBody
    public List<TrackBean> SaveTrackByWork(TrackBean trackBean, @PathVariable("workid") String workid) {
        System.out.println("存追蹤by工作項目");
        String uuid = ZeroTools.getUUID();
        if (trackBean.getTrackid() == null || trackBean.getTrackid().isEmpty())
            trackBean.setTrackid(uuid);
// 插入Customerid
        if (trackBean.getCustomerid() == null || trackBean.getCustomerid().isEmpty()) {
            trackBean.setCustomerid(uuid);


            WorkBean wBean = ws.getById(workid);
            wBean.setTrack(uuid);
            ws.SaveWork(wBean);
        }
// 插入日期
        trackBean.setTracktime(ZeroTools.getTime(new Date()));
        TrackBean save = ms.SaveTrack(trackBean);

        return PCS.getTrackByCustomerid(save.getCustomerid());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//修改追蹤by銷售機會
    @RequestMapping("/changeTrackByMarket/{workid}")
    public String changeTrackByMarket(TrackBean trackBean, @PathVariable("workid") Integer workid) {
        System.out.println("修改追蹤by銷售機會");
        String uuid = ZeroTools.getUUID();
        if (trackBean.getTrackid() == null || trackBean.getTrackid().isEmpty())
            trackBean.setTrackid(uuid);
//插入Customerid
//if (trackBean.getCustomerid() == null || trackBean.getCustomerid().isEmpty()) {
//trackBean.setCustomerid(uuid);
//MarketBean marketBean = ms.getById(marketid);
//marketBean.setCustomerid(uuid);
//ms.save(marketBean);
//}
//插入日期
        trackBean.setTracktime(ZeroTools.getTime(new Date()));
        ms.SaveTrack(trackBean);

        return "redirect:/work/detail/" + workid;
    }
}
