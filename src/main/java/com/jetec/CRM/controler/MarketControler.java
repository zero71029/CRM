package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.ClientService;
import com.jetec.CRM.controler.service.DirectorService;
import com.jetec.CRM.controler.service.MarketService;
import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/Market")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')")
public class MarketControler {
    @Autowired
    MarketService ms;
    @Autowired
    PotentialCustomerService PCS;
    @Autowired
    ClientService cs;
    @Autowired
    AdminRepository ar;
    @Autowired
    ZeroTools zTools;
    @Autowired
    DirectorService DS;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/init/{id}")
    @ResponseBody
    public Map<String, Object> Market(@PathVariable("id") String id) {
        System.out.println("銷售機會初始化");
        Map<String, Object> result = new HashMap<>();
        MarketBean marketBean = ms.getById(id);
        result.put("existsCustomer", PCS.existsById(marketBean.getCustomerid()));
        result.put("bean", marketBean);
        result.put("changeMessageList", DS.getChangeMessage(id));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存潛在客戶
    @RequestMapping("/SavePotentialCustomer")
    @ResponseBody
    public String SavePotentialCustomer(PotentialCustomerBean pcb,HttpSession session) {
        System.out.println("*****儲存潛在客戶*****");
        AdminBean admin = (AdminBean) session.getAttribute("user");
        if(admin != null && (pcb.getCustomerid() == null ||pcb.getCustomerid().isEmpty())){
            pcb.setFounder(admin.getName());
        }
        PotentialCustomerBean bean = PCS.SavePotentialCustomer(pcb);
        return bean.getCustomerid();
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	讀取潛在客戶細節
    @RequestMapping("/potentialcustomer/{id}")
    public String potentialcustomer(Model model, @PathVariable("id") String id) {
        System.out.println("*****讀取潛在客戶細節****");
        model.addAttribute("bean", PCS.getById(id));
        return "/Market/potentialcustomer";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會列表
    @ResponseBody
    @RequestMapping("/MarketList")
    public Map<String, Object> Market(@RequestParam("pag") Integer pag, HttpSession session) {
        System.out.println("*****讀取銷售機會列表****");
        pag--;
        Map<String, Object> result = new HashMap();
        List<MarketBean> list = ms.getList(pag);
        //找到過期資料
        AdminBean user = (AdminBean) session.getAttribute("user");
        result.put("SubmitBos", ms.getSubmitBos());
        result.put("endCast", ms.getEndCast(user.getName()));
        result.put("list", list);
        result.put("todayTotal", ms.gettodayTotal());
        result.put("CallBos", ms.CallBos());
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 所有筆數
    @ResponseBody
    @RequestMapping("/total")
    public Integer total() {
        System.out.println("*****所有筆數****");
        return ms.getTotal();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索聯絡人電話
//    @ResponseBody
//    @RequestMapping("/selectContantPhone/{phone}")
//    public List<MarketBean> selectContantPhone(@PathVariable("phone") String phone) {
//        System.out.println("*****搜索聯絡人電話****");
//        phone = phone.trim();
//        phone = phone.replace("-", "");
//        phone = phone.replace("(", "");
//        phone = phone.replace(")", "");
//        phone = phone.replace(" ", "");
//        return ms.selectContantPhone(phone);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會列表(結案)
    @RequestMapping("/CloseMarket")
    public String CloseMarket(Model model) {
        model.addAttribute("list", ms.CloseMarket());
        return "/Market/MarketList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 存銷售機會
    @RequestMapping("/SaveMarket")
    public String SaveMarket(MarketBean marketBean,HttpSession session) {
        System.out.println("*****存銷售機會****");
        AdminBean admin = (AdminBean) session.getAttribute("user");
        if(admin != null && (marketBean.getMarketid() == null || marketBean.getMarketid().isEmpty())){
            marketBean.setFounder(admin.getName());
        }

        MarketBean save = ms.save(marketBean);
        return "redirect:/Market/Market/" + save.getMarketid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/Market/{id}")
    public String Market(Model model, @PathVariable("id") String id) {
        System.out.println("進入詳細");
        System.out.println(ms.getById(id));
        model.addAttribute("bean", ms.getById(id));
        return "/Market/Market";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存備註
    @RequestMapping("/SaveRemark")
    public String SaveRemark(MarketRemarkBean mrb) {
        System.out.println("存備註");
        ms.SaveRemark(mrb);
        return "redirect:/Market/Market/" + mrb.getMarketid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除銷售機會
    @RequestMapping("/delMarket")
    @ResponseBody
    public String delMarket(@RequestParam("id") List<String> id) {
        System.out.println("*****刪除銷售機會*****");
        ms.delMarket(id);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索銷售機會
    @ResponseBody
    @RequestMapping("/selectMarket")
    public List<MarketBean> selectMarket(@RequestParam("from") String startDay,@RequestParam("to") String endDay,@RequestParam("key") String key,@RequestParam("val") List<String> val) {
        System.out.println("搜索銷售機會ALL");
        if (startDay == null || startDay == "") {
//            startDay = zTools.getTime(new Date());
//            startDay = startDay.substring(0, 10);
//            startDay = startDay + " 00:00";
            startDay = "2022-02-01 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        if (endDay == "") {
            endDay = zTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        System.out.println(startDay);
        System.out.println(endDay);

        return ms.selectMarketByAll(startDay,endDay,key,val);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除備註
    @RequestMapping("/delRemark/{remarkId}/{MarketId}")
    public String delRemark(@PathVariable("remarkId") Integer remarkId, @PathVariable("MarketId") Integer MarketId) {
        System.out.println("*****刪除備註*****");
        ms.delRemark(remarkId);
        return "redirect:/Market/Market/" + MarketId;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存追蹤	
    @RequestMapping("/SaveTrack")
    public String SaveTrack(TrackBean trackBean) {
        System.out.println("存追蹤");
        if (trackBean.getTrackid() == null || trackBean.getTrackid().isEmpty())
            trackBean.setTrackid(zTools.getUUID());
        trackBean.setTracktime(zTools.getTime(new Date()));
        ms.SaveTrack(trackBean);
        return "redirect:/Market/potentialcustomer/" + trackBean.getCustomerid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除潛在客戶
    @RequestMapping("/delPotentialCustomer")
    @ResponseBody
    public String delPotentialCustomer(@RequestParam("id") List<String> id) {
        System.out.println("*****刪除潛在客戶*****");
        PCS.delPotentialCustomer(id);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 搜索潛在客戶
    @RequestMapping("/selectPotentialCustomer")
    public String selectPotentialCustomer(Model model, @RequestParam("name") String name) {
        System.out.println("搜索潛在客戶");
        model.addAttribute("list", PCS.selectPotentialCustomer(name));
        return "/Market/potentialcustomerList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//轉成報價單
    @RequestMapping("/goQuotation.action")
    public String goQuotation(MarketBean marketBean, Model model) {
        QuotationBean qBean = new QuotationBean();
        qBean.setName(marketBean.getClient());
        qBean.setPhone(marketBean.getContactphone());
        qBean.setContactname(marketBean.getContactname());
        qBean.setContactmoblie(marketBean.getContactmoblie());
        qBean.setRemark(marketBean.getMessage());
        qBean.setUser(marketBean.getUser());
        model.addAttribute("bean", qBean);
        return "/Market/Quotation";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存報價單
    @RequestMapping("/SaveQuotation")
    public String SaveQuotation(QuotationBean qBean) {
        System.out.println("存報價單");
        QuotationBean save = ms.SaveQuotation(qBean);
        return "redirect:/Market/Quotation/" + save.getQuotationid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取報價單細節
    @RequestMapping("/Quotation/{id}")
    public String Quotation(Model model, @PathVariable("id") Integer id) {
        System.out.println("*****讀取報價單細節****");

        if (id == 0) {
            model.addAttribute("bean", new QuotationBean());
        } else {
            QuotationBean qBean = ms.getQuotationById(id);
            model.addAttribute("bean", qBean);
            model.addAttribute("contact", cs.selectContactByClientName(qBean.getName()));// 讀取聯絡人by客戶
        }
//model.addAttribute("admin", ar.findAll());

        return "/Market/Quotation";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//報價單列表
    @RequestMapping("/QuotationList")
    public String QuotationList(Model model) {
        model.addAttribute("list", ms.getQuotationList());
        return "/Market/QuotationList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存合約	
    @RequestMapping("/SaveAgreement")
    public String SaveAgreement(AgreementBean aBean) {
        System.out.println("存合約");
        ms.SaveAgreement(aBean);
        return "redirect:/Market/Agreement/1";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取合約細節
    @RequestMapping("/Agreement/{id}")
    public String Agreement(Model model, @PathVariable("id") Integer id) {
        System.out.println("*****讀取合約細節****");
        if (id == 0) {
            model.addAttribute("bean", new AgreementBean());
        } else {
            model.addAttribute("bean", ms.getAgreementBeanById(id));

        }
//model.addAttribute("admin", ar.findAll());

        return "/Market/agreement";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//判斷客戶存在
    @RequestMapping("/existsClient")
    @ResponseBody
    public String existsClient(PotentialCustomerBean Bean) {
        System.out.println("*****判斷客戶存在****");
        if (!cs.existsByName(Bean.getCompany())) {
            return "不存在";
        }
        System.out.println("*****判斷聯絡人存在****");
        return "客戶已存在";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//潛在各戶轉成客戶
    @RequestMapping("/changeClient.action")
    @ResponseBody
    public String changeClient(PotentialCustomerBean Bean) {
        System.out.println("*****潛在各戶轉成客戶****");
        ClientBean clientBean = new ClientBean();
        clientBean.setName(Bean.getCompany());
        clientBean.setPhone(Bean.getPhone());
        clientBean.setIndustry(Bean.getIndustry());
        clientBean.setEmail(Bean.getEmail());
        clientBean.setFax(Bean.getFax());
//        clientBean.setRemark(Bean.getRemark());
        clientBean.setBillcity(Bean.getCity());
        clientBean.setBilltown(Bean.getTown());
        clientBean.setBillpostal(Bean.getPostal());
        clientBean.setBilladdress(Bean.getAddress());
        clientBean.setDelivercity(Bean.getCity());
        clientBean.setDelivertown(Bean.getTown());
        clientBean.setDeliverpostal(Bean.getPostal());
        clientBean.setDeliveraddress(Bean.getAddress());
        clientBean.setState(1);
        clientBean.setExtension(Bean.getExtension());
        clientBean.setSerialnumber(Bean.getSerialnumber());


        ClientBean saveBean = cs.SaveAdmin(clientBean);
        return "新增客戶";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//判斷聯絡人存在
    @RequestMapping("/existsContact")
    @ResponseBody
    public String existsContact(PotentialCustomerBean Bean, Model model) {
        System.out.println("*****判斷聯絡人存在****");
        if (cs.existsContactByName(Bean.getName(), Bean.getCompany())) {
            System.out.println("*****聯絡人已存在****");
            return "聯絡人已存在";
        } else if (!cs.existsContactByCompany(Bean.getCompany())) {
            System.out.println("*****公司不存在****");
            return "公司不存在";
        }
        System.out.println("*****不存在****");
        return "不存在";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//潛在各戶 轉 聯絡人
    @RequestMapping("/changeContact.action")
    @ResponseBody
    public String changeContact(ContactBean contactBean) {
        System.out.println("*****潛在各戶 轉 聯絡人****");
//		ContactBean contactBean = new ContactBean();
//		contactBean.setName(Bean.getName());
//		contactBean.setPhone(Bean.getPhone());
//		contactBean.setMoblie(Bean.getMoblie());
//		contactBean.setEmail(Bean.getEmail());
//		contactBean.setCompany(Bean.getCompany());
//		contactBean.setUser(Bean.getUser());
//		contactBean.setDepartment(Bean.getDepartment());
//		contactBean.setDirector(Bean.getDirector());
//		contactBean.setFax(Bean.getFax());
//		contactBean.setRemark(Bean.getRemark());
//		contactBean.setUser(Bean.getUser());
        cs.SaveContact(contactBean);
        return "新增聯絡人";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人by名稱 ajax
    @RequestMapping("/selectContactByClientName/{name}")
    @ResponseBody
    public List<ContactBean> selectContactByClientName(@PathVariable("name") String name) {

        return cs.selectContactByClientName(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//潛在各戶轉工作項目
    @RequestMapping("/changeWork")
    public String changeWork(Model model, PotentialCustomerBean potentialCustomerBean) {
        System.out.println("潛在各戶轉工作項目");
        WorkBean bean = new WorkBean();
        bean.setCustomerid(potentialCustomerBean.getCustomerid());
        bean.setTrack(potentialCustomerBean.getCustomerid());
        bean.setCustomername(potentialCustomerBean.getCompany());
        model.addAttribute("bean", bean);
        return "/Market/work";
    }

    // 銷售機會 轉工作項目
    @RequestMapping("/MarketChangeWork")
    public String changeWork(Model model, MarketBean mBean) {
        System.out.println("銷售機 轉工作項目");
        WorkBean bean = new WorkBean();
        bean.setTrack(mBean.getCustomerid());
        bean.setMarketid(mBean.getMarketid());
        bean.setMarketname(mBean.getName());

        model.addAttribute("bean", bean);
        return "/Market/work";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//潛在各戶轉銷售機會
    @RequestMapping("/changeMarket")
    public String changeMarket(Model model, PotentialCustomerBean pBean) {
        System.out.println("潛在各戶轉銷售機會");
        model.addAttribute("changeMarket", "changeMarket");
        model.addAttribute("changeid", pBean.getCustomerid());
        return "/Market/Market";
    }

    @RequestMapping("/getchange/{id}")
    @ResponseBody
    public Map<String, Object> getchange(@PathVariable("id") String id) {
        System.out.println("潛在各戶轉銷售機會");
        PotentialCustomerBean pBean = PCS.getById(id);
        MarketBean bean = new MarketBean();
        ClientBean clientBean = cs.getCompanyByName(pBean.getCompany());
        bean.setClient(pBean.getCompany());
        bean.setPhone(pBean.getPhone());
        bean.setUser(pBean.getUser());
        bean.setMessage(pBean.getRemark());
        bean.setContactname(pBean.getName());
        bean.setContactphone(pBean.getPhone());
        bean.setContactmoblie(pBean.getMoblie());
        bean.setContactemail(pBean.getEmail());
        bean.setType(pBean.getIndustry());
        bean.setSource(pBean.getSource());
        bean.setImportant(pBean.getImportant());
        bean.setLine(pBean.getLine());
        bean.setCustomerid(pBean.getCustomerid());
        bean.setExtension(pBean.getExtension());
        bean.setContactextension(pBean.getExtension());
        bean.setStage("尚未處理");
        bean.setClientid(clientBean.getClientid());
        bean.setContactmethod(pBean.getCompanynum());
        bean.setSerialnumber(pBean.getSerialnumber());
        bean.setJobtitle(pBean.getJobtitle());
        bean.setClinch(3);
        bean.setFax((pBean.getFax()));
        bean.setCreatetime("轉賣/自用");
        //設定結束日期
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) +7);
        bean.setEndtime(sdf.format(calendar.getTime()));
        bean.setFileforeignid(pBean.getFileforeignid());
        bean.setMarketfilelist(pBean.getMarketfilelist());
        bean.setContacttitle(pBean.getContacttitle());




        Map<String, Object> result = new HashMap<>();
        result.put("bean", bean);
        result.put("changeMessageList", DS.getChangeMessage(id));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by負則人
    @ResponseBody
    @RequestMapping("/selectMarket/{name}")
    public List<MarketBean> selectName(@PathVariable("name") String name) {
        System.out.println("搜索銷售機會AAA");
        return ms.selectMarketByUser(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by日期
    @RequestMapping("/selectDate")
    @ResponseBody
    public List<MarketBean> selectDate(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("搜索銷售機會 日期");
        if (startDay == null || startDay == "") {
//            startDay = zTools.getTime(new Date());
//            startDay = startDay.substring(0, 10);
//            startDay = startDay + " 00:00";
            startDay = "2022-02-01 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        if (endDay == "") {
            endDay = zTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        System.out.println(startDay);
        System.out.println(endDay);
        return ms.selectDate(startDay, endDay);

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////搜索銷售機會by狀態
//    @RequestMapping("/selectStage/{name}")
//    @ResponseBody
//    public List<MarketBean> selectStage(@PathVariable("name") String name) {
//        System.out.println("搜索銷售機會");
//        return ms.selectStage(name);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////搜索銷售機會by產品類別
//    @RequestMapping("/selectProductType")
//    @ResponseBody
//    public List<MarketBean> selectProductType(@RequestBody List<String> data) {
//        System.out.println("搜索銷售機會by產品類別");
//        System.out.println(data);
//        return ms.selectProductType(data);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by產業
//    @RequestMapping("/selectIndustry")
//    @ResponseBody
//    public List<MarketBean> selectIndustry(@RequestBody List<String> data) {
//        System.out.println("搜索銷售機會by產業");
//        System.out.println(data);
//        return ms.selectIndustry(data);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by來源
//    @RequestMapping("/selectSource")
//    @ResponseBody
//    public List<MarketBean> selectSource(@RequestBody List<String> data) {
//        System.out.println("搜索銷售機會by來源");
//        System.out.println(data);
//        return ms.selectProductType(data);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by成交機率
    @RequestMapping("/selectClinch/{Clinch}")
    @ResponseBody
    public List<MarketBean> selectClinch(@PathVariable("Clinch") String Clinch) {
        System.out.println("搜索銷售機會by成交機率");
        return ms.selectClinch(Clinch);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by預算
    @RequestMapping("/selectBudget/{start}/{to}")
    @ResponseBody
    public List<MarketBean> selectBudget(@PathVariable("start") String start, @PathVariable("to") String to) {
        System.out.println("搜索銷售機會by預算");
        System.out.println(start);
        System.out.println(to);
        return ms.selectBudget(start, to);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存追蹤by銷售機會
    @RequestMapping("/SaveTrackByMarket/{marketid}")
    @ResponseBody
    public List<TrackBean> SaveTrackByMarket(TrackBean trackBean, @PathVariable("marketid") String marketid) {
        System.out.println("存追蹤by銷售機會");
        String uuid = zTools.getUUID();
        if (trackBean.getTrackid() == null || trackBean.getTrackid().isEmpty())
            trackBean.setTrackid(uuid);
        // 插入Customerid
        if (trackBean.getCustomerid() == null || trackBean.getCustomerid().isEmpty()) {
            trackBean.setCustomerid(uuid);
            MarketBean marketBean = ms.getById(marketid);
            marketBean.setCustomerid(uuid);
            ms.save(marketBean);
        }
        // 插入日期
        trackBean.setTracktime(zTools.getTime(new Date()));
        TrackBean save = ms.SaveTrack(trackBean);

        return PCS.getTrackByCustomerid(save.getCustomerid());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//修改追蹤by銷售機會
    @RequestMapping("/changeTrackByMarket/{marketid}")
    public String changeTrackByMarket(TrackBean trackBean, @PathVariable("marketid") String marketid) {
        System.out.println("修改追蹤by銷售機會");
        String uuid = zTools.getUUID();
        if (trackBean.getTrackid() == null || trackBean.getTrackid().isEmpty())
            trackBean.setTrackid(uuid);
//插入Customerid
//		if (trackBean.getCustomerid() == null || trackBean.getCustomerid().isEmpty()) {
//			trackBean.setCustomerid(uuid);
//			MarketBean marketBean = ms.getById(marketid);
//			marketBean.setCustomerid(uuid);
//			ms.save(marketBean);
//		}
//插入日期
        trackBean.setTracktime(zTools.getTime(new Date()));
        ms.SaveTrack(trackBean);

        return "redirect:/Market/Market/" + marketid;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //點擊數
    @RequestMapping("/clicks/{id}")
    @ResponseBody
    public String clicks(Model model, @PathVariable("id") String id) {
        System.out.println("點擊數");
        MarketBean mBean = ms.getById(id);
        Integer clicks = mBean.getClicks();
        if (clicks == null) clicks = 0;
        clicks++;
        mBean.setClicks(clicks);
        ms.save(mBean);
        return "嘿嘿";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //檢查有無銷售機會
    @RequestMapping("/existMarket/{customerid}")
    @ResponseBody
    public boolean existMarket(@PathVariable("customerid") String customerid) {
        System.out.println("檢查有無銷售機會");
        return ms.existMarket(customerid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //通知主管延長
    @RequestMapping("/callBos/{marketid}")
    @ResponseBody
    public String callBos(@PathVariable("marketid") String marketid) {
        System.out.println("通知主管延長");
        MarketBean mbean = ms.getById(marketid);
        if (mbean.getCallbos() == null || !mbean.getCallbos().equals("1")) {
            mbean.setCallbos("1");
            ms.save(mbean);
            return "通知主管";
        } else {
            mbean.setCallbos("0");
            ms.save(mbean);
            return "取消通知";
        }
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //求助
    @RequestMapping("/CallHelp/{marketid}")
    @ResponseBody
    public String CallHelp(@PathVariable("marketid") String marketid) {
        System.out.println("求助");
        MarketBean mbean = ms.getById(marketid);
        if (mbean.getCallhelp() == null || !mbean.getCallhelp().equals("1")) {
            mbean.setCallhelp("1");
            ms.save(mbean);
            return "求助";
        } else {
            mbean.setCallhelp("0");
            ms.save(mbean);
            return "取消";
        }
    }

}
