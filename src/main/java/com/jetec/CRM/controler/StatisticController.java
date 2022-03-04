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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/statistic")
//@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')")
public class StatisticController {
    @Autowired
    ZeroTools zTools;
    @Autowired
    StatisticService ss;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索公司數量
    @RequestMapping("/selectCompany")
    @ResponseBody
    public Map<String, Object> selectCompany(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("搜索公司數量");
        Map<String, Object> result = new HashMap<>();

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
        ss.selectCompany(startDay, endDay);

        Map<String, Object>   img = getListByDate(startDay.substring(0, 10),endDay.substring(0, 10));
        result.put("img",img);
        result.put("companyNum",ss.selectCompany(startDay, endDay));

        ///////////////////////////////////////




        return result;

    }
    @RequestMapping("/AAA")
    @ResponseBody
    public Map<String, Object> getListByDate(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        Map<String, Object> result = new HashMap<>();
        System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
        System.out.println(startDay);
        System.out.println(endDay);

        System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
        while (addDay(endDay).compareTo(startDay) > 0) {

            String s = startDay + " 00:00";
            String e = startDay + " 23:00";

            List<String> ll = ss.selectCompany(s, e);
            System.out.println("s :"+s +"  e: "+e +"  AAA:"+ll);

            result.put(startDay, ss.selectCompany(s, e));
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            try {
                cal.setTime(dateFormat.parse(startDay));
            } catch (ParseException e1) {

            }
            cal.add(Calendar.DATE, 1);
            startDay = dateFormat.format(cal.getTime());
        }
        System.out.println(result);
        return  result;

    }

    public String addDay(String day){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(dateFormat.parse(day));
        } catch (ParseException e1) {

        }
        cal.add(Calendar.DATE, 1);
        return dateFormat.format(cal.getTime());

    }



}
