package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.MarketService;
import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.controler.service.StatisticService;
import com.jetec.CRM.controler.service.SystemService;
import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.LibraryBean;
import com.jetec.CRM.model.MarketBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static java.util.stream.Collectors.toList;

@Controller
@RequestMapping("/statistic")
//@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')")
public class StatisticController {
    @Autowired
    ZeroTools zTools;
    @Autowired
    StatisticService ss;
    @Autowired
    SystemService systemService;
    @Autowired
    MarketService ms;
    @Autowired
    PotentialCustomerService pcs;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//數據管理初始化
    @RequestMapping("/init")
    @ResponseBody
    public Map<String, Object> init() {
        System.out.println("數據管理初始化");
        Map<String, Object> result = new HashMap<>();
        result.put("SubmitBos", ms.getSubmitBos());//提交主管
        result.put("CallBos", ms.CallBos());//延長請求
        result.put("potential", pcs.getPotentialSubmitBos());//提交主管

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String endDay = sdf.format(new Date());
        //取90天
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -90);
        Date todate1 = cal.getTime();
        String startDay = sdf.format(todate1);
        System.out.println("startDay :" + startDay);
        System.out.println("endDay :" + endDay);


        Map<String, Object> CompanyNumList = getListByDate(startDay, endDay);

        result.put("CompanyNumList", CompanyNumList);//每天公司數量
        //result.put("companyNum", ss.selectCompany(startDay, endDay));//公司名稱列表
//        result.put("AdminCastNum", AdminCastNum(startDay, endDay));//取得個業務案件數量
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索
    @RequestMapping("/selectCompany")
    @ResponseBody
    public Map<String, Object> selectCompany(@RequestParam("from") String startDay, @RequestParam("to") String endDay, HttpServletRequest sce) {
        System.out.println("搜索公司數量");
        Map<String, Object> result = new HashMap<>();

        if (startDay == null || startDay.equals("")) {
            startDay = zTools.getTime(new Date());
            startDay = startDay.substring(0, 10);
            startDay = startDay + " 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        if (Objects.equals(endDay, "")) {
            endDay = zTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        Map<String, Object> CompanyNumList = getListByDate(startDay.substring(0, 10), endDay.substring(0, 10));
        ServletContext app = sce.getServletContext();
        List<LibraryBean> libraryList = (List<LibraryBean>) app.getAttribute("library");



        result.put("CompanyNumList", CompanyNumList);//每天公司數量
        result.put("companyNum", ss.selectCompany(startDay, endDay));//公司名稱列表
        result.put("AdminCastNum", AdminCastNum(startDay, endDay));//取得個業務案件數量
        result.put("producttype", producttype(startDay, endDay, libraryList));//商品類別
        result.put("BusinessState", BusinessState(startDay, endDay));//業務成功失敗
        result.put("MaxNumCompany", ss.getMaxNumCompany(startDay, endDay));//案件最多的5間公司
        result.put("SuccessMaxNumCompany", ss.getSuccessMaxNumCompany(startDay, endDay));//成功案件最多的5間公司
        result.put("FailMaxNumCompany", ss.getFailMaxNumCompany(startDay, endDay));//失敗案件最多的5間公司

        return result;

    }

    /////////////////////////////////////////////////////////////////////////////////////////
//取得個業務案件數量
    private Map<String, Object> AdminCastNum(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("取得個業務案件數量");
        Map<String, Object> result = new HashMap<>();
        List<AdminBean> adminList = systemService.getAdminByDepartment("業務");
        for (AdminBean abean : adminList) {
            result.put(abean.getName(), ss.getAminCastNum(startDay, endDay, abean.getName()));
        }
        return result;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    public Map<String, Object> getListByDate(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        Map<String, Object> result = new HashMap<>();
        while (addDay(endDay).compareTo(startDay) > 0) {
            String s = startDay + " 00:00";
            String e = startDay + " 23:00";
            result.put(startDay, ss.selectCompany(s, e));
            startDay = addDay(startDay);
        }
        return result;

    }

    /////////////////////////////////////////////////////////////////////////////////////////
//商品種類
    private Map<String, Integer> producttype(@RequestParam("from") String startDay, @RequestParam("to") String endDay, List<LibraryBean> libraryBeanList) {
        System.out.println("商品種類");
        Map<String, Integer> result = new HashMap<>();
        String s = startDay + " 00:00";
        String e = endDay + " 23:00";

        //取得資料
        for (LibraryBean bean : libraryBeanList) {
            if ("producttype".equals(bean.getLibrarygroup())) {
                Integer i = ss.selectProductType(bean.getLibraryoption(), s, e);
                if (i > 0)
                    result.put(bean.getLibraryoption(), i);
            }
        }


        //排序
//        List<Map.Entry<String, Integer>> l = new ArrayList<>(result.entrySet() );
//        Collections.sort(l, new Comparator<Map.Entry<String, Integer>>() {
//            @Override
//            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer>o2) {
//                return o1.getValue().compareTo(o2.getValue());
//            }
//        });
//        result.clear();
//        Iterator<Map.Entry<String, Integer>> iterator = l.iterator();
//        for (Map.Entry<String, Integer> m: l  ) {
//            System.out.println(m.getKey()+" = "+m.getValue());
//            result.put(m.getKey(),m.getValue());
//        }
//
//        System.out.println(result);
        return result;
    }

    //////////////////////////////////////////////////////////////////////////////
//    日期加1天
    public String addDay(String day) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(dateFormat.parse(day));
        } catch (ParseException e1) {

        }
        cal.add(Calendar.DATE, 1);
        return dateFormat.format(cal.getTime());
    }

