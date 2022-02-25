package com.jetec.CRM.controler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jetec.CRM.controler.service.ClientService;
import com.jetec.CRM.model.ClientAddressBean;
import com.jetec.CRM.model.ClientBean;
import com.jetec.CRM.model.ContactBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.QuotationBean;
import com.jetec.CRM.model.WorkBean;

@Controller
@RequestMapping("/CRM")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')")
public class CustomerControler {
    @Autowired
    ClientService cs;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存客戶
    @RequestMapping("/SaveClient")
    public String SaveClient(ClientBean clientBean) {
        System.out.println("*****儲存客戶*****");
        System.out.println(clientBean);
        String name = clientBean.getName().trim();
        clientBean.setState(1);
        if (name.length() != 0)
            cs.SaveAdmin(clientBean);
        return "redirect:/CRM/ClientList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表
    @RequestMapping("/ClientList")
    public String clientList(Model model) {
        System.out.println("*****讀取客戶列表*****");
        model.addAttribute("list", cs.getList());
        return "/client/clientList";
    }

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
        System.out.println("*****讀取客戶細節****");
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
    public List<ClientBean> selectclientResponseBody(@PathVariable("name") String name) {
        System.out.println("搜索客戶");
        name = name.trim();
        return cs.selectclient(name);
    }

    @RequestMapping("/selectclient")
    public String selectclient(Model model, @RequestParam("name") String name) {
        System.out.println("搜索客戶");
        name = name.trim();
        model.addAttribute("list", cs.selectclient(name));
        return "/client/clientList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除客戶
    @RequestMapping("/delClient")
    @ResponseBody
    public String delClient(@RequestParam("id") List<Integer> id) {
        System.out.println("*****刪除客戶*****");
        cs.delClient(id);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人by名稱 ajax
    @RequestMapping("/selectContactByClientName/{name}")
    @ResponseBody
    public List<ContactBean> selectContactByClientName(@PathVariable("name") String name) {

        return cs.selectContactByClientName(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存聯絡人
    @RequestMapping("/SaveContact")
    public String SaveContact(ContactBean contactBean) {
        System.out.println("*****儲存客戶*****");
        System.out.println(contactBean);
        cs.SaveContact(contactBean);
        return "redirect:/CRM/ContactList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人列表
    @RequestMapping("/ContactList")
    public String ContactList(Model model) {
        System.out.println("*****讀取聯絡人列表*****");
        model.addAttribute("list", cs.getContactList());
        return "/client/contactList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人細節
    @RequestMapping("/contact/{id}")
    public String contact(Model model, @PathVariable("id") Integer id) {
        System.out.println("*****讀取聯絡人細節****");
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
        System.out.println("*****刪除聯絡人*****");
        cs.delMarket(id);
        return "刪除成功";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 搜索聯絡人
    @RequestMapping("/selectContact")
    public String sselectContact(Model model, @RequestParam("name") String name) {
        System.out.println("搜索聯絡人");
        name = name.trim();
        model.addAttribute("list", cs.selectContact(name));
        return "/client/contactList";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//客戶轉換聯絡人
    @RequestMapping("/changeContact")
    public String changeContact(Model model, ClientBean clientBean) {
        System.out.println("*****客戶轉成聯絡人*****");
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
//轉成銷售機會
    @RequestMapping("/changeMarket")
    public String changeMarket(Model model, ClientBean clientBean) {
        System.out.println("*****轉成銷售機會*****");
        MarketBean marketBean = new MarketBean();
        marketBean.setClient(clientBean.getName());
        marketBean.setPhone(clientBean.getPhone());
        marketBean.setType(clientBean.getIndustry());
        marketBean.setContactemail(clientBean.getEmail());
        model.addAttribute("bean", marketBean);
        return "/Market/Market";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//轉成銷售機會
    @RequestMapping("/changeWork")
    public String changeWork(Model model, ClientBean clientBean) {
        System.out.println("*****工作項目*****");
        WorkBean workBean = new WorkBean();
        workBean.setClient(clientBean);
        model.addAttribute("bean", workBean);
        return "/Market/work";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增其他地址
    @RequestMapping("/newAddress")
    public String newAddress(ClientAddressBean cabean) {
        System.out.println("*****新增其他地址*****");
        cs.newAddress(cabean);
        return "redirect:/CRM/client/" + cabean.getClientid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除其他地址
    @RequestMapping("/delClientAddress/{addressid}/{clientid}")
    public String delClientAddress(@PathVariable("addressid") String addressid,
                                   @PathVariable("clientid") String clientid) {
        System.out.println("*****刪除其他地址*****");
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
