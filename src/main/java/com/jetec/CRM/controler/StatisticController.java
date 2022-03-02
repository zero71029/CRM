package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.StatisticService;
import com.jetec.CRM.model.MarketBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/statistic")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')")
public class StatisticController {
    @Autowired
    ZeroTools zTools;
    @Autowired
    StatisticService ss;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索公司數量
    @RequestMapping("/selectCompany")
    @ResponseBody
    public List<String> selectCompany(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("搜索公司數量");
        if (startDay == null || startDay == "") {
            startDay = zTools.getTime(new Date());
            startDay = startDay.substring(0, 10);
            startDay = startDay + " 00:00";
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
        return ss.selectCompany(startDay, endDay);

    }

}