    //////////////////////////////////////////////////////////////////////////////
    //  業務成功失敗
    private Map<String, Object> BusinessState(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("業務成功失敗");

        Map<String, Object> result = new HashMap<>();


        List<AdminBean> adminList = systemService.getAdminByDepartment("業務");
        for (AdminBean abean : adminList) {
            List<Integer> sta = new ArrayList<>();
            sta.add(ss.getAminStateNum(abean.getName(), "成功結案", startDay, endDay));
            sta.add(ss.getAminStateNum(abean.getName(), "失敗結案", startDay, endDay));
            result.put(abean.getName(), sta);
        }
        return result;
    }
    //////////////////////////////////////////////////////////////////////////////
    //結案狀態
    @ResponseBody
    @RequestMapping("/CloseState")
    private Map<String, Object> CloseState(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("結案狀態");
        Map<String, Object> result = new HashMap<>();


        if (Objects.equals(endDay, "")) {
            endDay = zTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        if (startDay == null || startDay.equals("")) {
            startDay = zTools.addDay(endDay,-7);
            startDay = startDay.substring(0, 10);
            startDay = startDay + " 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        List<MarketBean> l = ss.getMarketByState("私敗結案",startDay,endDay);
        result.put("success",ss.getMarketByState("成功結案",startDay,endDay));
        result.put("fail",ss.getMarketByState("失敗結案",startDay,endDay));
        result.put("other",ss.getMarketByCloseNot(startDay,endDay));
        l.forEach(System.out::println);

        return result;
    }

    //////////////////////////////////////////////////////////////////////////////
    //結案狀態
    @ResponseBody
    @RequestMapping("/CloseState2")
    private Map<String, Object> CloseState2(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("結案狀態");
        Map<String, Object> result = new HashMap<>();


        if (Objects.equals(endDay, "")) {
            endDay = zTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        if (startDay == null || startDay.equals("")) {
            startDay = zTools.addDay(endDay,-7);
            startDay = startDay.substring(0, 10);
            startDay = startDay + " 00:00";
        } else {
            startDay = startDay + " 00:00";
        }



        List<MarketBean> l = ss.getMarketByAaa( startDay,endDay);
        List<Map<String ,String>> success = new ArrayList<>();
        l.stream().filter(e->e.getStage().equals("成功結案")).forEach(e->{
            Map<String ,String> x = new HashMap<>();
            x.put("client",e.getClient());
            x.put("aaa",e.getAaa());
            x.put("user",e.getUser());
            success.add(x);
        });

        List<Map<String ,String>> fail = new ArrayList<>();
        l.stream().filter(e->e.getStage().equals("失敗結案")).forEach(e->{
            Map<String ,String> x = new HashMap<>();
            x.put("client",e.getClient());
            x.put("closereason",e.getClosereason());
            fail.add(x);
        });



        System.out.println(l.size());

        result.put("success",success);
        result.put("fail",fail);
        result.put("other",ss.getMarketByCloseNot(startDay,endDay));


        return result;
    }

}
