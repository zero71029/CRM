package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.controler.service.ClientService;
import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.ContactBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
    Logger logger = LoggerFactory.getLogger("ContactController.class");

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人列表
    @RequestMapping("/ContactListInit")
    @ResponseBody
    public ResultBean ContactListInit(@RequestParam("pag") Integer pag) {
        logger.info("讀取聯絡人列表");
        pag--;
        if (pag < 0) pag = 0;
        return ZeroFactory.success("聯絡人列表",cs.getContactList(pag));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索聯絡人
    @RequestMapping("/selectContact")
    @ResponseBody
    public ResultBean selectContact(@RequestParam("name") String name) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        name = name.trim();
        logger.info("{} 搜索聯絡人 {}",adminBean.getName(),name);
        return ZeroFactory.success("搜索聯絡",cs.selectContact(name));
    }
}
