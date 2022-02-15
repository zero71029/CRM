package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.DirectorService;
import com.jetec.CRM.model.BosMessageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/director")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') ")
public class DirectorController {
    @Autowired
    DirectorService ds;
    @Autowired
    ZeroTools zTools;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存主管留言
    @ResponseBody
    @RequestMapping("/SaveMessage")
    public List<BosMessageBean> SaveMessage(@RequestBody Map<String, String> body ){
        System.out.println("*****儲存主管留言*****");
        BosMessageBean bmBean = new BosMessageBean(zTools.getUUID(),body.get("bosmessage"),body.get("admin"),body.get("message"));
        ds.save(bmBean);
        System.out.println(ds.getBosMessageList(body.get("bosmessage")));
        return ds.getBosMessageList(body.get("bosmessage"));
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //讀取主管留言
    @ResponseBody
    @RequestMapping("/getMessage/{customerid}")
    public List<BosMessageBean> getMessage(@PathVariable("customerid") String customerid){
        System.out.println("*****讀取主管留言*****");
        System.out.println(ds.getBosMessageList(customerid));
        return ds.getBosMessageList(customerid);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //刪除主管留言
    @ResponseBody
    @RequestMapping("/reomveBosMessage/{bosmessageid}")
    public List<BosMessageBean> reomveBosMessage(@PathVariable("bosmessageid") String bosmessageid){
        System.out.println("*****刪除主管留言*****");
        return ds.delBosMessageList(bosmessageid);
    }


}
