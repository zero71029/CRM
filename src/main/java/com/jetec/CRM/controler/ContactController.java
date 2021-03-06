package com.jetec.CRM.controler;

import com.jetec.CRM.controler.service.ClientService;
import com.jetec.CRM.model.ContactBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/contact")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')OR hasAuthority('國貿')")
public class ContactController {

    @Autowired
    ClientService cs;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人列表
    @RequestMapping("/ContactListInit")
    @ResponseBody
    public Map<String, Object> ContactListInit(@RequestParam("pag") Integer pag) {
        System.out.println("*****讀取聯絡人列表*****");
        pag--;
        return cs.getContactList(pag);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索聯絡人
    @RequestMapping("/selectContact")
    @ResponseBody
    public List<ContactBean> selectContact(@RequestParam("name") String name) {
        System.out.println("*****搜索聯絡人****");
        System.out.println(cs.selectContact(name));
        return cs.selectContact(name);
    }
}
