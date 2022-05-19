package com.jetec.CRM.controler;


import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.ApplicationService;
import com.jetec.CRM.model.ApplicationBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/AccountApplication")
public class AccountApplicationController {

    @Autowired
    ApplicationService as;
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存帳號申請表
    @RequestMapping("/save")
    public String save(ApplicationBean aBean) {
        System.out.println("*****儲存帳號申請表*****");
        if(aBean.getApplicationid() == null){
            aBean.setCreatetime(ZeroTools.getTime(new Date()));
        }

        return "redirect:/AccountApplication/detail/"+as.save(aBean).getApplicationid()+"?mess=save ok";
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//列表初始化
    @RequestMapping("/ListInit")
    @ResponseBody
    public List<ApplicationBean> ListInit(@RequestParam("pag") String pag) {
        System.out.println("*****⼯作說明列表初始化*****");
        return as.findAll();
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//進入細節
    @RequestMapping("/detail/{applicationid}")
    public String detail(@PathVariable("applicationid")Integer applicationid,Model model,@RequestParam("mess")String mess) throws UnsupportedEncodingException {

        System.out.println("*****進入細節*****");
        model.addAttribute("bean",as.getById(applicationid));
        model.addAttribute("error", mess);
        return "/system/AccountApplication";
    }



}
