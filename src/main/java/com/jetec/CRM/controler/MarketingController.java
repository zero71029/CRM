package com.jetec.CRM.controler;

import com.jetec.CRM.model.ClientBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.ClientRepository;
import com.jetec.CRM.repository.MarketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Marketing")
public class MarketingController {
    @Autowired
    ClientRepository cr;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
    @RequestMapping("/search")
    @ResponseBody
    public String search(@RequestBody Map<String, Object> body ) {
        System.out.println(body);
        List<String> industryList = (List<String>) body.get("industry");
        List<ClientBean> clientList = new ArrayList<>();
        industryList.forEach(industry ->{
            clientList.addAll(cr.findByIndustry(industry));
        });
        clientList.forEach(clientBean -> {
            System.out.printf("%s,%s,%s",clientBean.getEmail(),clientBean.getName(),"");
            System.out.println("");
        });

        return "";
    }
}
