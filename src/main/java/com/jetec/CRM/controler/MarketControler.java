package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.*;
import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.AdminRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/Market")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')OR hasAuthority('國貿')")
public class MarketControler {
    Logger logger = LoggerFactory.getLogger("MarketControler");
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
    @Autowired
    SystemService ss;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/init/{id}")
    @ResponseBody
    public ResultBean Market(@PathVariable("id") String id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 讀取銷售機會 {}", adminBean.getName(), id);
        Map<String, Object> result = new HashMap<>();
        MarketBean marketBean = ms.getById(id);
        marketBean.setOpentime(LocalDateTime.now().toString());
        result.put("existsCustomer", PCS.existsById(marketBean.getCustomerid()));//判斷潛在客戶存在
        result.put("bean", marketBean);
        result.put("changeMessageList", DS.getChangeMessage(id));//讀取主管留言
        return ZeroFactory.success("銷售機會", result);
    }

    //儲存潛在客戶
    @RequestMapping("/SavePotentialCustomer")
    @ResponseBody
    public Map<String, Object> SavePotentialCustomer(PotentialCustomerBean pcb, HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 儲存潛在客戶 {}", adminBean.getName(), pcb.getCustomerid());
        Map<String, Object> result = new HashMap<>();
        AdminBean admin = (AdminBean) session.getAttribute("user");
        //判斷是否是新案件
        if (pcb.getCustomerid() == null || pcb.getCustomerid().isEmpty()) {
            pcb.setFounder(admin.getName());//插入創建人
        } else if (PCS.existsById(pcb.getCustomerid())) {
            //避免同時開同一頁面
            PotentialCustomerBean oldBean = PCS.getById(pcb.getCustomerid());
            if (oldBean.getBbb() != null) {
                if (oldBean.getBbb().compareTo(pcb.getOpentime()) > 0) {
                    result.put("state", false);
                    result.put("mess", "錯誤,資料已被其他人更新,不能儲存");
                    logger.info("錯誤,資料已被其他人更新,不能儲存");
                    return result;
                }
            }
        }
        pcb.setBbb(LocalDateTime.now().toString());
        PotentialCustomerBean save = PCS.SavePotentialCustomer(pcb);
        logger.info("儲存{}", save);
        result.put("state", true);
        result.put("mess", "儲存成功");
        result.put("id", save.getCustomerid());
        return result;
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	進入潛在客戶細節
    @RequestMapping("/potentialcustomer/{id}")
    public String potentialcustomer(Model model, @PathVariable("id") String id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 進入潛在客戶細節 {} ", adminBean.getName(), id);
        //
        PotentialCustomerBean bean = PCS.getById(id);
        if (bean == null) {
            model.addAttribute("message", "此id找不到資料");
            return "/error/500";
        }
        //判斷有沒有轉過銷售機會
        MarketBean mBean = ms.findByCustomerid(id);
        if (mBean != null) {
            model.addAttribute("marketid", mBean.getMarketid());
            System.out.println(mBean.getMarketid());
        }
        //添加開啟時間
        bean.setOpentime(LocalDateTime.now().toString());
        model.addAttribute("bean", bean);
        return "/Market/potentialcustomer";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會列表
    @ResponseBody
    @RequestMapping("/MarketList")
    public Map<String, Object> MarketList(@RequestParam("pag") Integer pag, @RequestParam("pageSize") Integer size, HttpSession session) {
        System.out.println("*****讀取銷售機會列表****");
        pag--;
        Map<String, Object> result = new HashMap<>();
        AdminBean aBean = (AdminBean) session.getAttribute("user");
        List<MarketStateBean> stateList = ms.getMarketStateList(aBean.getAdminid());
        List<MarketBean> list;
        //判斷有沒有設定狀態
        if (stateList.size() > 0) {
            result = ms.getStateList(stateList, pag, size);
        } else {
            list = ms.getList(pag, size);
            result.put("list", list);
            result.put("total", ms.getTotal());
        }
        //輸出
        result.put("potential", PCS.getPotentialSubmitBos());//提交主管
        result.put("SubmitBos", ms.getSubmitBos());
        result.put("endCast", ms.getEndCast(aBean.getName()));//讀取過期任務
        result.put("todayTotal", ms.gettodayTotal());//今天新增案件數量
        result.put("CallBos", ms.CallBos());// 搜索銷售機會by延長申請
        result.put("marketstate", ms.getMarketStateList(aBean.getAdminid()));//getM使用者狀態列表
        result.put("pcc", ms.getMarketByStageAndUser("潛在客戶轉", aBean.getName()));
        result.put("markeCreateTime", ms.getCreatetimeAndEndtime("轉賣"));//轉賣今天到期
        return result;
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
    @ResponseBody
    public Map<String, Object> SaveMarket(MarketBean marketBean, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        AdminBean admin = (AdminBean) session.getAttribute("user");
        logger.info("{} 存銷售機會", admin.getName());
        logger.info("{}", marketBean);
        if (marketBean.getMarketid() == null || marketBean.getMarketid().isEmpty()) {
            marketBean.setFounder(admin.getName());
        } else if (ms.existMarketById(marketBean.getMarketid())) {
            //避免同時開同一頁面
            MarketBean oldBean = ms.getById(marketBean.getMarketid());
            if (oldBean.getBbb() != null) {
                if (oldBean.getBbb().compareTo(marketBean.getOpentime()) > 0) {
                    result.put("state", false);
                    result.put("mess", "錯誤,資料已被其他人更新,不能儲存");
                    logger.info("錯誤,資料已被其他人更新,不能儲存");
                    return result;
                }
            }
        }
        MarketBean save = ms.save(marketBean);
        result.put("state", true);
        result.put("id", save.getMarketid());
        result.put("mess", "儲存成功");
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/Market/{id}")
    public String inMarket(Model model, @PathVariable("id") String id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        System.out.println("進入銷售機會詳細");
        logger.info("{}  進入銷售機會詳細 {}", adminBean.getName(), id);
        MarketBean mBean = ms.getById(id);
        if (mBean == null) {
            model.addAttribute("message", "此id找不到資料");
            return "/error/500";
        }
        mBean.setOpentime(LocalDateTime.now().toString());
        model.addAttribute("bean", mBean);
        return "/Market/Market";
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
    public List<MarketBean> selectMarket(@RequestParam("from") String startDay, @RequestParam("to") String endDay, @RequestParam("key") String key, @RequestParam("val") List<String> val) {
        logger.info("搜索銷售機會ALL {} :{}", key, val);
        if (startDay == null || startDay.equals("")) {
//            startDay = zTools.getTime(new Date());
//            startDay = startDay.substring(0, 10);
//            startDay = startDay + " 00:00";
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
        return ms.selectMarketByAll(startDay, endDay, key, val);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除備註
//    @RequestMapping("/delRemark/{remarkId}/{MarketId}")
//    public String delRemark(@PathVariable("remarkId") Integer remarkId, @PathVariable("MarketId") Integer MarketId) {
//        System.out.println("*****刪除備註*****");
//        ms.delRemark(remarkId);
//        return "redirect:/Market/Market/" + MarketId;
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存追蹤by 淺在顧客
    @RequestMapping("/SaveTrack")
    public String SaveTrack(TrackBean trackBean) {
        logger.info("存追蹤 {}", trackBean.getCustomerid());
        logger.info(trackBean.getTrackdescribe());
        logger.info(trackBean.getResult());
        if (trackBean.getTrackid() == null || trackBean.getTrackid().isEmpty()) {
            trackBean.setTrackid(ZeroTools.getUUID());
        }
        trackBean.setTracktime(ZeroTools.getTime(new Date()));
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
    public String changeClient(PotentialCustomerBean Bean, HttpServletRequest req) {
        logger.info("潛在各戶轉成客戶 Customerid:{}", Bean.getCustomerid());
        logger.info("admin : {}", ZeroTools.getAdmin().getName());
        ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), Bean.getCustomerid(), ZeroTools.getAdmin().getName(), "行動", "", "潛在各戶轉成客戶", ZeroTools.getTime(new Date()));
        ss.saveChangeMesssage(cmBean);

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
        clientBean.setAaa(LocalDate.now().toString());
        cs.SaveAdmin(clientBean);
        new Thread(() -> {
            ServletContext sce = req.getServletContext();
            sce.setAttribute("client", cs.getList());
        }).start();
        return "新增客戶";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//判斷聯絡人存在
    @RequestMapping("/existsContact")
    @ResponseBody
    public ResultBean existsContact(PotentialCustomerBean Bean) {
        System.out.println("*****判斷聯絡人存在****");
        if (cs.existsContactByName(Bean.getName(), Bean.getCompany())) {
            System.out.println("*****聯絡人已存在****");
            ContactBean c = cs.getContactByNameAndCompany(Bean.getName(), Bean.getCompany());
            return ZeroFactory.success("聯絡人已存在", c.getContactid());

        } else if (!cs.existsContactByCompany(Bean.getCompany())) {
            System.out.println("*****公司不存在****");
            return ZeroFactory.fail("公司不存在");

        }
        System.out.println("*****不存在****");
        return ZeroFactory.fail("不存在");

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//潛在各戶 轉 聯絡人
    @RequestMapping("/changeContact.action")
    @ResponseBody
    public ResultBean changeContact(ContactBean contactBean, @RequestParam("customerid") String customerid) {
        logger.info("潛在各戶轉聯絡人 Customerid:{}", customerid);
        logger.info("admin : {}", ZeroTools.getAdmin().getName());
        ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), customerid, ZeroTools.getAdmin().getName(), "行動", "", "潛在各戶轉聯絡人", ZeroTools.getTime(new Date()));
        ss.saveChangeMesssage(cmBean);
        contactBean.setRemark("");
        ContactBean save = cs.SaveContact(contactBean);
        PotentialCustomerBean pcBean = PCS.getById(customerid);
        if (pcBean != null) {
            pcBean.setContactid(save.getContactid());
            PCS.SavePotentialCustomer(pcBean);
        }
        return ZeroFactory.success("新增聯絡人", save.getContactid());
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
        logger.info("潛在各戶轉銷售機會 Customerid:{}", pBean.getCustomerid());
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            AdminBean adminBean = (AdminBean) authentication.getPrincipal();
            logger.info("admin : {}", adminBean.getName());
            ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), pBean.getCustomerid(), adminBean.getName(), "行動", "", "轉銷售機會", ZeroTools.getTime(new Date()));
            ss.saveChangeMesssage(cmBean);
        } catch (Exception e) {
            logger.info("未登入 或 潛在各戶轉銷售機會發生錯誤錯誤");
        }
        model.addAttribute("changeMarket", "changeMarket");
        model.addAttribute("changeid", pBean.getCustomerid());
        return "/Market/Market";
    }

    @RequestMapping("/getchange/{id}")
    @ResponseBody
    public ResultBean getchange(@PathVariable("id") String id) {
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
        bean.setStage("潛在客戶轉");
        bean.setClientid(clientBean.getClientid());
        bean.setContactmethod(pBean.getCompanynum());
        bean.setSerialnumber(pBean.getSerialnumber());
        bean.setJobtitle(pBean.getJobtitle());
        bean.setClinch(3);
        bean.setFax((pBean.getFax()));
        bean.setCreatetime("");
        //設定結束日期
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) + 7);
        bean.setEndtime(sdf.format(calendar.getTime()));
        bean.setFileforeignid(pBean.getFileforeignid());
        bean.setMarketfilelist(pBean.getMarketfilelist());
        bean.setContacttitle(pBean.getContacttitle());
        bean.setOthersource(pBean.getOthersource());
        bean.setOpentime(LocalDateTime.now().toString());
        bean.setAaa(pBean.getAaa());
        bean.setQuote("");
        bean.setReceivestate(pBean.getReceivestate());
        bean.setReceive(pBean.getReceive());
        bean.setContactid(pBean.getContactid());

        Map<String, Object> result = new HashMap<>();
        result.put("bean", bean);
        result.put("changeMessageList", DS.getChangeMessage(id));
        return ZeroFactory.success("潛在各戶轉銷售機會", result);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by負則人
    @ResponseBody
    @RequestMapping("/selectMarket/{name}")
    public List<MarketBean> selectName(@PathVariable("name") String name) {
        logger.info("{} 負則人列表", name);
        return ms.selectMarketByUser(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by日期
    @RequestMapping("/selectDate")
    @ResponseBody
    public List<MarketBean> selectDate(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("搜索銷售機會 日期");
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
//    @RequestMapping("/selectClinch/{Clinch}")
//    @ResponseBody
//    public List<MarketBean> selectClinch(@PathVariable("Clinch") String Clinch) {
//        System.out.println("搜索銷售機會by成交機率");
//        return ms.selectClinch(Clinch);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by預算
//    @RequestMapping("/selectBudget/{start}/{to}")
//    @ResponseBody
//    public List<MarketBean> selectBudget(@PathVariable("start") String start, @PathVariable("to") String to) {
//        System.out.println("搜索銷售機會by預算");
//        System.out.println(start);
//        System.out.println(to);
//        return ms.selectBudget(start, to);
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存追蹤by銷售機會
    @RequestMapping("/SaveTrackByMarket/{marketid}")
    @ResponseBody
    public List<TrackBean> SaveTrackByMarket(TrackBean trackBean, @PathVariable("marketid") String marketid) {
        System.out.println("存追蹤by銷售機會");
        logger.info("存追蹤by銷售機會 {}", trackBean.getCustomerid());
        logger.info(trackBean.getTrackdescribe());
        logger.info(trackBean.getResult());
        String uuid = ZeroTools.getUUID();
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
        trackBean.setTracktime(ZeroTools.getTime(new Date()));
        TrackBean save = ms.SaveTrack(trackBean);

        return PCS.getTrackByCustomerid(save.getCustomerid());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//修改追蹤by銷售機會
    @RequestMapping("/changeTrackByMarket/{marketid}")
    public String changeTrackByMarket(TrackBean trackBean, @PathVariable("marketid") String marketid) {
        System.out.println("修改追蹤by銷售機會");
        String uuid = ZeroTools.getUUID();
        if (trackBean.getTrackid() == null || trackBean.getTrackid().isEmpty())
            trackBean.setTrackid(uuid);

//插入日期
        trackBean.setTracktime(ZeroTools.getTime(new Date()));
        ms.SaveTrack(trackBean);

        return "redirect:/Market/Market/" + marketid;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //點擊數
    @RequestMapping("/clicks/{id}")
    @ResponseBody
    public String clicks(@PathVariable("id") String id) {
        logger.info("增加點擊數 {}", id);
        MarketBean mBean = ms.getById(id);
        Integer clicks = mBean.getClicks();
        if (clicks == null) clicks = 0;
        clicks++;
        mBean.setClicks(clicks);

        ms.save(mBean);
        return "增加成功";
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

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //切換使用者狀態
    @RequestMapping("/AddState/{filed}/{state}/{type}")
    @ResponseBody
    public List<MarketStateBean> AddState(@PathVariable("filed") String field, @PathVariable("state") String state, HttpSession session, @PathVariable("type") String type) {

        if (type.equals("user")) type = "";
        AdminBean aBean = (AdminBean) session.getAttribute("user");
        logger.info("{} 切換使用者狀態", aBean.getName());
        //如果有相同資料 就不處裡
        if (ms.existMarketState(aBean.getAdminid(), field, state)) {
            ms.delMarketState(aBean.getAdminid(), field, state);
            return ms.getMarketStateList(aBean.getAdminid());
        }

        //如果沒資料 就處裡
        //
        if (field.equals("day")) {
            if (ms.existMarketStateByState(aBean.getAdminid(), "day")) {
                MarketStateBean marketStateBean = ms.getMarketField(aBean.getAdminid(), "day");
                marketStateBean.setState(state);
                ms.sevaMarketStateBean(marketStateBean);
            } else {
                ms.saveMarketState(aBean.getAdminid(), field, state, type);
            }
        } else {
            ms.saveMarketState(aBean.getAdminid(), field, state, type);
        }

        List<MarketStateBean> stateList = ms.getMarketStateList(aBean.getAdminid());
        logger.info("{}", stateList);
        return stateList;

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //刪除使用者狀態
    @RequestMapping("/delState/{marketstateid}")
    @ResponseBody
    public List<MarketStateBean> DelState(@PathVariable("marketstateid") String marketstateid, HttpSession session) {
        ms.delState(marketstateid);
        AdminBean aBean = (AdminBean) session.getAttribute("user");
        logger.info("{} 刪除使用者狀態 {}", aBean.getName(), marketstateid);
        return ms.getMarketStateList(aBean.getAdminid());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //刪除所有狀態
    @RequestMapping("/delAllState/{adminid}")
    @ResponseBody
    public boolean delAllState(@PathVariable("adminid") Integer adminid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 刪除所有狀態", adminBean.getName());
        ms.delAllState(adminid);
        return true;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //失去焦點,自動儲存
    @RequestMapping("/blur")
    @ResponseBody
    @Deprecated
    public boolean blur(@RequestParam("marketid") String marketid, @RequestParam("field") String field, @RequestParam("val") String val, HttpSession session) {
        logger.info("失去焦點,自動儲存");
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/crm", "root", "root");
            stmt = conn.createStatement();
            AdminBean adminBean = (AdminBean) session.getAttribute("user");
            //存修改
//            MarketBean marketBean = ms.getById(marketid);
//            System.out.println(marketBean.get(field));
            String sql1 = "select " + field + " from market where marketid = '" + marketid + "'";
            rs = stmt.executeQuery(sql1);
            rs.next();

            ChangeMessageBean cmbean;
            if ("cost".equals(field)) {
                cmbean = new ChangeMessageBean(ZeroTools.getUUID(), marketid, adminBean.getName(), field, String.valueOf(rs.getInt(1)), val, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

                if (String.valueOf(rs.getInt(1)).equals(val)) {

                } else {
                    ss.saveChangeMesssage(cmbean);
                }
            } else {
                cmbean = new ChangeMessageBean(ZeroTools.getUUID(), marketid, adminBean.getName(), field, rs.getString(1), val, ZeroTools.getTime(new Date()));
                cmbean.setName(adminBean.getName());

                if (!(rs.getString(1) == null)) {

                    if (rs.getString(1).equals(val)) {

                    } else {
                        ss.saveChangeMesssage(cmbean);
                    }
                }
            }
            //updata
//        ms.updata(marketid,field,val);
            String sql = "update market set " + field + " = '" + val + "' where marketid ='" + marketid + "'";
            System.out.println(sql);
            stmt.executeUpdate(sql);


            sql = "update market set  bbb = '" + ZeroTools.getTime(new Date()) + "' where marketid ='" + marketid + "'";
            System.out.println(sql);
            stmt.executeUpdate(sql);


        } catch (Exception e) {
            e.printStackTrace();
        }

        //先建立後釋放，後建立先釋放
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {

        }


        return true;
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //手動 轉賣過期 自動結案
    @RequestMapping("/XXX")
    @ResponseBody
    public String AutoCloseCase() {
        logger.info("手動 轉賣過期 自動結案");
        ms.AutoCloseCase("轉賣/自用");
        ms.AutoCloseCase("轉賣");
        return "自動結案 成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //讀取 自動結案
    @RequestMapping("/getAutoClose")
    @ResponseBody
    public Map<String, Object> getAutoClose() {
        logger.info("讀取 自動結案");
        return ms.getAutoClose();
    }


    //領取任務
    @RequestMapping("/getReceive/{marketid}")
    @ResponseBody
    public ResultBean getReceive(HttpSession session, @PathVariable("marketid") String marketid, MarketBean inBean) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();

        logger.info("{} 領取任務 {}", adminBean.getName(), marketid);
        MarketBean mBean = ms.getById(marketid);
        if (mBean != null) {
            AdminBean aBean = (AdminBean) session.getAttribute("user");
            //判斷 樂觀鎖
            if (mBean.getBbb() != null) {
                if (mBean.getBbb().compareTo(inBean.getOpentime()) > 0) {
                    return ZeroFactory.fail("錯誤,資料已被其他人更新,不能儲存");
                }
            }
            //判斷領取 或 取消
            if (mBean.getReceive() == null || mBean.getReceive().isEmpty() || !Objects.equals(aBean.getName(), mBean.getUser())) {
                ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), mBean.getMarketid(), aBean.getName(), "領取任務", mBean.getReceive(), aBean.getName(), LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                ss.saveChangeMesssage(cmBean);
                cmBean = new ChangeMessageBean(ZeroTools.getUUID(), mBean.getMarketid(), aBean.getName(), "負責人", mBean.getUser(), aBean.getName(), LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                ss.saveChangeMesssage(cmBean);
                mBean.setReceive(aBean.getName());
                mBean.setUser(aBean.getName());
                mBean.setReceivestate(1);
                ms.save(mBean);
                logger.info("{} 領取成功 {}", adminBean.getName(), marketid);
                return ZeroFactory.success("領取成功");
            }
            ChangeMessageBean cmBean = new ChangeMessageBean(ZeroTools.getUUID(), mBean.getMarketid(), aBean.getName(), "領取任務", aBean.getName(), "null", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            ss.saveChangeMesssage(cmBean);
            cmBean = new ChangeMessageBean(ZeroTools.getUUID(), mBean.getMarketid(), aBean.getName(), "負責人", aBean.getName(), "null", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            ss.saveChangeMesssage(cmBean);
            mBean.setReceive(null);
            mBean.setUser(null);
            mBean.setReceivestate(3);
            ms.save(mBean);
            logger.info("{} 取消成功 {}", adminBean.getName(), marketid);
            return ZeroFactory.success("取消成功");
        }
        return ZeroFactory.fail("請先建立任務");
    }


    //客戶列表
    @RequestMapping("/selectContactByClientName/{name}")
    @ResponseBody
    public ResultBean selectContactByClientName(@PathVariable("name") String name) {
        logger.info("讀取客戶列表 {}", name);
        return ZeroFactory.success("聯絡人列表", cs.selectContactByClientName(name));
    }

    //銷售機會中 新增聯絡人
    @RequestMapping("/newContact/{clientid}")
    public String newContact(@PathVariable("clientid") Integer clientid, Model model) {
        logger.info("銷售機會中 新增聯絡人  clientid:{}", clientid);
        //沒找到公司
        if (!cs.existsByid(clientid)) {
            System.out.println("沒找到公司");
            return null;
        }
        ClientBean cBean = cs.getById(clientid);
        ContactBean contactBean = new ContactBean();
        //找到公司
        contactBean.setPhone(cBean.getPhone());
        contactBean.setExtension(cBean.getExtension());
        contactBean.setClientid(cBean.getClientid());
        contactBean.setFax(cBean.getFax());
        contactBean.setCompany(cBean.getName());
        contactBean.setClient(cBean);


        model.addAttribute("bean",contactBean);
        System.out.println("找到公司");
        return "/client/contact";

    }

}
