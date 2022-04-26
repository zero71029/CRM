package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.MarketService;
import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.controler.service.StatisticService;
import com.jetec.CRM.controler.service.SystemService;
import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.LibraryBean;
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
        result.put("companyNum", ss.selectCompany(startDay, endDay));//公司名稱列表
        result.put("AdminCastNum", AdminCastNum(startDay, endDay));//取得個業務案件數量
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索
    @RequestMapping("/selectCompany")
    @ResponseBody
    public Map<String, Object> selectCompany(@RequestParam("from") String startDay, @RequestParam("to") String endDay, HttpServletRequest sce) {
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
        Map<String, Object> CompanyNumList = getListByDate(startDay.substring(0, 10), endDay.substring(0, 10));
        ServletContext app = sce.getServletContext();
        List<LibraryBean> libraryList = (List<LibraryBean>) app.getAttribute("library");


        result.put("CompanyNumList", CompanyNumList);//每天公司數量
        result.put("companyNum", ss.selectCompany(startDay, endDay));//公司名稱列表
        result.put("AdminCastNum", AdminCastNum(startDay, endDay));//取得個業務案件數量
        result.put("producttype", producttype(startDay, endDay, libraryList));//商品類別
        result.put("BusinessState", BusinessState(startDay, endDay));//業務成功失敗


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
            List<String> ll = ss.selectCompany(s, e);
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


        String[] type = {"尚未分類", "大型顯示器", "空氣品質", "流量-AICHI", "流量-RGL", "流量-Siargo", "流量-其他", "記錄器", "資料收集器-JETEC", "資料收集器-其他", "溫濕-JETEC", "溫濕-GALLTEC", "溫濕-E+E", "溫濕-其他", "紅外線",
                "壓力-JETEC", "壓力-HUBA", "壓力-COPAL", "壓力-其他", "差壓", "氣體-JETEC", "氣體-Senko", "氣體-GASDNA", "氣體-手持",
                "氣體-其他", "氣象儀器-土壤/pH", "氣象儀器-日照/紫外線", "氣象儀器-風速/風向", "氣象儀器-雨量", "氣象儀器-其他", "水質相關", "液位/料位-JETEC",
                "液位/料位-DINEL", "液位/料位-HONDA", "液位/料位-其他", "溫度貼紙", "溫控器-TOHO", "溫控器-其他", "感溫線棒", "無線傳輸", "編碼器/電位計", "能源管理控制", "食品", "其它"};

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
            List sta = new ArrayList();
            sta.add(ss.getAminStateNum(abean.getName(), "成功結案", startDay, endDay));
            sta.add(ss.getAminStateNum(abean.getName(), "失敗結案", startDay, endDay));
            result.put(abean.getName(), sta);
        }


        return result;
    }
}
