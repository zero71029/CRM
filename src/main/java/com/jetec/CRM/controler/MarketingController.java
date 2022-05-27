package com.jetec.CRM.controler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.Map;

@Controller
@RequestMapping("/Marketing")
public class MarketingController {

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//上傳附件
    @RequestMapping("/search")
    @ResponseBody
    public String search(@RequestBody String body ) {
        System.out.println(body);
        return "";
    }
}
