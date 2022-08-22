package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.controler.service.ClientService;
import com.jetec.CRM.model.*;
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
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/CRM")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('國貿')")
public class CustomerControler {
    @Autowired
    ClientService cs;

    Logger logger = LoggerFactory.getLogger("CustomerControler");

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//客戶列表初始化
    @RequestMapping("/init")
    @ResponseBody
    public ResultBean init(@RequestParam("pag") Integer pag) {
        System.out.println("*****客戶列表初始化*****");
        pag--;
        if (pag < 0) pag = 0;

        return ZeroFactory.success("客戶列表", cs.init(pag));
//        return cs.init(pag);

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存客戶
    @RequestMapping("/SaveClient")
    public String SaveClient(ClientBean clientBean, HttpServletRequest req,Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        //新案件
        if (clientBean.getClientid() == null) {
            clientBean.setAaa(LocalDate.now().toString());
            clientBean.setState(1);
            //名稱檢查
            if(cs.existsByName(clientBean.getName())){
                model.addAttribute("message","名稱重複");
                return "error/500";
            }
        }
        logger.info("{} 儲存客戶 {}", adminBean.getName(), clientBean.getClientid());
        ClientBean save = cs.SaveAdmin(clientBean);
        //更新applient客戶列表
        new Thread(() -> {
            ServletContext sce = req.getServletContext();
            sce.setAttribute("client", cs.getList());
            logger.info("更新applient客戶列表");
        }).start();
        //
        List<MarketBean> marketList = cs.getMarketListByClientid(clientBean.getClientid());
        for (MarketBean marketBean : marketList) {
            marketBean.setClient(clientBean.getName());
            if (clientBean.getSerialnumber() == null || clientBean.getSerialnumber().equals("")) {
                System.out.println("沒有編號");
            } else {
                marketBean.setSerialnumber(clientBean.getSerialnumber());
            }
            cs.saveMarket(marketBean);
        }
        return "redirect:/CRM/client/" + save.getClientid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表
//    @RequestMapping("/ClientList")
//    public String clientList(Model model) {
//        System.out.println("*****讀取客戶列表*****");
//        model.addAttribute("list", cs.getList());
//        return "/client/clientList";
//    }

    @RequestMapping("/getclientList")
    @ResponseBody
    public List<ClientBean> getclientList() {
        System.out.println("*****讀取客戶列表*****");
        return cs.getList();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶細節
    @RequestMapping("/client/{id}")
    public String client(Model model, @PathVariable("id") Integer id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 讀取客戶細節 {}", adminBean.getName(), id);
        if (id == 0) {
            model.addAttribute("bean", new ClientBean());
            model.addAttribute("market", new MarketBean());
            model.addAttribute("quotation", new QuotationBean());
        } else {
            ClientBean cb = cs.getById(id);
            model.addAttribute("bean", cb);// 讀取客戶細節
            model.addAttribute("market", cs.getMarketListByClient(cb.getName()));// 讀取銷售機會by公司
            model.addAttribute("quotation", cs.getQuotationByClient(cb.getName()));// 讀取報價單by公司
        }
        return "/client/client";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索客戶
    @ResponseBody
    @RequestMapping("/selectclientResponseBody/{name}")
    public ResultBean selectclientResponseBody(@PathVariable("name") String name) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 搜索客戶 {}", adminBean.getName(), name);
        name = name.trim();
        return ZeroFactory.success("搜索客戶", cs.selectclient(name));
    }

//    @RequestMapping("/selectclient")
//    public String selectclient(Model model, @RequestParam("name") String name) {
//        System.out.println("搜索客戶");
//        name = name.trim();
//        model.addAttribute("list", cs.selectclient(name));
//        return "/client/clientList";
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除客戶
    @RequestMapping("/delClient")
    @ResponseBody
    public ResultBean delClient(@RequestParam("id") List<Integer> id) {
        logger.info("刪除客戶 {}", id);
        cs.delClient(id);
        return ZeroFactory.success("刪除成功");

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人by公司 ajax
    @RequestMapping("/selectContactByClientName/{name}")
    @ResponseBody
    public List<ContactBean> selectContactByClientName(@PathVariable("name") String name) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 讀取聯絡人by公司 {}", adminBean.getName(), name);
        return cs.selectContactByClientName(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存聯絡人
    @RequestMapping("/SaveContact")
    public String SaveContact(ContactBean contactBean) {
        logger.info("儲存聯絡人 ");
        logger.info("{}", contactBean);
        cs.SaveContact(contactBean);
        return "redirect:/client/contactList.jsp";
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人細節
    @RequestMapping("/contact/{id}")
    public String contact(Model model, @PathVariable("id") Integer id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 讀取聯絡人細節 {}", adminBean.getName(), id);
        if (id == 0) {
            model.addAttribute("bean", new ContactBean());
        } else {
            model.addAttribute("bean", cs.getContactById(id));
        }
        return "/client/contact";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除聯絡人
    @RequestMapping("/delcontact")
    @ResponseBody
    public String delcontact(@RequestParam("id") List<Integer> id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 刪除聯絡人 {}", adminBean.getName(), id);
        cs.delMarket(id);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    // 搜索聯絡人
//    @RequestMapping("/selectContact")
//    public String sselectContact(Model model, @RequestParam("name") String name) {
//        System.out.println("搜索聯絡人");
//        name = name.trim();
//        model.addAttribute("list", cs.selectContact(name));
//        return "/client/contactList";
//    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//客戶轉換聯絡人
    @RequestMapping("/changeContact")
    public String changeContact(Model model, ClientBean clientBean) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 將客戶轉成聯絡人 {}", adminBean.getName(), clientBean.getName());

        ContactBean contactBean = new ContactBean();
        contactBean.setCompany(clientBean.getName());
        contactBean.setEmail(clientBean.getEmail());
        contactBean.setPhone(clientBean.getPhone());
        contactBean.setCity(clientBean.getBillcity());
        contactBean.setTown(clientBean.getBilltown());
        contactBean.setPostal(clientBean.getBillpostal());
        contactBean.setAddress(clientBean.getBilladdress());
        contactBean.setFax(clientBean.getFax());
        contactBean.setRemark(clientBean.getRemark());
        contactBean.setClient(clientBean);
        model.addAttribute("bean", contactBean);
        return "/client/contact";
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增工作項目
    @RequestMapping("/changeWork")
    public String changeWork(Model model, ClientBean clientBean) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 新增工作項目 {}", adminBean.getName(), clientBean.getName());

        WorkBean workBean = new WorkBean();
        workBean.setClient(clientBean);
        model.addAttribute("bean", workBean);
        return "/Market/work";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增其他地址
    @RequestMapping("/newAddress")
    public String newAddress(ClientAddressBean cabean) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 新增其他地址 {}", adminBean.getName(), cabean);
        cs.newAddress(cabean);
        return "redirect:/CRM/client/" + cabean.getClientid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除其他地址
    @RequestMapping("/delClientAddress/{addressid}/{clientid}")
    public String delClientAddress(@PathVariable("addressid") String addressid,
                                   @PathVariable("clientid") String clientid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 刪除其他地址 {}", adminBean.getName(), clientid);
        cs.delAddress(addressid);
        return "redirect:/CRM/client/" + clientid;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//點擊標籤
    @RequestMapping("/client/list")
    public String clickTag(Model model, @RequestParam("tag") String tag) {
        System.out.println("***點擊標籤***");
        model.addAttribute("list", cs.clickTag(tag));
        return "/client/clientList";
    }

}
